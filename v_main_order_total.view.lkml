view: v_main_order_total {
  sql_table_name:  {{ _access_filters["client.schema_name"] }}.v_main_order_total;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: tax_factor {
    type: number
    sql: ${TABLE}.tax_factor ;;
  }

  dimension: main_product_amount {
    type: number
    sql: ${TABLE}.main_product_amount ;;
  }

  dimension: shipping_amount {
    type: number
    sql: ${TABLE}.shipping_amount ;;
  }

  dimension: refunded_amount {
    type: number
    sql: ${TABLE}.refunded_amount ;;
  }

  dimension: main_product_amount_shipping_tax {
    type: number
    sql: ${TABLE}.main_product_amount_shipping_tax ;;
  }

  dimension: current_total {
    type: number
    sql: ${TABLE}.current_total ;;
  }

  set: detail {
    fields: [
      orders_id,
      tax_factor,
      main_product_amount,
      shipping_amount,
      refunded_amount,
      main_product_amount_shipping_tax,
      current_total
    ]
  }
}
