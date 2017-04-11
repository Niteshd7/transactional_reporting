view: decline_hold_pdt_campaign {
  derived_table: {
    sql: SELECT
                           d.orders_id,
                           d.cnt                                     AS decline_cnt,
                           d.rev                                     AS decline_rev,
                           0                                         AS hold_cnt,
                           0                                         AS hold_rev,
                           0                                         AS hold_cnt_outside,
                           0                                         AS hold_rev_o,
                           0                                         AS chargeback_cnt
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
                                             {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                                             AND o.is_test_cc IN (0, 1)

                                     GROUP BY
                                             CONCAT(o.campaign_order_id, o.customers_email_address),
                                             ot.main_product_amount_shipping_tax + f_upsell_order_total(o.orders_id)
                                    ) d
                            GROUP BY
                                    d.join_val
                           ) d
                   GROUP BY
                           d.orders_id
 ;;
    indexes: ["orders_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: prior_hold_count {
    type: number
    sql: SUM(${hold_cnt_outside}) ;;
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }

  measure: decline_revenue {
    type: number
    sql: ${decline_revenue_hide} ;;
    value_format_name: decimal_2
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }

  measure: decline_revenue_hide {
    type: sum
    hidden: yes
    filters: {
      field: orders.upsell_flag
      value: "0"
    }
    sql: ${decline_rev} ;;
    value_format_name: decimal_2
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }


  measure: current_hold_count {
    type: sum
    sql: ${hold_cnt};;
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }

  dimension: orders_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.orders_id ;;
  }

  dimension: decline_cnt {
    type: number
    sql: ${TABLE}.decline_cnt ;;
  }

  dimension: decline_rev {
    type: number
    sql: ${TABLE}.decline_rev ;;
  }

  dimension: hold_cnt {
    type: number
    sql: ${TABLE}.hold_cnt ;;
  }

  dimension: hold_rev {
    type: number
    sql: ${TABLE}.hold_rev ;;
  }

  dimension: hold_cnt_outside {
    type: number
    sql: ${TABLE}.hold_cnt_outside ;;
  }

  dimension: hold_rev_o {
    type: number
    sql: ${TABLE}.hold_rev_o ;;
  }

  dimension: chargeback_cnt {
    type: number
    sql: ${TABLE}.chargeback_cnt ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${orders.t_stamp_date} ;;
    convert_tz: no
  }


  set: detail {
    fields: [
      orders_id,
      created_date,
      decline_cnt,
      decline_rev,
      hold_cnt,
      hold_rev,
      hold_cnt_outside,
      hold_rev_o,
      chargeback_cnt
    ]
  }
}
