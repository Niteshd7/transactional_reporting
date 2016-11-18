view: orders_history {
  sql_table_name:audince_llcrm.orders_history
      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: h_id {
    type: number
    sql: ${TABLE}.hID ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}.user ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: t_stamp {
    type: time
    sql: ${TABLE}.t_stamp ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  set: detail {
    fields: [h_id, orders_id, user, type, status, t_stamp_time, deleted, campaign_id]
  }
}
