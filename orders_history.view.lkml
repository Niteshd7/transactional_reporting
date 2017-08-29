view: orders_history {
  sql_table_name:orders_history
      ;;

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
    timeframes: [time, date, week, month]
    sql: ${TABLE}.t_stamp ;;
    convert_tz: no
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: oht_type_id {
    type: string
    sql: CASE WHEN ${type} = 'recurring' AND ${status} IN ('hold','stop') THEN ${type} || '-' || ${status} ELSE ${type} END ;;
  }


  dimension_group: chargeback_date {
    type: time
    timeframes: [time, date, week, month]
    sql: CASE WHEN ${type} = 'chargeback-order-on' THEN ${t_stamp_date} ELSE NULL END ;;
    convert_tz: no
  }

  dimension_group: refund_date {
    type: time
    timeframes: [time, date, week, month]
    sql: CASE WHEN ${type} = 'refund' THEN ${t_stamp_date} ELSE NULL END ;;
    convert_tz: no
  }

  measure: shipped_count {
    type: count
    filters: {
      field: type
      value: "order-tracking-success,shipped"
    }
    label: "Shipped Orders"
    drill_fields: [detail*]
  }

  set: detail {
    fields: [h_id, orders_id, user, type, status, t_stamp_time, deleted, campaign_id]
  }
}
