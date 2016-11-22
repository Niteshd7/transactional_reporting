view: gateway_accounts {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.gateway_accounts
      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ga_id {
    type: number
    sql: ${TABLE}.ga_id ;;
  }

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.is_active ;;
  }

  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }

  dimension: higher_dollar_preauth_flag {
    type: number
    sql: ${TABLE}.higher_dollar_preauth_flag ;;
  }

  set: detail {
    fields: [ga_id, account, is_active, type_id, higher_dollar_preauth_flag]
  }
}
