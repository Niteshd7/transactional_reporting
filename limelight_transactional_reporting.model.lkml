connection: "pair2-aws"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
explore: campaigns{}

explore: countries{}

explore: gateway{}

explore: orders_decline_salvage{

  join: declined_ccs {
    type: left_outer
    relationship: many_to_one
    sql_on: ${declined_ccs.orders_id} = ${orders_decline_salvage.orders_id};;
  }
}

explore: orders_first_try{}

explore: orders_history{}

explore: orders {
  join: upsell_orders {
    type: left_outer
    relationship: many_to_one
    sql_on: ${upsell_orders.main_orders_id} = ${orders.common_ancestor_order_id};;
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

  join: campaigns {
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
    relationship: one_to_one
    sql_on: ${gateway.gateway_id} = ${orders.gateway_id};;
  }
  join: gateway_accounts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${gateway_accounts.ga_id} = ${orders.gateway_id};;
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


explore: sessions{}

explore: upsell_orders{}

explore: upsell_orders_first_try{}

explore: upsell_orders_decline_salvage{}
