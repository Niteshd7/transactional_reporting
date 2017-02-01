view: v_orders {
   sql_table_name: v_orders      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension_group: t_stamp {
    type: time
    sql: ${TABLE}.t_stamp ;;
    convert_tz: no
  }

  dimension: orders_status {
    type: number
    sql: ${TABLE}.orders_status ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: customers_id {
    type: number
    sql: ${TABLE}.customers_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: common_ancestor {
    type: number
    sql: ${TABLE}.common_ancestor ;;
  }

  dimension: rebill_depth {
    type: number
    sql: ${TABLE}.rebill_depth ;;
  }

  dimension: parent_order_id {
    type: number
    sql: ${TABLE}.parent_order_id ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: is_hold {
    type: number
    sql: ${TABLE}.is_hold ;;
  }

  dimension: hold_date {
    type: date
    sql: ${TABLE}.hold_date ;;
    convert_tz: no
  }

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
    convert_tz: no
  }

  dimension: recurring_date_offset {
    type: date
    sql: ${TABLE}.recurring_date_offset ;;
    convert_tz: no
  }

  dimension: true_recurring_date {
    type: date
    sql: ${TABLE}.true_recurring_date ;;
    convert_tz: no
  }

  dimension: is_archived {
    type: number
    sql: ${TABLE}.is_archived ;;
  }

  dimension: preserve_gateway {
    type: yesno
    sql: ${TABLE}.preserve_gateway ;;
  }

  dimension: forecasted_revenue {
    type: number
    sql: ${TABLE}.forecasted_revenue ;;
  }

  dimension: hold_from_recurring {
    type: number
    sql: ${TABLE}.hold_from_recurring ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: delivery_suburb {
    type: string
    sql: ${TABLE}.delivery_suburb ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state_id {
    type: string
    sql: ${TABLE}.state_id ;;
  }

  dimension: gateway_id {
    type: number
    sql: ${TABLE}.gateway_id ;;
  }

  dimension: cc_type {
    type: string
    sql: ${TABLE}.cc_type ;;
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

  dimension: charge_c {
    type: string
    sql: ${TABLE}.charge_c ;;
  }

  dimension: charge_c_ins {
    type: number
    sql: ${TABLE}.charge_c_ins ;;
  }

  dimension: charge_c_mod {
    type: number
    sql: ${TABLE}.charge_c_mod ;;
  }

  dimension: charge_c_length {
    type: yesno
    sql: ${TABLE}.charge_c_length ;;
  }

  dimension: charge_sc_length {
    type: yesno
    sql: ${TABLE}.charge_sc_length ;;
  }

  dimension: checking_routing_number {
    type: string
    sql: ${TABLE}.checking_routing_number ;;
  }

  dimension: checking_account_number {
    type: string
    sql: ${TABLE}.checking_account_number ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: authorization_id {
    type: string
    sql: ${TABLE}.authorization_id ;;
  }

  dimension: afid {
    type: string
    sql: ${TABLE}.AFID ;;
  }

  dimension: sid {
    type: string
    sql: ${TABLE}.SID ;;
  }

  dimension: affid {
    type: string
    sql: ${TABLE}.AFFID ;;
  }

  dimension: c1 {
    type: string
    sql: ${TABLE}.C1 ;;
  }

  dimension: c2 {
    type: string
    sql: ${TABLE}.C2 ;;
  }

  dimension: c3 {
    type: string
    sql: ${TABLE}.C3 ;;
  }

  dimension: aid {
    type: string
    sql: ${TABLE}.AID ;;
  }

  dimension: opt {
    type: string
    sql: ${TABLE}.OPT ;;
  }

  dimension: stop_recurring_after_next_success {
    type: string
    sql: ${TABLE}.stop_recurring_after_next_success ;;
  }

  dimension: rebill_discount {
    type: string
    sql: ${TABLE}.rebill_discount ;;
  }

  dimension: retry_discount_pct {
    type: number
    sql: ${TABLE}.retry_discount_pct ;;
  }

  dimension: retry_discount_amt {
    type: number
    sql: ${TABLE}.retry_discount_amt ;;
  }

  dimension: retry_attempt_no {
    type: number
    sql: ${TABLE}.retry_attempt_no ;;
  }

  dimension: was_reprocessed {
    type: number
    sql: ${TABLE}.was_reprocessed ;;
  }

  dimension: was_salvaged {
    type: yesno
    sql: ${TABLE}.was_salvaged ;;
  }

  dimension: is_test_cc {
    type: number
    sql: ${TABLE}.is_test_cc ;;
  }

  dimension: is_fraud {
    type: yesno
    sql: ${TABLE}.is_fraud ;;
  }

  dimension: is_chargeback {
    type: yesno
    sql: ${TABLE}.is_chargeback ;;
  }

  dimension: is_rma {
    type: yesno
    sql: ${TABLE}.is_rma ;;
  }

  dimension: rma_number {
    type: string
    sql: ${TABLE}.rma_number ;;
  }

  dimension: rma_reason_code_id {
    type: number
    sql: ${TABLE}.rma_reason_code_id ;;
  }

  dimension_group: rma_return_date {
    type: time
    sql: ${TABLE}.rma_return_date ;;
    convert_tz: no
  }

  dimension: return_reason_id {
    type: number
    sql: ${TABLE}.return_reason_id ;;
  }

  dimension: order_finished {
    type: yesno
    sql: ${TABLE}.order_finished ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
  }

  dimension: shippable_flag {
    type: string
    sql: ${TABLE}.shippable_flag ;;
  }

  dimension: is_shipped {
    type: string
    sql: ${TABLE}.is_shipped ;;
  }

  dimension_group: shipped_date {
    type: time
    sql: ${TABLE}.shipped_date ;;
    convert_tz: no
  }

  dimension: fulfillment_tracking_been_posted {
    type: number
    sql: ${TABLE}.fulfillment_tracking_been_posted ;;
  }

  dimension: fulfillment_been_posted {
    type: number
    sql: ${TABLE}.fulfillment_been_posted ;;
  }

  dimension: fulfillment_number {
    type: number
    sql: ${TABLE}.fulfillment_number ;;
  }

  dimension: tracking_number {
    type: string
    sql: ${TABLE}.tracking_number ;;
  }

  dimension: refund_type {
    type: number
    sql: ${TABLE}.refund_type ;;
  }

  dimension: amount_refunded {
    type: number
    sql: ${TABLE}.amount_refunded ;;
  }

  dimension: order_confirmed {
    type: string
    sql: ${TABLE}.order_confirmed ;;
  }

  dimension: order_confirmation_status {
    type: number
    sql: ${TABLE}.order_confirmation_status ;;
  }

  dimension_group: order_confirmation_t_stamp {
    type: time
    sql: ${TABLE}.order_confirmation_t_stamp ;;
    convert_tz: no
  }

  dimension: order_confirmation_id {
    type: string
    sql: ${TABLE}.order_confirmation_id ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: recurring_product_custom {
    type: number
    sql: ${TABLE}.recurring_product_custom ;;
  }

  dimension: custom_subscription {
    type: string
    sql: ${TABLE}.custom_subscription ;;
  }

  dimension: recurring_days_custom {
    type: number
    sql: ${TABLE}.recurring_days_custom ;;
  }

  dimension: prospects_id_for_declines {
    type: number
    sql: ${TABLE}.prospects_id_for_declines ;;
  }

  dimension: date_purchased {
    type: date
    sql: ${TABLE}.date_purchased ;;
    convert_tz: no
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: ccbill_rebill_days_cycle {
    type: string
    sql: ${TABLE}.ccbill_rebill_days_cycle ;;
  }

  dimension: billing_first_name {
    type: string
    sql: ${TABLE}.billing_first_name ;;
  }

  dimension: billing_last_name {
    type: string
    sql: ${TABLE}.billing_last_name ;;
  }

  dimension: billing_address {
    type: string
    sql: ${TABLE}.billing_address ;;
  }

  dimension: billing_suburb {
    type: string
    sql: ${TABLE}.billing_suburb ;;
  }

  dimension: billing_city {
    type: string
    sql: ${TABLE}.billing_city ;;
  }

  dimension: billing_zip {
    type: string
    sql: ${TABLE}.billing_zip ;;
  }

  dimension: billing_state {
    type: string
    sql: ${TABLE}.billing_state ;;
  }

  dimension: billing_country {
    type: string
    sql: ${TABLE}.billing_country ;;
  }

  dimension: billing_state_id {
    type: string
    sql: ${TABLE}.billing_state_id ;;
  }

  dimension: click_id {
    type: string
    sql: ${TABLE}.click_id ;;
  }

  dimension: checking_limbo_flag {
    type: number
    sql: ${TABLE}.checking_limbo_flag ;;
  }

  dimension: paypal_payer_id {
    type: string
    sql: ${TABLE}.paypal_payer_id ;;
  }

  dimension: paypal_token {
    type: string
    sql: ${TABLE}.paypal_token ;;
  }

  dimension: alt_pay_payer_id {
    type: string
    sql: ${TABLE}.alt_pay_payer_id ;;
  }

  dimension: alt_pay_token {
    type: string
    sql: ${TABLE}.alt_pay_token ;;
  }

  dimension: custom_variant_id {
    type: string
    sql: ${TABLE}.custom_variant_id ;;
  }

  dimension_group: update_in {
    type: time
    sql: ${TABLE}.update_in ;;
    convert_tz: no
  }

  dimension: text_4 {
    type: string
    sql: ${TABLE}.text_4 ;;
  }

  dimension: promo_code_id {
    type: number
    sql: ${TABLE}.promo_code_id ;;
  }

  dimension: int_4 {
    type: number
    sql: ${TABLE}.int_4 ;;
  }

  dimension_group: date_1 {
    type: time
    sql: ${TABLE}.date_1 ;;
    convert_tz: no
  }

  dimension_group: date_2 {
    type: time
    sql: ${TABLE}.date_2 ;;
    convert_tz: no
  }

  dimension_group: date_3 {
    type: time
    sql: ${TABLE}.date_3 ;;
    convert_tz: no
  }

  dimension_group: date_4 {
    type: time
    sql: ${TABLE}.date_4 ;;
    convert_tz: no
  }

  dimension: amount_1 {
    type: number
    sql: ${TABLE}.amount_1 ;;
  }

  dimension: amount_2 {
    type: number
    sql: ${TABLE}.amount_2 ;;
  }

  dimension: amount_3 {
    type: number
    sql: ${TABLE}.amount_3 ;;
  }

  dimension: amount_4 {
    type: number
    sql: ${TABLE}.amount_4 ;;
  }

  dimension: semi_depricated_customers_fname {
    type: string
    sql: ${TABLE}.semi_depricated_customers_fname ;;
  }

  dimension: semi_depricated_customers_lname {
    type: string
    sql: ${TABLE}.semi_depricated_customers_lname ;;
  }

  dimension: semi_depricated_customers_street_address {
    type: string
    sql: ${TABLE}.semi_depricated_customers_street_address ;;
  }

  dimension: semi_depricated_customers_city {
    type: string
    sql: ${TABLE}.semi_depricated_customers_city ;;
  }

  dimension: semi_depricated_customers_postcode {
    type: string
    sql: ${TABLE}.semi_depricated_customers_postcode ;;
  }

  dimension: semi_depricated_customers_state {
    type: string
    sql: ${TABLE}.semi_depricated_customers_state ;;
  }

  dimension: semi_depricated_customers_country {
    type: string
    sql: ${TABLE}.semi_depricated_customers_country ;;
  }

  dimension: semi_depricated_customers_telephone {
    type: string
    sql: ${TABLE}.semi_depricated_customers_telephone ;;
  }

  dimension: semi_depricated_notes {
    type: string
    sql: ${TABLE}.semi_depricated_notes ;;
  }

  dimension: depricated_not_used_cc_owner_use_me {
    type: string
    sql: ${TABLE}.depricated_not_used_cc_owner_use_me ;;
  }

  dimension: depricated_customers_suburb {
    type: string
    sql: ${TABLE}.depricated_customers_suburb ;;
  }

  dimension: depricated_billing_company {
    type: string
    sql: ${TABLE}.depricated_billing_company ;;
  }

  dimension: depricated_delivery_company {
    type: string
    sql: ${TABLE}.depricated_delivery_company ;;
  }

  dimension: depricated_customers_company {
    type: string
    sql: ${TABLE}.depricated_customers_company ;;
  }

  dimension: depricated_delivery_address_format_id {
    type: number
    sql: ${TABLE}.depricated_delivery_address_format_id ;;
  }

  dimension: depricated_payment_method {
    type: string
    sql: ${TABLE}.depricated_payment_method ;;
  }

  dimension: depricated_order_total_reporting {
    type: number
    sql: ${TABLE}.depricated_order_total_reporting ;;
  }

  dimension: depricated_total_shipping_reporting {
    type: number
    sql: ${TABLE}.depricated_total_shipping_reporting ;;
  }

  dimension: depricated_total_complete_reporting {
    type: number
    sql: ${TABLE}.depricated_total_complete_reporting ;;
  }

  dimension: depricated_currency {
    type: string
    sql: ${TABLE}.depricated_currency ;;
  }

  dimension: depricated_order_total {
    type: number
    sql: ${TABLE}.depricated_order_total ;;
  }

  dimension: depricated_order_tax {
    type: number
    sql: ${TABLE}.depricated_order_tax ;;
  }

  dimension: depricated_child_order_id {
    type: number
    sql: ${TABLE}.depricated_child_order_id ;;
  }

  dimension: depricated_bid {
    type: string
    sql: ${TABLE}.depricated_bid ;;
  }

  set: detail {
    fields: [
      orders_id,
      t_stamp_time,
      orders_status,
      campaign_id,
      customers_id,
      email,
      common_ancestor,
      rebill_depth,
      parent_order_id,
      is_recurring,
      is_hold,
      hold_date,
      recurring_date,
      recurring_date_offset,
      true_recurring_date,
      is_archived,
      preserve_gateway,
      forecasted_revenue,
      hold_from_recurring,
      first_name,
      last_name,
      address,
      delivery_suburb,
      city,
      zip,
      state,
      country,
      state_id,
      gateway_id,
      cc_type,
      cc_number,
      cc_expires,
      cc_cvv,
      charge_c,
      charge_c_ins,
      charge_c_mod,
      charge_c_length,
      charge_sc_length,
      checking_routing_number,
      checking_account_number,
      transaction_id,
      authorization_id,
      afid,
      sid,
      affid,
      c1,
      c2,
      c3,
      aid,
      opt,
      stop_recurring_after_next_success,
      rebill_discount,
      retry_discount_pct,
      retry_discount_amt,
      retry_attempt_no,
      was_reprocessed,
      was_salvaged,
      is_test_cc,
      is_fraud,
      is_chargeback,
      is_rma,
      rma_number,
      rma_reason_code_id,
      rma_return_date_time,
      return_reason_id,
      order_finished,
      shipping_method,
      shippable_flag,
      is_shipped,
      shipped_date_time,
      fulfillment_tracking_been_posted,
      fulfillment_been_posted,
      fulfillment_number,
      tracking_number,
      refund_type,
      amount_refunded,
      order_confirmed,
      order_confirmation_status,
      order_confirmation_t_stamp_time,
      order_confirmation_id,
      deleted,
      recurring_product_custom,
      custom_subscription,
      recurring_days_custom,
      prospects_id_for_declines,
      date_purchased,
      ip_address,
      ccbill_rebill_days_cycle,
      billing_first_name,
      billing_last_name,
      billing_address,
      billing_suburb,
      billing_city,
      billing_zip,
      billing_state,
      billing_country,
      billing_state_id,
      click_id,
      checking_limbo_flag,
      paypal_payer_id,
      paypal_token,
      alt_pay_payer_id,
      alt_pay_token,
      custom_variant_id,
      update_in_time,
      text_4,
      promo_code_id,
      int_4,
      date_1_time,
      date_2_time,
      date_3_time,
      date_4_time,
      amount_1,
      amount_2,
      amount_3,
      amount_4,
      semi_depricated_customers_fname,
      semi_depricated_customers_lname,
      semi_depricated_customers_street_address,
      semi_depricated_customers_city,
      semi_depricated_customers_postcode,
      semi_depricated_customers_state,
      semi_depricated_customers_country,
      semi_depricated_customers_telephone,
      semi_depricated_notes,
      depricated_not_used_cc_owner_use_me,
      depricated_customers_suburb,
      depricated_billing_company,
      depricated_delivery_company,
      depricated_customers_company,
      depricated_delivery_address_format_id,
      depricated_payment_method,
      depricated_order_total_reporting,
      depricated_total_shipping_reporting,
      depricated_total_complete_reporting,
      depricated_currency,
      depricated_order_total,
      depricated_order_tax,
      depricated_child_order_id,
      depricated_bid
    ]
  }
}
