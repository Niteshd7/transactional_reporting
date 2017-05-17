view: prospect_pdt {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
        IF(LENGTH(group_by_val) = 0, 1, 2)                                                                                                                AS order_val,
        affiliate_id                                                          AS affiliate_id,
        sub_affiliate_id                                                      AS sub_affiliate_id,
        sub_aff_2                                                             AS sub_aff_2,
        sub_aff_3                                                             AS sub_aff_3,
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
        IF(total_rev IS NOT NULL, total_rev,0)                                                                                                                                         AS total_rev,
        CONCAT('$', FORMAT(total_rev, 2), '')                                                                   AS total_rev_fmt,
        IF(display_link = 1, ':AFF_LINK', '')                                                                                                             AS features,
        currency_id AS currency_id,
        currency_symbol  AS currency_symbol
    FROM
        (
           SELECT
                 r.currency_id    AS currency_id,
                r.currency_symbol  AS currency_symbol,
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
                 order_report       r,
                 v_main_order_total ot
            WHERE
                 o.orders_status NOT IN (7, 10, 11)
              AND
                 o.orders_id = ot.orders_id
              AND
                 r.upsell_flag = 0
              AND
                 o.orders_id         = r.order_id
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

                 AND {% condition is_test %} o.is_test_cc {% endcondition %}

         GROUP BY
                 group_by_val
            UNION
           SELECT
                 0  AS currency_id,
                 0  AS currency_symbol,
                CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN IFNULL(p.pAFID, '')
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN p.pAID
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN p.pAFFID
                          ELSE 'BLANK'
                       END AS  affiliate_id,

                  CASE
                          WHEN LENGTH(p.pAFID)  > 0 AND LENGTH(p.pSID) > 0 THEN p.pSID
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1)  > 0 THEN p.pC1
                          WHEN LENGTH(p.pAID)   > 0 AND LENGTH(p.pOPT) > 0 THEN p.pOPT
                          ELSE 'BLANK'
                       END AS sub_affiliate_id,

                  CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 THEN p.pC2
                          ELSE 'BLANK'
                       END AS sub_aff_2,

                  CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 AND LENGTH(p.pC3) > 0 THEN p.pC3
                          ELSE 'BLANK'
                       END AS sub_aff_3,

                 CASE 'BASE'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(IFNULL(p.pAFID, ''))  > 0 THEN IFNULL(p.pAFID, 'BLANK')
                          WHEN LENGTH(IFNULL(p.pAID, ''))   > 0 THEN p.pAID
                          WHEN LENGTH(IFNULL(p.pAFFID, '')) > 0 THEN p.pAFFID
                          ELSE 'BLANK'
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(p.pAFID)  > 0 AND LENGTH(p.pSID) > 0 THEN 'SID'
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1)  > 0 THEN 'C1'
                          WHEN LENGTH(p.pAID)   > 0 AND LENGTH(p.pOPT) > 0 THEN 'OPT'
                          ELSE 'BLANK'
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 THEN 'C2'
                          ELSE 'BLANK'
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(p.pAFFID) > 0 AND LENGTH(p.pC1) > 0 AND LENGTH(p.pC2) > 0 AND LENGTH(p.pC3) > 0 THEN 'C3'
                          ELSE 'BLANK'
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

         GROUP BY
                 group_by_val
        ) p
GROUP BY
        group_by_val) a    ORDER BY order_val ASC, CAST(group_by_val AS signed) ASC
 ;; indexes: ["group_by_val"]
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
    full_suggestions: yes
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
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${total_revenue}/NULLIF(${count_customers},0) ;;
    value_format_name: decimal_2
    #sql_distinct_key: ${group_by_val} ;;
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${total_rev} ;;
    #sql_distinct_key: ${group_by_val} ;;
    drill_fields: [detail*]
  }

  measure: conversion_percent {
    type: number
    value_format_name: percent_1
    sql: ${count_customers}/NULLIF((${count_customers}+${count_prospects}),0) ;;
    drill_fields: [detail*]
  }

  measure: affiliate_breakdown {
    sql: "Affiliate ID" ;;
    description: "Sales by Prospect"
    label: "Affiliate Breakdown"
    drill_fields: [prospect_drill*]
  }

  measure: sub_affiliate_breakdown {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Prospect"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [prospect_drill_1*]
  }

  measure: sub_affiliate_breakdown_2 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Prospect"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [prospect_drill_2*]
  }

  measure: sub_affiliate_breakdown_3 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Prospect"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [prospect_drill_3*]
  }

  set: prospect_drill {
    fields: [affiliate_id,count_prospects, count_customers, conversion_percent, total_revenue, average_revenue, sub_affiliate_breakdown]
  }

  set: prospect_drill_1 {
    fields: [sub_affiliate_id, count_prospects, count_customers, conversion_percent, total_revenue, average_revenue,sub_affiliate_breakdown_2]
  }

  set: prospect_drill_2 {
    fields: [sub_aff_2,count_prospects, count_customers, conversion_percent, total_revenue, average_revenue,sub_affiliate_breakdown_3]
  }

  set: prospect_drill_3 {
    fields: [sub_aff_3, count_prospects, count_customers, conversion_percent, total_revenue, average_revenue]
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
