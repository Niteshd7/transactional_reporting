view: pdt_fulfillment_drill {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
      product_ids,
      fulfillmentId,
      o.orders_id                           AS order_id,
      op.cnt                                AS shippable_prod_cnt,
      FORMAT(op.cnt, 0)                     AS shippable_prod_cnt_fmt,
      DATE_FORMAT(o.t_stamp, '%m/%d/%Y %r') AS order_date,
      IF(
         o.shipping_module_code > 0,
         DATE_FORMAT(o.orders_date_finished, '%m/%d/%Y %r'),
         '-'
      )                                     AS shipped_date,
      o.shipping_module_code                AS shipped_flag,
      IF(
         o.isRMA > 0,
         IFNULL(
            DATE_FORMAT((
               SELECT
                     MAX(oh.t_stamp)
                 FROM
                     orders_history oh
                WHERE
                     oh.type = 'rma-order-on'
                  AND
                     oh.orders_id = o.orders_id
            ), '%m/%d/%Y'),
            '-'),
         '-'
      )                                     AS rma_date,
      IF(
         o.isRMA = 2,
         DATE_FORMAT((
            SELECT
                  MAX(oh.t_stamp)
             FROM
                 orders_history oh
            WHERE
                 oh.type = 'history-note-return-reason'
              AND
                 oh.orders_id = o.orders_id
         ), '%m/%d/%Y'),
         '-'
      )                                     AS return_date,
      IFNULL(rr.name, '-')                  AS return_reason,
      CASE
          WHEN o.isRMA = 2                                                                      THEN 'Returned'
          WHEN o.shipping_module_code = 1 AND o.isRMA = 0                                       THEN 'Shipped'
          WHEN (o.hasTrackingBeenPosted = 0 AND o.hasBeenPosted = 1)  THEN 'Pending Tracking Number'
          WHEN o.hasBeenPosted = 0                                                              THEN 'Pending Post to Provider'
          WHEN o.isRMA = 1                                                                      THEN 'Pending Return'
      END status
  FROM
      (
         SELECT
               orders_id,
               GROUP_CONCAT(products_id ORDER BY products_id)  AS product_ids,
               SUM(products_quantity)                          AS cnt,
               MAX(pending_tracking_flag)                      AS pending_tracking_flag,
               fulfillmentId
         FROM
             (
                -- Main orders created in date range
                SELECT
                      o.orders_id,
                      op.products_id,
                      op.products_quantity,
                      c.fulfillmentId,
                      IF (o.tracking_num IN ('','0')  AND o.hasBeenPosted=1, 1, 0) AS pending_tracking_flag
                  FROM
                      orders          o,
                      orders_products op,
                      campaigns       c
                 WHERE
                      o.orders_id = op.orders_id
                   AND
                      o.campaign_order_id = c.c_id
                   AND
                      o.deleted = 0
                   AND
                      o.payment_module_code = 1

                   AND
                      IF ('0' = '1', 0, 1)
                      AND ({% condition orders.t_stamp_date %} o.t_stamp {% endcondition %})
                      AND {% condition orders.is_test_cc %} o.is_test_cc {% endcondition %}

             UNION ALL
                -- Main orders shipped in date range
                SELECT
                      o.orders_id,
                      op.products_id,
                      op.products_quantity,
                      c.fulfillmentId,
                      IF (tracking_num IN ('','0') AND o.hasBeenPosted=1, 1, 0) AS pending_tracking_flag
                  FROM
                      orders          o,
                      orders_products op,
                      campaigns       c
                 WHERE
                      o.orders_id = op.orders_id
                   AND
                      o.campaign_order_id = c.c_id
                   AND
                      o.deleted = 0
                   AND
                      o.payment_module_code = 1
                   AND
                      o.shipping_module_code = 1
                   AND
                      {% condition orders.t_stamp_date %} o.orders_date_finished {% endcondition %}
                   AND
                      IF ('0' = 1, 1, (o.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))))
                   AND
                      IF('shipped' = 'shipped', 1, 0)
                      AND {% condition orders.is_test_cc %} o.is_test_cc {% endcondition %}

             UNION ALL
                -- Upsells created in range
                SELECT
                      o.orders_id,
                      uop.products_id,
                      uop.products_quantity,
                      c.fulfillmentId,
                      IF (uo.tracking_num IN ('','0') AND o.hasBeenPosted=1, 1, 0) AS pending_tracking_flag
                  FROM
                      orders                 o,
                      upsell_orders          uo,
                      upsell_orders_products uop,
                      campaigns              c
                 WHERE
                      o.orders_id = uo.main_orders_id
                   AND
                      uo.upsell_orders_id = uop.upsell_orders_id
                   AND
                      o.campaign_order_id = c.c_id
                   AND
                      o.deleted = 0
                   AND
                      uo.payment_module_code = 1
                   AND
                      IF ('0' = '1', 0, 1)
                   AND
                      {% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}
                      AND {% condition orders.is_test_cc %} o.is_test_cc {% endcondition %}

             UNION ALL
                -- Upsells shipped in date range
                SELECT
                      o.orders_id,
                      uop.products_id,
                      uop.products_quantity,
                      c.fulfillmentId,
                      IF (uo.tracking_num IN ('','0') AND o.hasBeenPosted=1, 1, 0) AS pending_tracking_flag
                  FROM
                      orders                 o,
                      upsell_orders          uo,
                      upsell_orders_products uop,
                      campaigns              c
                 WHERE
                      o.orders_id = uo.main_orders_id
                   AND
                      uo.upsell_orders_id = uop.upsell_orders_id
                   AND
                      o.campaign_order_id = c.c_id
                   AND
                      o.deleted = 0
                   AND
                      uo.payment_module_code = 1
                   AND
                      o.shipping_module_code = 1

                   AND
                       {% condition orders.t_stamp_date %} o.orders_date_finished {% endcondition %}
                   AND
                      IF ('0' = 1, 1, (uo.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))))
                   AND
                      IF('shipped' = 'shipped', 1, 0)
                      AND {% condition orders.is_test_cc %} o.is_test_cc {% endcondition %}

            ) o
    GROUP BY
            orders_id
      ) op,
      orders  o
LEFT JOIN
      tlkp_return_reason rr
    ON
      o.paypal_ipn_id = rr.id
 WHERE
      o.deleted = 0
   AND
      o.orders_status IN(2,6,8)
   AND
      o.orders_id = op.orders_id
   AND
      CASE 'shipped'
         WHEN 'shippable'        THEN op.cnt > 0 AND IF(o.hasBeenPosted = 1, 1, o.orders_status IN (2,8) AND (o.isFraud + o.isRMA + o.isChargeback) = 0)
         WHEN 'shipped'          THEN o.shipping_module_code = 1
         WHEN 'sent'             THEN o.hasBeenPosted = 1
         WHEN 'pending_post'     THEN o.shipping_module_code = 0 AND o.hasBeenPosted = 0 AND o.orders_status = 2 AND o.isFraud = 0 AND o.isRMA = 0 AND o.isChargeback = 0
         WHEN 'returns'          THEN o.isRMA = 2
         WHEN 'pending_return'   THEN o.isRMA = 1
         ELSE 1
      END
   AND {% condition orders.is_test_cc %} o.is_test_cc {% endcondition %}
   ) a    ORDER BY order_id ASC
 ;; indexes: ["order_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: product_ids {
    type: string
    sql: ${TABLE}.product_ids ;;
  }

  dimension: fulfillment_id {
    type: number
    sql: ${TABLE}.fulfillmentId ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: shippable_prod_cnt {
    type: number
    sql: ${TABLE}.shippable_prod_cnt ;;
  }

  dimension: shippable_prod_cnt_fmt {
    type: string
    sql: ${TABLE}.shippable_prod_cnt_fmt ;;
  }

  dimension: order_date {
    type: string
    sql: ${TABLE}.order_date ;;
  }

  dimension: shipped_date {
    type: string
    sql: ${TABLE}.shipped_date ;;
  }

  dimension: shipped_flag {
    type: string
    sql: ${TABLE}.shipped_flag ;;
  }

  dimension: rma_date {
    type: string
    sql: ${TABLE}.rma_date ;;
  }

  dimension: return_date {
    type: string
    sql: ${TABLE}.return_date ;;
  }

  dimension: return_reason {
    type: string
    sql: ${TABLE}.return_reason ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  set: detail {
    fields: [
      product_ids,
      fulfillment_id,
      order_id,
      shippable_prod_cnt,
      shippable_prod_cnt_fmt,
      order_date,
      shipped_date,
      shipped_flag,
      rma_date,
      return_date,
      return_reason,
      status
    ]
  }
}
