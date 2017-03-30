view: hold_pdt {
  derived_table: {
    sql: SELECT
                           o.orders_id,
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
                           SUM(IF(outside = 0, IFNULL(o.currency_value, 0), 0)) AS hold_rev,
                           COUNT(IF(outside = 1, 1, NULL))                      AS hold_cnt_outside,
                           SUM(IF(outside = 1, IFNULL(o.currency_value, 0), 0)) AS hold_rev_o,
                           0                                                    AS chargeback_cnt
                       FROM
                           orders o,
                           (
                              SELECT
                                    o.orders_id,
                                    IFNULL(currency_value, 0) AS currency_value,
                                    IF(({% condition orders.t_stamp_date %} o.hold_date {% endcondition %}) AND (NOT {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}), 1, 0) AS outside
                                FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                 AND
                                    (
                                       {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                                        OR
                                                   {% condition orders.t_stamp_date %} o.hold_date {% endcondition %}
                                    )

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    IF(({% condition orders.t_stamp_date %} o.hold_date {% endcondition %}) AND (NOT {% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}), 1, 0) AS outside
                                FROM
                                    orders        o,
                                    upsell_orders uo
                               WHERE
                                    o.orders_id = uo.main_orders_id
                                 AND
                                    uo.is_hold = 1
                                 AND
                                    (
                                       {% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}
                                        OR
                                                   {% condition orders.t_stamp_date %} uo.hold_date {% endcondition %}

                                    )
                                    AND o.is_test_cc IN (0, 1)

                           ) oh
                      WHERE
                           o.orders_id = oh.orders_id
                        AND
                           o.deleted   = 0
                   GROUP BY
                           o.orders_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  measure: count_hold {
    type: sum_distinct
    sql: ${hold_cnt} ;;
    sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }


  measure: sum_hold {
    type: sum_distinct
    sql: ${hold_rev};;
    value_format_name: decimal_2
    sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: new_order_cnt {
    type: number
    sql: ${TABLE}.new_order_cnt ;;
  }

  dimension: new_order_rev {
    type: number
    sql: ${TABLE}.new_order_rev ;;
  }

  dimension: recurring_order_cnt {
    type: number
    sql: ${TABLE}.recurring_order_cnt ;;
  }

  dimension: recurring_order_rev {
    type: number
    sql: ${TABLE}.recurring_order_rev ;;
  }

  dimension: shipping_cnt {
    type: number
    sql: ${TABLE}.shipping_cnt ;;
  }

  dimension: shipping_rev {
    type: number
    sql: ${TABLE}.shipping_rev ;;
  }

  dimension: all_new_order_cnt {
    type: number
    sql: ${TABLE}.all_new_order_cnt ;;
  }

  dimension: all_new_order_rev {
    type: number
    sql: ${TABLE}.all_new_order_rev ;;
  }

  dimension: pending_order_cnt {
    type: number
    sql: ${TABLE}.pending_order_cnt ;;
  }

  dimension: pending_order_rev {
    type: number
    sql: ${TABLE}.pending_order_rev ;;
  }

  dimension: refund_void_cnt {
    type: number
    sql: ${TABLE}.refund_void_cnt ;;
  }

  dimension: refund_void_rev {
    type: number
    sql: ${TABLE}.refund_void_rev ;;
  }

  dimension: taxable_rev {
    type: number
    sql: ${TABLE}.taxable_rev ;;
  }

  dimension: active_cnt {
    type: number
    sql: ${TABLE}.active_cnt ;;
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

  set: detail {
    fields: [
      orders_id,
      new_order_cnt,
      new_order_rev,
      recurring_order_cnt,
      recurring_order_rev,
      shipping_cnt,
      shipping_rev,
      all_new_order_cnt,
      all_new_order_rev,
      pending_order_cnt,
      pending_order_rev,
      refund_void_cnt,
      refund_void_rev,
      taxable_rev,
      active_cnt,
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
