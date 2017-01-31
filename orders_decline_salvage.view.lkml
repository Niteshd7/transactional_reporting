view: orders_decline_salvage {
  sql_table_name: v_orders_decline_salvage
      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
  }

  dimension: orders_id {
    type: number
    primary_key: yes
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

  dimension: was_reprocessed {
    type: number
    sql: ${TABLE}.wasReprocessed ;;
  }

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }


  set: detail {
    fields: [recurring_date, orders_id, is_recurring, parent_order_id, was_reprocessed, campaign_order_id]
  }
}
