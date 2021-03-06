view: pdt_sales_by_product {
    derived_table: {
      sql: SELECT  * FROM (  SELECT
        order_id,
        campaign_id,
        is_test_cc,
        currency_id                                                           AS currency_id,
        currency_symbol                                                           AS currency_symbol,
        affiliate_id                                                          AS affiliate_id,
        sub_affiliate_id                                                          AS sub_affiliate_id,
        sub_aff_2                                                          AS sub_aff_2,
        sub_aff_3                                                          AS sub_aff_3,
        IF(LENGTH(group_by_val) = 0, 1, 2)                                    AS order_val,
        IF(IFNULL(LENGTH(group_by_val), '') = 0, 'BLANK', group_by_val_disp)  AS group_by_disp,
        IF(IFNULL(LENGTH(group_by_val), '') = 0, 'BLANK', group_by_val)       AS group_by_val,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 0, MAX(display_link))        AS display_link,
        SUM(new_products_cnt)                                                 AS new_products_cnt,
        FORMAT(SUM(new_products_cnt), 0)                                      AS new_products_cnt_fmt,
        new_products_rev                       AS new_products_rev,

        SUM(rec_products_cnt)                                                 AS rec_products_cnt,
        FORMAT(SUM(rec_products_cnt), 0)                                      AS rec_products_cnt_fmt,
        rec_products_rev                        AS rec_products_rev,

        SUM(all_products_cnt)                                                 AS all_products_cnt,
        FORMAT(SUM(all_products_cnt), 0)                                      AS all_products_cnt_fmt,
        all_products_rev                         AS all_products_rev,

        SUM(pending_products_cnt)                                             AS pending_products_cnt,
        FORMAT(SUM(pending_products_cnt), 0)                                  AS pending_products_cnt_fmt,
        pending_products_rev                     AS pending_products_rev,
        SUM(refund_void_cnt)                                                                                                                   AS refund_void_cnt,
        refund_void_rev                                                                                           AS refund_void_rev,
        SUM(hold_cnt)                                                         AS hold_cnt,
        FORMAT(SUM(hold_cnt), 0)                                              AS hold_cnt_fmt,
        hold_rev                                AS hold_rev,
        hold_rev_o                                AS hold_rev_o,

        SUM(hold_cnt_outside)                                                 AS hold_cnt_outside,
        FORMAT(SUM(hold_cnt_outside), 0)                                      AS hold_cnt_outside_fmt,
        SUM(prod_hold_cnt)                                                    AS prod_hold_cnt,
        FORMAT(SUM(prod_hold_cnt), 0)                                         AS prod_hold_cnt_fmt,
        SUM(prod_hold_cnt_outside)                                            AS prod_hold_cnt_outside,
        FORMAT(SUM(prod_hold_cnt_outside), 0)                                 AS prod_hold_cnt_outside_fmt,
        IF(display_link, ':AFF_LINK', '')                                     AS features
    FROM
        (
           SELECT
                    o.orders_id as order_id,
                    o.campaign_order_id as campaign_id,
                    o.is_test_cc as is_test_cc,
                    CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN  o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN  o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN  o.AFFID
                          ELSE 'BLANK'
                    END  affiliate_id,

                   CASE
                      WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                      WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN  o.OPT
                      ELSE 'BLANK'
                   END sub_affiliate_id,

                   CASE
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                      ELSE 'BLANK'
                   END sub_aff_2,

                   CASE
                      WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                      ELSE 'BLANK'
                   END sub_aff_3,

                 CASE 'PROD'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN o.AFFID
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN o.OPT
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN o.SID
                    WHEN 'AFFID' THEN o.C1
                    WHEN 'AID'   THEN o.OPT
                    WHEN 'C1'    THEN o.C2
                    WHEN 'C2'    THEN o.C3
                    ELSE p.products_id
                 END group_by_val,
                 CASE 'PROD'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN o.AFID
                          WHEN LENGTH(o.AID)   > 0 THEN o.AID
                          WHEN LENGTH(o.AFFID) > 0 THEN o.AFFID
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN o.SID
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN o.C1
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN o.OPT
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN o.C2
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN o.C3
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN o.SID
                    WHEN 'AFFID' THEN o.C1
                    WHEN 'AID'   THEN o.OPT
                    WHEN 'C1'    THEN o.C2
                    WHEN 'C2'    THEN o.C3
                    ELSE products_id_disp
                 END group_by_val_disp,
                 CASE 'PROD'
                    WHEN 'PROD' THEN
                       1
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN
                             IF(LENGTH(MAX(o.SID)) > 0, 1, 0)
                          WHEN LENGTH(o.AID)   > 0 THEN
                             IF(LENGTH(MAX(o.OPT)) > 0, 1, 0)
                          WHEN LENGTH(o.AFFID) > 0 THEN
                             IF(LENGTH(MAX(o.C1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 THEN
                             IF(LENGTH(MAX(o.C1)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN
                             IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                          ELSE
                             0
                       END
                    WHEN 'AFFID' THEN
                       IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                    WHEN 'C1' THEN
                       IF(LENGTH(MAX(o.C2)) > 0, 1, 0)
                    ELSE
                       0
                 END display_link,
                 SUM(IFNULL(new_products_cnt,0))      AS new_products_cnt,
                 SUM(new_products_rev)                AS new_products_rev,
                 SUM(IFNULL(rec_products_cnt,0))      AS rec_products_cnt,
                 SUM(rec_products_rev)                AS rec_products_rev,
                 SUM(IFNULL(all_products_cnt,0))      AS all_products_cnt,
                 SUM(all_products_rev)                AS all_products_rev,
                 SUM(IFNULL(pending_products_cnt,0))  AS pending_products_cnt,
                 SUM(pending_products_rev)            AS pending_products_rev,
                 SUM(IFNULL(hold_cnt,0))              AS hold_cnt,
                 SUM(hold_rev)                        AS hold_rev,
                 SUM(hold_rev_o)                      AS hold_rev_o,
                 SUM(refund_void_cnt)                                                                                                                   AS refund_void_cnt,
                 SUM(IFNULL(refund_void_rev,0))                                                                                           AS refund_void_rev,
                 SUM(IFNULL(hold_cnt_outside,0))      AS hold_cnt_outside,
                 SUM(prod_hold_cnt)                   AS prod_hold_cnt,
                 SUM(prod_hold_cnt_outside)           AS prod_hold_cnt_outside,
                 currency_id                                                           AS currency_id,
                currency_symbol                       AS currency_symbol
             FROM
                 orders o,
                 campaigns c,
                 (
                    SELECT
                          o.orders_id,
                          p.products_id,
                          p.variant_id,
                          CONCAT('(', p.products_id, ') ', pd.products_name,
                             IF (p.variant_id > 0,
                                 (
                                    SELECT
                                          CONCAT(' <br><div class="report-variant">', GROUP_CONCAT(po.name ORDER BY pa.order_key SEPARATOR '/'), '</div>')
                                      FROM
                                          product_variant_attribute_jct pvj,
                                          product_attribute pa,
                                          product_attribute po
                                     WHERE
                                          pa.id = po.parent_id
                                       AND
                                          pa.parent_id = 0
                                       AND
                                          pvj.attribute_id = po.id
                                       AND
                                          pa.active = 1
                                       AND
                                          po.active = 1
                                       AND
                                          pvj.variant_id = p.variant_id
                                  GROUP BY
                                          pvj.variant_id
                                 ),
                                 ''
                                ))                                                                                                 AS products_id_disp,
                          SUM(IF(o.rebillDepth = 0 AND o.orders_status != 7, p.products_quantity, NULL))                           AS new_products_cnt,
                          SUM(IF(o.rebillDepth = 0 AND o.orders_status != 7, ot.value, 0))                                         AS new_products_rev,
                          SUM(IF(o.parent_order_id > 0 AND o.rebillDepth > 0 AND o.orders_status != 7, p.products_quantity, NULL)) AS rec_products_cnt,
                          SUM(IF(o.parent_order_id > 0 AND o.rebillDepth > 0 AND o.orders_status != 7, ot.value, 0))               AS rec_products_rev,
                          SUM(IF(o.orders_status != 7, p.products_quantity, NULL))                                                 AS all_products_cnt,
                          SUM(IF(o.orders_status != 7, ot.value, 0))                                                               AS all_products_rev,
                          SUM(IF(o.orders_status IN(10, 11), p.products_quantity, NULL))                                           AS pending_products_cnt,
                          SUM(IF(o.orders_status IN (10, 11), ot.value, 0))                                                        AS pending_products_rev,
                          COUNT(IF(o.refundType > 1, p.products_quantity, NULL))                                                   AS refund_void_cnt,
                          SUM(IF(o.refundType > 1, vot.refunded_amount, NULL))                                                                                  AS refund_void_rev,
                          0 AS hold_cnt,
                          0 AS hold_rev,
                          0 AS hold_cnt_outside,
                          0 AS hold_rev_o,
                          0 AS prod_hold_cnt,
                          0 AS prod_hold_cnt_outside,
                          v.currency_id    AS currency_id,
                          v.html_entity_name  AS currency_symbol
                      FROM
                          orders               o,
                          v_campaign_currencies v,
                          orders_products      p,
                          orders_total         ot,
                          v_main_order_total   vot,
                          products_description pd
                     WHERE
                          o.deleted     = 0
                       AND
                          p.orders_id   = o.orders_id
                       AND
                          v.c_id = o.campaign_order_id
                       AND
                          ot.orders_id  = o.orders_id
                       AND
                           o.orders_id         = vot.orders_id
                       AND
                          ot.orders_id  = p.orders_id
                       AND
                          p.products_id = pd.products_id
                       AND
                          ot.class      = 'ot_subtotal'
                       AND
                          {% condition date_select %} o.t_stamp {% endcondition %}

                  GROUP BY
                          p.products_id,
                          o.orders_id
                 UNION ALL
                    SELECT
                          o.orders_id,
                          p.products_id,
                          p.variant_id,
                          CONCAT('(', p.products_id, ') ', pd.products_name,
                             IF (p.variant_id > 0,
                                 (
                                    SELECT
                                          CONCAT(' <br><div class="report-variant">', GROUP_CONCAT(po.name ORDER BY pa.order_key SEPARATOR '/'), '</div>')
                                      FROM
                                          product_variant_attribute_jct pvj,
                                          product_attribute pa,
                                          product_attribute po
                                     WHERE
                                          pa.id = po.parent_id
                                       AND
                                          pa.parent_id = 0
                                       AND
                                          pvj.attribute_id = po.id
                                       AND
                                          pa.active = 1
                                       AND
                                          po.active = 1
                                       AND
                                          pvj.variant_id = p.variant_id
                                  GROUP BY
                                          pvj.variant_id
                                 ),
                                 ''
                                ))                                                                                                 AS products_id_disp,
                          SUM(IF(o.rebillDepth = 0 AND o.orders_status != 7, p.products_quantity, NULL))                           AS new_products_cnt,
                          SUM(IF(o.rebillDepth = 0 AND o.orders_status != 7, uot.value, 0))                                        AS new_products_rev,
                          SUM(IF(o.parent_order_id > 0 AND o.rebillDepth > 0 AND o.orders_status != 7, p.products_quantity, NULL)) AS rec_products_cnt,
                          SUM(IF(o.parent_order_id > 0 AND o.rebillDepth > 0 AND o.orders_status != 7, uot.value, 0))              AS rec_products_rev,
                          SUM(IF(o.orders_status != 7, p.products_quantity, NULL))                                                 AS all_products_cnt,
                          SUM(IF(o.orders_status != 7, uot.value, 0))                                                              AS all_products_rev,
                          SUM(IF(o.orders_status IN(10, 11), p.products_quantity, NULL))                                           AS pending_products_cnt,
                          SUM(IF(o.orders_status IN(10, 11), uot.value, 0))                                                        AS pending_products_rev,
                          0                                                   AS refund_void_cnt,
                          0                                                                                  AS refund_void_rev,
                          0 AS hold_cnt,
                          0 AS hold_rev,
                          0 AS hold_cnt_outside,
                          0 AS hold_rev_o,
                          0 AS prod_hold_cnt,
                          0 AS prod_hold_cnt_outside,
                          v.currency_id AS currency_id,
                          0                       AS currency_symbol
                      FROM
                          orders                 o,
                          v_campaign_currencies v,
                          upsell_orders_products p,
                          upsell_orders          uo,
                          upsell_orders_total    uot,
                          products_description   pd
                     WHERE
                          o.deleted           = 0
                       AND
                          o.orders_id         = uo.main_orders_id
                       AND
                          v.c_id = o.campaign_order_id
                       AND
                          p.upsell_orders_id  = uo.upsell_orders_id
                       AND
                          uo.upsell_orders_id = uot.upsell_orders_id
                       AND
                          p.upsell_orders_id  = uot.upsell_orders_id
                       AND
                          p.products_id       = pd.products_id
                       AND
                          uot.class           = 'ot_subtotal'
                       AND
                          {% condition date_select %} uo.t_stamp {% endcondition %}

                  GROUP BY
                          p.products_id,
                          o.orders_id
                 UNION ALL
                    SELECT
                          o.orders_id,
                          oh.products_id,
                          oh.variant_id,
                          oh.products_id_disp,
                          0                                         AS new_products_cnt,
                          0                                         AS new_products_rev,
                          0                                         AS rec_products_cnt,
                          0                                         AS rec_products_rev,
                          0                                         AS all_products_cnt,
                          0                                         AS all_products_rev,
                          0                                                   AS refund_void_cnt,
                          0                                                                                  AS refund_void_rev,
                          0                                         AS pending_products_cnt,
                          0                                         AS pending_products_rev,
                          COUNT(IF(outside = 0, 1, NULL))           AS hold_cnt,
                          SUM(IF(outside = 0, o.currency_value, 0)) AS hold_rev,
                          COUNT(IF(outside = 1, 1, NULL))           AS hold_cnt_outside,
                          SUM(IF(outside = 1, o.currency_value, 0)) AS hold_rev_o,
                          SUM(IF(outside = 0, oh.prod_cnt, 0))      AS prod_hold_cnt,
                          SUM(IF(outside = 1, oh.prod_cnt, 0))      AS prod_hold_cnt_outside,
                          0                                                           AS currency_id,
                          0                       AS currency_symbol
                      FROM
                          orders o,
                          (
                             SELECT
                                   o.orders_id,
                                   p.products_id,
                                   p.variant_id,
                                   IFNULL(currency_value, 0)                          AS currency_value,
                                   CONCAT('(', p.products_id, ') ', pd.products_name) AS products_id_disp,
                                   p.products_quantity                                AS prod_cnt,
                                   IF((o.hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))), 1, 0) AS outside
                               FROM
                                   orders               o,
                                   orders_products      p,
                                   products_description pd
                              WHERE
                                   o.deleted   = 0
                                AND
                                   p.orders_id = o.orders_id
                                AND
                                   p.products_id = pd.products_id
                                AND
                                   o.is_hold = 1
                                AND
                                   (
                                      {% condition date_select %} o.t_stamp {% endcondition %}
                                        OR
                                                  {% condition date_select %} o.hold_date {% endcondition %}
                                   )

                          UNION ALL
                             SELECT
                                   o.orders_id,
                                   p.products_id,
                                   p.variant_id,
                                   IFNULL(uo.currency_value, 0)                       AS currency_value,
                                   CONCAT('(', p.products_id, ') ', pd.products_name) AS products_id_disp,
                                   p.products_quantity                                AS prod_cnt,
                                   IF((uo.hold_date BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))) AND (uo.t_stamp NOT BETWEEN (SELECT ({% date_start date_select %})) AND (SELECT ({% date_end date_select %}))), 1, 0) AS outside
                               FROM
                                   orders                 o,
                                   upsell_orders          uo,
                                   upsell_orders_products p,
                                   products_description   pd
                              WHERE
                                   o.deleted          = 0
                                AND
                                   o.orders_id        = uo.main_orders_id
                                AND
                                   p.upsell_orders_id = uo.upsell_orders_id
                                AND
                                   p.products_id      = pd.products_id
                                AND
                                   uo.is_hold         = 1
                                AND
                                   (
                                      {% condition date_select %} uo.t_stamp {% endcondition %}
                                        OR
                                                  {% condition date_select %} uo.hold_date {% endcondition %}
                                   )

                           ) oh
                      WHERE
                           o.orders_id = oh.orders_id
                        AND
                           o.deleted   = 0
                   GROUP BY
                           o.orders_id
                 ) p
            WHERE
                 o.orders_id = p.orders_id
              AND
                 o.deleted   = 0
              AND
                 c.c_id = o.campaign_order_id
                 AND
                           o.gatewayId IS NOT NULL
         GROUP BY
                 order_id
        ) o
GROUP BY
        order_id
  HAVING
        (
           IFNULL(new_products_cnt, 0) +
           IFNULL(rec_products_cnt, 0) +
           IFNULL(all_products_cnt, 0) +
           IFNULL(pending_products_cnt, 0) +
           IFNULL(hold_cnt, 0) +
           IFNULL(hold_cnt_outside, 0) +
           IFNULL(prod_hold_cnt, 0) +
           IFNULL(prod_hold_cnt_outside, 0)
        ) > 0) a    ORDER BY order_val ASC, CAST(group_by_val AS signed) ASC
 ;; indexes: ["order_id"]
    }

    filter: date_select {
      type: date
      default_value: "today"
    }

  dimension: is_test_cc {
    type: yesno
    sql: ${TABLE}.is_test_cc = 1 ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

    dimension: currency_id {
      type: number
      sql: ${TABLE}.currency_id ;;
    }

  dimension: currency_symbol {
    type: string
    sql: CASE WHEN ${TABLE}.currency_symbol = '0' THEN '$' ELSE ${TABLE}.currency_symbol END ;;
  }

   dimension: currency_fmt {
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


    dimension: order_val {
      type: number
      sql: ${TABLE}.order_val ;;
    }

    dimension: affiliate_id {
      type: string
      sql: ${TABLE}.affiliate_id ;;
    }

    dimension: sub_affiliate_id {
      type: string
      sql: ${TABLE}.sub_affiliate_id ;;
    }

    dimension: sub_aff_2 {
      type: string
      sql: ${TABLE}.sub_aff_2 ;;
    }

    dimension: sub_aff_3 {
      type: string
      sql: ${TABLE}.sub_aff_3 ;;
    }


    dimension: product {
      type: string
      sql: ${TABLE}.group_by_disp ;;
    }

    dimension: product_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.group_by_val ;;
    }

    dimension: display_link {
      type: number
      sql: ${TABLE}.display_link ;;
    }

    dimension: new_products_cnt {
      type: number
      sql: ${TABLE}.new_products_cnt ;;
    }


    dimension: new_products_cnt_fmt {
      type: number
      sql: ${TABLE}.new_products_cnt_fmt ;;
    }

    dimension: new_products_rev {
      type: number
      sql: ${TABLE}.new_products_rev ;;
    }

    dimension: new_products_rev_fmt {
      type: number
      sql: ${TABLE}.new_products_rev_fmt ;;
    }

    dimension: rec_products_cnt {
      type: number
      sql: ${TABLE}.rec_products_cnt ;;
    }

    dimension: rec_products_cnt_fmt {
      type: number
      sql: ${TABLE}.rec_products_cnt_fmt ;;
    }

    dimension: rec_products_rev {
      type: number
      sql: ${TABLE}.rec_products_rev ;;
    }

    dimension: rec_products_rev_fmt {
      type: number
      sql: ${TABLE}.rec_products_rev_fmt ;;
    }

    dimension: all_products_cnt {
      type: number
      sql: ${TABLE}.all_products_cnt ;;
    }

    dimension: all_products_cnt_fmt {
      type: number
      sql: ${TABLE}.all_products_cnt_fmt ;;
    }

    dimension: all_products_rev {
      type: number
      sql: ${TABLE}.all_products_rev ;;
    }

    dimension: all_products_rev_fmt {
      type: string
      sql: ${TABLE}.all_products_rev_fmt ;;
    }

    dimension: pending_products_cnt {
      type: number
      sql: ${TABLE}.pending_products_cnt ;;
    }

    dimension: pending_products_cnt_fmt {
      type: string
      sql: ${TABLE}.pending_products_cnt_fmt ;;
    }

    dimension: pending_products_rev {
      type: string
      sql: ${TABLE}.pending_products_rev ;;
    }

    dimension: pending_products_rev_fmt {
      type: string
      sql: ${TABLE}.pending_products_rev_fmt ;;
    }

    dimension: refund_void_cnt {
      type: number
      sql: ${TABLE}.refund_void_cnt ;;
    }

    dimension: refund_void_rev {
      type: number
      sql: ${TABLE}.refund_void_rev ;;
    }

    dimension: hold_cnt {
      type: number
      sql: ${TABLE}.hold_cnt ;;
    }

    dimension: hold_cnt_fmt {
      type: string
      sql: ${TABLE}.hold_cnt_fmt ;;
    }

    dimension: hold_rev {
      type: number
      sql: ${TABLE}.hold_rev ;;
    }


    dimension: hold_rev_o {
      type: number
      sql: ${TABLE}.hold_rev_o ;;
    }

    dimension: hold_rev_fmt {
      type: string
      sql: ${TABLE}.hold_rev_fmt ;;
    }

    dimension: hold_cnt_outside {
      type: number
      sql: ${TABLE}.hold_cnt_outside ;;
    }

    dimension: hold_cnt_outside_fmt {
      type: string
      sql: ${TABLE}.hold_cnt_outside_fmt ;;
    }

    dimension: prod_hold_cnt {
      type: number
      sql: ${TABLE}.prod_hold_cnt ;;
    }

    dimension: prod_hold_cnt_fmt {
      type: string
      sql: ${TABLE}.prod_hold_cnt_fmt ;;
    }

    dimension: prod_hold_cnt_outside {
      type: number
      sql: ${TABLE}.prod_hold_cnt_outside ;;
    }

    dimension: prod_hold_cnt_outside_fmt {
      type: string
      sql: ${TABLE}.prod_hold_cnt_outside_fmt ;;
    }

    dimension: features {
      type: string
      sql: ${TABLE}.features ;;
    }

    measure: initial {
      type: sum
      sql: ${new_products_cnt} ;;
    }

    measure: initial_revenue {
      type: string
      value_format_name: decimal_2
      sql: CONCAT(${currency_symbol},FORMAT(SUM(${new_products_rev}), 2)) ;;
    }

    measure: subscription {
      type: sum
      sql: ${rec_products_cnt} ;;
    }

    measure: subscription_revenue {
      type: string
      value_format_name: decimal_2
      sql: CONCAT(${currency_symbol},FORMAT(SUM(${rec_products_rev}), 2)) ;;
    }

    measure: total {
      type: sum
      sql: ${all_products_cnt} ;;
    }

    measure: total_revenue {
      type: string
      value_format_name: decimal_2
      sql: CONCAT(${currency_symbol},FORMAT(SUM(${all_products_rev}), 2)) ;;
    }

    measure: pending {
      type: sum
      sql: ${pending_products_cnt} ;;
    }

  measure: void_refund {
    label: "Voids/Refunds"
    type: sum
    sql: ${refund_void_cnt} ;;
  }

    measure: pending_revenue {
      type: string
      value_format_name: decimal_2
      sql: CONCAT(${currency_symbol},FORMAT(SUM(${pending_products_rev}), 2)) ;;
    }

  measure: void_refund_revenue {
    type: string
    value_format_name: decimal_2
    sql: CONCAT(${currency_symbol},FORMAT(SUM(${refund_void_rev}), 2)) ;;
  }

    measure: holds_cancel_revenue {
      type: string
      value_format_name: decimal_2
      sql: CONCAT(${currency_symbol},FORMAT(SUM((${hold_rev} + ${hold_rev_o})), 2)) ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    measure: count_hold {
      label: "Holds/Cancels"
      type: sum
      sql: ${prod_hold_cnt} ;;
      #sql_distinct_key: ${orders_id} ;;
      drill_fields: [detail*]
    }

    measure: count_prior_hold {
      label: "Prior Holds/Cancels"
      type: sum
      sql: ${hold_cnt_outside} ;;
      #sql_distinct_key: ${orders_id} ;;
      drill_fields: [detail*]
    }

    measure: affiliate_breakdown {
      sql: "Affiliate ID" ;;
      description: "Sales by Date"
      label: "Affiliate Breakdown"
      drill_fields: [product_drill*]
    }

    measure: sub_affiliate_breakdown {
      sql: "Sub-Affiliate ID" ;;
      description: "Sales by Date"
      label: "Sub-Affiliate Breakdown"
      drill_fields: [product_drill_1*]
    }

    measure: sub_affiliate_breakdown_2 {
      sql: "Sub-Affiliate ID" ;;
      description: "Sales by Date"
      label: "Sub-Affiliate Breakdown"
      drill_fields: [product_drill_2*]
    }

    measure: sub_affiliate_breakdown_3 {
      sql: "Sub-Affiliate ID" ;;
      description: "Sales by Date"
      label: "Sub-Affiliate Breakdown"
      drill_fields: [product_drill_3*]
    }

  set: product_drill {
    fields: [affiliate_id,initial ,initial_revenue, subscription , subscription_revenue, total, total_revenue, pending, pending_revenue, count_hold, count_prior_hold, holds_cancel_revenue, sub_affiliate_breakdown]
  }

  set: product_drill_1 {
    fields: [sub_affiliate_id, initial ,initial_revenue, subscription , subscription_revenue, total, total_revenue, pending, pending_revenue, count_hold, count_prior_hold, holds_cancel_revenue,sub_affiliate_breakdown_2]
  }

  set: product_drill_2 {
    fields: [sub_aff_2, initial ,initial_revenue, subscription , subscription_revenue, total, total_revenue, pending, pending_revenue, count_hold, count_prior_hold, holds_cancel_revenue,sub_affiliate_breakdown_3]
  }

  set: product_drill_3 {
    fields: [sub_aff_3, initial ,initial_revenue, subscription , subscription_revenue, total, total_revenue, pending, pending_revenue, count_hold, count_prior_hold, holds_cancel_revenue]
  }

    set: detail {
      fields: [
        hold_cnt,
        hold_cnt_fmt,
        hold_rev,
        hold_rev_fmt,
        hold_cnt_outside,
        hold_cnt_outside_fmt,
        prod_hold_cnt,
        prod_hold_cnt_fmt,
        prod_hold_cnt_outside,
        prod_hold_cnt_outside_fmt,
        features
      ]
    }
  }
