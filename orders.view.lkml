view: orders {
  sql_table_name: orders ;;

  dimension: common_ancestor_order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.commonAncestorOrderId ;;
  }

  dimension: 3_dauth_token {
    type: string
    sql: ${TABLE}.3DAuthToken ;;
  }


  dimension: activity {
    label: "Activity"
    type: string
    sql: IFNULL(${tlkp_orders_history_group.name}, ${tlkp_orders_history_type.name}) ;;
    #sql: IF(IFNULL(${tlkp_orders_history_group.name}, '') = '', ${tlkp_orders_history_type.name}, CONCAT(${tlkp_orders_history_group.name}, ' (', ${tlkp_orders_history_type.name}, ')')) ;;
  }


  dimension: activity_rep_yesno {
    label: "Activity"
    type: yesno
    sql: ((
                  IF
                  (
                     ${orders_history.type} = 'recurring' AND ${orders_history.status} IN ('hold', 'stop'),
                     CONCAT(${orders_history.type}, '-', ${orders_history.status}),
                     ${orders_history.type}
                  )
               ) = ${tlkp_orders_history_type.type_id});;
    #sql: IF(IFNULL(${tlkp_orders_history_group.name}, '') = '', ${tlkp_orders_history_type.name}, CONCAT(${tlkp_orders_history_group.name}, ' (', ${tlkp_orders_history_type.name}, ')')) ;;
  }

  dimension: affid {
    type: string
    sql: ${TABLE}.AFFID ;;
  }

  measure: affiliate_breakdown {
    sql: "Affiliate ID" ;;
    link: {
      label: "Affiliate Breakdown"
      url: "https://analytics.limelightcrm.com/looks/406"
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

  dimension: client_domain {
    type: string
    sql: (select concat(`value`,'.limelightcrm.com') as client_domain from config_settings where `key` = 'APPLICATION_KEY') ;;
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

  dimension: campaign {
    full_suggestions: yes
    label: "Campaign"
    type: string
    sql: CONCAT('(', ${campaign_order_id}, ') ', ${campaigns.c_name}) ;;
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

  dimension: currency_fmt {
    hidden: no
    full_suggestions: yes
    type: string
    sql: CASE WHEN ${currency_id} = 1 THEN 'USD'
              WHEN ${currency_id} = 2 THEN 'EUR'
              WHEN ${currency_id} = 3 THEN 'GBP'
              WHEN ${currency_id} = 4 THEN 'CAD'
              WHEN ${currency_id} = 5 THEN 'AUD'
              WHEN ${currency_id} = 6 THEN 'ZAR'
              WHEN ${currency_id} = 7 THEN 'JPY'
              WHEN ${currency_id} = 8 THEN 'DKK'
              WHEN ${currency_id} = 9 THEN 'NOK'
              WHEN ${currency_id} = 10 THEN 'SEK'
              WHEN ${currency_id} = 11 THEN 'BRL'
              WHEN ${currency_id} = 12 THEN 'CLP'
              WHEN ${currency_id} = 13 THEN 'MXN'
              WHEN ${currency_id} = 14 THEN 'KRW'
              WHEN ${currency_id} = 15 THEN 'NZD'
              WHEN ${currency_id} = 16 THEN 'PLN'
              WHEN ${currency_id} = 17 THEN 'SGD'
              WHEN ${currency_id} = 18 THEN 'HKD'
              WHEN ${currency_id} = 19 THEN 'ARS'
              ELSE 'CUR ' || ${currency_id}
         END ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: currency_id {
    type: string
    sql: ${order_report.currency_id} ;;
  }

  dimension: currency_value {
    type: number
    sql: ${TABLE}.currency_value ;;
  }

  dimension: currency_symbol {
    type: string
    sql: ${order_report.currency_symbol} ;;
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
    convert_tz: no
  }

  dimension_group: date_1 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_1 ;;
    convert_tz: no
  }

  dimension_group: date_2 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_2 ;;
    convert_tz: no
  }

  dimension_group: date_3 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_3 ;;
    convert_tz: no
  }

  dimension_group: date_4 {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_4 ;;
    convert_tz: no
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
    sql:  CONCAT('(',${gateway_id}, ') ', ${gateway.gateway_alias}) ;;
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

  dimension: is_chargeback_num {
    type: number
    sql: ${TABLE}.isChargeback ;;
  }

  dimension: is_declined {
    type: yesno
    sql: ${TABLE}.orders_status = 7 ;;
  }

  dimension: is_chargeback_reversal {
    type: yesno
    sql: ${TABLE}.isChargebackReversal ;;
  }

  dimension: date_decline {
    type: number
    sql: (CONCAT(${campaign_order_id}, ${customers_email_address}, ${t_stamp_date} , ${t_stamp_week}));;
  }

  dimension: is_fraud {
    type: yesno
    sql: ${TABLE}.isFraud ;;
  }

  dimension: is_fraud_num {
    type: number
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

  dimension: is_rma_num {
    type: number
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
    convert_tz: no
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
    convert_tz: no
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
    convert_tz: no
  }

  dimension: orders_id {
    type: number
    link: {
      label: "Navigate to Order"
      url: "https://{{client_domain._value}}/admin/orders.php?show_details=show_details&show_folder=view_all&fromPost=1&act=&sequence=1&show_by_id={{value}}"
    }
    # hidden: true
    sql: ${TABLE}.orders_id ;;
  }

  dimension: orders_status {
    type: number
    sql: ${TABLE}.orders_status ;;
  }

  dimension: oht_type_id {
    type: string
    sql: ${orders_history.oht_type_id} ;;
  }

  dimension: oht_group_id {
    type: string
    sql: ${tlkp_orders_history_type.group_id} ;;
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

  dimension: products_id {
    type: number
    # hidden: true
    sql: ${orders_products.products_id} ;;
  }

  measure: product_id_list {
    type: string
    sql: SUBSTRING(GROUP_CONCAT(DISTINCT(${orders_products.products_id})),1,20) ;;
  }

  dimension: products_quantity {
    type: number
    # hidden: true
    sql: ${orders_products.products_quantity} ;;
  }

  dimension: rebill_depth {
    type: number
    sql: ${TABLE}.rebillDepth ;;
  }


  dimension: subscription_cycle {
    # We put the SPACE in front of Initial on purpose so it sorts properly in tables
    type: string
    sql: CASE WHEN ${rebill_depth} = 0 THEN ' Initial' WHEN ${rebill_depth} >= 5 THEN 'Cycle 5+' ELSE 'Cycle ' || ${rebill_depth} END ;;
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

  dimension: return_flag {
    type: yesno
    sql: ${order_report.return_flag} ;;
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
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.t_stamp ;;
    convert_tz: no
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

  dimension: user_id {
    type: string
    sql: ${orders_history.user} ;;
  }


  dimension: history_type {
    type: string
    sql: ${orders_history.type} ;;
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

  dimension: cancellation_flag {
    type: yesno
    sql: ${order_report.cancellation_flag} ;;
  }

  dimension: hold_flag {
    type: yesno
    sql: ${order_report.hold_flag} ;;
  }

  dimension: upsell_id {
    type: number
    sql: ${order_report.upsell_id} ;;
  }




  filter: cycle_select {
    type: number
    suggest_dimension: rebill_depth
  }

  dimension: subscription_pivot {
    sql: (CASE
        WHEN {% condition cycle_select %} ${rebill_depth} {% endcondition %}
          THEN ${rebill_depth}
          ELSE 0
          END)
       ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_upsell_products {
    type: number
    sql:  ${upsell_orders_products.count};;
    drill_fields: [detail*]
  }

  measure:  count_customers {
    type: count_distinct
    filters: {
      field: customers_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "NOT 7, 10, 11"
    }
    filters: {
      field: parent_order_id
      value: "0"
    }
    label: "Initial Customers"
    sql: ${customers_email_address} ;;
    drill_fields: [detail*]
  }


  measure: order_count_employee_activity {
    type: count
    filters: {
      field: orders_history.type
      value: "-%gateway%"
    }
    label: "Activity Count"
    link: {
      url: "https://analytics.limelightcrm.com/looks/579"
    }
    drill_fields: [orders_id, admin.admin_id, admin.admin_fullname, activity, t_stamp_date]
  }

  measure:  average_order_total {
    type: number
    label: "Avg Order"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${total_revenue}/NULLIF(${order_count},0) ;;
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
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_report.subtotal_amt} + ${order_report.tax_amt} + ${order_report.shipping_amt} ;;
  }


  measure:  declines {
    type: count
    label: "Declines"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: was_salvaged
      value: "no"
    }
    filters: {
      field: deleted
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: decline_percent {
    type: number
    label: "Decline Percentage"
    value_format_name: percent_2
    sql: ${declined_orders} / NULLIF(${gross_order_count},0) ;;
  }

  measure:  holds_orders {
    type: count
    label: "Holds"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: v_orders.hold_from_recurring
      value: "1"
    }
    filters: {
      field: orders_status
      value: "2,6,8"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }


  measure:  hold_cancel_orders {
    type: number
    label: "Holds/Cancels"
    sql: ${holds_orders} + ${cancel_orders} ;;
    drill_fields: [detail*]
  }

  measure:  cancel_orders {
    type: count
    label: "Cancels"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: v_orders.hold_from_recurring
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    filters: {
      field: orders_status
      value: "2,6,8"
    }
    drill_fields: [detail*]
  }

  measure:  prior_hold_cancel_orders {
    type: count
    label: "Prior Holds/Cancels"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    filters: {
      field: prior_holds
      value: "yes"
    }
    drill_fields: [detail*]
  }

  filter: prior_date_select {
    type: date
    suggest_dimension: t_stamp_date
  }


  dimension: prior_holds {
    type: yesno
    sql: {% condition prior_date_select %} ${hold_date} {% endcondition %} AND
        NOT({% condition prior_date_select %} ${t_stamp_date} {% endcondition %}) ;;
    hidden: yes
  }


  measure:  subscription_approved {
    type: count
    label: "Subscriptions Approved"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    filters: {
      field: parent_order_id
      value: ">0"
    }
    filters: {
      field: is_approved
      value: "yes"
    }
    drill_fields: [detail*]
  }


  measure:  void_full_refund_orders {
    type: count
    label: "Void/Full Refund"
    filters: {
      field: refund_type
      value: "2,3"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  partial_refund_orders {
    type: count
    label: "Partial Refund"
    filters: {
      field: refund_type
      value: "1"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
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
      field: orders_status
      value: "NOT 7,10,11"
    }
    filters: {
      field: payment_module_code
      value: "1"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: approved_revenue {
    type: sum
    label: "Approved Revenue"
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${v_main_order_total.main_product_amount_shipping_tax} ;;
  }

  measure: percent_approved {
    type: number
    value_format_name: percent_2
    sql: ${count_approved} / NULLIF(${count},0) ;;
    html: {% if value < 0.3 %}
      <div style="color:red; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% elsif value >= 0.3 and value < 0.7 %}
      <div style="color:#eab409; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% elsif value >= 0.7 %}
      <div style="color:green; font-size:100%; text-align:center">{{ rendered_value }}</div>
      {% endif %}
      ;;
  }

  measure:  tax_revenue {
    type: sum
    label: "Tax Revenue"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_tax} ;;
  }

 # ------- Sales By Date ------

  measure:  initial_orders {
    type: count
    label: "Initial Orders"
    filters: {
      field: rebill_depth
      value: "0"
    }
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: order_count {
    type: count
    label: "Total"
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }


  measure:  pending_orders {
    type: count
    label: "Pending Orders"
    filters: {
      field: orders_status
      value: "10,11"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure:  declined_orders {
    type: count_distinct
    label: "Declined Orders"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: was_salvaged
      value: "no"
    }
    sql: CONCAT(${campaign_order_id}, ${customers_email_address}, ${t_stamp_date}) ;;
    drill_fields: [detail*]
  }

  measure:  subscription_orders {
    type: count
    label: "Subscriptions"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    filters: {
      field: parent_order_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }


  measure:  void_refund_orders {
    type: count
    label: "Void/Refund Orders"
    filters: {
      field: refund_type
      value: ">1"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [orders_id, orders_status,order_status_name, order_total]
  }

  measure:  hold_cancel_orders_date {
    type: count
    label: "Holds/Cancels - Sales by Date"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: decline_revenue {
    type: sum
    label: "Decline Revenue"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: was_salvaged
      value: "no"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${v_main_order_total.main_product_amount_shipping_tax} + ${order_report.upsell_amt}) ;;
    #sql_distinct_key: CONCAT(${campaign_order_id}, ${customers_email_address}, ${t_stamp_date}) ;;
  }

  measure: decline_distinct_ratio_date {
    type: number
    hidden: yes
    value_format_name: decimal_4
    sql:  ${declined_orders}/NULLIF(${declined_orders_hide},0);;
  }

  measure: decline_revenue_date {
    type: number
    label: "Decline Revenue - Date"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql:${decline_revenue}*${decline_distinct_ratio_date} ;;
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
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: currency_value
      value: "NOT NULL"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${currency_value} ;;
  }

  measure:  initial_revenue {
    type: sum
    label: "Initial Revenue"
    filters: {
      field: rebill_depth
      value: "0"
    }
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${v_main_order_total.current_total} + ${order_report.upsell_amt});;
  }

  measure: pending_revenue {
    type: sum
    label: "Pending Revenue"
    filters: {
      field: orders_status
      value: "10,11"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    value_format_name: decimal_2
    sql:(${v_main_order_total.current_total} + ${order_report.upsell_amt}) ;;
  }

  measure:  subscription_revenue {
    type: sum
    label: "Subscription Revenue"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    filters: {
      field: parent_order_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${v_main_order_total.current_total} + ${order_report.upsell_amt}) ;;
  }

  measure:  shipping_revenue {
    type: sum
    label: "Shipping Revenue"
    filters: {
      field: payment_module_code
      value: "1"
    }
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: orders_status
      value: "NOT 7,10,11"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${order_report.shipping_amt}) ;;
  }

  measure:  total_revenue {
    type: sum
    label: "Total Revenue"
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${v_main_order_total.current_total} + ${order_report.upsell_amt}) ;;
  }

  measure:  void_refund_revenue {
    type: sum
    label: "Void/Refunded Revenue"
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${v_main_order_total.refunded_amount} ;;
  }



   # ------- Sales By Date End------

  # ------- Sales By Campaign ------

  measure:  declined_orders_campaign {
    type: count_distinct
    label: "Declined Orders - Campaign"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: was_salvaged
      value: "no"
    }
    sql: CONCAT(${campaign_order_id}, ${customers_email_address}) ;;
    drill_fields: [detail*]
  }

  measure:  declined_orders_hide {
    type: count
    hidden: yes
    label: "Declined Orders - Hide"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: was_salvaged
      value: "no"
    }
    drill_fields: [detail*]
  }

  measure: decline_distinct_ratio_campaign {
    type: number
    hidden: yes
    value_format_name: decimal_4
    sql:  ${declined_orders_campaign}/NULLIF(${declined_orders_hide},0);;
  }

  measure: decline_revenue_campaign {
    type: number
    label: "Decline Revenue - Campaign"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql:${decline_revenue}*${decline_distinct_ratio_campaign} ;;
  }

  measure: active_subscription_cnt {
    label: "Active Subscription Count"
    type: sum
    filters: {
      field: orders_status
      value: "2,8"
    }
    filters: {
      field: is_recurring
      value: "yes"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    sql: ${is_recurring} ;;
    drill_fields: [detail*]
    #sql: ${order_report.active_subscription_cnt} ;;
  }



  # ------- Sales By Campaign End  ------

  # ------- Sales By Subscription ------

  dimension: attempt {
    label: "Attempt"
    type: string
    sql: CASE WHEN ${int_2} > 0 THEN CONCAT('Attempt', ${int_2}) ELSE 'Initial' END ;;
    drill_fields: [subscription*]
  }

  measure: gross_order_count {
    label: "Gross Orders"
    type: count
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [subscription*]
  }

  measure: approved_order_count {
    label: "Approved Orders"
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    type: count
    drill_fields: [subscription*]
  }

  measure: approved_revenue_subscription {
    type: sum
    label: "Approved Revenue - Subscription"
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${v_main_order_total.main_product_amount_shipping_tax} + ${order_report.upsell_amt}) ;;
  }

  measure: approved_order_percent {
    type: number
    label: "Approved %"
    value_format_name: percent_1
    sql: ${approved_order_count} / NULLIF(${count},0) ;;
  }

  measure: average_discount_percent {
    type: average
    label: "Average Discount %"
    value_format_name: percent_1
    sql: CASE WHEN ${int_1} IS NULL THEN "0" ELSE (${int_1}/100) END ;;
  }

  measure:  declined_orders_subscriptions {
    type: count
    label: "Declined Orders - Subscriptions"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: discount_percent {
    type: number
    label: "Discount %"
    value_format_name: percent_1
    sql: CASE WHEN ${v_orders.retry_discount_pct} IS NULL THEN "0" ELSE ${v_orders.retry_discount_pct} END ;;
  }

  measure: discount_amount {
    type: number
    label: "Discount Amount"
    value_format_name: decimal_2
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${v_orders.retry_discount_amt};;
  }

  # ------- Sales By Subscription End------

 # ------- Sales By Gateway ------

  measure: net_order_total_gateway {
    label: "Net Revenue_Gateway"
    type: sum
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${v_main_order_total.current_total} + ${order_report.upsell_amt} ;;
  }

  measure: gross_order_gateway {
    label: "Gross Orders_Gateway"
    type: count
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [gateway*]
  }

  measure: chargeback_count {
    label: "Chargebacks"
    filters: {
      field: is_chargeback
      value: "yes"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    type: count
    drill_fields: [gateway*]
  }


  measure:  void_refund_orders_gateway {
    type: count
    label: "Void/Refund Orders - Gateway"
    filters: {
      field: refund_type
      value: ">0"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    drill_fields: [gateway*]
  }


  measure:  void_refund_revenue_gateway {
    type: sum
    label: "Void/Refunded Revenue - Gateway"
    filters: {
      field: refund_type
      value: ">0"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${amount_refunded_so_far} ;;
  }

  measure: chargeback_percentage {
    type: number
    label: "Chargeback Percentage"
    value_format_name: percent_2
    sql: ${chargeback_count} / NULLIF(${order_count},0) ;;
  }

  measure: refund_count {
    label: "Refunds"
    filters: {
      field: refund_type
      value: ">0"
    }
    type: count
    drill_fields: [detail*]
  }

  measure: net_approved_total {
    label: "Gross Approved Revenue"
    description: "This is the total amount of all orders"
    type: sum
    filters: {
      field: orders_status
      value: "2,8"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_total};;
  }

  measure:  net_revenue {
    type: number
    label: "Net Revenue"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${net_approved_total} - ${void_refund_revenue} ;;
  }

  measure:  gross_revenue_gateway {
    type: number
    label: "Gross Approved Revenue_Gateway"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: (${net_order_total_gateway} + ${void_refund_revenue_gateway}) ;;
  }

  measure: chargeback_percentage_gateway {
    type: number
    label: "Chargeback Percentage - Gateway"
    value_format_name: percent_2
    sql: ${chargeback_count} / NULLIF(${gross_order_gateway},0) ;;
  }

  measure:  declined_orders_gateway {
    type: count
    label: "Declined Orders - Gateway"
    filters: {
      field: orders_status
      value: "7"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    #sql: CONCAT(${campaign_order_id}, ${customers_email_address}, ${t_stamp_date}) ;;
    drill_fields: [gateway*]
  }

  measure: decline_percent_gateway {
    type: number
    label: "Decline Percentage - Gateway"
    value_format_name: percent_2
    sql: ${declined_orders_gateway} / NULLIF(${gross_order_gateway},0) ;;
  }

 # ------- Sales By Gateway End------


 # ------- Fulfillment Reconciliation-----

  measure: tracking_count {
    label: "Tracking Orders"
    filters: {
      field: has_been_posted
      value: "1"
    }
    filters: {
      field: shipping_module_code
      value: "0"
    }
    filters: {
      field: has_tracking_been_posted
      value: "0"
    }
    type: count
    drill_fields: [detail*]
  }

  measure: pending_post_count {
    type: count
    filters: {
      field: has_been_posted
      value: "0"
    }
    filters: {
      field: shipping_module_code
      value: "0"
    }
    filters: {
      field: is_fraud
      value: "no"
    }
    filters: {
      field: is_rma
      value: "no"
    }
    filters: {
      field: is_chargeback
      value: "no"
    }
    filters: {
      field: orders_status
      value: "2"
    }
    filters: {
      field: orders_products.products_quantity
      value: ">0"
    }
    label: "Orders Pending Post"
    drill_fields: [detail*]
  }


    measure: sent_count {
    type: count
    filters: {
      field: order_report.fulfillment_sent_flag
      value: "1"
    }
    label: "Sent to Fulfillment"
    #sql: (${products_quantity} + ${count_upsell_products}) ;;
    drill_fields: [detail*]
  }

  measure: shipped_count {
    type: count
    filters: {
      field: shipping_module_code
      value: "1"
    }
    label: "Shipped Orders"
    #sql: (${products_quantity} + ${count_upsell_products}) ;;
    drill_fields: [detail*]
  }


  measure: pending_tracking_count {
    type: number
    label: "Pending Tracking Count"
    sql: ${tracking_count} + ${products_tracking_count};;
    drill_fields: [detail*]
  }

  measure: products_tracking_count {
    type: sum
    filters: {
      field: tracking_num
      value: "NULL"
    }
    label: "Product Tracking"
    sql: ${products_quantity} ;;
  }

  measure: shippable_order_count {
    type: count
    label: "Shippable Orders Count"
    filters: {
      field: v_orders.shippable_flag
      value: "1"
    }
  }

  measure: shippable_product_count {
    type: sum
    label: "Shippable Product Count"
    sql: ${order_report.shippable_prod_cnt} ;;
  }

  measure: avg_days_pending {
    type: average
    label: "Average Days Pending Tracking"
    sql: ${order_report.days_pending} ;;
  }

  measure: pending_return_count {
    type: count
    filters: {
      field: is_rma
      value: "1"
    }
    filters: {
      field: return_flag
      value: ">0"
    }
    label: "Pending Return"
    drill_fields: [detail*]
  }

  measure: return_count {
    type: count
    filters: {
      field: is_rma
      value: "2"
    }
    label: "Returned"
    drill_fields: [detail*]
  }

#-----Fulfillment Renciliation End ----------------------------

#-----Sales by Prospect ----------------------------


  measure: net_order_total_prospect {
    label: "Gross Revenue_Prospects"
    description: "This is the total amount for Sales by Prospects"
    type: sum
    filters: {
      field: customers_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "NOT 7, 10, 11"
    }
    filters: {
      field: parent_order_id
      value: "0"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_total} ;;
    drill_fields: [detail*]
  }

  measure:  average_revenue_prospect {
    type: number
    label: "Average Revenue"
    description: "Average Revenue Calculation for Sales by Prospect"
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${net_order_total_prospect}/NULLIF(${count_customers},0) ;;
  }


#-----Sales by Prospect Ends ----------------------------

#-----Decline Reasons ----------------------------


  dimension: cc_type_fmt {
    label: "Provider Type"
    type: string
    sql: CASE WHEN ${cc_type} != 'checking' THEN 'Credit Card / Other' ELSE ${cc_type} END  ;;
  }

  dimension: decline_reason {
    type: string
    sql: ${orders_history.status} ;;
  }

  measure:  initial_orders_decline_reasons {
    type: count
    label: "Initial"
    description: "This is Initial count for Decline Reasons Report"
    filters: {
      field: rebill_depth
      value: "0"
    }
    drill_fields: [orders_id, is_subscription, t_stamp_date, decline_reason]
  }

  measure: subscription_decline_reason {
    label: "Subscription"
    type: number
    description: "Separate measure for Decline Reasons Report"
    sql: ${count_decl_reas} - ${initial_orders_decline_reasons} ;;
    drill_fields: [orders_id, is_subscription, t_stamp_date, decline_reason]
  }

  measure: count_decl_reas {
    type: count_distinct
    label: "All"
    sql: ${orders_id} ;;
    description: "Separate measure for Decline Reasons Report"
    drill_fields: [orders_id, is_subscription, t_stamp_date, decline_reason]
  }
#-----Decline Reasons End----------------------------
#-----Sales by Product ----------------------------

  measure:  initial_orders_product {
    type: sum
    label: "Initial Products"
    description: "Initial Product Count"
    filters: {
      field: rebill_depth
      value: "0"
    }
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    sql: ${orders_products.products_quantity} ;;
    drill_fields: [detail*]
  }

  measure:  subscription_orders_product {
    type: sum
    label: "Subscription- Sales By Product"
    description: "Subscription Product Count"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    filters: {
      field: parent_order_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    sql: ${orders_products.products_quantity} ;;
    drill_fields: [detail*]
  }

  measure:  total_orders_product {
    type: sum
    label: "Total- Sales By Product"
    description: "Total Product Count"
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    sql: ${orders_products.products_quantity} ;;
    drill_fields: [detail*]
  }

  measure:  pending_orders_product {
    type: sum
    label: "Pending - Sales By Product"
    description: "Pending Product Count"
    filters: {
      field: orders_status
      value: "10,11"
    }
    sql: ${orders_products.products_quantity} ;;
    drill_fields: [detail*]
  }

  measure:  hold_orders_product {
    type: sum
    label: "Hold/Cancel - Sales By Product"
    description: "Hold/Cancel Product Count"
    filters: {
      field: is_hold
      value: "1"
    }
    filters: {
      field: is_archived
      value: "0"
    }
    sql: ${orders_products.products_quantity} ;;
    drill_fields: [detail*]
  }

  measure:  initial_revenue_products {
    type: sum
    label: "Initial Revenue - Products"
    filters: {
      field: rebill_depth
      value: "0"
    }
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_report.subtotal_amt} ;;
  }

  measure: pending_revenue_products {
    type: sum
    label: "Pending Revenue - Products"
    filters: {
      field: orders_status
      value: "10,11"
    }
    value_format_name: decimal_2
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    sql: ${order_report.subtotal_amt} ;;
  }

  measure:  subscription_revenue_products {
    type: sum
    label: "Subscription Revenue - Products"
    filters: {
      field: rebill_depth
      value: ">0"
    }
    filters: {
      field: parent_order_id
      value: ">0"
    }
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_report.subtotal_amt} ;;
  }


  measure:  total_revenue_products {
    type: sum
    label: "Total Revenue - Products"
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_report.subtotal_amt} ;;
  }

  measure:  hold_cancel_revenue_products {
    type: sum
    label: "Holds/Cancels Revenue - Products"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: is_hold
      value: "1"
    }
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${order_report.subtotal_amt} ;;
  }
 # ------- Sales By Products Ends ------

 # ------- Sales By Retention ------

  measure: order_count_retention {
    type: count
    label: "Gross Orders - Retention"
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: orders_status
      value: "NOT 7"
    }
    #sql: CONCAT(${campaign_order_id}, ${customers_email_address}) ;;
    drill_fields: [subscription*]
  }

  measure: unique_declines_retention {
    type: count_distinct
    label: "Unique Declines - Retention"
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: orders_status
      value: "7"
    }
    sql: CONCAT(${campaign_order_id}, ${customers_email_address}) ;;
    drill_fields: [subscription*]
  }

  measure: unique_declines_1_retention {
    type: count_distinct
    label: "Unique Declines 1 - Retention"
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: is_approved
      value: "yes"
    }
    sql: CONCAT(${campaign_order_id}, ${customers_email_address}) ;;
    drill_fields: [subscription*]
  }

  measure: approved_subscriptions_count {
    label: "Subscriptions Approved SbR"
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: is_approved
      value: "yes"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: order_report.subscription_cnt
      value: ">0"
    }
    type: count
    drill_fields: [subscription*]
  }

  measure: pending_count_retention {
    label: "Pending SbR"
    filters: {
      field: is_approved
      value: "yes"
    }
    filters: {
      field: order_report.straight_sale_flag
      value: "0"
    }
    filters: {
      field: is_hold
      value: "0"
    }
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: is_subscription
      value: "yes"
    }
    type: count
    drill_fields: [subscription*]
  }

  measure: approved_order_count_retention {
    label: "Approved Orders - Sales by Retention"
    filters: {
      field: is_approved
      value: "yes"
    }
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    type: count
    drill_fields: [subscription*]
  }

  measure: approval_rate_retention {
    type: number
    label: "Approval Rate"
    value_format_name: percent_2
    sql: ${approved_subscriptions_count} / NULLIF(${order_count_retention},0) ;;
  }

  measure:  declined_orders_retention {
    type: count_distinct
    filters: {
      field: orders_status
      value: "7"
    }
    label: "Declined Orders - Sales By Retention"
    #sql: ${order_count_retention} - ${approved_order_count_retention} ;;
    sql: CONCAT(${campaign_order_id}, ${customers_email_address}) ;;
    drill_fields: [subscription*]
  }

  measure:  hold_orders {
    type: count
    label: "Hold"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: hold_flag
      value: "yes"
    }
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: cancellation_flag
      value: "no"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: order_report.straight_sale_flag
      value: "0"
    }
    drill_fields: [subscription*]
  }

  measure:  canceled_orders {
    type: count
    label: "Canceled"
    filters: {
      field: is_archived
      value: "0"
    }
    filters: {
      field: cancellation_flag
      value: "yes"
    }
    filters: {
      field: refund_type
      value: "<2"
    }
    filters: {
      field: order_report.upsell_flag
      value: "0"
    }
    filters: {
      field: order_report.straight_sale_flag
      value: "0"
    }
    drill_fields: [subscription*]
  }

 # ------- Sales By Retention Ends ------

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [orders_id,orders_status, rebill_depth, order_status_name, products_quantity, order_total, currency,  parent_order_id,common_ancestor_order_id]
  }

  set: subscription {
    fields: [orders_id, attempt, t_stamp_date, order_status_name, discount_percent, discount_amount, approved_revenue]
  }

  set: gateway {
    fields: [orders_id, cc_type_fmt, net_order_total, void_refund_revenue_gateway, refund_type, is_chargeback, is_declined, t_stamp_date]
  }
}
