view: 3d_verify_enrollment {
  derived_table: {
    sql: SELECT
      COUNT(CASE WHEN c.name in ('3d_enrolled_yes','3d_enrolled_no') THEN 1 END) as enrollment_attempts,
      COUNT(CASE WHEN c.name = '3d_enrolled_yes' AND LENGTH(gt.cavv) > 0 THEN 1 END) as successful_enrollments
  FROM
      value_add_transaction a
  JOIN
      all_clients_limelight.value_add_outcome c
    ON
      a.outcome = c.id
   AND
      a.provider_type_id = c.provider_type_id
   AND
      a.provider_account_id = c.provider_account_id
LEFT JOIN
      gateway_transactions_limelight_3d_verify gt
    ON
      CASE WHEN c.name = '3d_enrolled_yes' THEN gt.orderId = a.order_id END
 WHERE
      a.action_type = 'enrollment_check'
   AND
      c.provider_account_id = 153
   AND
      a.date_in > TIMESTAMP({% date_start date_select %}) -- apply whatever date filter here
 ;;
  }

  filter: date_select {
    type: date
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: enrollment_attempts {
    type: number
    sql: ${TABLE}.enrollment_attempts ;;
  }

  dimension: successful_enrollments {
    type: number
    sql: ${TABLE}.successful_enrollments ;;
  }

  set: detail {
    fields: [enrollment_attempts, successful_enrollments]
  }
}
