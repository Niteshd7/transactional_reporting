view: orders {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.orders ;;

  dimension: common_ancestor_order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.commonAncestorOrderId ;;
  }

  dimension: 3_dauth_token {
    type: string
    sql: ${TABLE}.3DAuthToken ;;
  }

  dimension: affid {
    type: string
    sql: ${TABLE}.AFFID ;;
  }

  dimension: affiliate_breakdown {
    sql: ${TABLE}.campaign_order_id ;;
    link: {
      label: "Affiliate Breakdown"
      url: "https://demo.limelightcrm.com/admin/report/custom/index.php?r=6&f={{value}}&aff=1"
      icon_url: "https://cdn.limelightcrm.com/logo1.png"
    }
  }

  dimension: afid {
    type: string
    sql: ${TABLE}.AFID ;;
  }

  dimension: aid {
    type: string
    sql: ${TABLE}.AID ;;
  }

  dimension: amount_0 {
    type: number
    sql: ${TABLE}.amount_0 ;;
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

  dimension: amount_refunded_so_far {
    type: number
    sql: ${TABLE}.amountRefundedSoFar ;;
  }

  dimension: auth_id {
    type: string
    sql: ${TABLE}.auth_id ;;
  }

  dimension: bid {
    type: string
    sql: ${TABLE}.BID ;;
  }

  dimension: billing_address_format_id {
    type: number
    sql: ${TABLE}.billing_address_format_id ;;
  }

  dimension: billing_city {
    type: string
    sql: ${TABLE}.billing_city ;;
  }

  dimension: billing_company {
    type: string
    sql: ${TABLE}.billing_company ;;
  }

  dimension: billing_country {
    type: string
    sql: ${TABLE}.billing_country ;;
  }

  dimension: billing_fname {
    type: string
    sql: ${TABLE}.billing_fname ;;
  }

  dimension: billing_lname {
    type: string
    sql: ${TABLE}.billing_lname ;;
  }

  dimension: billing_postcode {
    type: string
    sql: ${TABLE}.billing_postcode ;;
  }

  dimension: billing_state {
    type: string
    sql: ${TABLE}.billing_state ;;
  }

  dimension: billing_state_id {
    type: string
    sql: ${TABLE}.billing_state_id ;;
  }

  dimension: billing_street_address {
    type: string
    sql: ${TABLE}.billing_street_address ;;
  }

  dimension: billing_suburb {
    type: string
    sql: ${TABLE}.billing_suburb ;;
  }

  dimension: blacklist_id {
    type: number
    sql: ${TABLE}.blacklist_id ;;
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

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }

  dimension: cc_cvv {
    type: string
    sql: ${TABLE}.cc_cvv ;;
  }

  dimension: cc_expires {
    type: string
    sql: ${TABLE}.cc_expires ;;
  }

  dimension: cc_number {
    type: string
    sql: ${TABLE}.cc_number ;;
  }

  dimension: cc_owner {
    type: string
    sql: ${TABLE}.cc_owner ;;
  }

  dimension: cc_type {
    type: string
    sql: ${TABLE}.cc_type ;;
  }

  dimension: charge_c {
    type: string
    sql: ${TABLE}.charge_c ;;
  }

  dimension: charge_c_ins {
    type: number
    sql: ${TABLE}.charge_c_ins ;;
  }

  dimension: charge_c_length {
    type: yesno
    sql: ${TABLE}.charge_c_length ;;
  }

  dimension: charge_c_mod {
    type: number
    sql: ${TABLE}.charge_c_mod ;;
  }

  dimension: charge_ch_an {
    type: string
    sql: ${TABLE}.charge_ch_an ;;
  }

  dimension: charge_ch_rt {
    type: string
    sql: ${TABLE}.charge_ch_rt ;;
  }

  dimension: charge_sc {
    type: string
    sql: ${TABLE}.charge_sc ;;
  }

  dimension: charge_sc_length {
    type: yesno
    sql: ${TABLE}.charge_sc_length ;;
  }

  dimension: checking_account_number {
    type: string
    sql: ${TABLE}.checking_account_number ;;
  }

  dimension: checking_routing_number {
    type: string
    sql: ${TABLE}.checking_routing_number ;;
  }

  dimension: child_order_id {
    type: number
    sql: ${TABLE}.child_order_id ;;
  }

  dimension: coupon_code {
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: currency_value {
    type: number
    sql: ${TABLE}.currency_value ;;
  }

  dimension: customers_address_format_id {
    type: number
    sql: ${TABLE}.customers_address_format_id ;;
  }

  dimension: customers_city {
    type: string
    sql: ${TABLE}.customers_city ;;
  }

  dimension: customers_company {
    type: string
    sql: ${TABLE}.customers_company ;;
  }

  dimension: customers_country {
    type: string
    sql: ${TABLE}.customers_country ;;
  }

  dimension: customers_email_address {
    type: string
    sql: ${TABLE}.customers_email_address ;;
  }

  dimension: customers_fname {
    type: string
    sql: ${TABLE}.customers_fname ;;
  }

  dimension: customers_id {
    type: number
    # hidden: true
    sql: ${TABLE}.customers_id ;;
  }

  dimension: customers_lname {
    type: string
    sql: ${TABLE}.customers_lname ;;
  }

  dimension: customers_postcode {
    type: string
    sql: ${TABLE}.customers_postcode ;;
  }

  dimension: customers_state {
    type: string
    sql: ${TABLE}.customers_state ;;
  }

  dimension: customers_street_address {
    type: string
    sql: ${TABLE}.customers_street_address ;;
  }

  dimension: customers_suburb {
    type: string
    sql: ${TABLE}.customers_suburb ;;
  }

  dimension: customers_telephone {
    type: string
    sql: ${TABLE}.customers_telephone ;;
  }

  dimension_group: date_0 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_0 ;;
  }

  dimension_group: date_1 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_1 ;;
  }

  dimension_group: date_2 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_2 ;;
  }

  dimension_group: date_3 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_3 ;;
  }

  dimension_group: date_4 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_4 ;;
  }

  dimension_group: date_purchased {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.date_purchased ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: delivery_address_format_id {
    type: number
    sql: ${TABLE}.delivery_address_format_id ;;
  }

  dimension: delivery_city {
    type: string
    sql: ${TABLE}.delivery_city ;;
  }

  dimension: delivery_company {
    type: string
    sql: ${TABLE}.delivery_company ;;
  }

  dimension: delivery_country {
    type: string
    sql: ${TABLE}.delivery_country ;;
  }

  dimension: delivery_fname {
    type: string
    sql: ${TABLE}.delivery_fname ;;
  }

  dimension: delivery_lname {
    type: string
    sql: ${TABLE}.delivery_lname ;;
  }

  dimension: delivery_postcode {
    type: string
    sql: ${TABLE}.delivery_postcode ;;
  }

  dimension: delivery_state {
    type: string
    sql: ${TABLE}.delivery_state ;;
  }

  dimension: delivery_state_id {
    type: string
    sql: ${TABLE}.delivery_state_id ;;
  }

  dimension: delivery_street_address {
    type: string
    sql: ${TABLE}.delivery_street_address ;;
  }

  dimension: delivery_suburb {
    type: string
    sql: ${TABLE}.delivery_suburb ;;
  }

  dimension: fulfillment_number {
    type: number
    sql: ${TABLE}.fulfillmentNumber ;;
  }

  dimension: gateway_id {
    type: number
    # hidden: true
    sql: ${TABLE}.gatewayId ;;
  }

  dimension: gateway {
    full_suggestions: yes
    type: string
    sql: CONCAT(${gateway.gateway_alias},' ','(',' ',${gateway_id},' ',')') ;;
  }

  dimension: gateway_preserve {
    type: yesno
    sql: ${TABLE}.gatewayPreserve ;;
  }

  dimension: has_been_posted {
    type: number
    sql: ${TABLE}.hasBeenPosted ;;
  }

  dimension: has_tracking_been_posted {
    type: number
    sql: ${TABLE}.hasTrackingBeenPosted ;;
  }

  dimension_group: hold {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.hold_date ;;
  }

  dimension: int_1 {
    type: number
    sql: ${TABLE}.int_1 ;;
  }

  dimension: int_2 {
    type: number
    sql: ${TABLE}.int_2 ;;
  }

  dimension: int_3 {
    type: number
    sql: ${TABLE}.int_3 ;;
  }

  dimension: int_4 {
    type: number
    sql: ${TABLE}.int_4 ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: is_archived {
    type: number
    sql: ${TABLE}.is_archived ;;
  }

  dimension: is_chargeback {
    type: yesno
    sql: ${TABLE}.isChargeback ;;
  }

  dimension: is_chargeback_reversal {
    type: yesno
    sql: ${TABLE}.isChargebackReversal ;;
  }

  dimension: is_fraud {
    type: yesno
    sql: ${TABLE}.isFraud ;;
  }

  dimension: is_hold {
    type: number
    sql: ${TABLE}.is_hold ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: is_rma {
    type: yesno
    sql: ${TABLE}.isRMA ;;
  }

  dimension: is_test_cc {
    type: number
    sql: ${TABLE}.is_test_cc ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: opt {
    type: string
    sql: ${TABLE}.OPT ;;
  }

  dimension: order_confirmation_id {
    type: string
    sql: ${TABLE}.orderConfirmationId ;;
  }

  dimension: order_confirmed {
    type: string
    sql: ${TABLE}.orderConfirmed ;;
  }

  dimension_group: order_confirmed_date {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.orderConfirmedDateTime ;;
  }

  dimension: order_confirmed_status {
    type: number
    sql: ${TABLE}.orderConfirmedStatus ;;
  }

  dimension: order_tax {
    type: number
    sql: ${TABLE}.order_tax ;;
  }

  dimension: order_total {
    type: number
    sql: ${TABLE}.order_total ;;
  }

  dimension: order_total_complete_reporting {
    type: number
    sql: ${TABLE}.orderTotalCompleteReporting ;;
  }

  dimension: order_total_reporting {
    type: number
    sql: ${TABLE}.orderTotalReporting ;;
  }

  dimension: order_total_shipping_reporting {
    type: number
    sql: ${TABLE}.orderTotalShippingReporting ;;
  }

  dimension_group: orders_date_finished {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.orders_date_finished ;;
  }

  dimension: orders_id {
    type: number
    # hidden: true
    sql: ${TABLE}.orders_id ;;
  }

  dimension: orders_status {
    type: number
    sql: ${TABLE}.orders_status ;;
  }

  dimension: parent_order_id {
    type: number
    sql: ${TABLE}.parent_order_id ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_module_code {
    type: string
    sql: ${TABLE}.payment_module_code ;;
  }

  dimension: paypal_ipn_id {
    type: number
    sql: ${TABLE}.paypal_ipn_id ;;
  }

  dimension: prospects_id {
    type: number
    # hidden: true
    sql: ${TABLE}.prospects_id ;;
  }

  dimension: rebill_depth {
    type: number
    sql: ${TABLE}.rebillDepth ;;
  }

  dimension: rebill_discount {
    type: string
    sql: ${TABLE}.rebillDiscount ;;
  }

  dimension_group: recurring {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.recurring_date ;;
  }

  dimension: recurring_days_custom {
    type: number
    sql: ${TABLE}.recurring_days_custom ;;
  }

  dimension: recurring_product_custom {
    type: number
    sql: ${TABLE}.recurring_product_custom ;;
  }

  dimension: refund_type {
    type: number
    sql: ${TABLE}.refundType ;;
  }

  dimension: rmanumber {
    type: string
    sql: ${TABLE}.RMANumber ;;
  }

  dimension: rmareason_code_id {
    type: number
    sql: ${TABLE}.RMAReasonCodeId ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
  }

  dimension: shipping_module_code {
    type: string
    sql: ${TABLE}.shipping_module_code ;;
  }

  dimension: sid {
    type: string
    sql: ${TABLE}.SID ;;
  }

  dimension: ssn_4 {
    type: number
    sql: ${TABLE}.ssn_4 ;;
  }

  dimension: stop_recurring_on_next_success {
    type: string
    sql: ${TABLE}.stopRecurringOnNextSuccess ;;
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
  }

  dimension_group: t_stamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.t_stamp ;;
  }

  dimension: text_0 {
    type: string
    sql: ${TABLE}.text_0 ;;
  }

  dimension: text_1 {
    type: string
    sql: ${TABLE}.text_1 ;;
  }

  dimension: text_2 {
    type: string
    sql: ${TABLE}.text_2 ;;
  }

  dimension: text_3 {
    type: string
    sql: ${TABLE}.text_3 ;;
  }

  dimension: text_4 {
    type: string
    sql: ${TABLE}.text_4 ;;
  }

  dimension: tracking_num {
    type: string
    sql: ${TABLE}.tracking_num ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: was_reprocessed {
    type: number
    sql: ${TABLE}.wasReprocessed ;;
  }

  dimension: was_salvaged {
    type: yesno
    sql: ${TABLE}.wasSalvaged ;;
  }

  dimension: is_subscription {
    type: yesno
    sql: ${subscription_id} IS NOT NULL ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: order_count {
    type: count
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  dimension: order_status_name {
    type: string
    sql: CASE WHEN ${orders_status} in (2,6,8) THEN 'Approved' WHEN ${orders_status} = 7 THEN 'Declined' WHEN ${orders_status} = 3 THEN 'Archived' WHEN ${orders_status} = 9 THEN 'On-Hold' ELSE 'Pending' END ;;
  }

  dimension: is_approved {
    type: yesno
    sql: ${orders_status} in (2, 6, 8) ;;
  }

  measure: net_order_total {
    label: "Gross Revenue"
    description: "This is the total amount of all orders"
    type: sum
    value_format_name: usd_0
    sql: ${order_total} ;;
  }

  measure:  declined_orders {
    type: count
    label: "Declines"
    filters: {
      field: order_status_name
      value: "Declined"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  hold_cancel_orders {
    type: count
    label: "Holds/Cancels"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  initial_orders {
    type: count
    label: "Initial Orders"
    filters: {
      field: rebill_depth
      value: "0"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  pending_orders {
    type: count
    label: "Pending Orders"
    filters: {
      field: order_status_name
      value: "Pending"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  subscription_orders {
    type: count
    label: "Subscriptions"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  void_refund_orders {
    type: count
    label: "Void/Refund Orders"
    filters: {
      field: order_status_name
      value: "Void/Refunded"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure: decline_revenue {
    type: sum
    label: "Decline Revenue"
    filters: {
      field: order_status_name
      value: "Declined"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure:  hold_cancel_revenue {
    type: sum
    label: "Holds/Cancels Revenue"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure:  initial_revenue {
    type: sum
    label: "Initial Revenue"
    filters: {
      field: rebill_depth
      value: "0"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure: pending_revenue {
    type: sum
    label: "Pending Revenue"
    filters: {
      field: order_status_name
      value: "Pending"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure:  subscription_revenue {
    type: sum
    label: "Subscription Revenue"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure:  total_revenue {
    type: sum
    label: "Total Revenue"
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure:  void_refund_revenue {
    type: sum
    label: "Void/Refunded Revenue"
    filters: {
      field: order_status_name
      value: "Void/Refunded"
    }
    value_format_name: usd
    sql: ${order_total} ;;
  }

  measure: count_approved {
    type: count
    label: "Successful Transactions"
    filters: {
      field: is_approved
      value: "yes"
    }

    drill_fields: [detail*]
  }

  measure: count_salvaged {
    type: count
    label: "Salvaged Orders"
    filters: {
      field: was_salvaged
      value: "Yes"
    }

    drill_fields: [detail*]
  }

  measure: count_shipped {
    type: count
    label: "Shipping"
    filters: {
      field: payment_module_code
      value: "1"
    }
    filters: {
      field: is_approved
      value: "1"
    }
    drill_fields: [detail*]
  }

  measure: order_statuses {
    type: count
    drill_fields: [orders_id]
  }


  measure: percent_approved {
    type: number
    value_format_name: percent_2
    sql: ${count_approved} / NULLIF(${count},0) ;;
    html: {% if value < 0.3 %}
      <div style="color:Black; background-color:red; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% elsif value >= 0.3 and value < 0.7 %}
      <div style="color:Black; background-color:yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% elsif value >= 0.7 %}
      <div style="color:Black; background-color:green; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% endif %}
      ;;
  }

  measure:  tax_revenue {
    type: sum
    label: "Tax Revenue"
    value_format_name: usd_0
    sql: ${order_tax} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [common_ancestor_order_id, customers_fname, customers_lname, delivery_fname, delivery_lname, billing_fname, billing_lname, orders.customers_fname, orders.customers_lname, orders.delivery_fname, orders.delivery_lname, orders.billing_fname, orders.billing_lname, orders.common_ancestor_order_id, customers.customers_id, customers.customers_fname, customers.customers_lname, prospects.prospects_id, prospects.p_first_name, prospects.p_last_name, gateway.gateway_id, account_updater_audit.count, declined_ccs.count, decline_salvage_preserve.count, decline_salvage_queue.count, emailprovider_temp_removal.count, fraudprovider_transactions_fraudlogic.count, fraudprovider_transactions_fraudshield.count, fraudprovider_transactions_kount.count, fraudprovider_transactions_maxmind.count, fraudprovider_transactions_phoenix.count, fraudprovider_transactions_pinpoint.count, gateway_cascade_orders_preserved.count, gateway_cascade_orders_salvaged.count, gateway_force_preserved.count, gateway_salvage_skip_log.count, gateway_transactions_a1payments.count, gateway_transactions_acquired.count, gateway_transactions_actum.count, gateway_transactions_admeris.count, gateway_transactions_allied.count, gateway_transactions_alternativepayments.count, gateway_transactions_altoglobal.count, gateway_transactions_amazon.count, gateway_transactions_anytrans.count, gateway_transactions_arguspayment.count, gateway_transactions_authorize.count, gateway_transactions_baian.count, gateway_transactions_basecommerce.count, gateway_transactions_beanstream.count, gateway_transactions_betapay.count, gateway_transactions_bill1st.count, gateway_transactions_billpro.count, gateway_transactions_binaryfolder.count, gateway_transactions_binaryfolder.count, gateway_transactions_bitcoin_pg.count, gateway_transactions_braintree.count, gateway_transactions_braspag.count, gateway_transactions_brightspeed.count, gateway_transactions_cardready.count, gateway_transactions_cartconnect.count, gateway_transactions_cascadebill.count, gateway_transactions_cashflows.count, gateway_transactions_ccbill.count, gateway_transactions_chargeback_guardian.count, gateway_transactions_chargeback_guardian_previous.count, gateway_transactions_chargeback_sentinel.count, gateway_transactions_check21.count, gateway_transactions_checkout_dot_com.count, gateway_transactions_chequebot.count, gateway_transactions_citigate.count, gateway_transactions_cobrebem.count, gateway_transactions_codiumpro.count, gateway_transactions_crctotal.count, gateway_transactions_curepay.count, gateway_transactions_cwbpay.count, gateway_transactions_da_data.count, gateway_transactions_debitunit.count, gateway_transactions_denarii.count, gateway_transactions_digitsecure.count, gateway_transactions_docdata.count, gateway_transactions_easypayments.count, gateway_transactions_ecomm.count, gateway_transactions_edatafinancial.count, gateway_transactions_edatarealcharge.count, gateway_transactions_egatepay.count, gateway_transactions_emerchantpay.count, gateway_transactions_emerchantpay.count, gateway_transactions_epayapp.count, gateway_transactions_epay_machine.count, gateway_transactions_epro.count, gateway_transactions_epx.count, gateway_transactions_evosnap.count, gateway_transactions_eway.count, gateway_transactions_ezic.count, gateway_transactions_fifth_dimension.count, gateway_transactions_first_data.count, gateway_transactions_gatewayserve.count, gateway_transactions_genesis.count, gateway_transactions_globalcollect.count, gateway_transactions_globalpaymentsnow.count, gateway_transactions_gocoin.count, gateway_transactions_gpndata.count, gateway_transactions_groupiso.count, gateway_transactions_hypercharge.count, gateway_transactions_icepay.count, gateway_transactions_ics.count, gateway_transactions_intelpayments.count, gateway_transactions_libill.count, gateway_transactions_limelight.count, gateway_transactions_lixpay.count, gateway_transactions_maverick.count, gateway_transactions_maxpay.count, gateway_transactions_maxxmerchants.count, gateway_transactions_mconline.count, gateway_transactions_meikopay.count, gateway_transactions_meritus.count, gateway_transactions_mes.count, gateway_transactions_micropayment.count, gateway_transactions_mifinity.count, gateway_transactions_migs.count, gateway_transactions_multisafepay.count, gateway_transactions_nationalbankcard.count, gateway_transactions_netbilling.count, gateway_transactions_networkmerchantinc.count, gateway_transactions_ogone.count, gateway_transactions_omnipayment.count, gateway_transactions_optimal.count, gateway_transactions_orbital.count, gateway_transactions_orbitalpay.count, gateway_transactions_pacnet.count, gateway_transactions_pagamentsegur.count, gateway_transactions_pago.count, gateway_transactions_paybox.count, gateway_transactions_payhub.count, gateway_transactions_paykings.count, gateway_transactions_paymentserv.count, gateway_transactions_paymentworld.count, gateway_transactions_paymentz.count, gateway_transactions_payment_flow.count, gateway_transactions_paynet.count, gateway_transactions_payon.count, gateway_transactions_paypal.count, gateway_transactions_paypalexpress.count, gateway_transactions_payscout.count, gateway_transactions_payspace.count, gateway_transactions_paytheon.count, gateway_transactions_paytoo.count, gateway_transactions_pbs.count, gateway_transactions_ppw_partners.count, gateway_transactions_prismpay.count, gateway_transactions_processingcom.count, gateway_transactions_profitorius.count, gateway_transactions_protectpay.count, gateway_transactions_protex.count, gateway_transactions_quickpay.count, gateway_transactions_qwipi.count, gateway_transactions_rancho.count, gateway_transactions_rocketgate.count, gateway_transactions_romit.count, gateway_transactions_salt_payments_2.count, gateway_transactions_securenet.count, gateway_transactions_securepay.count, gateway_transactions_sirix.count, gateway_transactions_stripe.count, gateway_transactions_suite_pay.count, gateway_transactions_systempay.count, gateway_transactions_todur.count, gateway_transactions_transactpro.count, gateway_transactions_transready.count, gateway_transactions_tripayments.count, gateway_transactions_twokcharge.count, gateway_transactions_txassist.count, gateway_transactions_usaepay.count, gateway_transactions_vantiv.count, gateway_transactions_verifi.count, gateway_transactions_versatilepay.count, gateway_transactions_vitalpay.count, gateway_transactions_webpay.count, gateway_transactions_webstreetmedia.count, gateway_transactions_wiretrust.count, gateway_transactions_worldpay.count, gateway_transactions_ziripay.count, gpndata_notification_queue.count, load_balance_configuration_gateway_order_preserved.count, load_balance_configuration_log.count, membership_fields.count, module_decline_audit.count, orders.count, orders_features_overrides.count, orders_history.count, orders_processing_queue.count, orders_products.count, orders_status_history.count, orders_total.count, orders_to_delete.count, order_actions_history.count, order_attribute.count, order_documents.count, order_emails_to_send.count, order_import_temp.count, order_notification_history.count, order_parents.count, order_report.count, order_report_log.count, order_report_sync_queue.count, order_temp_orders_created.count, order_tracking_import.count, prospects.count, provider_batch_entry.count, retention_ancestors.count, return_import_queue.count, three_d_secure.count, v_approved_orders_decline_salvage_v2.count, v_approved_orders_initials_v2.count, v_main_order_total.count, v_orders.count, v_orders_decline_salvage.count, v_orders_first_try.count, v_orders_history.count, v_order_attribute_all.count, v_order_non_taxable.count, v_order_report.count, v_order_sales_tax.count, v_order_shipping.count, v_order_taxable.count, v_order_tax_factor.count, v_order_total.count, v_prospects.count, v_upsell_orders_count.count, v_upsell_unique_order_id_active_recurring.count]
  }
}
