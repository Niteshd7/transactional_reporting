view: upsell_orders_products {
  sql_table_name:upsell_orders_products      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: upsell_orders_products_id {
    type: number
    sql: ${TABLE}.upsell_orders_products_id ;;
  }

  dimension: upsell_orders_id {
    type: number
    sql: ${TABLE}.upsell_orders_id ;;
  }

  dimension: products_id {
    type: number
    sql: ${TABLE}.products_id ;;
  }

  dimension: products_model {
    type: string
    sql: ${TABLE}.products_model ;;
  }

  dimension: products_name {
    type: string
    sql: ${TABLE}.products_name ;;
  }

  dimension: products_price {
    type: number
    sql: ${TABLE}.products_price ;;
  }

  dimension: final_price {
    type: number
    sql: ${TABLE}.final_price ;;
  }

  dimension: products_tax {
    type: number
    sql: ${TABLE}.products_tax ;;
  }

  dimension: products_quantity {
    type: number
    sql: ${TABLE}.products_quantity ;;
  }

  dimension: onetime_charges {
    type: number
    sql: ${TABLE}.onetime_charges ;;
  }

  dimension: products_priced_by_attribute {
    type: yesno
    sql: ${TABLE}.products_priced_by_attribute ;;
  }

  dimension: product_is_free {
    type: yesno
    sql: ${TABLE}.product_is_free ;;
  }

  dimension: products_discount_type {
    type: yesno
    sql: ${TABLE}.products_discount_type ;;
  }

  dimension: products_discount_type_from {
    type: yesno
    sql: ${TABLE}.products_discount_type_from ;;
  }

  dimension: products_prid {
    type: string
    sql: ${TABLE}.products_prid ;;
  }

  dimension: variant_id {
    type: number
    sql: ${TABLE}.variant_id ;;
  }

  set: detail {
    fields: [
      upsell_orders_products_id,
      upsell_orders_id,
      products_id,
      products_model,
      products_name,
      products_price,
      final_price,
      products_tax,
      products_quantity,
      onetime_charges,
      products_priced_by_attribute,
      product_is_free,
      products_discount_type,
      products_discount_type_from,
      products_prid,
      variant_id
    ]
  }
}
