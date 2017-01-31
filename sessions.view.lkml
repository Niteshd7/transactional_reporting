view: sessions {
  sql_table_name:sessions    ;;

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


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [sesskey, expiry, value]
  }
}
