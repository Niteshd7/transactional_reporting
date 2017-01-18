view: v_campaign_currencies {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.v_campaign_currencies      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: c_id {
    type: number
    sql: ${TABLE}.c_id ;;
  }

  dimension: currency_id {
    type: string
    sql: ${TABLE}.currency_id ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: iso4217_code {
    type: string
    sql: ${TABLE}.iso4217Code ;;
  }

  dimension: html_entity_name {
    type: string
    sql: ${TABLE}.html_entity_name ;;
  }

  set: detail {
    fields: [c_id, currency_id, code, iso4217_code, html_entity_name]
  }
}
