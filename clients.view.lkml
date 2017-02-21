view: clients {
  derived_table: {
    sql: SELECT * FROM all_clients_limelight.client_info;
      ;;
  }

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

  dimension: host_name {
    type: string
    sql: ${TABLE}.host_name ;;
  }

  dimension: db_name {
    type: string
    sql: ${TABLE}.db_name ;;
  }

  dimension: db_pair {
    type: number
    sql: ${TABLE}.db_pair ;;
  }

  dimension: db_node {
    type: string
    sql: ${TABLE}.db_node ;;
  }

  set: detail {
    fields: [
      id,
      name,
      host_name,
      db_name,
      db_pair,
      db_node
    ]
  }
}
