view: prospect_pdt {
  derived_table: {
    sql: SELECT
        campaign                                                                                                                                          AS campaign,
        SUM(prospect_cnt)                                                                                                                                 AS prospect_cnt,
        FORMAT(SUM(prospect_cnt), 0)                                                                                                                      AS prospect_cnt_fmt,
        SUM(customer_cnt)                                                                                                                                 AS customer_cnt,
        FORMAT(SUM(customer_cnt), 0)                                                                                                                      AS customer_cnt_fmt,
        total_rev                                                                                                                                         AS total_rev,
        CONCAT('$', FORMAT(total_rev, 2), '')                                                                   AS total_rev_fmt
    FROM
           (SELECT
                 c.c_id as campaign,
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
                 {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
              AND
                 o.is_test_cc IN (0, 1)

         GROUP BY
                 campaign
            UNION
           SELECT
                 c.c_id as campaign,
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
                 {% condition orders.t_stamp_date %} p.pDate {% endcondition %}

         GROUP BY
                 campaign)p
    GROUP BY
    campaign
 ;; indexes: ["campaign"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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

  measure: conversion_percent {
    type: number
    value_format_name: percent_2
    sql: ${count_customers}/NULLIF((${count_customers}+${count_prospects}),0) ;;
    drill_fields: [detail*]
  }

  dimension: campaign {
    type: number
    sql: ${TABLE}.campaign ;;
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

  dimension: total_rev {
    type: number
    sql: ${TABLE}.total_rev ;;
  }

  dimension: total_rev_fmt {
    type: string
    sql: ${TABLE}.total_rev_fmt ;;
  }

  set: detail {
    fields: [
      campaign,
      prospect_cnt,
      prospect_cnt_fmt,
      customer_cnt,
      total_rev,
      total_rev_fmt
    ]
  }
}
