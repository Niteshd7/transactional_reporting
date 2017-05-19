view: pdt_retention {
  derived_table: {
    sql: SELECT  * FROM (SELECT
      campaign_id,
      campaign_name,
      product_id,
      currency_id,
      currency_symbol,
      product_name,
      rebill_depth,
      order_id,
      gross_cnt                                                                                     AS gross,
      subscription_cnt                                                                              AS subscription_cnt,
      active_subscription_cnt                                                                       AS active_subscription_cnt,
      IF(approved_flag = 1 AND refund_type < 2, 1, NULL)                                     AS approve_cnt,
      gross_cnt - COUNT(IF(approved_flag = 1, 1, NULL))                                             AS decline_cnt,
      IF(cancellation_flag = 1, subscription_cnt, 0)                                                AS cancel_cnt,
      IF(hold_flag = 1 AND cancellation_flag = 0, subscription_cnt, 0)                              AS hold_cnt,
      IF(refund_type IN (2,3), gross_cnt, NULL)                                                     AS void_ref_cnt,
      IF(refund_type = 1, gross_cnt, NULL)                                                          AS partial_ref_cnt,
      IF(refund_type > 0, refund_amt, 0)                                                            AS void_ref_amt,
      IF(approved_flag= 1, grand_total_amt - refund_amt, 0)                                         AS total_amt,
      IF(approved_flag = 1 AND order_subscription_flag = 1 AND hold_flag = 0, active_subscription_cnt, 0)     AS pending_cnt
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
              c.currency_id,
              c.currency_symbol,
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
               {% condition date_select %} p.t_stamp {% endcondition %}
            AND
               p.upsell_flag = 0
            AND
               p.deleted_flag = 0
            AND
               p.currency_id = 1
            AND
               c.t_stamp > TIMESTAMP({% date_start date_select %})
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
               AND {% condition is_test %} p.test_card_flag {% endcondition %}

      UNION ALL
         SELECT
               IF ('BASE' = 'PROD' AND c.upsell_flag = 1, 0, 1) AS gross_cnt,
               p.order_id as order_id,
               c.upsell_flag,
               c.subscription_bundle_flag,
               c.subscription_id,
               c.campaign_id,
              c.currency_id,
              c.currency_symbol,
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
                        o.t_stamp > TIMESTAMP({% date_start date_select %})
                        AND {% condition is_test %} p.test_card_flag {% endcondition %}

                GROUP BY
                        CONCAT(o.campaign_order_id, o.customers_email_address)
               ) d
          WHERE
               {% condition date_select %} p.t_stamp {% endcondition %}
            AND
               p.upsell_flag = 0
            AND
               p.deleted_flag = 0
            AND
               p.currency_id = 1
            AND
               c.t_stamp > TIMESTAMP({% date_start date_select %})
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
               c.t_stamp > TIMESTAMP({% date_start date_select %})
            AND
               c.upsell_flag = 0
            AND
               c.deleted_flag = 0
            AND
               c.currency_id = 1
            AND
               p.order_id = c.subscription_id
               AND {% condition is_test %} p.test_card_flag {% endcondition %}

      ) x
GROUP BY
        order_id) a    ORDER BY CAST(campaign_id AS signed) ASC
 ;; indexes: ["order_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: date_select {
    type: date
    default_value: "today"
  }

  filter: is_test {
    type: string
    default_value: "0,1"
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign {
    type: string
    sql: CONCAT('(',${campaign_id},')',' ',${campaign_name}) ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: subscription_cycles {
    type: number
    full_suggestions: yes
    sql: ${TABLE}.rebill_depth ;;
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

  dimension: approve_cnt {
    type: number
    sql: ${TABLE}.approve_cnt ;;
  }

  dimension: currency_id {
    type: string
    sql: ${TABLE}.currency_id ;;
  }

  dimension: currency_symbol {
    type: string
    sql: ${TABLE}.currency_symbol ;;
  }

  dimension: currency {
    hidden: no
    suggestions: ["USD","EUR","GBP","CAD","AUD","ZAR","JPY","DKK","NOK","SEK","BRL","CLP"]
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
              ELSE 'USD'
         END ;;
  }

  dimension: decline_cnt {
    type: number
    sql: ${TABLE}.decline_cnt ;;
  }

  dimension: hold_cnt {
    type: number
    sql: ${TABLE}.hold_cnt ;;
  }

  dimension: cancel_cnt {
    type: number
    sql: ${TABLE}.cancel_cnt ;;
  }

  dimension: partial_ref_cnt {
    type: number
    sql: ${TABLE}.partial_ref_cnt ;;
  }

  dimension: void_ref_cnt {
    type: number
    sql: ${TABLE}.void_ref_cnt ;;
  }

  dimension: pending_cnt {
    type: number
    sql: ${TABLE}.pending_cnt ;;
  }

  dimension: total_amt {
    type: number
    sql: ${TABLE}.total_amt ;;
  }

  dimension: void_ref_amt {
    type: number
    sql: ${TABLE}.void_ref_amt ;;
  }

  measure: gross_orders {
    type: sum
    sql: ${gross} ;;
    drill_fields: [detail*]
  }

  measure: count_active_subscription {
    type: sum
    sql: ${active_subscription_cnt} ;;
    drill_fields: [detail*]
  }

  measure: subscriptions_approved {
    type: sum
    sql: ${subscription_cnt} ;;
    drill_fields: [detail*]
  }

  measure: pending {
    type: sum
    sql: ${pending_cnt} ;;
    drill_fields: [detail*]
  }

  measure: net_approved{
    type: sum
    sql: ${approve_cnt} ;;
    drill_fields: [detail*]
  }

  measure: declined{
    type: sum
    sql: ${decline_cnt} ;;
    drill_fields: [detail*]
  }

  measure: void_full_refund{
    type: sum
    sql: ${void_ref_cnt} ;;
    drill_fields: [detail*]
  }

  measure: partial_refund{
    type: sum
    sql: ${partial_ref_cnt} ;;
    drill_fields: [detail*]
  }

  measure: canceled{
    type: sum
    sql: ${cancel_cnt} ;;
    drill_fields: [detail*]
  }

  measure: hold{
    type: sum
    sql: ${hold_cnt} ;;
    drill_fields: [detail*]
  }

  measure: void_refund_revenue{
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${void_ref_amt}), 2)) ;;
    drill_fields: [detail*]
  }

  measure: net_revenue{
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${total_amt}), 2)) ;;
    drill_fields: [detail*]
  }

  measure: approval_rate_retention {
    type: number
    label: "Approval Rate"
    value_format_name: percent_2
    sql: ${net_approved} / NULLIF(${gross_orders},0) ;;
  }

  measure: affiliate_breakdown_subscription {
    sql: "Affiliate ID" ;;
    description: "Sales by Subscription"
    label: "Affiliate Breakdown"
    drill_fields: [subscription_drill*]
  }

  measure: sub_affiliate_breakdown_subscription {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Subscription"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [subscription_drill_1*]
  }

  measure: sub_affiliate_breakdown_subscription_2 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Subscription"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [subscription_drill_2*]
  }

  measure: sub_affiliate_breakdown_subscription_3 {
    sql: "Sub-Affiliate ID" ;;
    description: "Sales by Subscription"
    label: "Sub-Affiliate Breakdown"
    drill_fields: [subscription_drill_3*]
  }

  set: subscription_drill {
    fields: [ sub_affiliate_breakdown_subscription]
  }

  set: subscription_drill_1 {
    fields: [sub_affiliate_breakdown_subscription_2]
  }

  set: subscription_drill_2 {
    fields: [sub_affiliate_breakdown_subscription_3]
  }

  set: subscription_drill_3 {
    fields: []
  }


  set: detail {
    fields: [campaign_id, gross, order_id]
  }
}
