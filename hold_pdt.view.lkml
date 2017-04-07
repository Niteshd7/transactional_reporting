view: hold_pdt {
  derived_table: {
    sql: SELECT
                           o.orders_id,
                           COUNT(IF(outside = 0, 1, NULL))                      AS hold_cnt,
                           SUM(IF(outside = 0, IFNULL(o.currency_value, 0), 0)) AS hold_rev,
                           COUNT(IF(outside = 1, 1, NULL))                      AS hold_cnt_outside,
                           SUM(IF(outside = 1, IFNULL(o.currency_value, 0), 0)) AS hold_rev_o
                       FROM
                           orders o,
                           (
                              SELECT
                                    o.orders_id,
                                    IFNULL(currency_value, 0) AS currency_value,
                                    IF((o.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
                                FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                 AND
                                    (
                                       (o.t_stamp BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))
                                        OR
                                                   (o.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))
                                    )

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    IF((uo.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))) AND (uo.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
                                FROM
                                    orders        o,
                                    upsell_orders uo
                               WHERE
                                    o.orders_id = uo.main_orders_id
                                 AND
                                    uo.is_hold = 1
                                 AND
                                    (
                                       (uo.t_stamp BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))
                                        OR
                                                   (uo.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))

                                    )
                                    AND o.is_test_cc IN (0, 1)

                           ) oh
                      WHERE
                           o.orders_id = oh.orders_id
                        AND
                           o.deleted   = 0
                   GROUP BY
                           oh.orders_id
 ;;
    indexes: ["orders_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  measure: count_hold {
    type: sum
    sql: ${hold_cnt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }


  measure: sum_hold {
    type: sum
    sql: ${hold_rev};;
    value_format_name: decimal_2
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: sum_hold_outside {
    type: sum
    sql: ${hold_rev_o};;
    value_format_name: decimal_2
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: count_prior_hold {
    type: sum
    sql: ${hold_cnt_outside} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  dimension: orders_id {
    #primary_key: yes
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
