view: pdt_sales_by_campaign {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
    order_id,
    is_test_cc,
        IF(LENGTH(group_by_val) = 0, 1, 2)                                                                                                     AS order_val,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_val)                                                                        AS campaign_id,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_val_disp)                                                                   AS campaign,
        affiliate_id                                                          AS affiliate_id,
        sub_affiliate_id                                                      AS sub_affiliate_id,
        sub_aff_2                                                             AS sub_aff_2,
        sub_aff_3                                                             AS sub_aff_3,
        SUM(new_order_cnt)                                                                                                                     AS new_order_cnt,
        FORMAT(SUM(new_order_cnt), 0)                                                                                                          AS new_order_cnt_fmt,
        SUM(new_order_rev)                                                                                             AS new_order_rev,
        FORMAT(SUM(new_order_rev), 2)                                              AS new_order_rev_fmt,
        SUM(recurring_order_cnt)                                                                                                               AS recurring_order_cnt,
        FORMAT(SUM(recurring_order_cnt), 0)                                                                                                    AS recurring_order_cnt_fmt,
        SUM(recurring_order_rev)                                                                                      AS recurring_order_rev,
        SUM(recurring_order_rev)                                        AS recurring_order_rev_fmt,
        SUM(shipping_cnt)                                                                                                                      AS shipping_cnt,
        FORMAT(SUM(shipping_cnt), 0)                                                                                                           AS shipping_cnt_fmt,
        SUM(shipping_rev)                                                                                             AS shipping_rev,
        SUM(shipping_rev)                                               AS shipping_rev_fmt,
        SUM(all_new_order_cnt)                                                                                                                 AS all_new_order_cnt,
        FORMAT(SUM(all_new_order_cnt), 0)                                                                                                      AS all_new_order_cnt_fmt,
        SUM(all_new_order_rev)                                                                                         AS all_new_order_rev,
        SUM(all_new_order_rev)                                           AS all_new_order_rev_fmt,
        SUM(pending_order_cnt)                                                                                                                 AS pending_order_cnt,
        FORMAT(SUM(pending_order_cnt), 0)                                                                                                      AS pending_order_cnt_fmt,
        SUM(pending_order_rev)                                                                                         AS pending_order_rev,
        SUM(pending_order_rev)                                           AS pending_order_rev_fmt,
        FORMAT(SUM(taxable_rev), 2)                                                                                               AS taxable_rev,
        SUM(taxable_rev)                                                 AS taxable_rev_fmt,
        SUM(decline_cnt)                                                                                                                       AS decline_cnt,
        FORMAT(SUM(decline_cnt), 0)                                                                                                            AS decline_cnt_fmt,
        SUM(decline_rev)                                                                                               AS decline_rev,
        SUM(decline_rev)                                                 AS decline_rev_fmt,
        SUM(refund_void_cnt)                                                                                                                   AS refund_void_cnt,
        FORMAT(SUM(refund_void_cnt), 0)                                                                                                        AS refund_void_cnt_fmt,
        SUM(refund_void_rev)                                                                                           AS refund_void_rev,
        SUM(refund_void_rev)                                             AS refund_void_rev_fmt,
        SUM(active_cnt)                                                                                                                        AS active_cnt,
        FORMAT(SUM(active_cnt), 0)                                                                                                             AS active_cnt_fmt,
        IF(SUM(all_new_order_cnt) > 0,
           SUM(all_new_order_rev) / SUM(all_new_order_cnt),
           0
        )                                                                                                                     AS avg_rev,
        IF(SUM(all_new_order_cnt) > 0,
           SUM(all_new_order_rev) / SUM(all_new_order_cnt),
           0
        )                                                                                                 AS avg_rev_fmt,
        SUM(hold_cnt)                                                                                                                          AS hold_cnt,
        FORMAT(SUM(hold_cnt), 0)                                                                                                               AS hold_cnt_fmt,
        SUM(hold_rev)                                AS hold_rev,
        SUM(hold_rev_o)                                AS hold_rev_o,
        SUM(hold_cnt_outside)                                                                                                                  AS hold_cnt_outside,
        FORMAT(SUM(hold_cnt_outside), 0)                                                                                                       AS hold_cnt_outside_fmt,
        SUM(chargeback_cnt)                                                                                                                    AS chargeback_cnt,
        FORMAT(SUM(chargeback_cnt), 0)                                                                                                         AS chargeback_cnt_fmt,
        (IF(SUM(all_new_order_cnt) > 0, (SUM(chargeback_cnt) / SUM(all_new_order_cnt)), 0) * 100)                                   AS chargeback_pct,
        (IF(SUM(all_new_order_cnt) > 0, (SUM(chargeback_cnt) / SUM(all_new_order_cnt)), 0) * 100)                                  AS chargeback_pct_fmt,
        IF(MAX(display_link) = 1, ':AFF_LINK', '')                                                                                             AS features,
        GROUP_CONCAT(DISTINCT(products_id))                                        AS prod_ids,
        currency_id AS currency_id,
        currency_symbol                                                           AS currency_symbol
    FROM
        (
           SELECT
                 o.orders_id AS order_id,
                 o.is_test_cc as is_test_cc,

                   CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN  o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN  o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN  o.AFFID
                          ELSE 'BLANK'
                    END  affiliate_id,

                   CASE
                      WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                      WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN  o.OPT
                      ELSE 'BLANK'
                   END sub_affiliate_id,

                   CASE
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                      ELSE 'BLANK'
                   END sub_aff_2,

                   CASE
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                      ELSE 'BLANK'
                   END sub_aff_3,

                 CASE 'CID'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN o.AFFID
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                        CASE
                           WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                           WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                           WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN o.OPT
                           ELSE ''
                        END
                    WHEN 'ALL_SUB2' THEN
                        CASE
                           WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                           ELSE ''
                        END
                    WHEN 'ALL_SUB3' THEN
                        CASE
                           WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                           ELSE ''
                        END
                    WHEN 'AFID'  THEN o.SID
                    WHEN 'AFFID' THEN o.C1
                    WHEN 'AID'   THEN o.OPT
                    WHEN 'C1'    THEN o.C2
                    WHEN 'C2'    THEN o.C3
                    WHEN 'DATE'  THEN
                       IF((o.hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))),
                          DATE(o.hold_date),
                          DATE(o.t_stamp)
                       )
                    ELSE o.campaign_order_id
                 END group_by_val,
                 CASE 'CID'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN o.AFFID
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN o.OPT
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                        CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN o.SID
                    WHEN 'AFFID' THEN o.C1
                    WHEN 'AID'   THEN o.OPT
                    WHEN 'C1'    THEN o.C2
                    WHEN 'C2'    THEN o.C3
                    WHEN 'DATE'  THEN
                       IF((o.hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))),
                          DATE_FORMAT(o.hold_date, '%m/%d/%Y'),
                          DATE_FORMAT(o.t_stamp, '%m/%d/%Y')
                       )
                    ELSE CONCAT('(', c.c_id, ') ', c.c_name)
                 END group_by_val_disp,
                 CASE 'CID'
                    WHEN 'CID' THEN
                       1
                    WHEN 'DATE' THEN
                       1
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN
                             IF(LENGTH(MAX(o.SID)) > 0, 1, 0)
                          WHEN LENGTH(o.AID)   > 0 THEN
                             IF(LENGTH(MAX(o.OPT)) > 0, 1, 0)
                          WHEN LENGTH(o.AFFID) > 0 THEN
                             IF(LENGTH(MAX(o.C1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 THEN
                             IF(LENGTH(MAX(o.C1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB2' THEN
                        CASE
                           WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN
                              IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                           ELSE
                              0
                        END
                    WHEN 'AFFID' THEN
                       IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                    WHEN 'C1' THEN
                       IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                    ELSE
                       0
                 END display_link,
                 o.campaign_order_id AS campaign_order_id,
                 o.t_stamp,
                 SUM(new_order_cnt)         AS new_order_cnt,
                 SUM(new_order_rev)         AS new_order_rev,
                 SUM(recurring_order_cnt)   AS recurring_order_cnt,
                 SUM(recurring_order_rev)   AS recurring_order_rev,
                 SUM(shipping_cnt)          AS shipping_cnt,
                 SUM(shipping_rev)          AS shipping_rev,
                 SUM(all_new_order_cnt)     AS all_new_order_cnt,
                 SUM(all_new_order_rev)     AS all_new_order_rev,
                 SUM(pending_order_cnt)     AS pending_order_cnt,
                 SUM(pending_order_rev)     AS pending_order_rev,
                 SUM(refund_void_cnt)       AS refund_void_cnt,
                 SUM(refund_void_rev)       AS refund_void_rev,
                 SUM(taxable_rev)           AS taxable_rev,
                 SUM(active_cnt)            AS active_cnt,
                 SUM(decline_cnt)           AS decline_cnt,
                 SUM(decline_rev)           AS decline_rev,
                 SUM(hold_cnt)              AS hold_cnt,
                 SUM(hold_rev)              AS hold_rev,
                 SUM(hold_rev_o)            AS hold_rev_o,
                 SUM(hold_cnt_outside)      AS hold_cnt_outside,
                 SUM(chargeback_cnt)        AS chargeback_cnt,
                 currency_id                AS currency_id,
                 products_id                AS products_id,
                currency_symbol             AS currency_symbol
             FROM
                 orders o,
                 campaigns c,
                 (
                    SELECT
                          o.orders_id,
                          op.products_id AS products_id,
                          COUNT(IF(o.orders_status IN (2,8) AND o.rebillDepth = 0, 1, NULL))                                                                         AS new_order_cnt,
                          SUM(IF(o.orders_status IN (2,8) AND o.rebillDepth = 0, ot.current_total + f_upsell_order_total(o.orders_id), 0))                           AS new_order_rev,
                          COUNT(IF(o.orders_status IN (2,8) AND o.parent_order_id > 0 AND o.rebillDepth > 0, 1, NULL))                                               AS recurring_order_cnt,
                          SUM(IF(o.orders_status IN (2,8) AND o.parent_order_id > 0 AND o.rebillDepth > 0, ot.current_total + f_upsell_order_total(o.orders_id), 0)) AS recurring_order_rev,
                          COUNT(IF(
                             o.orders_status NOT IN(7, 10, 11) AND
                             (o.payment_module_code = 1 OR IFNULL((SELECT MAX(payment_module_code) FROM upsell_orders uo WHERE uo.main_orders_id = o.orders_id), 0) = 1),
                             1, NULL))                                      AS shipping_cnt,
                          SUM(IF(
                             o.orders_status NOT IN(7, 10, 11) AND
                             (o.payment_module_code = 1 OR IFNULL((SELECT MAX(payment_module_code) FROM upsell_orders uo WHERE uo.main_orders_id = o.orders_id), 0) = 1) AND
                             o.refundType < 2,
                             ot.shipping_amount, 0))                                                                                                                 AS shipping_rev,
                          COUNT(IF(o.orders_status IN (2,8), 1, NULL))                                                                                               AS all_new_order_cnt,
                          SUM(IF(o.orders_status IN (2,8), ot.current_total + f_upsell_order_total(o.orders_id), 0))                                                 AS all_new_order_rev,
                          COUNT(IF(o.orders_status IN (10, 11), 1, NULL))                                                                                            AS pending_order_cnt,
                          SUM(IF(o.orders_status IN (10, 11), ot.current_total + f_upsell_order_total(o.orders_id), 0))                                              AS pending_order_rev,
                          COUNT(IF(o.refundType > 1, 1, NULL))                                                                                                       AS refund_void_cnt,
                          SUM(ot.refunded_amount)                                                                                                                    AS refund_void_rev,
                          SUM(IF(o.orders_status NOT IN (6,7), ot.tax_factor, 0))                                                                                    AS taxable_rev,
                          COUNT(IF(o.is_recurring AND o.orders_status IN (2,8), 1, NULL))                                                                            AS active_cnt,
                          0                                                                                                                                          AS decline_cnt,
                          0                                                                                                                                          AS decline_rev,
                          0                                                                                                                                          AS hold_cnt,
                          0                                                                                                                                          AS hold_rev,
                          0                                                                                                                                          AS hold_cnt_outside,
                          0                                                                                                                                          AS hold_rev_o,
                          COUNT(IF(o.isChargeback = 1, 1, NULL))                                                                                                     AS chargeback_cnt,
                          v.currency_id AS currency_id,
                          v.html_entity_name AS currency_symbol
                       FROM
                           v_main_order_total   ot,
                           orders_products op,
                           campaigns       c,
                           orders          o,
                           v_campaign_currencies v
                      WHERE
                           o.deleted           = 0
                        AND
                           o.campaign_order_id = c.c_id
                        AND
                           o.orders_id         = ot.orders_id
                        AND
                           o.orders_id         = op.orders_id
                        AND
                           v.c_id = o.campaign_order_id
                        AND
                           {% condition date_select %} o.t_stamp {% endcondition %}

                   GROUP BY
                           o.orders_id
                  UNION ALL
                     SELECT
                           o.orders_id,
                           "" AS products_id,
                           0                                                    AS new_order_cnt,
                           0                                                    AS new_order_rev,
                           0                                                    AS recurring_order_cnt,
                           0                                                    AS recurring_order_rev,
                           0                                                    AS shipping_cnt,
                           0                                                    AS shipping_rev,
                           0                                                    AS all_new_order_cnt,
                           0                                                    AS all_new_order_rev,
                           0                                                    AS pending_order_cnt,
                           0                                                    AS pending_order_rev,
                           0                                                    AS refund_void_cnt,
                           0                                                    AS refund_void_rev,
                           0                                                    AS taxable_rev,
                           0                                                    AS active_cnt,
                           0                                                    AS decline_cnt,
                           0                                                    AS decline_rev,
                           COUNT(IF(outside = 0, 1, NULL))                      AS hold_cnt,
                           (IF(outside = 0, IFNULL(o.currency_value, 0), 0))                         AS hold_rev,
                           COUNT(IF(outside = 1, 1, NULL))                      AS hold_cnt_outside,
                           (IF(outside = 1, IFNULL(o.currency_value, 0), 0)) AS hold_rev_o,
                           0                                                    AS chargeback_cnt,
                           0 as currency_id,
                           0 as currency_symbol
                       FROM
                           orders o,
                           (
                              SELECT
                                    o.orders_id,
                                    IFNULL(currency_value, 0) AS currency_value,
                                    IF((hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))), 1, 0) AS outside
                               FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                 AND
                                    (
                                       {% condition date_select %} o.t_stamp {% endcondition %}
                                        OR
                                                  {% condition date_select %} o.hold_date {% endcondition %}
                                    )

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    IF((uo.hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (uo.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))), 1, 0) AS outside
                               FROM
                                    orders        o,
                                    upsell_orders uo
                               WHERE
                                    o.orders_id = uo.main_orders_id
                                 AND
                                    uo.is_hold = 1
                                 AND
                                    (
                                       {% condition date_select %} uo.t_stamp {% endcondition %}
                                        OR
                                                  {% condition date_select %} uo.hold_date {% endcondition %}

                                    )

                           ) oh
                      WHERE
                           o.orders_id = oh.orders_id
                        AND
                           o.deleted   = 0
                   GROUP BY
                           o.orders_id
                  UNION ALL
                     SELECT
                           d.orders_id,
                           "" AS products_id,
                           0                                         AS new_order_cnt,
                           0                                         AS new_order_rev,
                           0                                         AS recurring_order_cnt,
                           0                                         AS recurring_order_rev,
                           0                                         AS shipping_cnt,
                           0                                         AS shipping_rev,
                           0                                         AS all_new_order_cnt,
                           0                                         AS all_new_order_rev,
                           0                                         AS pending_order_cnt,
                           0                                         AS pending_order_rev,
                           0                                         AS refund_void_cnt,
                           0                                         AS refund_void_rev,
                           0                                         AS taxable_rev,
                           0                                         AS active_cnt,
                           d.cnt                                     AS decline_cnt,
                           d.rev                                     AS decline_rev,
                           0                                         AS hold_cnt,
                           0                                         AS hold_rev,
                           0                                         AS hold_cnt_outside,
                           0                                         AS hold_rev_o,
                           0                                         AS chargeback_cnt,
                           0 as currency_id,
                           0 as currency_symbol
                       FROM
                           (
                              SELECT
                                    d.orders_id,
                                    d.join_val,
                                    1          AS cnt,
                                    SUM(d.rev) AS rev
                                FROM
                                    (
                                       SELECT
                                             MAX(o.orders_id) AS orders_id,
                                             CONCAT(o.campaign_order_id, o.customers_email_address)       AS join_val,
                                             ot.main_product_amount_shipping_tax + f_upsell_order_total(o.orders_id) AS rev
                                         FROM
                                             orders o,
                                             v_main_order_total ot
                                        WHERE
                                             o.deleted   = 0
                                          AND
                                             o.orders_id = ot.orders_id
                                          AND
                                             o.orders_status = 7
                                          AND
                                             o.wasSalvaged   = 0
                                          AND
                                             {% condition date_select %} o.t_stamp {% endcondition %}

                                     GROUP BY
                                             CONCAT(o.campaign_order_id, o.customers_email_address),
                                             ot.main_product_amount_shipping_tax + f_upsell_order_total(o.orders_id)
                                    ) d
                            GROUP BY
                                    d.join_val
                           ) d
                   GROUP BY
                           d.orders_id
                 ) x
            WHERE
                 o.orders_id = x.orders_id
              AND
                 o.deleted   = 0
               AND
                o.gatewayId IS NOT NULL
              AND
                 o.campaign_order_id = c.c_id

         GROUP BY
                 o.orders_id
        ) o
GROUP BY
        order_id) a    ORDER BY order_val ASC, CAST(campaign_id AS signed) ASC
 ;;  indexes: ["order_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: date_select {
    type: date
    default_value: "today"
  }

  dimension: is_test_cc {
    type: yesno
    sql: ${TABLE}.is_test_cc = 1 ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: affiliate_id {
    type: string
    sql: ${TABLE}.affiliate_id ;;
  }

  dimension: sub_affiliate_id {
    type: string
    sql: ${TABLE}.sub_affiliate_id ;;
  }

  dimension: sub_aff_2 {
    type: string
    sql: ${TABLE}.sub_aff_2 ;;
  }

  dimension: sub_aff_3 {
    type: string
    sql: ${TABLE}.sub_aff_3 ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}.currency_id ;;
  }

  dimension: currency_symbol {
    type: string
    sql: CASE WHEN ${TABLE}.currency_symbol = '0' THEN '$' ELSE ${TABLE}.currency_symbol END ;;
  }

  dimension: currency_fmt {
    hidden: no
    suggestions: ["USD","EUR","GBP","CAD","AUD","ZAR","JPY","DKK","NOK","SEK","BRL","CLP"]
    type: string
    sql: CASE WHEN ${currency_id} = 1 THEN 'USD'
            WHEN ${currency_id} = 2 THEN 'EUR'
            WHEN ${currency_id} = 3 THEN 'GBP'
            WHEN ${currency_id} = 4 THEN 'CAD'
            WHEN ${currency_id} = 5 THEN 'AUD'
            WHEN ${currency_id} = 6 THEN 'ZAR'
            WHEN ${currency_id} = 7 THEN 'JPY'
            WHEN ${currency_id} = 8 THEN 'DKK'
            WHEN ${currency_id} = 9 THEN 'NOK'
            WHEN ${currency_id} = 10 THEN 'SEK'
            WHEN ${currency_id} = 11 THEN 'BRL'
            WHEN ${currency_id} = 12 THEN 'CLP'
            WHEN ${currency_id} = 13 THEN 'MXN'
            WHEN ${currency_id} = 14 THEN 'KRW'
            WHEN ${currency_id} = 15 THEN 'NZD'
            WHEN ${currency_id} = 16 THEN 'PLN'
            WHEN ${currency_id} = 17 THEN 'SGD'
            WHEN ${currency_id} = 18 THEN 'HKD'
            WHEN ${currency_id} = 19 THEN 'ARS'
            ELSE 'USD'
       END ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: new_order_cnt {
    type: number
    sql: ${TABLE}.new_order_cnt ;;
  }

  dimension: new_order_cnt_fmt {
    type: string
    sql: ${TABLE}.new_order_cnt_fmt ;;
  }

  dimension: new_order_rev {
    type: number
    sql: ${TABLE}.new_order_rev ;;
  }

  dimension: new_order_rev_fmt {
    type: number
    sql: ${TABLE}.new_order_rev_fmt ;;
  }

  dimension: recurring_order_cnt {
    type: number
    sql: ${TABLE}.recurring_order_cnt ;;
  }

  dimension: recurring_order_cnt_fmt {
    type: string
    sql: ${TABLE}.recurring_order_cnt_fmt ;;
  }

  dimension: recurring_order_rev {
    type: number
    sql: ${TABLE}.recurring_order_rev ;;
  }

  dimension: recurring_order_rev_fmt {
    type: number
    sql: ${TABLE}.recurring_order_rev_fmt ;;
  }

  dimension: shipping_cnt {
    type: number
    sql: ${TABLE}.shipping_cnt ;;
  }

  dimension: shipping_cnt_fmt {
    type: number
    sql: ${TABLE}.shipping_cnt_fmt ;;
  }

  dimension: shipping_rev {
    type: number
    sql: ${TABLE}.shipping_rev ;;
  }

  dimension: shipping_rev_fmt {
    type: string
    sql: ${TABLE}.shipping_rev_fmt ;;
  }

  dimension: all_new_order_cnt {
    type: number
    sql: ${TABLE}.all_new_order_cnt ;;
  }

  dimension: all_new_order_cnt_fmt {
    type: string
    sql: ${TABLE}.all_new_order_cnt_fmt ;;
  }

  dimension: all_new_order_rev {
    type: number
    sql: ${TABLE}.all_new_order_rev ;;
  }

  dimension: all_new_order_rev_fmt {
    type: string
    sql: ${TABLE}.all_new_order_rev_fmt ;;
  }

  dimension: pending_order_cnt {
    type: number
    sql: ${TABLE}.pending_order_cnt ;;
  }

  dimension: pending_order_cnt_fmt {
    type: string
    sql: ${TABLE}.pending_order_cnt_fmt ;;
  }

  dimension: pending_order_rev {
    type: number
    sql: ${TABLE}.pending_order_rev ;;
  }

  dimension: pending_order_rev_fmt {
    type: string
    sql: ${TABLE}.pending_order_rev_fmt ;;
  }

  dimension: taxable_rev {
    type: number
    sql: ${TABLE}.taxable_rev ;;
  }

  dimension: taxable_rev_fmt {
    type: string
    sql: ${TABLE}.taxable_rev_fmt ;;
  }

  dimension: decline_cnt {
    type: number
    sql: ${TABLE}.decline_cnt ;;
  }

  dimension: decline_cnt_fmt {
    type: string
    sql: ${TABLE}.decline_cnt_fmt ;;
  }

  dimension: decline_rev {
    type: number
    sql: ${TABLE}.decline_rev ;;
  }

  dimension: decline_rev_fmt {
    type: string
    sql: ${TABLE}.decline_rev_fmt ;;
  }

  dimension: refund_void_cnt {
    type: number
    sql: ${TABLE}.refund_void_cnt ;;
  }

  dimension: refund_void_cnt_fmt {
    type: string
    sql: ${TABLE}.refund_void_cnt_fmt ;;
  }

  dimension: refund_void_rev {
    type: number
    sql: ${TABLE}.refund_void_rev ;;
  }

  dimension: refund_void_rev_fmt {
    type: string
    sql: ${TABLE}.refund_void_rev_fmt ;;
  }

  dimension: active_cnt {
    type: number
    sql: ${TABLE}.active_cnt ;;
  }

  dimension: active_cnt_fmt {
    type: string
    sql: ${TABLE}.active_cnt_fmt ;;
  }

  dimension: avg_rev {
    type: number
    sql: ${TABLE}.avg_rev ;;
  }

  dimension: avg_rev_fmt {
    type: string
    sql: ${TABLE}.avg_rev_fmt ;;
  }

  dimension: hold_cnt {
    type: number
    sql: ${TABLE}.hold_cnt ;;
  }

  dimension: hold_cnt_fmt {
    type: string
    sql: ${TABLE}.hold_cnt_fmt ;;
  }

  dimension: hold_rev {
    type: number
    sql: ${TABLE}.hold_rev ;;
  }

  dimension: hold_rev_o {
    type: number
    sql: ${TABLE}.hold_rev_o ;;
  }

  dimension: hold_rev_fmt {
    type: string
    sql: ${TABLE}.hold_rev_fmt ;;
  }

  dimension: hold_cnt_outside {
    type: number
    sql: ${TABLE}.hold_cnt_outside ;;
  }

  dimension: hold_cnt_outside_fmt {
    type: string
    sql: ${TABLE}.hold_cnt_outside_fmt ;;
  }

  dimension: chargeback_cnt {
    type: number
    sql: ${TABLE}.chargeback_cnt ;;
  }

  dimension: chargeback_cnt_fmt {
    type: number
    sql: ${TABLE}.chargeback_cnt_fmt ;;
  }

  dimension: chargeback_pct {
    type: number
    sql: ${TABLE}.chargeback_pct ;;
  }

  dimension: chargeback_pct_fmt {
    type: number
    sql: ${TABLE}.chargeback_pct_fmt ;;
  }

  dimension: features {
    type: string
    sql: ${TABLE}.features ;;
  }

  dimension: prod_ids {
    type: string
    sql: ${TABLE}.prod_ids ;;
  }

  measure: initial {
    type: sum
    sql: ${new_order_cnt} ;;
  }

  measure: initial_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${new_order_rev}), 2)) ;;
  }

  measure: shipping {
    type: sum
    sql: ${shipping_cnt} ;;
  }

  measure: shipping_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${shipping_rev}), 2)) ;;
  }

  measure: subscription {
    type: sum
    sql: ${recurring_order_cnt} ;;
  }

  measure: subscription_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${recurring_order_rev_fmt}), 2)) ;;
  }

  measure: total {
    type: sum
    sql: ${all_new_order_cnt} ;;
  }

  measure: total_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${all_new_order_rev}), 2)) ;;
  }

  measure: total_revenue_hide {
    hidden: yes
    type: sum
    value_format_name: decimal_2
    sql: ${all_new_order_rev} ;;
  }

  measure: tax_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${taxable_rev}), 2)) ;;
  }

  measure: pending {
    type: sum
    sql: ${pending_order_cnt} ;;
  }

  measure: pending_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${pending_order_rev}), 2)) ;;
  }

  measure: declines {
    type: sum
    sql: ${decline_cnt} ;;
  }

  measure: decline_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${decline_rev}), 2)) ;;
  }

  measure: void_refund {
    type: sum
    sql: ${refund_void_cnt} ;;
  }

  measure: void_refund_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${refund_void_rev}), 2)) ;;
  }

  measure: holds_cancel_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM((${hold_rev} + ${hold_rev_o})), 2)) ;;
  }

  measure: chargebacks {
    type: sum
    sql: ${chargeback_cnt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: chargeback_percent {
    label: "Chargeback %"
    type: number
    sql: ${chargebacks}/${total} ;;
    value_format_name: percent_1
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: active_subscriptions {
    type: sum
    sql: ${active_cnt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: avg_order {
    type: number
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${total_revenue_hide}/NULLIF(${total},0) ;;
    value_format_name: decimal_2
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: count_hold {
    label: "Holds/Cancels"
    type: sum
    sql: ${hold_cnt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: count_prior_hold {
    label: "Prior Holds/Cancels"
    type: sum
    sql: ${hold_cnt_outside} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: product_id_list {
    label: "Product Ids Included"
    type: string
    sql: SUBSTRING(GROUP_CONCAT(DISTINCT(${prod_ids})),2,20) ;;
  }

  measure: affiliate_breakdown {
    sql: "Affiliate ID" ;;
    description: "Sales by Campaign"
    label: "Affiliate Breakdown"
    drill_fields: [product_drill*]
  }

  measure: sub_affiliate_breakdown {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Campaign"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [product_drill_1*]
  }

  measure: sub_affiliate_breakdown_2 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Campaign"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [product_drill_2*]
  }

  measure: sub_affiliate_breakdown_3 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Campaign"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [product_drill_3*]
  }

  set: product_drill {
    fields: [affiliate_id,initial ,initial_revenue, subscription , subscription_revenue, shipping, shipping_revenue,total, total_revenue, pending, pending_revenue, tax_revenue, declines, decline_revenue,void_refund, void_refund_revenue,count_hold, count_prior_hold, holds_cancel_revenue, chargebacks, chargeback_percent, active_subscriptions, avg_order, sub_affiliate_breakdown]
  }

  set: product_drill_1 {
    fields: [sub_affiliate_id, initial ,initial_revenue, subscription , subscription_revenue, shipping, shipping_revenue,total, total_revenue, pending, pending_revenue, tax_revenue, declines, decline_revenue,void_refund, void_refund_revenue,count_hold, count_prior_hold, holds_cancel_revenue, chargebacks, chargeback_percent, active_subscriptions, avg_order,sub_affiliate_breakdown_2]
  }

  set: product_drill_2 {
    fields: [sub_aff_2,initial ,initial_revenue, subscription , subscription_revenue, shipping, shipping_revenue,total, total_revenue, pending, pending_revenue, tax_revenue, declines, decline_revenue,void_refund, void_refund_revenue,count_hold, count_prior_hold, holds_cancel_revenue, chargebacks, chargeback_percent, active_subscriptions, avg_order,sub_affiliate_breakdown_3]
  }

  set: product_drill_3 {
    fields: [sub_aff_3, initial ,initial_revenue, subscription , subscription_revenue, shipping, shipping_revenue,total, total_revenue, pending, pending_revenue, tax_revenue, declines, decline_revenue,void_refund, void_refund_revenue,count_hold, count_prior_hold, holds_cancel_revenue, chargebacks, chargeback_percent, active_subscriptions, avg_order]
  }

  set: detail {
    fields: [
      campaign_id,
      campaign,
      new_order_cnt,
      new_order_cnt_fmt,
      new_order_rev,
      new_order_rev_fmt,
      recurring_order_cnt,
      recurring_order_cnt_fmt,
      recurring_order_rev,
      recurring_order_rev_fmt,
      shipping_cnt,
      shipping_cnt_fmt,
      shipping_rev,
      shipping_rev_fmt,
      all_new_order_cnt,
      all_new_order_cnt_fmt,
      all_new_order_rev,
      all_new_order_rev_fmt,
      pending_order_cnt,
      pending_order_cnt_fmt,
      pending_order_rev,
      pending_order_rev_fmt,
      taxable_rev,
      taxable_rev_fmt,
      decline_cnt,
      decline_cnt_fmt,
      decline_rev,
      decline_rev_fmt,
      refund_void_cnt,
      refund_void_cnt_fmt,
      refund_void_rev,
      refund_void_rev_fmt,
      active_cnt,
      active_cnt_fmt,
      avg_rev,
      avg_rev_fmt,
      hold_cnt,
      hold_cnt_fmt,
      hold_rev,
      hold_rev_fmt,
      hold_cnt_outside,
      hold_cnt_outside_fmt,
      chargeback_cnt,
      chargeback_cnt_fmt,
      chargeback_pct,
      chargeback_pct_fmt,
      features,
      prod_ids
    ]
  }
}
