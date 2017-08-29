connection: "transactional-pair-aws"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
explore: campaigns{}

explore: mysql_stats {}

explore: 3d_verify_enrollment {}

explore: ad_hoc_page_access_by_order {}

explore: countries{}

explore: gateway{}

explore: pdt_retention {
  access_filter: {
    field: pdt_retention.campaign_id
    user_attribute: campaign_id
  }
}

explore: pdt_retention_new {
  access_filter: {
    field: pdt_retention_new.campaign_id
    user_attribute: campaign_id
  }
}

explore: pdt_sales_by_product {
  access_filter: {
    field: pdt_sales_by_product.campaign_id
    user_attribute: campaign_id
  }
}

explore: pdt_user_activity {}

explore: pdt_employee_activity {}

explore: pdt_sales_by_campaign {
  access_filter: {
    field: pdt_sales_by_campaign.campaign_id
    user_attribute: campaign_id
  }
}

explore: pdt_fulfillment_reconciliation {

  access_filter: {
    field: pdt_fulfillment_reconciliation.campaign_id
    user_attribute: campaign_id
  }

  join: v_orders {
    type: left_outer
    relationship: one_to_one
    sql_on: ${v_orders.orders_id} = ${pdt_fulfillment_reconciliation.order_id} ;;
  }
}


explore: subscr_mgmt{}

explore: order_report {}

explore: orders_history{}

explore: orders {
  access_filter: {
    field: orders.campaign_id
    user_attribute: campaign_id
  }

  join: upsell_orders {
    type: left_outer
    relationship: many_to_one
    sql_on: ${upsell_orders.main_orders_id} = ${orders.orders_id};;
  }

  join: upsell_orders_products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${upsell_orders.main_orders_id} = ${orders.common_ancestor_order_id}
      AND ${upsell_orders_products.upsell_orders_products_id} = ${upsell_orders.upsell_orders_id};;
  }

  join: orders_history {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders_history.orders_id} = ${orders.orders_id};;
  }

  join: admin {
    type: left_outer
    relationship: many_to_one
    sql_on: ${admin.admin_id} = ${orders.user_id};;
  }

  join: client_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_info.domain} = ${orders.domain};;
  }

  join: order_report {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_report.order_id} = ${orders.orders_id};;
  }

  join: v_orders {
    type: left_outer
    relationship: one_to_one
    sql_on: ${v_orders.orders_id} = ${orders.orders_id};;
  }


  join: decline_hold_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${decline_hold_pdt.orders_id} = ${orders.orders_id}
        AND ${decline_hold_pdt.orders_id} > '0';;
  }


  join: decline_hold_data{
    type: left_outer
    relationship: one_to_one
    sql_on: ${decline_hold_data.orders_id} = ${orders.orders_id}
      AND ${decline_hold_data.orders_id} > '0';;
  }

  join: tlkp_orders_history_type {
    type: left_outer
    relationship: many_to_one
    sql_on: ${tlkp_orders_history_type.type_id} = ${orders.oht_type_id};;
  }

  join: tlkp_orders_history_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${tlkp_orders_history_group.id} = ${orders.oht_group_id};;
  }

  join: products_description {
    type: left_outer
    relationship: one_to_one
    sql_on: ${orders.products_id} = ${products_description.products_id};;
  }

  join: campaigns {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.campaign_order_id} = ${campaigns.c_id};;
  }
  join: v_campaign_currencies {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.campaign_order_id} = ${v_campaign_currencies.c_id};;
  }

  join: orders_products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.orders_id} = ${orders_products.orders_id};;
  }

  join: orders_first_try {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders_first_try.parent_order_id} = ${orders.common_ancestor_order_id};;
  }

  join: declined_ccs {
    type: left_outer
    relationship: many_to_one
    sql_on: ${declined_ccs.orders_id} = ${orders.orders_id};;
  }
  join: gateway {
    type: left_outer
    relationship: many_to_one
    sql_on: ${gateway.gateway_id} = ${orders.gateway_id} AND
       ${orders.campaign_order_id} = ${campaigns.c_id};;
  }
  join: gateway_accounts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${gateway_accounts.ga_id} = ${orders.gateway_id};;
  }

  join: prospects {
    type: left_outer
    relationship: one_to_one
    #sql_on: ${prospects.campaign_id} = ${orders.campaign_order_id};;
    sql_on: {% condition orders.t_stamp_date %} prospects.pDate {% endcondition %};;
  }

  join: check_provider_accounts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${check_provider_accounts.check_account_id} = ${orders.gateway_id};;
  }
  join: v_main_order_total {
    type: left_outer
    relationship: one_to_one
    sql_on: ${v_main_order_total.orders_id} = ${orders.orders_id};;
  }
}

explore:  tlkp_orders_history_type {
  join:tlkp_orders_history_group {
    type: left_outer
    relationship: one_to_one
    sql_on: ${tlkp_orders_history_group.id} = ${tlkp_orders_history_type.group_id};;
  }

}

explore: upsell_orders{}

explore: prospect_pdt {
  access_filter: {
    field: campaign
    user_attribute: campaign_id
  }
}
