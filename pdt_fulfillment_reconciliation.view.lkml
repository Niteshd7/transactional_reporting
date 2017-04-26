view: pdt_fulfillment_reconciliation {
  derived_table: {
    sql: SELECT  * FROM (SELECT
      IF (fulfillment_id > 0, fulfillment_id, '-') AS fulfillment_id_fmt,
      fulfillment_id,
      fulfillment_name,
      fulfillment_alias,
      shippable_order_cnt,
      shippable_prod_cnt,
      shipped_cnt,
      IF(fulfillment_id > 0, sent_cnt, 0)         AS sent_cnt,
      pending_tracking_cnt,
      IF(fulfillment_id > 0, pending_post_cnt, 0) AS pending_post_cnt,
      pending_avg,
      return_cnt,
      pending_return_cnt
  FROM
      (
         SELECT
               fulfillment_id,
               fulfillment_name,
               fulfillment_alias,
               SUM(shippable_order_cnt)             AS shippable_order_cnt,
               FORMAT(SUM(shippable_order_cnt), 0)  AS shippable_order_cnt_fmt,
               SUM(shippable_prod_cnt)              AS shippable_prod_cnt,
               FORMAT(SUM(shippable_prod_cnt), 0)   AS shippable_prod_cnt_fmt,
               SUM(shipped_cnt)                     AS shipped_cnt,
               FORMAT(SUM(shipped_cnt), 0)          AS shipped_cnt_fmt,
               SUM(sent_cnt)                        AS sent_cnt,
               FORMAT(SUM(sent_cnt), 0)             AS sent_cnt_fmt,
               SUM(pending_tracking_cnt)            AS pending_tracking_cnt,
               FORMAT(SUM(pending_tracking_cnt), 0) AS pending_tracking_cnt_fmt,
               SUM(pending_post_cnt)                AS pending_post_cnt,
               FORMAT(SUM(pending_post_cnt), 0)     AS pending_post_cnt_fmt,
               SUM(pending_avg)                     AS pending_avg,
               SUM(return_cnt)                      AS return_cnt,
               SUM(pending_return_cnt)              AS pending_return_cnt
           FROM
               (
                  SELECT
                        IFNULL(c.fulfillmentId, 0)                AS fulfillment_id,
                        IFNULL(c.fulfillment_name, 'In House')    AS fulfillment_name,
                        IFNULL(c.fulfillment_alias, 'N/A')        AS fulfillment_alias,
                        SUM(
                           CASE
                              WHEN op.cnt > 0 AND o.hasBeenPosted = 1 THEN
                                 1
                              WHEN op.cnt > 0 AND o.orders_status IN (2,8) AND (o.isFraud + o.isRMA + o.isChargeback) = 0 THEN
                                 1
                              ELSE
                                 0
                           END
                        )                                         AS shippable_order_cnt,
                        SUM(
                           CASE
                              WHEN o.hasBeenPosted = 1 THEN
                                 op.cnt
                              WHEN o.orders_status IN (2,8) AND (o.isFraud + o.isRMA + o.isChargeback) = 0 THEN
                                 op.cnt
                              ELSE
                                 0
                           END
                        )                                         AS shippable_prod_cnt,
                        SUM(IF(o.shipping_module_code = 1, 1, 0)) AS shipped_cnt,
                        SUM(IF(o.hasBeenPosted = 1, 1, 0))        AS sent_cnt,
                        SUM(
                           IF(
                              CASE
                                 WHEN c.fulfillmentId > 0 THEN
                                    IF (o.hasBeenPosted = 1
                                     AND
                                        o.shipping_module_code = 0
                                     AND
                                        o.hasTrackingBeenPosted = 0,
                                    1, 0)
                                 ELSE
                                    IF (op.cnt > 0
                                     AND
                                        o.tracking_num = '',
                                    1, 0)
                                 END,
                              1, 0
                           )
                        )                                         AS pending_tracking_cnt,
                        SUM(
                           IF(
                              o.shipping_module_code = 0
                           AND
                              op.cnt > 0
                           AND
                              o.hasBeenPosted = 0
                           AND
                              o.orders_status = 2
                           AND
                              o.isFraud = 0
                           AND
                              o.isRMA = 0
                           AND
                              o.isChargeback = 0,
                              1, 0
                           )
                        )                                         AS pending_post_cnt,
                        ROUND(AVG(IFNULL(pending.diff, 0)))       AS pending_avg,
                        SUM(IF (o.isRMA = 2, 1, 0))               AS return_cnt,
                        SUM(
                           IF (
                              o.isRMA = 1 AND IFNULL(c.returns_flag, 0) > 0,
                              1, 0
                           )
                        )                                         AS pending_return_cnt
                    FROM
                        (
                           SELECT
                                 orders_id,
                                 SUM(cnt) AS cnt
                             FROM
                                 (
                                    SELECT
                                          op.orders_id,
                                          SUM(op.products_quantity) AS cnt
                                      FROM
                                          orders          o,
                                          orders_products op
                                     WHERE
                                          o.deleted = 0
                                       AND
                                          o.orders_id = op.orders_id
                                       AND
                                          o.payment_module_code = 1
                                          AND ({% condition date_select %} o.t_stamp {% endcondition %})
                                          AND {% condition is_test %} o.is_test_cc {% endcondition %}

                                  GROUP BY
                                          orders_id
                                 UNION ALL
                                    SELECT
                                          o.orders_id,
                                          SUM(uop.products_quantity) AS cnt
                                      FROM
                                          orders                 o,
                                          upsell_orders          uo,
                                          upsell_orders_products uop
                                     WHERE
                                          o.deleted = 0
                                       AND
                                          o.orders_id = uo.main_orders_id
                                       AND
                                          uo.upsell_orders_id = uop.upsell_orders_id
                                       AND
                                          uo.payment_module_code = 1
                                          AND ({% condition date_select %} o.t_stamp {% endcondition %})
                                          AND {% condition is_test %} o.is_test_cc {% endcondition %}

                                  GROUP BY
                                          o.orders_id
                                 ) p
                          GROUP BY
                                  orders_id
                        ) op,
                        orders  o
               LEFT JOIN
                        (
                           SELECT
                                 post.orders_id,
                                 ABS(DATEDIFF(IFNULL(track.t_stamp, DATE(CURRENT_TIMESTAMP)), post.t_stamp)) AS diff
                             FROM
                                (
                                   SELECT
                                         o.orders_id,
                                         DATE(oh.t_stamp) t_stamp
                                     FROM
                                         orders         o,
                                         orders_history oh
                                    WHERE
                                         o.orders_id = oh.orders_id
                                      AND
                                         o.deleted = 0
                                      AND
                                         oh.type IN ('order_fulfillment-success', 'history-note-genftp-fulfillment-success')
                                         AND ({% condition date_select %} o.t_stamp {% endcondition %})
                                         AND {% condition is_test %} o.is_test_cc {% endcondition %}

                                   ) post
                          LEFT JOIN
                                   (
                                      SELECT
                                            o.orders_id,
                                            DATE(oh.t_stamp) t_stamp
                                        FROM
                                            orders         o,
                                            orders_history oh
                                       WHERE
                                            o.orders_id = oh.orders_id
                                         AND
                                            o.deleted = 0
                                         AND
                                            oh.type = 'order-tracking-success'
                                            AND ({% condition date_select %} o.t_stamp {% endcondition %})
                                            AND {% condition is_test %} o.is_test_cc {% endcondition %}

                                   ) track
                                 ON
                                   post.orders_id = track.orders_id

                        ) pending
                      ON
                        o.orders_id = pending.orders_id
               LEFT JOIN
                        (
                           SELECT
                                 c.c_id,
                                 c.fulfillmentId,
                                 fa.name AS fulfillment_name,
                                 f.alias AS fulfillment_alias,
                                 IF (gf.fieldValue IS NULL, 0, 1) AS returns_flag
                             FROM
                                 campaigns c,
                                 all_clients_limelight.fulfillment_accounts fa,
                                 fulfillment f
                        LEFT JOIN
                                 generic_fields gf
                               ON
                                 (
                                    f.genericId = gf.genericId
                                 AND
                                    gf.fieldName = 'Receive Returns'
                                 AND
                                    gf.fieldValue = 'yes'
                                 )
                            WHERE
                                 c.fulfillmentId = f.fulfillmentId
                              AND
                                 f.fulfillmentAccountId = fa.fulfillmentAccountId
                        ) c
                      ON
                        o.campaign_order_id = c.c_id
                   WHERE
                        o.deleted = 0
                     AND
                        o.orders_id = op.orders_id
                     AND
                        (o.payment_module_code + (SELECT COUNT(1) FROM upsell_orders WHERE main_orders_id = o.orders_id AND payment_module_code = 1) > 0)
                     AND
                        o.orders_status IN(2,6,8)
                        AND ({% condition date_select %} o.t_stamp {% endcondition %})
                        AND {% condition is_test %} o.is_test_cc {% endcondition %}

                GROUP BY
                        c.fulfillmentId
               UNION ALL
                  -- Include orders shipped within date range
                  SELECT
                        IFNULL(c.fulfillmentId, 0)                AS fulfillment_id,
                        IFNULL(c.fulfillment_name, 'In House')    AS fulfillment_name,
                        IFNULL(c.fulfillment_alias, 'N/A')        AS fulfillment_alias,
                        0                                         AS shippable_order_cnt,
                        0                                         AS shippable_prod_cnt,
                        SUM(IF(o.shipping_module_code = 1, 1, 0)) AS shipped_cnt,
                        0                                         AS sent_cnt,
                        0                                         AS pending_tracking_cnt,
                        0                                         AS pending_post_cnt,
                        0                                         AS pending_avg,
                        SUM(IF (o.isRMA = 2, 1, 0))               AS return_cnt,
                        SUM(
                           IF (
                              o.isRMA = 1 AND IFNULL(c.returns_flag, 0) > 0,
                              1, 0
                           )
                        )                                         AS pending_return_cnt
                    FROM
                        orders  o
               LEFT JOIN
                        (
                           SELECT
                                 c.c_id,
                                 c.fulfillmentId,
                                 fa.name AS fulfillment_name,
                                 f.alias AS fulfillment_alias,
                                 IF (gf.fieldValue IS NULL, 0, 1) AS returns_flag
                             FROM
                                 campaigns c,
                                 all_clients_limelight.fulfillment_accounts fa,
                                 fulfillment f
                        LEFT JOIN
                                 generic_fields gf
                               ON
                                 (
                                    f.genericId = gf.genericId
                                 AND
                                    gf.fieldName = 'Receive Returns'
                                 AND
                                    gf.fieldValue = 'yes'
                                 )
                            WHERE
                                 c.fulfillmentId = f.fulfillmentId
                              AND
                                 f.fulfillmentAccountId = fa.fulfillmentAccountId
                        ) c
                      ON
                        o.campaign_order_id = c.c_id
                   WHERE
                        o.deleted = 0
                     AND
                        o.payment_module_code = 1
                     AND
                        o.shipping_module_code = 1
                     AND
                        {% condition date_select %} o.orders_date_finished {% endcondition %}
                     AND
                        o.orders_status IN(2,6,8)
                     AND
                        (o.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %})))
                        AND {% condition is_test %} o.is_test_cc {% endcondition %}

                GROUP BY
                        c.fulfillmentId

               ) x
       GROUP BY
               fulfillment_id
      ) z) a    ORDER BY fulfillment_id DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: date_select {
    type: date
  }

  filter: is_test {
    type: string
    default_value: "0,1"
  }

  dimension: fulfillment_id_fmt {
    type: string
    sql: ${TABLE}.fulfillment_id_fmt ;;
  }

  dimension: fulfillment_id {
    type: number
    sql: ${TABLE}.fulfillment_id ;;
  }

  dimension: fulfillment_name {
    type: string
    sql: ${TABLE}.fulfillment_name ;;
  }

  dimension: fulfillment_alias {
    type: string
    sql: ${TABLE}.fulfillment_alias ;;
  }

  dimension: shippable_order_cnt {
    type: number
    sql: ${TABLE}.shippable_order_cnt ;;
  }

  dimension: shippable_prod_cnt {
    type: number
    sql: ${TABLE}.shippable_prod_cnt ;;
  }

  dimension: shipped_cnt {
    type: number
    sql: ${TABLE}.shipped_cnt ;;
  }

  dimension: sent_cnt {
    type: number
    sql: ${TABLE}.sent_cnt ;;
  }

  dimension: pending_tracking_cnt {
    type: number
    sql: ${TABLE}.pending_tracking_cnt ;;
  }

  dimension: pending_post_cnt {
    type: number
    sql: ${TABLE}.pending_post_cnt ;;
  }

  dimension: pending_avg {
    type: number
    sql: ${TABLE}.pending_avg ;;
  }

  dimension: return_cnt {
    type: number
    sql: ${TABLE}.return_cnt ;;
  }

  dimension: pending_return_cnt {
    type: number
    sql: ${TABLE}.pending_return_cnt ;;
  }

  measure: shippable_orders {
    type: sum
    sql: ${shippable_order_cnt} ;;
  }

  measure: shippable_products {
    type: sum
    sql: ${shippable_prod_cnt} ;;
  }

  measure: orders_pending_post {
    type: sum
    sql: ${pending_post_cnt} ;;
  }

  measure: orders_sent {
    type: sum
    sql: ${sent_cnt} ;;
  }

  measure: sent_pending_tracking {
    type: sum
    sql: ${pending_tracking_cnt} ;;
  }

  measure: shipped {
    type: sum
    sql: ${shipped_cnt} ;;
  }

  measure: pending_return {
    type: sum
    sql: ${pending_return_cnt} ;;
  }

  measure: returned {
    type: sum
    sql: ${return_cnt} ;;
  }

  measure: avg_days_pending_tracking {
    type: number
    sql: ROUND(${pending_avg}) ;;
  }

  set: detail {
    fields: [
      fulfillment_id_fmt,
      fulfillment_id,
      fulfillment_name,
      fulfillment_alias,
      shippable_order_cnt,
      shippable_prod_cnt,
      shipped_cnt,
      sent_cnt,
      pending_tracking_cnt,
      pending_post_cnt,
      pending_avg,
      return_cnt,
      pending_return_cnt
    ]
  }
}
