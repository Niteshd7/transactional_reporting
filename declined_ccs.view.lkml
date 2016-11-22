view: declined_ccs {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.declined_ccs
      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: attempt_no {
    type: number
    sql: ${TABLE}.attempt_no ;;
  }

  dimension: is_order_or_upsell {
    type: number
    sql: ${TABLE}.is_order_or_upsell ;;
  }


  set: detail {
    fields: [id, orders_id, attempt_no, is_order_or_upsell]
  }
}
