view: gateway {
  sql_table_name: gateway;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: gateway_id {
    type: number
    sql: ${TABLE}.gateway_id ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: gateway_alias {
    type: string
    sql: ${TABLE}.gatewayAlias ;;
  }

  dimension_group: created_on {
    type: time
    sql: ${TABLE}.createdOn ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: global_monthly_cap {
    type: number
    sql: ${TABLE}.global_monthly_cap ;;
  }

  dimension: global_monthly_cap_fmt {
    type: string
    value_format_name: usd
    sql: CASE WHEN ${global_monthly_cap} IS NULL THEN 'N/A' ELSE ${global_monthly_cap} END ;;
  }

  dimension: current_monthly_amount {
    type: number
    sql: ${TABLE}.current_monthly_amount ;;
  }

  dimension: processing_percent {
    type: number
    sql: ${TABLE}.processing_percent ;;
  }

  dimension: reserve_percent {
    type: number
    sql: ${TABLE}.reserve_percent ;;
  }

  dimension: transaction_fee {
    type: number
    sql: ${TABLE}.transaction_fee ;;
  }

  dimension: chargeback_fee {
    type: number
    sql: ${TABLE}.chargeback_fee ;;
  }

  dimension: descriptor {
    type: string
    sql: ${TABLE}.descriptor ;;
  }

  dimension: customer_service_number {
    type: string
    sql: ${TABLE}.customer_service_number ;;
  }

  dimension: cascade_profile_id {
    type: number
    sql: ${TABLE}.cascade_profile_id ;;
  }

  dimension: archived_flag {
    type: yesno
    sql: ${TABLE}.archived_flag ;;
  }

  dimension_group: archive_date {
    type: time
    sql: ${TABLE}.archive_date ;;
  }

  set: detail {
    fields: [gateway_id, account_id, gateway_alias, created_on_time, active, global_monthly_cap, current_monthly_amount, processing_percent, reserve_percent, transaction_fee, chargeback_fee, descriptor, customer_service_number, cascade_profile_id, archived_flag, archive_date_time]
  }
}
