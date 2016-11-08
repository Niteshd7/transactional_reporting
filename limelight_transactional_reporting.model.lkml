connection: "pair2-aws"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
explore: campaigns{}

explore: countries{}

explore: gateway{}

explore: orders_first_try{}

explore: orders_decline_salvage{}

explore: upsell_orders{}

explore: upsell_orders_first_try{}

explore: upsell_orders_decline_salvage{}

explore: sessions{}

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
    sql_on: ${orders_history.orders_id} = ${orders.common_ancestor_order_id};;
  }

  join: orders_first_try {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders_first_try.parent_order_id} = ${orders.common_ancestor_order_id};;
  }

  join: orders_decline_salvage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders_decline_salvage.parent_order_id} = ${orders.common_ancestor_order_id};;
  }

  join: declined_ccs {
    type: left_outer
    relationship: many_to_one
    sql_on: ${declined_ccs.orders_id} = ${orders.common_ancestor_order_id};;
  }
}
