view: order_report {
  sql_table_name:order_report      ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: upsell_id {
    type: number
    sql: ${TABLE}.upsell_id ;;
  }

  dimension: subscription_id {
    type: number
    sql: ${TABLE}.subscription_id ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: upsell_flag {
    type: number
    sql: ${TABLE}.upsell_flag ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension_group: t_stamp {
    type: time
    sql: ${TABLE}.t_stamp ;;
    convert_tz: no
  }

  dimension: deleted_flag {
    type: number
    sql: ${TABLE}.deleted_flag ;;
  }

  dimension: gateway_provider_type {
    type: string
    sql: ${TABLE}.gateway_provider_type ;;
  }

  dimension: upsell_cnt {
    type: number
    sql: ${TABLE}.upsell_cnt ;;
  }

  dimension: subscription_cnt {
    type: number
    sql: ${TABLE}.subscription_cnt ;;
  }

  dimension: active_subscription_cnt {
    type: number
    sql: ${TABLE}.active_subscription_cnt ;;
  }

  dimension: approved_flag {
    type: number
    sql: ${TABLE}.approved_flag ;;
  }

  dimension: decline_reason {
    type: string
    sql: ${TABLE}.decline_reason ;;
  }

  dimension: hold_flag {
    type: number
    sql: ${TABLE}.hold_flag ;;
  }

  dimension: cancellation_flag {
    type: number
    sql: ${TABLE}.cancellation_flag ;;
  }

  dimension: chargeback_flag {
    type: number
    sql: ${TABLE}.chargeback_flag ;;
  }

  dimension: fraud_flag {
    type: number
    sql: ${TABLE}.fraud_flag ;;
  }

  dimension: rma_flag {
    type: number
    sql: ${TABLE}.rma_flag ;;
  }

  dimension: return_flag {
    type: number
    sql: ${TABLE}.return_flag ;;
  }

  dimension: salvaged_flag {
    type: number
    sql: ${TABLE}.salvaged_flag ;;
  }

  dimension: pending_flag {
    type: number
    sql: ${TABLE}.pending_flag ;;
  }

  dimension: test_card_flag {
    type: number
    sql: ${TABLE}.test_card_flag ;;
  }

  dimension: refund_type {
    type: number
    sql: ${TABLE}.refund_type ;;
  }

  dimension: rma_reason {
    type: string
    sql: ${TABLE}.rma_reason ;;
  }

  dimension: return_reason {
    type: string
    sql: ${TABLE}.return_reason ;;
  }

  dimension_group: hold_date {
    type: time
    sql: ${TABLE}.hold_date ;;
    convert_tz: no
  }

  dimension: subtotal_amt {
    type: number
    sql: ${TABLE}.subtotal_amt ;;
  }

  dimension: shipping_amt {
    type: number
    sql: ${TABLE}.shipping_amt ;;
  }

  dimension: refund_amt {
    type: number
    sql: ${TABLE}.refund_amt ;;
  }

  dimension: tax_amt {
    type: number
    sql: ${TABLE}.tax_amt ;;
  }

  dimension: tax_pct {
    type: number
    sql: ${TABLE}.tax_pct ;;
  }

  dimension: forecasted_amt {
    type: number
    sql: ${TABLE}.forecasted_amt ;;
  }

  dimension: upsell_amt {
    type: number
    sql: ${TABLE}.upsell_amt ;;
  }

  dimension: sub_ltv {
    type: number
    sql: ${TABLE}.sub_ltv ;;
  }

  dimension: cust_ltv {
    type: number
    sql: ${TABLE}.cust_ltv ;;
  }

  dimension: subscription_flag {
    type: number
    sql: ${TABLE}.subscription_flag ;;
  }

  dimension: order_subscription_flag {
    type: number
    sql: ${TABLE}.order_subscription_flag ;;
  }

  dimension: subscription_bundle_flag {
    type: number
    sql: ${TABLE}.subscription_bundle_flag ;;
  }

  dimension: straight_sale_flag {
    type: number
    sql: ${TABLE}.straight_sale_flag ;;
  }

  dimension: rebill_depth {
    type: number
    sql: ${TABLE}.rebill_depth ;;
  }

  dimension: card_on_file_flag {
    type: number
    sql: ${TABLE}.card_on_file_flag ;;
  }

  dimension_group: recurring_date {
    type: time
    sql: ${TABLE}.recurring_date ;;
    convert_tz: no
  }

  dimension_group: retry_date {
    type: time
    sql: ${TABLE}.retry_date ;;
    convert_tz: no
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: variant_id {
    type: number
    sql: ${TABLE}.variant_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_attributes {
    type: string
    sql: ${TABLE}.product_attributes ;;
  }

  dimension: product_qty_main {
    type: number
    sql: ${TABLE}.product_qty_main ;;
  }

  dimension: product_qty_upsell {
    type: number
    sql: ${TABLE}.product_qty_upsell ;;
  }

  dimension: gateway_id {
    type: number
    sql: ${TABLE}.gateway_id ;;
  }

  dimension: gateway_name {
    type: string
    sql: ${TABLE}.gateway_name ;;
  }

  dimension: gateway_alias {
    type: string
    sql: ${TABLE}.gateway_alias ;;
  }

  dimension: lbc_id {
    type: number
    sql: ${TABLE}.lbc_id ;;
  }

  dimension: lbc_name {
    type: string
    sql: ${TABLE}.lbc_name ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}.currency_id ;;
  }

  dimension: currency_symbol {
    type: string
    sql: ${TABLE}.currency_symbol ;;
  }

  dimension: fulfillment_id {
    type: number
    sql: ${TABLE}.fulfillment_id ;;
  }

  dimension: provider_id {
    type: string
    sql: CASE WHEN ${fulfillment_id} IS NULL THEN 0
              WHEN ${fulfillment_id} = 0 THEN '-'
              ELSE ${fulfillment_id} END ;;
  }

  dimension: fulfillment_name {
    type: string
    sql: ${TABLE}.fulfillment_name ;;
  }

  dimension: provider {
    type: string
    sql: CASE WHEN ${provider_id} = '-' THEN "In House" ELSE ${fulfillment_name} END ;;
  }

  dimension: fulfillment_alias {
    type: string
    sql: ${TABLE}.fulfillment_alias ;;
  }

  dimension: alias {
    type: string
    sql: CASE WHEN ${provider_id} = '-' THEN "N/A" ELSE ${fulfillment_alias} END ;;
  }

  dimension: shippable_flag {
    type: number
    sql: ${TABLE}.shippable_flag ;;
  }

  dimension: shipped_flag {
    type: number
    sql: ${TABLE}.shipped_flag ;;
  }

  dimension: fulfillment_sent_flag {
    type: number
    sql: ${TABLE}.fulfillment_sent_flag ;;
  }

  dimension: tracking_sent_flag {
    type: number
    sql: ${TABLE}.tracking_sent_flag ;;
  }

  dimension_group: shipped_date {
    type: time
    sql: ${TABLE}.shipped_date ;;
    convert_tz: no
  }

  dimension: shippable_prod_cnt {
    type: number
    sql: ${TABLE}.shippable_prod_cnt ;;
  }

  dimension: days_pending {
    type: number
    sql: ${TABLE}.days_pending ;;
  }

  dimension: affiliate_depth {
    type: number
    sql: ${TABLE}.affiliate_depth ;;
  }

  dimension: aff_type_1 {
    type: string
    sql: ${TABLE}.aff_type_1 ;;
  }

  dimension: aff_val_1 {
    type: string
    sql: ${TABLE}.aff_val_1 ;;
  }

  dimension: aff_type_2 {
    type: string
    sql: ${TABLE}.aff_type_2 ;;
  }

  dimension: aff_val_2 {
    type: string
    sql: ${TABLE}.aff_val_2 ;;
  }

  dimension: aff_type_3 {
    type: string
    sql: ${TABLE}.aff_type_3 ;;
  }

  dimension: aff_val_3 {
    type: string
    sql: ${TABLE}.aff_val_3 ;;
  }

  dimension: aff_type_4 {
    type: string
    sql: ${TABLE}.aff_type_4 ;;
  }

  dimension: aff_val_4 {
    type: string
    sql: ${TABLE}.aff_val_4 ;;
  }

  measure: order_count {
    type: count
    filters: {
      field: status
      value: "2,6,8.10,11"
    }
    label: "Total"
    drill_fields: [detail*]
  }

  measure: net_order_total_gateway {
    label: "Gross Revenue_Gateway"
    description: "This is the total amount of all orders"
    type: sum
    html: {{ currency_symbol._value }}{{ rendered_value }};;
    value_format_name: decimal_2
    sql: ${subtotal_amt} + ${tax_amt} + ${shipping_amt} ;;
  }

  measure: gross_order_gateway {
    label: "Gross Orders_Gateway"
    type: count
    filters: {
      field: upsell_flag
      value: "0"
    }
    drill_fields: [detail*]
  }

  measure: shippable_count {
    type: count
    filters: {
      field: shippable_flag
      value: "1"
    }
    label: "Shippable Count"
    drill_fields: [detail*]
  }

  measure: shipped_count {
    type: count
    filters: {
      field: shipped_flag
      value: "1"
    }
    label: "Shipped Count"
    drill_fields: [detail*]
  }


  measure: shippable_prod_count {
    type: sum
    label: "Shippable Product Count"
    sql: ${shippable_prod_cnt} ;;
    drill_fields: [detail*]
  }

  dimension: order_status_name {
    type: string
    sql: CASE WHEN ${status} in (2,6,8) THEN 'Approved' WHEN ${status} = 7 THEN 'Declined' WHEN ${status} = 3 THEN 'Archived' WHEN ${status} = 9 THEN 'On-Hold' ELSE 'Pending' END ;;
  }

  dimension: is_approved {
    type: yesno
    sql: ${status} in (2, 6, 8) ;;
  }

  measure: active_subs_count {
    type: count
    filters: {
      field: active_subscription_cnt
      value: ">0"
    }
    label: "Active Subscription Count"
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      order_id,
      upsell_id,
      subscription_id,
      customer_id,
      upsell_flag,
      status,
      t_stamp_time,
      deleted_flag,
      gateway_provider_type,
      upsell_cnt,
      subscription_cnt,
      active_subscription_cnt,
      approved_flag,
      decline_reason,
      hold_flag,
      cancellation_flag,
      chargeback_flag,
      fraud_flag,
      rma_flag,
      return_flag,
      salvaged_flag,
      pending_flag,
      test_card_flag,
      refund_type,
      rma_reason,
      return_reason,
      hold_date_time,
      subtotal_amt,
      shipping_amt,
      refund_amt,
      tax_amt,
      tax_pct,
      forecasted_amt,
      upsell_amt,
      sub_ltv,
      cust_ltv,
      subscription_flag,
      order_subscription_flag,
      subscription_bundle_flag,
      straight_sale_flag,
      rebill_depth,
      card_on_file_flag,
      recurring_date_time,
      retry_date_time,
      campaign_id,
      campaign_name,
      product_id,
      variant_id,
      product_name,
      product_attributes,
      product_qty_main,
      product_qty_upsell,
      gateway_id,
      gateway_name,
      gateway_alias,
      lbc_id,
      lbc_name,
      currency_id,
      currency_symbol,
      fulfillment_id,
      fulfillment_name,
      fulfillment_alias,
      shippable_flag,
      shipped_flag,
      fulfillment_sent_flag,
      tracking_sent_flag,
      shipped_date_time,
      shippable_prod_cnt,
      days_pending,
      affiliate_depth,
      aff_type_1,
      aff_val_1,
      aff_type_2,
      aff_val_2,
      aff_type_3,
      aff_val_3,
      aff_type_4,
      aff_val_4
    ]
  }

  #----Sales by Retention------------------
}
