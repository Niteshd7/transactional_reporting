view: decline_hold_data {
  extends: [decline_hold_pdt]
}

view: decline_hold_pdt {
  derived_table: {
    sql: SELECT
                          o.orders_id,
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
                          COUNT(IF(o.isChargeback = 1, 1, NULL))                                                                                                     AS chargeback_cnt
                       FROM
                           v_main_order_total   ot,
                           campaigns       c,
                           orders          o
                      WHERE
                           o.deleted           = 0
                        AND
                           o.campaign_order_id = c.c_id
                        AND
                           o.orders_id         = ot.orders_id
                        AND
                           {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                           AND o.is_test_cc IN (0, 1)

                   GROUP BY
                           o.orders_id
                  UNION ALL
                     SELECT
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
                                    IF(({% condition orders.t_stamp_date %} o.hold_date {% endcondition %}) AND ({% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}), 1, 0) AS outside
                                FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                 AND
                                    (
                                       {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}

                                    )

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    IF(({% condition orders.t_stamp_date %} uo.hold_date {% endcondition %}) AND ({% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}), 1, 0) AS outside
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

                                    )
                                    AND o.is_test_cc IN (0, 1)

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
                                             CONCAT(o.campaign_order_id, o.customers_email_address, DATE(o.t_stamp))       AS join_val,
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
                                             CONCAT(o.campaign_order_id, o.customers_email_address, DATE(o.t_stamp)),
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
    type: sum
    sql: ${hold_cnt_outside} ;;
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }

  measure: decline_revenue {
    type: sum
    sql: ${decline_rev} ;;
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
  }


  measure: current_hold_count {
    type: sum
    sql: ${hold_cnt};;
    drill_fields: [orders_id, orders.hold_date, orders.t_stamp_date]
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