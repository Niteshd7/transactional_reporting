view: orders_first_try {
  sql_table_name:v_orders_first_try;;

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: parent_order_id {
    type: number
    sql: ${TABLE}.parent_order_id ;;
  }

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [recurring_date, orders_id, is_recurring, parent_order_id, campaign_order_id]
  }
}
