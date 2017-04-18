view: prod_hold_pdt {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
        IF(LENGTH(group_by_val) = 0, 1, 2)                                    AS order_val,
        IF(LENGTH(group_by_type) = 0, '', group_by_type)                      AS group_by_type,
        IF(LENGTH(sub_group_by_type) = 0, '', sub_group_by_type)              AS sub_group_by_type,
        IF(IFNULL(LENGTH(group_by_val), '') = 0, 'BLANK', group_by_val_disp)  AS group_by_disp,
        IF(IFNULL(LENGTH(group_by_val), '') = 0, 'BLANK', group_by_val)       AS group_by_val,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 0, MAX(display_link))        AS display_link,
        SUM(new_products_cnt)                                                 AS new_products_cnt,
        FORMAT(SUM(new_products_cnt), 0)                                      AS new_products_cnt_fmt,
        FORMAT(SUM(new_products_rev), 2)                         AS new_products_rev,

        SUM(rec_products_cnt)                                                 AS rec_products_cnt,
        FORMAT(SUM(rec_products_cnt), 0)                                      AS rec_products_cnt_fmt,
        FORMAT(SUM(rec_products_rev), 2)                         AS rec_products_rev,

        SUM(all_products_cnt)                                                 AS all_products_cnt,
        FORMAT(SUM(all_products_cnt), 0)                                      AS all_products_cnt_fmt,
        FORMAT(SUM(all_products_rev), 2)                         AS all_products_rev,

        SUM(pending_products_cnt)                                             AS pending_products_cnt,
        FORMAT(SUM(pending_products_cnt), 0)                                  AS pending_products_cnt_fmt,
        FORMAT(SUM(pending_products_rev), 2)                     AS pending_products_rev,

        SUM(hold_cnt)                                                         AS hold_cnt,
        FORMAT(SUM(hold_cnt), 0)                                              AS hold_cnt_fmt,
        FORMAT(SUM(hold_rev), 2)                                 AS hold_rev,
        FORMAT(SUM(hold_rev_o), 2)                                 AS hold_rev_o,

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
                 CASE 'PROD'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN 'AFID'
                          WHEN LENGTH(o.AID)   > 0 THEN 'AID'
                          WHEN LENGTH(o.AFFID) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN 'SID'
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN 'C1'
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN  'OPT'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN 'C2'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN 'C3'
                          ELSE ''
                       END
                    ELSE 'PROD'
                 END group_by_type,
                 CASE 'PROD'
                    WHEN 'ALL' THEN
                       CASE
                          WHEN LENGTH(o.AFID)  > 0 THEN 'AFID'
                          WHEN LENGTH(o.AID)   > 0 THEN 'AID'
                          WHEN LENGTH(o.AFFID) > 0 THEN 'AFFID'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB' THEN
                       CASE
                          WHEN LENGTH(o.AFID) > 0 AND LENGTH(o.SID) > 0 THEN 'SID'
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 THEN 'C1'
                          WHEN LENGTH(o.AID) > 0 AND LENGTH(o.OPT) > 0 THEN  'OPT'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB2' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 THEN 'C2'
                          ELSE ''
                       END
                    WHEN 'ALL_SUB3' THEN
                       CASE
                          WHEN LENGTH(o.AFFID) > 0 AND LENGTH(o.C1) > 0 AND LENGTH(o.C2) > 0 AND LENGTH(o.C3) > 0 THEN 'C3'
                          ELSE ''
                       END
                    WHEN 'AFID'  THEN 'SID'
                    WHEN 'AID'   THEN 'OPT'
                    WHEN 'AFFID' THEN 'C1'
                    WHEN 'C1'    THEN 'C2'
                    WHEN 'C2'    THEN 'C3'
                    WHEN 'PROD'  THEN 'ALL'
                    ELSE ''
                 END sub_group_by_type,
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
                 SUM(IFNULL(hold_cnt_outside,0))      AS hold_cnt_outside,
                 SUM(prod_hold_cnt)                   AS prod_hold_cnt,
                 SUM(prod_hold_cnt_outside)           AS prod_hold_cnt_outside
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
                          0 AS hold_cnt,
                          0 AS hold_rev,
                          0 AS hold_cnt_outside,
                          0 AS hold_rev_o,
                          0 AS prod_hold_cnt,
                          0 AS prod_hold_cnt_outside
                      FROM
                          orders               o,
                          orders_products      p,
                          orders_total         ot,
                          products_description pd
                     WHERE
                          o.deleted     = 0
                       AND
                          p.orders_id   = o.orders_id
                       AND
                          ot.orders_id  = o.orders_id
                       AND
                          ot.orders_id  = p.orders_id
                       AND
                          p.products_id = pd.products_id
                       AND
                          ot.class      = 'ot_subtotal'
                       AND
                          {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                          AND o.is_test_cc IN (0, 1)

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
                          0 AS hold_cnt,
                          0 AS hold_rev,
                          0 AS hold_cnt_outside,
                          0 AS hold_rev_o,
                          0 AS prod_hold_cnt,
                          0 AS prod_hold_cnt_outside
                      FROM
                          orders                 o,
                          upsell_orders_products p,
                          upsell_orders          uo,
                          upsell_orders_total    uot,
                          products_description   pd
                     WHERE
                          o.deleted           = 0
                       AND
                          o.orders_id         = uo.main_orders_id
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
                          {% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}
                          AND o.is_test_cc IN (0, 1)

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
                          0                                         AS pending_products_cnt,
                          0                                         AS pending_products_rev,
                          COUNT(IF(outside = 0, 1, NULL))           AS hold_cnt,
                          SUM(IF(outside = 0, o.currency_value, 0)) AS hold_rev,
                          COUNT(IF(outside = 1, 1, NULL))           AS hold_cnt_outside,
                          SUM(IF(outside = 1, o.currency_value, 0)) AS hold_rev_o,
                          SUM(IF(outside = 0, oh.prod_cnt, 0))      AS prod_hold_cnt,
                          SUM(IF(outside = 1, oh.prod_cnt, 0))      AS prod_hold_cnt_outside
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
                                   IF((o.hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
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
                                      {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                                        OR
                                                  {% condition orders.t_stamp_date %} o.hold_date {% endcondition %}
                                   )
                                   AND o.is_test_cc IN (0, 1)

                          UNION ALL
                             SELECT
                                   o.orders_id,
                                   p.products_id,
                                   p.variant_id,
                                   IFNULL(uo.currency_value, 0)                       AS currency_value,
                                   CONCAT('(', p.products_id, ') ', pd.products_name) AS products_id_disp,
                                   p.products_quantity                                AS prod_cnt,
                                   IF((uo.hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (uo.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
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
                                      {% condition orders.t_stamp_date %} uo.t_stamp {% endcondition %}
                                        OR
                                                  {% condition orders.t_stamp_date %} uo.hold_date {% endcondition %}
                                   )
                                   AND o.is_test_cc IN (0, 1)

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
                 AND o.is_test_cc IN (0, 1)

         GROUP BY
                 group_by_val
        ) o
GROUP BY
        group_by_val
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
 ;; indexes: ["group_by_val"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_hold {
    type: sum
    sql: ${hold_cnt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: count_prior_hold {
    type: sum
    sql: ${hold_cnt_outside_fmt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: count_prior_hold_prod {
    type: sum
    sql: ${prod_hold_cnt_outside_fmt} ;;
    #sql_distinct_key: ${orders_id} ;;
    drill_fields: [detail*]
  }

  measure: holds_cancels_revenue {
    type: sum
    sql: (${hold_rev}) ;;
    drill_fields: [detail*]
  }

  measure: holds_cancels_revenue_1 {
    type: sum
    sql: (${hold_rev_o}) ;;
    drill_fields: [detail*]
  }

  dimension: order_val {
    type: number
    sql: ${TABLE}.order_val ;;
  }

  dimension: group_by_type {
    type: string
    sql: ${TABLE}.group_by_type ;;
  }

  dimension: sub_group_by_type {
    type: string
    sql: ${TABLE}.sub_group_by_type ;;
  }

   dimension: product {
    type: string
    primary_key: yes
    sql: ${TABLE}.group_by_disp ;;
  }

  dimension: product_id {
    type: number
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
    type: string
    sql: ${TABLE}.new_products_cnt_fmt ;;
  }

  dimension: new_products_rev {
    type: string
    sql: ${TABLE}.new_products_rev ;;
  }

  dimension: new_products_rev_fmt {
    type: string
    sql: ${TABLE}.new_products_rev_fmt ;;
  }

  dimension: rec_products_cnt {
    type: number
    sql: ${TABLE}.rec_products_cnt ;;
  }

  dimension: rec_products_cnt_fmt {
    type: string
    sql: ${TABLE}.rec_products_cnt_fmt ;;
  }

  dimension: rec_products_rev {
    type: string
    sql: ${TABLE}.rec_products_rev ;;
  }

  dimension: rec_products_rev_fmt {
    type: string
    sql: ${TABLE}.rec_products_rev_fmt ;;
  }

  dimension: all_products_cnt {
    type: number
    sql: ${TABLE}.all_products_cnt ;;
  }

  dimension: all_products_cnt_fmt {
    type: string
    sql: ${TABLE}.all_products_cnt_fmt ;;
  }

  dimension: all_products_rev {
    type: string
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
