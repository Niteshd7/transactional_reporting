view: tlkp_orders_history_type {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.tlkp_orders_history_type      ;;


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: type_id {
    type: string
    sql: ${TABLE}.type_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }


  set: detail {
    fields: [id, type_id, name, group_id, active]
  }
}
