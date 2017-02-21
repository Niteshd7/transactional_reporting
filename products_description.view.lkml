view: products_description {
 sql_table_name: products_description      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_id {
    type: number
    sql: ${TABLE}.products_id ;;
  }

  dimension: language_id {
    type: number
    sql: ${TABLE}.language_id ;;
  }

  dimension: products_name {
    type: string
    sql: ${TABLE}.products_name ;;
  }

  dimension: products_name_display {
    type: string
    sql: CONCAT('(',${products_id},')',' ',${products_name}) ;;
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
      products_id,
      language_id,
      products_name,
      products_description,
      products_url,
      products_viewed
    ]
  }
}
