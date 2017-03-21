view: subscr_mgmt {
  derived_table: {
    sql: SELECT


                  orders.orders_id,
                  CASE WHEN orders.int_2 > 0 THEN CONCAT('Attempt', orders.int_2) ELSE 'Initial' END as attempt,
                  orders.campaign_order_id,
                        IF
                        (
                           orders.date_purchased = '0000-00-00',
                           orders.recurring_date,
                           orders.date_purchased
                        ) recurring_date,
                       IF
                       (
                          orders.date_purchased = '0000-00-00',
                          DATE_FORMAT(orders.recurring_date,'%m/%d/%Y') ,
                          DATE_FORMAT(orders.date_purchased,'%m/%d/%Y')
                       ) the_date,
                       IFNULL(currencies.code,'USD') as code,
                        orders.is_recurring,
                       orders.gatewayPreserve,
                       orders.cc_type,
                       orders.gatewayId,
                        0 AS is_upsell,

                        SUM(orders.currency_value) as forecasted_revenue,
                              CASE
                    WHEN
                       frce_chk.gateway_id IS NOT NULL AND frce_chk.is_check = 1
                       THEN
                       CONCAT((SELECT alias FROM check_provider WHERE checkProviderId = frce_chk.gateway_id),' (',frce_chk.gateway_id,')')
                    WHEN
                       casc.orders_id IS NOT NULL THEN
                       CONCAT((SELECT gatewayAlias FROM gateway WHERE gateway_id = casc.gateway_id),' (',casc.gateway_id,')')
                    WHEN
                       frce.gateway_id IS NOT NULL THEN
                       CONCAT((SELECT gatewayAlias FROM gateway WHERE gateway_id = frce.gateway_id),' (',frce.gateway_id,')')
                    WHEN
                       campaigns.is_load_balanced = 1 AND casc.orders_id IS NULL THEN
                          CASE
                            WHEN
                               orders.cc_type = 'checking' THEN
                               CONCAT(chk.alias,' (',chk.checkProviderId,')')
                            WHEN
                               orders.gatewayPreserve = 1 AND adv_route.campaign_id IS NULL THEN
                               CONCAT(gateway_orders.gatewayAlias ,' (',gateway_orders.gateway_id,')')
                            ELSE
                               CONCAT(lbc.name,' (',lbc.id,')')
                          END
                    WHEN
                       orders.cc_type = 'checking' THEN
                       CONCAT(chk.alias,' (',chk.checkProviderId,')')
                    ELSE
                       CONCAT(gateway.gatewayAlias,' (',gateway.gateway_id,')')
                  END as next_gateway,
                              CASE
                    WHEN
                       frce_chk.gateway_id IS NOT NULL AND frce_chk.is_check = 1
                       THEN
                       CONCAT('Force Check <a onclick="UnsetNextGateway(this);">(Remove)</a>')
                    WHEN
                       casc.orders_id IS NOT NULL THEN
                       CONCAT('Cascade Preserved')
                    WHEN
                       frce.gateway_id IS NOT NULL THEN
                       CONCAT('Force Gateway <a onclick="UnsetNextGateway(this);">(Remove)</a>')
                    WHEN
                       campaigns.is_load_balanced = 1 AND casc.orders_id IS NULL THEN
                          CASE
                            WHEN
                               orders.cc_type = 'checking' THEN
                               CONCAT('Checking Gateway')
                            WHEN
                               orders.gatewayPreserve = 1 AND adv_route.campaign_id IS NULL THEN
                               CONCAT('Load Balance Preserved')
                            ELSE
                               CONCAT('Load Balance')
                          END
                    WHEN
                       orders.cc_type = 'checking' THEN
                       CONCAT('Checking Gateway')
                    ELSE
                       CONCAT('Campaign Gateway')
                  END as next_reason,
                              CASE
                    WHEN
                       frce_chk.gateway_id IS NOT NULL AND frce_chk.is_check = 1
                       THEN
                       CONCAT('FORCECHECKING',frce_chk.gateway_id)
                    WHEN
                       casc.orders_id IS NOT NULL THEN
                       CONCAT('CASCADEPRESERVED',casc.gateway_id)
                    WHEN
                       frce.gateway_id IS NOT NULL THEN
                       CONCAT('FORCE',frce.gateway_id)
                    WHEN
                       campaigns.is_load_balanced = 1 AND casc.orders_id IS NULL THEN
                          CASE
                            WHEN
                               orders.cc_type = 'checking' THEN
                               CONCAT('CHECKING',chk.checkProviderId)
                            WHEN
                               orders.gatewayPreserve = 1 AND adv_route.campaign_id IS NULL THEN
                               CONCAT('LBCPRESERVED',gateway_orders.gateway_id)
                            ELSE
                               CONCAT('LBC',lbc.id)
                          END
                    WHEN
                       orders.cc_type = 'checking' THEN
                       CONCAT('CHECKING',chk.checkProviderId)
                    ELSE
                       CONCAT('GATEWAY',gateway.gateway_id)
                  END as next_id
                    FROM
                        orders

                        INNER JOIN campaigns ON (campaigns.c_id = orders.campaign_order_id)
                        INNER JOIN orders_products ON (orders.orders_id = orders_products.orders_id)
                        INNER JOIN products_description ON (orders_products.products_id = products_description.products_id)
                              LEFT OUTER JOIN gateway ON (campaigns.gateway_id = gateway.gateway_id)
                  LEFT OUTER JOIN gateway gateway_orders ON (orders.gatewayId = gateway_orders.gateway_id)
                  LEFT OUTER JOIN check_provider ON (campaigns.checkProviderId = check_provider.checkProviderId AND orders.gatewayId = check_provider.checkProviderId)
                  LEFT OUTER JOIN check_provider chk ON (chk.checkProviderId = campaigns.checkProviderId)
                  LEFT OUTER JOIN load_balance_configuration_profile lbc ON (lbc.id = campaigns.lbc_id AND campaigns.is_load_balanced = 1)
                        LEFT JOIN
                           gateway_force_preserved AS frce
                         ON
                           frce.orders_id = orders.orders_id
                        AND
                           frce.is_check = 0
                  LEFT JOIN
                           (
                              SELECT
                                    campaign_id,
                                    lbc_id
                                FROM
                                    load_balance_configuration_routing_attribute
                               WHERE
                                    deleted = 0
                                 AND
                                    active = 1
                            GROUP BY
                                    campaign_id, lbc_id
                           ) AS adv_route
                         ON
                           adv_route.lbc_id = campaigns.lbc_id
                        AND
                           adv_route.campaign_id = campaigns.c_id
                  LEFT JOIN
                           gateway_force_preserved AS frce_chk
                         ON
                           frce_chk.orders_id = orders.orders_id
                        AND
                           frce_chk.is_upsell = 0
                        AND
                           frce_chk.is_check = 1
                  LEFT JOIN
                           gateway_cascade_orders_preserved AS casc
                         ON
                           casc.orders_id = orders.orders_id
                  LEFT OUTER JOIN gateway_fields ON
                  (
                     gateway_fields.gatewayId = orders.gatewayId
                  AND
                     gateway_fields.fieldName = 'Currency'
                  AND
                     orders.cc_type != 'checking'
                  )

                  LEFT OUTER JOIN v_currencies currencies ON (currencies.currencies_id = gateway_fields.fieldValue)
                   WHERE

                     1 = 1
                     -- primary{_upsell} - keys- includes all rules without the date filter

                   AND
                      orders.deleted          = 0
                   AND
                      orders.is_recurring     = 1
                   AND
                      orders.is_hold         != 1
                   AND
                      orders.orders_status IN (2,8)
                   AND
                      orders.is_archived     != 1
                   AND
                      recurring_date > CURDATE()

                     -- filter out user campaigns of session


                GROUP BY
                     IF (orders.date_purchased = '0000-00-00', DATE(orders.recurring_date) ,DATE(orders.date_purchased) ), gateway_fields.fieldValue, next_gateway, next_id
    ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: attempt {
    type: string
    sql: ${TABLE}.attempt ;;
  }

  dimension: campaign_order_id {
    type: string
    sql: ${TABLE}.campaign_order_id ;;
  }

  dimension: recurring_date {
    type: date
    sql: ${TABLE}.recurring_date ;;
  }

  dimension: the_date {
    type: string
    sql: ${TABLE}.the_date ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: gateway_preserve {
    type: yesno
    sql: ${TABLE}.gatewayPreserve ;;
  }

  dimension: cc_type {
    type: string
    sql: ${TABLE}.cc_type ;;
  }

  dimension: gateway_id {
    type: number
    sql: ${TABLE}.gatewayId ;;
  }

  dimension: is_upsell {
    type: number
    sql: ${TABLE}.is_upsell ;;
  }

  dimension: forecasted_revenue {
    type: number
    sql: ${TABLE}.forecasted_revenue ;;
  }

  dimension: next_gateway {
    type: string
    sql: ${TABLE}.next_gateway ;;
  }

  dimension: next_reason {
    type: string
    sql: ${TABLE}.next_reason ;;
  }

  dimension: next_id {
    type: string
    sql: ${TABLE}.next_id ;;
  }

  set: detail {
    fields: [
      orders_id,
      attempt,
      campaign_order_id,
      recurring_date,
      the_date,
      code,
      is_recurring,
      gateway_preserve,
      cc_type,
      gateway_id,
      is_upsell,
      forecasted_revenue,
      next_gateway,
      next_reason,
      next_id
    ]
  }
}
