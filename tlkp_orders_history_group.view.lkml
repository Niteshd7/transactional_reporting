view: tlkp_orders_history_group {
  sql_table_name: tlkp_orders_history_group      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  set: detail {
    fields: [id, name]
  }
}
