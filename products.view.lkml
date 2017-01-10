view: products {
  derived_table: {
    sql: SELECT
      op.*,
      p.products_type as prod_type,
      p.products_date_added, p.products_date_available, p.products_last_modified,
      pd.products_description, pd.products_url, pd.products_viewed
  FROM

      orders_products AS op
  JOIN
      products AS p
    ON
      p.products_id = op.products_id
  JOIN
      products_description AS pd
    ON
      p.products_id = pd.products_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_products_id {
    type: number
    sql: ${TABLE}.orders_products_id ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
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

  dimension: prod_type {
    type: number
    sql: ${TABLE}.prod_type ;;
  }

  dimension_group: products_date_added {
    type: time
    sql: ${TABLE}.products_date_added ;;
  }

  dimension_group: products_date_available {
    type: time
    sql: ${TABLE}.products_date_available ;;
  }

  dimension_group: products_last_modified {
    type: time
    sql: ${TABLE}.products_last_modified ;;
  }

  dimension: products_description {
    type: string
    sql: ${TABLE}.products_description ;;
  }

  dimension: products_url {
    type: string
    sql: ${TABLE}.products_url ;;
  }

  dimension: products_viewed {
    type: number
    sql: ${TABLE}.products_viewed ;;
  }

  set: detail {
    fields: [
      orders_products_id,
      orders_id,
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
      variant_id,
      prod_type,
      products_date_added_time,
      products_date_available_time,
      products_last_modified_time,
      products_description,
      products_url,
      products_viewed
    ]
  }
}
