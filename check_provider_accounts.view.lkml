view: check_provider_accounts {
  sql_table_name:check_provider_accounts
      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: check_account_id {
    type: number
    sql: ${TABLE}.checkAccountId ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: generic_id {
    type: number
    sql: ${TABLE}.genericId ;;
  }

  dimension: ach {
    type: yesno
    sql: ${TABLE}.ach ;;
  }

  dimension: post_url {
    type: string
    sql: ${TABLE}.postURL ;;
  }

  dimension_group: created_on {
    type: time
    sql: ${TABLE}.createdOn ;;
    convert_tz: no
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }

  set: detail {
    fields: [check_account_id, name, description, generic_id, ach, post_url, created_on_time, table_name]
  }
}
