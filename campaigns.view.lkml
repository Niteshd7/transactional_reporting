view: campaigns {
  sql_table_name: campaigns ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: c_id {
    type: number
    sql: ${TABLE}.c_id ;;
  }

  dimension: c_parent_id {
    type: number
    sql: ${TABLE}.c_parent_id ;;
  }

  dimension: i_contact_api_id {
    type: number
    sql: ${TABLE}.i_contact_api_id ;;
  }

  dimension: c_name {
    type: string
    sql: ${TABLE}.c_name ;;
  }

  dimension: c_desc {
    type: string
    sql: ${TABLE}.c_desc ;;
  }

  dimension: c_shipping_id {
    type: string
    sql: ${TABLE}.c_shipping_id ;;
  }

  dimension: redirection_url {
    type: string
    sql: ${TABLE}.redirection_url ;;
  }

  dimension: success_url {
    type: string
    sql: ${TABLE}.success_url ;;
  }

  dimension: error_url {
    type: string
    sql: ${TABLE}.error_url ;;
  }

  dimension: wrong_land_url {
    type: string
    sql: ${TABLE}.wrong_land_url ;;
  }

  dimension: second_success_url {
    type: string
    sql: ${TABLE}.second_success_url ;;
  }

  dimension: second_error_url {
    type: string
    sql: ${TABLE}.second_error_url ;;
  }

  dimension: postback_url {
    type: string
    sql: ${TABLE}.postback_url ;;
  }

  dimension: postback_type {
    type: string
    sql: ${TABLE}.postback_type ;;
  }

  dimension: postback_initials {
    type: string
    sql: ${TABLE}.postback_initials ;;
  }

  dimension: postback_rebills {
    type: string
    sql: ${TABLE}.postback_rebills ;;
  }

  dimension: postback_declines {
    type: string
    sql: ${TABLE}.postback_declines ;;
  }

  dimension: postback_approvals {
    type: string
    sql: ${TABLE}.postback_approvals ;;
  }

  dimension: postback_testcards {
    type: string
    sql: ${TABLE}.postback_testcards ;;
  }

  dimension: postback_realcards {
    type: string
    sql: ${TABLE}.postback_realcards ;;
  }

  dimension: postback_subscription {
    type: string
    sql: ${TABLE}.postback_subscription ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: form_type {
    type: string
    sql: ${TABLE}.form_type ;;
  }

  dimension: i_contact_prospect {
    type: string
    sql: ${TABLE}.i_contact_prospect ;;
  }

  dimension: i_contact_client {
    type: string
    sql: ${TABLE}.i_contact_client ;;
  }

  dimension: gateway_id {
    type: number
    sql: ${TABLE}.gateway_id ;;
  }

  dimension: alt_provider_id {
    type: number
    sql: ${TABLE}.alt_provider_id ;;
  }

  dimension: lbc_id {
    type: number
    sql: ${TABLE}.lbc_id ;;
  }

  dimension: is_load_balanced {
    type: yesno
    sql: ${TABLE}.is_load_balanced ;;
  }

  dimension: max_rebill_amount_per_day {
    type: number
    sql: ${TABLE}.max_rebill_amount_per_day ;;
  }

  dimension: enabled_max_rebill_amount_per_day {
    type: yesno
    sql: ${TABLE}.enabled_max_rebill_amount_per_day ;;
  }

  dimension: rebill_daily_amount {
    type: number
    sql: ${TABLE}.rebill_daily_amount ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.is_active ;;
  }

  dimension: use_pre_paid {
    type: yesno
    sql: ${TABLE}.use_pre_paid ;;
  }

  dimension: allow_custom_pricing {
    type: yesno
    sql: ${TABLE}.allow_custom_pricing ;;
  }

  dimension: valid_countries {
    type: string
    sql: ${TABLE}.valid_countries ;;
  }

  dimension: custom_products {
    type: string
    sql: ${TABLE}.custom_products ;;
  }

  dimension: linktrust_post_back_pixel_on_off {
    type: number
    sql: ${TABLE}.linktrustPostBackPixelOnOff ;;
  }

  dimension: linktrust_campaign_id {
    type: string
    sql: ${TABLE}.linktrustCampaignId ;;
  }

  dimension: fulfillment_id {
    type: number
    sql: ${TABLE}.fulfillmentId ;;
  }

  dimension: check_provider_id {
    type: number
    sql: ${TABLE}.checkProviderId ;;
  }

  dimension: membership_provider_id {
    type: number
    sql: ${TABLE}.membershipProviderId ;;
  }

  dimension: optimizecustomeroutcome_provider_id {
    type: number
    sql: ${TABLE}.optimizecustomeroutcomeProviderId ;;
  }

  dimension: tax_provider_id {
    type: number
    sql: ${TABLE}.tax_provider_id ;;
  }

  dimension: callconfirm_provider_id {
    type: number
    sql: ${TABLE}.callconfirmProviderId ;;
  }

  dimension: chargeback_provider_id {
    type: number
    sql: ${TABLE}.chargebackProviderId ;;
  }

  dimension: prospect_provider_id {
    type: number
    sql: ${TABLE}.prospectProviderId ;;
  }

  dimension: use_avs {
    type: yesno
    sql: ${TABLE}.useAVS ;;
  }

  dimension: email_provider_id {
    type: number
    sql: ${TABLE}.emailProviderId ;;
  }

  dimension: fraud_provider_id {
    type: number
    sql: ${TABLE}.fraudProviderId ;;
  }

  dimension: higher_dollar_pre_auth {
    type: number
    sql: ${TABLE}.higherDollarPreAuth ;;
  }

  dimension: integration_type_id {
    type: number
    sql: ${TABLE}.integration_type_id ;;
  }

  dimension: update_id {
    type: number
    sql: ${TABLE}.update_id ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: created_id {
    type: number
    sql: ${TABLE}.created_id ;;
  }

  dimension_group: date_in {
    type: time
    sql: ${TABLE}.date_in ;;
  }

  dimension_group: update_in {
    type: time
    sql: ${TABLE}.update_in ;;
  }

  dimension: collections_flag {
    type: number
    sql: ${TABLE}.collections_flag ;;
  }

  dimension: data_verification_provider_id {
    type: number
    sql: ${TABLE}.data_verification_provider_id ;;
  }

  dimension: archived_flag {
    type: yesno
    sql: ${TABLE}.archived_flag ;;
  }

  dimension_group: archive_date {
    type: time
    sql: ${TABLE}.archive_date ;;
  }

  set: detail {
    fields: [c_id, c_parent_id, i_contact_api_id, c_name, c_desc, c_shipping_id, redirection_url, success_url, error_url, wrong_land_url, second_success_url, second_error_url, postback_url, postback_type, postback_initials, postback_rebills, postback_declines, postback_approvals, postback_testcards, postback_realcards, postback_subscription, product_id, form_type, i_contact_prospect, i_contact_client, gateway_id, alt_provider_id, lbc_id, is_load_balanced, max_rebill_amount_per_day, enabled_max_rebill_amount_per_day, rebill_daily_amount, is_active, use_pre_paid, allow_custom_pricing, valid_countries, custom_products, linktrust_post_back_pixel_on_off, linktrust_campaign_id, fulfillment_id, check_provider_id, membership_provider_id, optimizecustomeroutcome_provider_id, tax_provider_id, callconfirm_provider_id, chargeback_provider_id, prospect_provider_id, use_avs, email_provider_id, fraud_provider_id, higher_dollar_pre_auth, integration_type_id, update_id, deleted, active, created_id, date_in_time, update_in_time, collections_flag, data_verification_provider_id, archived_flag, archive_date_time]
  }
}
