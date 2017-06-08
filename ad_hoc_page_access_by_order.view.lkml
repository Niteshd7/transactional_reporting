view: ad_hoc_page_access_by_order {
  derived_table: {
    sql: select b.admin_name, b.admin_email, a.* from admin_activity_log a, admin b
      where {% condition order_id %} a.page_parameters {% endcondition %}
      and a.admin_id = b.admin_id and b.admin_id != 1 and {% condition date_select %} access_date {% endcondition %}
       ;;
  }

  filter: date_select {
    type: date
  }

  filter: order_id {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: admin_name {
    type: string
    sql: ${TABLE}.admin_name ;;
  }

  dimension: admin_email {
    type: string
    sql: ${TABLE}.admin_email ;;
  }

  dimension: log_id {
    type: number
    sql: ${TABLE}.log_id ;;
  }

  dimension_group: access_date {
    type: time
    sql: ${TABLE}.access_date ;;
  }

  dimension: admin_id {
    type: number
    sql: ${TABLE}.admin_id ;;
  }

  dimension: page_accessed {
    type: string
    sql: ${TABLE}.page_accessed ;;
  }

  dimension: page_parameters {
    type: string
    sql: ${TABLE}.page_parameters ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  set: detail {
    fields: [
      admin_name,
      admin_email,
      log_id,
      access_date_time,
      admin_id,
      page_accessed,
      page_parameters,
      ip_address
    ]
  }
}
