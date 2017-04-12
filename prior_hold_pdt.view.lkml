view: prior_hold_pdt {
  derived_table: {
    sql: SELECT
                                    o.orders_id,
                                    IFNULL(currency_value, 0) AS currency_value,
                                    1 AS outside

                                FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                    AND
                                    (o.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    1 AS outside

                                FROM
                                    orders        o,
                                    upsell_orders uo
                               WHERE
                                    o.orders_id = uo.main_orders_id
                                 AND
                                    uo.is_hold = 1
                                 AND
                                    (uo.hold_date BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %}))) AND (uo.t_stamp NOT BETWEEN (SELECT TIMESTAMP({% date_start orders.t_stamp_date %})) AND (SELECT TIMESTAMP({% date_end orders.t_stamp_date %})))
                                    AND o.is_test_cc IN (0, 1)
 ;;
    indexes: ["orders_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }


  dimension: outside {
    type: number
    sql: ${TABLE}.outside ;;
  }

  dimension: currency_value {
    type: number
    sql: ${TABLE}.currency_value ;;
  }

  measure: prior_hold_revenue {
    type: sum
    value_format_name: decimal_2
    sql: ${currency_value} ;;
  }

  measure: prior_hold_count {
    type: sum
    sql: ${outside} ;;
  }

  set: detail {
    fields: [orders_id, currency_value]
  }
}
