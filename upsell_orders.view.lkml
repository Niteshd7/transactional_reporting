view: upsell_orders {
  sql_table_name: upsell_orders      ;;

  dimension: upsell_orders_id {
    type: number
    sql: ${TABLE}.upsell_orders_id ;;
  }

  dimension: main_orders_id {
    type: number
    sql: ${TABLE}.main_orders_id ;;
  }

  dimension: customers_id {
    type: number
    sql: ${TABLE}.customers_id ;;
  }

  dimension: prospects_id {
    type: number
    sql: ${TABLE}.prospects_id ;;
  }

  dimension: customers_fname {
    type: string
    sql: ${TABLE}.customers_fname ;;
  }

  dimension: customers_lname {
    type: string
    sql: ${TABLE}.customers_lname ;;
  }

  dimension: customers_company {
    type: string
    sql: ${TABLE}.customers_company ;;
  }

  dimension: customers_street_address {
    type: string
    sql: ${TABLE}.customers_street_address ;;
  }

  dimension: customers_suburb {
    type: string
    sql: ${TABLE}.customers_suburb ;;
  }

  dimension: customers_city {
    type: string
    sql: ${TABLE}.customers_city ;;
  }

  dimension: customers_postcode {
    type: string
    sql: ${TABLE}.customers_postcode ;;
  }

  dimension: customers_state {
    type: string
    sql: ${TABLE}.customers_state ;;
  }

  dimension: customers_country {
    type: string
    sql: ${TABLE}.customers_country ;;
  }

  dimension: customers_telephone {
    type: string
    sql: ${TABLE}.customers_telephone ;;
  }

  dimension: customers_email_address {
    type: string
    sql: ${TABLE}.customers_email_address ;;
  }

  dimension: customers_address_format_id {
    type: number
    sql: ${TABLE}.customers_address_format_id ;;
  }

  dimension: delivery_fname {
    type: string
    sql: ${TABLE}.delivery_fname ;;
  }

  dimension: delivery_lname {
    type: string
    sql: ${TABLE}.delivery_lname ;;
  }

  dimension: delivery_company {
    type: string
    sql: ${TABLE}.delivery_company ;;
  }

  dimension: delivery_street_address {
    type: string
    sql: ${TABLE}.delivery_street_address ;;
  }

  dimension: delivery_suburb {
    type: string
    sql: ${TABLE}.delivery_suburb ;;
  }

  dimension: delivery_city {
    type: string
    sql: ${TABLE}.delivery_city ;;
  }

  dimension: delivery_postcode {
    type: string
    sql: ${TABLE}.delivery_postcode ;;
  }

  dimension: delivery_state {
    type: string
    sql: ${TABLE}.delivery_state ;;
  }

  dimension: delivery_country {
    type: string
    sql: ${TABLE}.delivery_country ;;
  }

  dimension: delivery_address_format_id {
    type: number
    sql: ${TABLE}.delivery_address_format_id ;;
  }

  dimension: billing_fname {
    type: string
    sql: ${TABLE}.billing_fname ;;
  }

  dimension: billing_lname {
    type: string
    sql: ${TABLE}.billing_lname ;;
  }

  dimension: billing_company {
    type: string
    sql: ${TABLE}.billing_company ;;
  }

  dimension: billing_street_address {
    type: string
    sql: ${TABLE}.billing_street_address ;;
  }

  dimension: billing_suburb {
    type: string
    sql: ${TABLE}.billing_suburb ;;
  }

  dimension: billing_city {
    type: string
    sql: ${TABLE}.billing_city ;;
  }

  dimension: billing_postcode {
    type: string
    sql: ${TABLE}.billing_postcode ;;
  }

  dimension: billing_state {
    type: string
    sql: ${TABLE}.billing_state ;;
  }

  dimension: billing_country {
    type: string
    sql: ${TABLE}.billing_country ;;
  }

  dimension: billing_address_format_id {
    type: number
    sql: ${TABLE}.billing_address_format_id ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_module_code {
    type: string
    sql: ${TABLE}.payment_module_code ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
  }

  dimension: shipping_module_code {
    type: string
    sql: ${TABLE}.shipping_module_code ;;
  }

  dimension: coupon_code {
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension: cc_type {
    type: string
    sql: ${TABLE}.cc_type ;;
  }

  dimension: cc_owner {
    type: string
    sql: ${TABLE}.cc_owner ;;
  }

  dimension: cc_number {
    type: string
    sql: ${TABLE}.cc_number ;;
  }

  dimension: cc_expires {
    type: string
    sql: ${TABLE}.cc_expires ;;
  }

  dimension: cc_cvv {
    type: string
    sql: ${TABLE}.cc_cvv ;;
  }

  dimension: checking_routing_number {
    type: string
    sql: ${TABLE}.checking_routing_number ;;
  }

  dimension: checking_account_number {
    type: string
    sql: ${TABLE}.checking_account_number ;;
  }

  dimension_group: last_modified {
    type: time
    sql: ${TABLE}.last_modified ;;
    convert_tz: no
  }

  dimension: date_purchased {
    type: date
    sql: ${TABLE}.date_purchased ;;
    convert_tz: no
  }

  dimension: orders_status {
    type: number
    sql: ${TABLE}.orders_status ;;
  }

  dimension_group: orders_date_finished {
    type: time
    sql: ${TABLE}.orders_date_finished ;;
    convert_tz: no
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: currency_value {
    type: number
    sql: ${TABLE}.currency_value ;;
  }

  dimension: order_total {
    type: number
    sql: ${TABLE}.order_total ;;
  }

  dimension: order_tax {
    type: number
    sql: ${TABLE}.order_tax ;;
  }

  dimension: paypal_ipn_id {
    type: number
    sql: ${TABLE}.paypal_ipn_id ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
    convert_tz: no
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
  }

  dimension: parent_order_id {
    type: number
    sql: ${TABLE}.parent_order_id ;;
  }

  dimension: child_order_id {
    type: number
    sql: ${TABLE}.child_order_id ;;
  }

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }

  dimension_group: t_stamp {
    type: time
    sql: ${TABLE}.t_stamp ;;
    convert_tz: no
  }

  dimension: is_hold {
    type: number
    sql: ${TABLE}.is_hold ;;
  }

  dimension: is_archived {
    type: number
    sql: ${TABLE}.is_archived ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: tracking_num {
    type: string
    sql: ${TABLE}.tracking_num ;;
  }

  dimension: auth_id {
    type: number
    sql: ${TABLE}.auth_id ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: hold_date {
    type: date
    sql: ${TABLE}.hold_date ;;
    convert_tz: no
  }

  dimension: order_total_reporting {
    type: number
    sql: ${TABLE}.orderTotalReporting ;;
  }

  dimension: order_total_shipping_reporting {
    type: number
    sql: ${TABLE}.orderTotalShippingReporting ;;
  }

  dimension: is_test_cc {
    type: number
    sql: ${TABLE}.is_test_cc ;;
  }

  dimension: delivery_state_id {
    type: string
    sql: ${TABLE}.delivery_state_id ;;
  }

  dimension: billing_state_id {
    type: string
    sql: ${TABLE}.billing_state_id ;;
  }

  dimension: deleted {
    type: yesno
    sql: ${TABLE}.deleted ;;
  }

  measure: upsell_order_count {
    type: count
    drill_fields: [upsell_orders_id]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure:  initial_orders {
    type: count
    label: "Initial Orders"
    filters: {
      field: is_recurring
      value: "0"
    }
    filters: {
      field: orders_status
      value: "2,8"
    }
    drill_fields: [detail*]
  }

  set: detail {
    fields: [upsell_orders_id, main_orders_id, customers_id, prospects_id, customers_fname, customers_lname, customers_company, customers_street_address, customers_suburb, customers_city, customers_postcode, customers_state, customers_country, customers_telephone, customers_email_address, customers_address_format_id, delivery_fname, delivery_lname, delivery_company, delivery_street_address, delivery_suburb, delivery_city, delivery_postcode, delivery_state, delivery_country, delivery_address_format_id, billing_fname, billing_lname, billing_company, billing_street_address, billing_suburb, billing_city, billing_postcode, billing_state, billing_country, billing_address_format_id, payment_method, payment_module_code, shipping_method, shipping_module_code, coupon_code, cc_type, cc_owner, cc_number, cc_expires, cc_cvv, checking_routing_number, checking_account_number, last_modified_time, date_purchased, orders_status, orders_date_finished_time, currency, currency_value, order_total, order_tax, paypal_ipn_id, ip_address, is_recurring, recurring_date, subscription_id, parent_order_id, child_order_id, campaign_order_id, t_stamp_time, is_hold, is_archived, transaction_id, tracking_num, auth_id, notes, hold_date, order_total_reporting, order_total_shipping_reporting, is_test_cc, delivery_state_id, billing_state_id, deleted]
  }
}
