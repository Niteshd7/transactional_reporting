view: countries {
  sql_table_name:{{ _access_filters["client.schema_name"] }}.countries    ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: countries_id {
    type: number
    sql: ${TABLE}.countries_id ;;
  }

  dimension: countries_name {
    type: string
    sql: ${TABLE}.countries_name ;;
  }

  dimension: countries_iso_code_2 {
    type: string
    sql: ${TABLE}.countries_iso_code_2 ;;
  }

  dimension: countries_iso_code_3 {
    type: string
    sql: ${TABLE}.countries_iso_code_3 ;;
  }

  dimension: address_format_id {
    type: number
    sql: ${TABLE}.address_format_id ;;
  }

  dimension: iso_numeric {
    type: number
    sql: ${TABLE}.iso_numeric ;;
  }

  dimension: calling_code {
    type: string
    sql: ${TABLE}.calling_code ;;
  }

  set: detail {
    fields: [countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric, calling_code]
  }
}
