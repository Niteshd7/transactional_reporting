view: admin {
  sql_table_name: admin      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: admin_id {
    type: number
    sql: ${TABLE}.admin_id ;;
  }

  dimension: admin_fullname {
    type: string
    sql: ${TABLE}.admin_fullname ;;
  }

  dimension: admin_name {
    type: string
    sql: ${TABLE}.admin_name ;;
  }

  dimension: admin_email {
    type: string
    sql: ${TABLE}.admin_email ;;
  }

  dimension: admin_pass {
    type: string
    sql: ${TABLE}.admin_pass ;;
  }

  dimension: admin_password {
    type: string
    sql: ${TABLE}.admin_password ;;
  }

  dimension: admin_level {
    type: yesno
    sql: ${TABLE}.admin_level ;;
  }

  dimension: admin_menus {
    type: string
    sql: ${TABLE}.admin_menus ;;
  }

  dimension: allowed_ip_address {
    type: string
    sql: ${TABLE}.allowedIpAddress ;;
  }

  dimension: department_id {
    type: number
    sql: ${TABLE}.department_id ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: update_id {
    type: number
    sql: ${TABLE}.update_id ;;
  }

  dimension: created_id {
    type: number
    sql: ${TABLE}.created_id ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension_group: date_in {
    type: time
    sql: ${TABLE}.date_in ;;
  }

  dimension_group: update_in {
    type: time
    sql: ${TABLE}.update_in ;;
  }

  dimension: total_login_counter {
    type: number
    sql: ${TABLE}.total_login_counter ;;
  }

  dimension: last_login_counter {
    type: number
    sql: ${TABLE}.last_login_counter ;;
  }

  dimension_group: date_last_login {
    type: time
    sql: ${TABLE}.date_last_login ;;
  }

  dimension_group: date_login_disabled {
    type: time
    sql: ${TABLE}.date_login_disabled ;;
  }

  dimension: temp_password {
    type: string
    sql: ${TABLE}.temp_password ;;
  }

  dimension: temp_password_reset_attempts {
    type: number
    sql: ${TABLE}.temp_password_reset_attempts ;;
  }

  dimension_group: temp_password_date_in {
    type: time
    sql: ${TABLE}.temp_password_date_in ;;
  }

  dimension_group: reset_password_date_in {
    type: time
    sql: ${TABLE}.reset_password_date_in ;;
  }

  dimension: reset_password_force {
    type: number
    sql: ${TABLE}.reset_password_force ;;
  }

  dimension: tmp_already_reset_by_temp {
    type: number
    sql: ${TABLE}.tmp_already_reset_by_temp ;;
  }

  dimension_group: message_check_date {
    type: time
    sql: ${TABLE}.message_check_date ;;
  }

  set: detail {
    fields: [
      admin_id,
      admin_fullname,
      admin_name,
      admin_email,
      admin_pass,
      admin_password,
      admin_level,
      admin_menus,
      allowed_ip_address,
      department_id,
      timezone,
      update_id,
      created_id,
      deleted,
      active,
      date_in_time,
      update_in_time,
      total_login_counter,
      last_login_counter,
      date_last_login_time,
      date_login_disabled_time,
      temp_password,
      temp_password_reset_attempts,
      temp_password_date_in_time,
      reset_password_date_in_time,
      reset_password_force,
      tmp_already_reset_by_temp,
      message_check_date_time
    ]
  }
}
