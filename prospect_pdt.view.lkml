view: prospect_pdt {
  derived_table: {
    sql: SELECT
                 o.campaign_order_id as campaign_id,
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
                 AND o.is_test_cc IN (0, 1)

         GROUP BY
                 campaign_id
            UNION ALL
           SELECT
                 p.campaign_id AS campaign_id,
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
                 campaign_id
 ;;
indexes: ["prospect_id,campaign_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: sum_prospect {
    type: sum
    sql: ${prospect_cnt} ;;
    drill_fields: [detail*]
  }

  measure: sum_revenue {
    type: sum
    sql: ${total_rev} ;;
  }

  measure: count_prospect {
    type: number
    sql: ${sum_prospect}/NULLIF(${count},0) ;;
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: number
    sql: ${sum_revenue}/NULLIF(${count},0) ;;
  }

  measure: avg_revenue {
    type: number
    sql: ${avg_rev} ;;
  }

  dimension: campaign_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: prospect_cnt {
    type: number
    sql: ${TABLE}.prospect_cnt ;;
  }

  dimension: customer_cnt {
    type: number
    sql: ${TABLE}.customer_cnt ;;
  }

  dimension: avg_rev {
    type: number
    sql: ${TABLE}.avg_rev ;;
  }

  dimension: total_rev {
    type: number
    sql: ${TABLE}.total_rev ;;
  }

  set: detail {
    fields: [campaign_id, prospect_cnt, customer_cnt, avg_rev, total_rev]
  }
}
