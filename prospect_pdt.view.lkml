view: prospect_pdt {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
        IF(LENGTH(group_by_val) = 0, 1, 2)                                                                                                                AS order_val,
        IF(LENGTH(group_by_type) = 0, '', group_by_type)                                                                                                  AS group_by_type,
        IF(LENGTH(sub_group_by_type) = 0, '', sub_group_by_type)                                                                                          AS sub_group_by_type,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_val)                                                                                   AS group_by_val,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_disp)                                                                                  AS group_by_disp,
        SUM(prospect_cnt)                                                                                                                                 AS prospect_cnt,
        FORMAT(SUM(prospect_cnt), 0)                                                                                                                      AS prospect_cnt_fmt,
        SUM(customer_cnt)                                                                                                                                 AS customer_cnt,
        FORMAT(SUM(customer_cnt), 0)                                                                                                                      AS customer_cnt_fmt,
        IF(SUM(customer_cnt) > 0 OR SUM(prospect_cnt) > 0, ROUND((SUM(customer_cnt) / SUM(customer_cnt + prospect_cnt)) * 100, 2), 0)                     AS conversion_pct,
        CONCAT(IF(SUM(customer_cnt) > 0 OR SUM(prospect_cnt) > 0, ROUND((SUM(customer_cnt) / SUM(customer_cnt + prospect_cnt)) * 100, 2), 0), '%') AS conversion_pct_fmt,
        FORMAT(avg_rev, 2)                                                                                                                   AS avg_rev,
        CONCAT('$', FORMAT(avg_rev, 2), '')                                                                     AS avg_rev_fmt,
        total_rev                                                                                                                                         AS total_rev,
        CONCAT('$', FORMAT(total_rev, 2), '')                                                                   AS total_rev_fmt,
        IF(display_link = 1, ':AFF_LINK', '')                                                                                                             AS features
    FROM
        (
           SELECT
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN 'AFID'
                          WHEN LENGTH(o.AID)   > 0 THEN 'AID'
                          WHEN LENGTH(o.AFFID) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    ELSE 'BASE'
                 END group_by_type,
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN 'AFID'
                          WHEN LENGTH(o.AID)   > 0 THEN 'AID'
                          WHEN LENGTH(o.AFFID) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'BASE' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN 'AFID'
                          WHEN LENGTH(o.AID)   > 0 THEN 'AID'
                          WHEN LENGTH(o.AFFID) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN 'SID'
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN 'C1'
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN  'OPT'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN 'C2'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN 'C3'
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN 'SID'
                    WHEN 'AID'   THEN 'OPT'
                    WHEN 'AFFID' THEN 'C1'
                    WHEN 'C1'    THEN 'C2'
                    WHEN 'C2'    THEN 'C3'
                    ELSE ''
                 END sub_group_by_type,
                 CASE 'BASE'
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
                    ELSE c.c_id
                 END group_by_val,
                 CASE 'BASE'
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
                    ELSE CONCAT('(', c.c_id, ') ', c.c_name)
                 END group_by_disp,
                 CASE 'BASE'
                    WHEN 'BASE' THEN 1
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
                 0        AS prospect_cnt,
                 COUNT(distinct o.customers_email_address) AS customer_cnt,
                 ROUND(SUM(ot.main_product_amount_shipping_tax + (
                    SELECT
                          IFNULL(SUM(value), 0)
                      FROM
                           upsell_orders_total uot,
                           upsell_orders uo
                      WHERE
                           uot.upsell_orders_id = uo.upsell_orders_id
                        AND
                           uot.class = 'ot_subtotal'
                        AND
                           uo.main_orders_id = o.orders_id)) / COUNT(distinct o.customers_email_address), 2) AS avg_rev,
                 SUM(ot.main_product_amount_shipping_tax + (
                    SELECT
                          IFNULL(SUM(value), 0)
                      FROM
                           upsell_orders_total uot,
                           upsell_orders uo
                      WHERE
                           uot.upsell_orders_id = uo.upsell_orders_id
                        AND
                           uot.class = 'ot_subtotal'
                        AND
                           uo.main_orders_id = o.orders_id))               AS total_rev
             FROM
                 campaigns          c,
                 orders             o,
                 v_main_order_total ot
            WHERE
                 o.orders_status NOT IN (7, 10, 11)
              AND
                 o.orders_id = ot.orders_id
              AND
                 o.campaign_order_id = c.c_id
              AND
                 o.deleted = 0
              AND
                 o.customers_id > 0
              AND
                 o.parent_order_id = 0
              AND
                 {% condition date_select %} o.t_stamp {% endcondition %}
                 AND
CASE
   WHEN
       o.cc_type = 'checking'
   THEN
       IF('1' = 1, TRUE, FALSE)
   WHEN
       c.is_load_balanced = 1
   THEN
      (
      EXISTS(
             SELECT
                   1
               FROM
                   v_load_balance_currencies v
              WHERE
                   v.lbc_id = c.lbc_id
                AND
                   v.currency_id = '1'
             )
      )
   ELSE
      (
      EXISTS(
             SELECT
                   1
               FROM
                   v_gateway_currency gc
              WHERE
                   o.gatewayId = gc.gatewayId
                AND
                   gc.currencyId = '1'
             )
      )
END
                 AND {% condition is_test %} o.is_test_cc {% endcondition %}

         GROUP BY
                 group_by_val
            UNION
           SELECT
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN 'AFID'
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN 'AID'
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(p.pAFID)  > 0 AND LENGTH(p.pSID) > 0 THEN 'SID'
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1)  > 0 THEN 'C1'
                          WHEN LENGTH(p.pAID)   > 0 AND LENGTH(p.pOPT) > 0 THEN 'OPT'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 THEN 'C2'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 AND LENGTH(p.pC3) > 0 THEN 'C3'
                          ELSE ''
                       END
                    ELSE 'BASE'
                 END group_by_type,
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN 'AFID'
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN 'AID'
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'AFFID' THEN 'C1'
                    WHEN 'C1'    THEN 'C2'
                    ELSE ''
                 END sub_group_by_type,
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN IFNULL(p.pAFID, '')
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN p.pAID
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN p.pAFFID
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(p.pAFID)  > 0 AND LENGTH(p.pSID) > 0 THEN 'SID'
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1)  > 0 THEN 'C1'
                          WHEN LENGTH(p.pAID)   > 0 AND LENGTH(p.pOPT) > 0 THEN 'OPT'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 THEN 'C2'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 AND LENGTH(p.pC3) > 0 THEN 'C3'
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN IFNULL(p.pSID, '')
                    WHEN 'AFFID' THEN IFNULL(p.pC1, '')
                    WHEN 'AID'   THEN IFNULL(p.pOPT, '')
                    WHEN 'C1'    THEN IFNULL(p.pC2, '')
                    WHEN 'C2'    THEN IFNULL(p.pC3, '')
                    ELSE c.c_id
                 END group_by_val,
                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN IFNULL(p.pAFID, '')
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN IFNULL(p.pAID, '')
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN IFNULL(p.pAFFID, '')
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(p.pAFID) > 0 AND LENGTH(p.pSID) > 0 THEN p.pSID
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 THEN p.pC1
                          WHEN LENGTH(p.pAID) > 0 AND LENGTH(p.pOPT) > 0 THEN p.pOPT
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 THEN p.pC2
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 AND LENGTH(p.pC3) > 0 THEN p.pC3
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN IFNULL(p.pSID, '')
                    WHEN 'AFFID' THEN IFNULL(p.pC1, '')
                    WHEN 'AID'   THEN IFNULL(p.pOPT, '')
                    WHEN 'C1'    THEN IFNULL(p.pC2, '')
                    WHEN 'C2'    THEN IFNULL(p.pC3, '')
                    ELSE CONCAT('(', c.c_id, ') ', c.c_name)
                 END group_by_val_disp,
                 CASE 'BASE'
                    WHEN 'BASE' THEN 1
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(p.pAFID)  > 0 THEN
                             IF(LENGTH(MAX(p.pSID)) > 0, 1, 0)
                          WHEN LENGTH(p.pAID)   > 0 THEN
                             IF(LENGTH(MAX(p.pOPT)) > 0, 1, 0)
                          WHEN LENGTH(p.pAFFID) > 0 THEN
                             IF(LENGTH(MAX(p.pC1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 THEN
                             IF(LENGTH(MAX(p.pC1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB2' THEN
                        CASE
                           WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 THEN
                              IF(LENGTH(MAX(p.pC2)) > 0, 1, 0)
                           ELSE
                              0
                        END
                    WHEN 'AFFID' THEN
                       IF(LENGTH(MAX(p.pC2)) > 0, 1, 0)
                    WHEN 'C1' THEN
                       IF(LENGTH(MAX(p.pC2)) > 0, 1, 0)
                    ELSE
                       0
                 END display_link,
                 COUNT(1) AS prospect_cnt,
                 0        AS customer_cnt,
                 0        AS avg_rev,
                 0        AS total_rev
             FROM
                 campaigns c,
                 prospects p
            WHERE
                 p.campaign_id = c.c_id
              AND
                 {% condition date_select %} p.pDate {% endcondition %}
              AND
                 CASE
                 WHEN c.is_load_balanced = 1 THEN
                    (
                       EXISTS
                       (
                          SELECT
                                1
                            FROM
                                v_load_balance_currencies v
                           WHERE
                                v.lbc_id      = c.lbc_id AND
                                v.currency_id = '1'
                       )
                    )
                 ELSE
                    (

                       EXISTS
                       (
                          SELECT
                                1
                            FROM
                                v_gateway_currency gc
                           WHERE
                                c.gateway_id  = gc.gatewayId
                             AND
                                gc.currencyId = '1'
                       )
                    )
                 END

         GROUP BY
                 group_by_val
        ) p
GROUP BY
        group_by_val) a    ORDER BY order_val ASC, CAST(group_by_val AS signed) ASC
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

  dimension: order_val {
    type: number
    sql: ${TABLE}.order_val ;;
  }

  dimension: group_by_type {
    type: string
    sql: ${TABLE}.group_by_type ;;
  }

  dimension: sub_group_by_type {
    type: string
    sql: ${TABLE}.sub_group_by_type ;;
  }

  dimension: campaign {
    type: string
    suggestable: yes
    sql: ${TABLE}.group_by_val ;;
  }

  dimension: campaign_disp {
    type: string
    sql: ${TABLE}.group_by_disp ;;
  }

  dimension: prospect_cnt {
    type: number
    sql: ${TABLE}.prospect_cnt ;;
  }

  dimension: prospect_cnt_fmt {
    type: string
    sql: ${TABLE}.prospect_cnt_fmt ;;
  }

  dimension: customer_cnt {
    type: number
    sql: ${TABLE}.customer_cnt ;;
  }

  dimension: customer_cnt_fmt {
    type: string
    sql: ${TABLE}.customer_cnt_fmt ;;
  }

  dimension: conversion_pct {
    type: number
    sql: ${TABLE}.conversion_pct ;;
  }

  dimension: conversion_pct_fmt {
    type: string
    sql: ${TABLE}.conversion_pct_fmt ;;
  }

  dimension: avg_rev {
    type: string
    sql: ${TABLE}.avg_rev ;;
  }

  dimension: avg_rev_fmt {
    type: string
    sql: ${TABLE}.avg_rev_fmt ;;
  }

  dimension: total_rev {
    type: number
    sql: ${TABLE}.total_rev ;;
  }

  dimension: total_rev_fmt {
    type: string
    sql: ${TABLE}.total_rev_fmt ;;
  }

  dimension: features {
    type: string
    sql: ${TABLE}.features ;;
  }

  measure: count_prospects {
    type: sum_distinct
    sql: ${prospect_cnt} ;;
    sql_distinct_key: ${campaign} ;;
    drill_fields: [detail*]
  }

  measure: count_customers {
    type: sum_distinct
    sql: ${customer_cnt} ;;
    sql_distinct_key: ${campaign} ;;
    drill_fields: [detail*]
  }

  measure: average_revenue {
    type: number
    sql: ${total_revenue}/NULLIF(${count_customers},0) ;;
    value_format_name: decimal_2
    #sql_distinct_key: ${group_by_val} ;;
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    sql: ${total_rev} ;;
    value_format_name: decimal_2
    #sql_distinct_key: ${group_by_val} ;;
    drill_fields: [detail*]
  }

  measure: conversion_percent {
    type: number
    value_format_name: percent_1
    sql: ${count_customers}/NULLIF((${count_customers}+${count_prospects}),0) ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      campaign,
      prospect_cnt,
      prospect_cnt_fmt,
      customer_cnt,
      customer_cnt_fmt,
      conversion_pct,
      conversion_pct_fmt,
      avg_rev,
      avg_rev_fmt,
      total_rev,
      total_rev_fmt,
      features
    ]
  }
}
