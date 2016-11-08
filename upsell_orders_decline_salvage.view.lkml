view: upsell_orders_decline_salvage {
  derived_table: {
    sql: select * from audince_llcrm.v_upsell_orders_decline_salvage
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
  }

  dimension: main_orders_id {
    type: number
    sql: ${TABLE}.main_orders_id ;;
  }

  dimension: upsell_orders_id {
    type: number
    sql: ${TABLE}.upsell_orders_id ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }

  set: detail {
    fields: [recurring_date, main_orders_id, upsell_orders_id, is_recurring, campaign_order_id]
  }
}
