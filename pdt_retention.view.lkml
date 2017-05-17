view: pdt_retention {
  derived_table: {
    sql: SELECT  * FROM (SELECT
      campaign_id,
      order_id,
      gross_cnt                                                                                     AS gross,
      subscription_cnt AS subscription_cnt,
      active_subscription_cnt AS active_subscription_cnt
  FROM
      (
         SELECT
               IF ('BASE' = 'PROD' AND c.upsell_flag = 1, NULL, 1) AS gross_cnt,
               p.order_id as order_id,
               c.upsell_flag,
               c.subscription_bundle_flag,
               c.subscription_id,
               c.campaign_id,
               c.campaign_name,
               c.product_id,
               c.variant_id,
               c.product_name,
               c.product_attributes,
               c.rebill_depth,
               c.refund_type,
               c.approved_flag,
               c.subscription_flag,
               IF ('BASE' = 'PROD',
                  IF (c.subscription_bundle_flag = 0,
                     IF (c.straight_sale_flag = 1, 0, 1),
                     IF (c.upsell_flag = 1,
                        IF (c.straight_sale_flag = 1, 0, 1),
                        IF (p.straight_sale_flag = 0, c.subscription_cnt, 0)
                     )
                  ),
                  c.subscription_cnt
               ) AS subscription_cnt,
               IF ('BASE' = 'PROD',
                  IF (c.subscription_bundle_flag = 0,
                     c.subscription_flag,
                     IF (c.upsell_flag = 1,
                        IF (p.straight_sale_flag = 1, 0, 1),
                        IF (p.straight_sale_flag = 0, c.active_subscription_cnt, 0)
                     )
                  ),
                  c.active_subscription_cnt
               ) AS active_subscription_cnt,
               c.order_subscription_flag,
               c.straight_sale_flag,
               c.cancellation_flag,
               c.hold_flag,
               c.test_card_flag,
               c.grand_total_amt,
               c.refund_amt,
               c.affiliate_depth,
               c.aff_type_1,
               c.aff_type_2,
               c.aff_type_3,
               c.aff_type_4,
               c.aff_val_1,
               c.aff_val_2,
               c.aff_val_3,
               c.aff_val_4
           FROM
               v_order_report p,
               v_order_report c
          WHERE
               {% condition orders.t_stamp_date %} p.t_stamp {% endcondition %}
            AND
               p.upsell_flag = 0
            AND
               p.deleted_flag = 0
            AND
               p.currency_id = 1
            AND
               c.t_stamp > TIMESTAMP({% date_start orders.t_stamp_date %})
            AND
               IF ('BASE' = 'PROD' OR '' = 'PROD', c.upsell_flag IN(0,1), c.upsell_flag = 0)
            AND
               c.deleted_flag = 0
            AND
               c.approved_flag = 1
            AND
               c.currency_id = 1
            AND
               p.order_id = c.subscription_id
               AND p.test_card_flag IN (0, 1)

      UNION ALL
         SELECT
               IF ('BASE' = 'PROD' AND c.upsell_flag = 1, 0, 1) AS gross_cnt,
               p.order_id as order_id,
               c.upsell_flag,
               c.subscription_bundle_flag,
               c.subscription_id,
               c.campaign_id,
               c.campaign_name,
               c.product_id,
               c.variant_id,
               c.product_name,
               c.product_attributes,
               c.rebill_depth,
               c.refund_type,
               c.approved_flag,
               c.subscription_flag,
               IF ('BASE' = 'PROD',
                  IF (c.subscription_bundle_flag = 0,
                     IF (c.straight_sale_flag = 1, 0, 1),
                     IF (c.upsell_flag = 1,
                        IF (c.straight_sale_flag = 1, 0, 1),
                        IF (c.straight_sale_flag = 0, c.subscription_cnt, 0)
                     )
                  ),
                  c.subscription_cnt
               ) AS subscription_cnt,
               IF ('BASE' = 'PROD',
                  IF (c.subscription_bundle_flag = 0, c.subscription_flag, c.active_subscription_cnt),
                  c.active_subscription_cnt
               ) AS active_subscription_cnt,
               c.order_subscription_flag,
               c.straight_sale_flag,
               c.cancellation_flag,
               c.hold_flag,
               c.test_card_flag,
               c.grand_total_amt,
               c.refund_amt,
               c.affiliate_depth,
               c.aff_type_1,
               c.aff_type_2,
               c.aff_type_3,
               c.aff_type_4,
               c.aff_val_1,
               c.aff_val_2,
               c.aff_val_3,
               c.aff_val_4
           FROM
               v_order_report p,
               v_order_report c,
               (
                  SELECT
                        MAX(orders_id) AS order_id
                    FROM
                        orders       o,
                        order_report p
                   WHERE
                        o.orders_id = p.order_id
                     AND
                        o.deleted   = 0
                     AND
                        o.orders_status = 7
                     AND
                        o.wasSalvaged   = 0
                     AND
                        o.t_stamp > TIMESTAMP({% date_start orders.t_stamp_date %})
                        AND p.test_card_flag IN (0, 1)

                GROUP BY
                        CONCAT(o.campaign_order_id, o.customers_email_address)
               ) d
          WHERE
               {% condition orders.t_stamp_date %} p.t_stamp {% endcondition %}
            AND
               p.upsell_flag = 0
            AND
               p.deleted_flag = 0
            AND
               p.currency_id = 1
            AND
               c.t_stamp > TIMESTAMP({% date_start orders.t_stamp_date %})
            AND
               IF ('BASE' = 'PROD' OR '' = 'PROD', c.upsell_flag IN(0,1), c.upsell_flag = 0)
            AND
               c.deleted_flag = 0
            AND
               c.currency_id = 1
            AND
               p.order_id = c.subscription_id
            AND
               c.order_id = d.order_id
            AND
               c.t_stamp > TIMESTAMP({% date_start orders.t_stamp_date %})
            AND
               c.upsell_flag = 0
            AND
               c.deleted_flag = 0
            AND
               c.currency_id = 1
            AND
               p.order_id = c.subscription_id
               AND p.test_card_flag IN (0, 1)

      ) x
GROUP BY
        order_id,campaign_id) a    ORDER BY CAST(campaign_id AS signed) ASC
 ;; indexes: ["order_id","campaign_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: gross {
    type: number
    sql: ${TABLE}.gross ;;
  }

  dimension: subscription_cnt {
    type: number
    sql: ${TABLE}.subscription_cnt ;;
  }

  dimension: active_subscription_cnt {
    type: number
    sql: ${TABLE}.active_subscription_cnt ;;
  }

  measure: gross_orders {
    type: sum
    filters: {
      field: orders.upsell_flag
      value: "0"
    }
    sql: ${gross} ;;
    drill_fields: [detail*]
  }

  measure: count_active_subscription {
    type: sum
    sql: ${active_subscription_cnt} ;;
    drill_fields: [detail*]
  }

  measure: count_subscription {
    type: sum
    sql: ${subscription_cnt} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [campaign_id, gross, order_id]
  }
}
