connection: "transactional-pair-aws"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
explore: campaigns{}

explore: countries{}

explore: gateway{}

explore: pdt_sales_by_product {}

explore: pdt_sales_by_date {}

explore: pdt_sales_by_campaign {}

explore: pdt_fulfillment_reconciliation {}

explore: pdt_user_activity {}

explore: pdt_employee_activity {}

explore: subscr_mgmt{}

explore: orders_decline_salvage{

  join: declined_ccs {
    type: left_outer
    relationship: many_to_one
    sql_on: ${declined_ccs.orders_id} = ${orders_decline_salvage.orders_id};;
  }
}

explore: order_report {}

explore: orders_history{}

explore: orders {
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

  join: upsell_orders_first_try {
    type: left_outer
    relationship: many_to_one
    sql_on: ${upsell_orders_first_try.main_orders_id} = ${orders.common_ancestor_order_id};;
  }

  join: upsell_orders_decline_salvage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${upsell_orders_decline_salvage.main_orders_id}.main_orders_id} = ${orders.common_ancestor_order_id};;
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

  join: hold_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${hold_pdt.orders_id} = ${orders.orders_id}
      AND ${hold_pdt.orders_id} > '0';;
  }

  join: prod_hold_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${prod_hold_pdt.product_id} = ${orders.products_id}
      AND ${prod_hold_pdt.product_id} IS NOT NULL;;
  }

  join: decline_hold_pdt_campaign {
    type: left_outer
    relationship: one_to_one
    sql_on: ${decline_hold_pdt_campaign.orders_id} = ${orders.orders_id}
      AND ${decline_hold_pdt_campaign.orders_id} > '0';;
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

  join: pdt_retention {
    type: left_outer
    relationship: one_to_one
    sql_on: ${pdt_retention.order_id} = ${orders.orders_id} ;;
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
    sql_on: ${orders.campaign_order_id} = ${campaigns.c_id};;
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

  join: orders_decline_salvage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders_decline_salvage.parent_order_id} = ${orders.orders_id};;
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
    sql_on: ${prospects.campaign_id} = ${campaigns.c_id}
        AND {% condition orders.t_stamp_date %} prospects.pDate {% endcondition %};;
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

explore: prospect_pdt {}

explore: upsell_orders_first_try{}

explore: upsell_orders_decline_salvage{}
