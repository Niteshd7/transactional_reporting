view: sessions {
  derived_table: {
    sql: {{ _access_filters["client.schema_name"] }}.sessions
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sesskey {
    type: string
    sql: ${TABLE}.sesskey ;;
  }

  dimension: expiry {
    type: number
    sql: ${TABLE}.expiry ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  set: detail {
    fields: [sesskey, expiry, value]
  }
}
