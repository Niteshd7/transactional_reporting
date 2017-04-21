view: hold_pdt_1 {
  derived_table: {
    sql: SELECT  * FROM (  SELECT
        IF(LENGTH(group_by_val) = 0, 1, 2)                                                                                                     AS order_val,
        IF(LENGTH(group_by_type) = 0, '', group_by_type)                                                                                       AS group_by_type,
        IF(LENGTH(sub_group_by_type) = 0, '', sub_group_by_type)                                                                               AS sub_group_by_type,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_val)                                                                        AS group_by_val,
        IF(LENGTH(IFNULL(group_by_val, '')) = 0, 'BLANK', group_by_val_disp)                                                                   AS group_by_disp,
        SUM(new_order_cnt)                                                                                                                     AS new_order_cnt,
        FORMAT(SUM(new_order_cnt), 0)                                                                                                          AS new_order_cnt_fmt,
        FORMAT(SUM(new_order_rev), 2)                                                                                             AS new_order_rev,
        CONCAT('$', FORMAT(SUM(new_order_rev), 2), '')                                               AS new_order_rev_fmt,
        SUM(recurring_order_cnt)                                                                                                               AS recurring_order_cnt,
        FORMAT(SUM(recurring_order_cnt), 0)                                                                                                    AS recurring_order_cnt_fmt,
        FORMAT(SUM(recurring_order_rev), 2)                                                                                       AS recurring_order_rev,
        CONCAT('$', FORMAT(SUM(recurring_order_rev), 2), '')                                         AS recurring_order_rev_fmt,
        SUM(shipping_cnt)                                                                                                                      AS shipping_cnt,
        FORMAT(SUM(shipping_cnt), 0)                                                                                                           AS shipping_cnt_fmt,
        FORMAT(SUM(shipping_rev), 2)                                                                                              AS shipping_rev,
        CONCAT('$', FORMAT(SUM(shipping_rev), 2), '')                                                AS shipping_rev_fmt,
        SUM(all_new_order_cnt)                                                                                                                 AS all_new_order_cnt,
        FORMAT(SUM(all_new_order_cnt), 0)                                                                                                      AS all_new_order_cnt_fmt,
        FORMAT(SUM(all_new_order_rev), 2)                                                                                         AS all_new_order_rev,
        CONCAT('$', FORMAT(SUM(all_new_order_rev), 2), '')                                           AS all_new_order_rev_fmt,
        SUM(pending_order_cnt)                                                                                                                 AS pending_order_cnt,
        FORMAT(SUM(pending_order_cnt), 0)                                                                                                      AS pending_order_cnt_fmt,
        FORMAT(SUM(pending_order_rev), 2)                                                                                         AS pending_order_rev,
        CONCAT('$', FORMAT(SUM(pending_order_rev), 2), '')                                           AS pending_order_rev_fmt,
        FORMAT(SUM(taxable_rev), 2)                                                                                               AS taxable_rev,
        CONCAT('$', FORMAT(SUM(taxable_rev), 2), '')                                                 AS taxable_rev_fmt,
        SUM(decline_cnt)                                                                                                                       AS decline_cnt,
        FORMAT(SUM(decline_cnt), 0)                                                                                                            AS decline_cnt_fmt,
        FORMAT(SUM(decline_rev), 2)                                                                                               AS decline_rev,
        CONCAT('$', FORMAT(SUM(decline_rev), 2), '')                                                 AS decline_rev_fmt,
        SUM(refund_void_cnt)                                                                                                                   AS refund_void_cnt,
        FORMAT(SUM(refund_void_cnt), 0)                                                                                                        AS refund_void_cnt_fmt,
        FORMAT(SUM(refund_void_rev), 2)                                                                                           AS refund_void_rev,
        CONCAT('$', FORMAT(SUM(refund_void_rev), 2), '')                                             AS refund_void_rev_fmt,
        SUM(active_cnt)                                                                                                                        AS active_cnt,
        FORMAT(SUM(active_cnt), 0)                                                                                                             AS active_cnt_fmt,)                                                                                                                          AS hold_cnt,
        FORMAT(SUM(hold_rev), 2)                                                                                                  AS hold_rev,
        SUM(hold_cnt_outside)                                                                                                                  AS hold_cnt_outside,
        SUM(chargeback_cnt)                                                                                                                    AS chargeback_cnt,
        FORMAT(SUM(chargeback_cnt), 0)                                                                                                         AS chargeback_cnt_fmt,
        FORMAT((IF(SUM(all_new_order_cnt) > 0, (SUM(chargeback_cnt) / SUM(all_new_order_cnt)), 0) * 100), 1)                                   AS chargeback_pct,
        CONCAT(FORMAT((IF(SUM(all_new_order_cnt) > 0, (SUM(chargeback_cnt) / SUM(all_new_order_cnt)), 0) * 100), 1), '%')                      AS chargeback_pct_fmt,
        IF(MAX(display_link) = 1, ':AFF_LINK', '')                                                                                             AS features,
        CONCAT('<div id="camp-id-', group_by_val, '" class="prod-id-placeholder"><img src="../../images/limeload.gif" alt="Loading" /></div>') AS prod_ids,
        orders_id                  AS orders_id,
        t_stamp                    AS t_stamp
    FROM
        (
           SELECT
                 o.orders_id AS orders_id,
                 CASE 'CID'
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
                   ELSE 'CID'
                 END group_by_type,
                 CASE 'CID'
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
                    WHEN 'CID'   THEN 'ALL'
                    WHEN 'DATE'  THEN 'ALL'
                    ELSE ''
                 END sub_group_by_type,
                 CASE 'CID'
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
                    WHEN 'DATE'  THEN
                       IF(o.hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))),
                          DATE(o.hold_date),
                          DATE(o.t_stamp)
                       )
                    ELSE o.campaign_order_id
                 END group_by_val,
                 CASE 'CID'
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
                    WHEN 'DATE'  THEN
                       IF(o.hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))),
                          DATE_FORMAT(o.hold_date, '%m/%d/%Y'),
                          DATE_FORMAT(o.t_stamp, '%m/%d/%Y')
                       )
                    ELSE CONCAT('(', c.c_id, ') ', c.c_name)
                 END group_by_val_disp,
                 CASE 'CID'
                    WHEN 'CID' THEN
                       1
                    WHEN 'DATE' THEN
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
                 o.campaign_order_id AS campaign_order_id,
                 o.t_stamp AS t_stamp,
                 SUM(new_order_cnt)         AS new_order_cnt,
                 SUM(new_order_rev)         AS new_order_rev,
                 SUM(recurring_order_cnt)   AS recurring_order_cnt,
                 SUM(recurring_order_rev)   AS recurring_order_rev,
                 SUM(shipping_cnt)          AS shipping_cnt,
                 SUM(shipping_rev)          AS shipping_rev,
                 SUM(all_new_order_cnt)     AS all_new_order_cnt,
                 SUM(all_new_order_rev)     AS all_new_order_rev,
                 SUM(pending_order_cnt)     AS pending_order_cnt,
                 SUM(pending_order_rev)     AS pending_order_rev,
                 SUM(refund_void_cnt)       AS refund_void_cnt,
                 SUM(refund_void_rev)       AS refund_void_rev,
                 SUM(taxable_rev)           AS taxable_rev,
                 SUM(active_cnt)            AS active_cnt,
                 SUM(decline_cnt)           AS decline_cnt,
                 SUM(decline_rev)           AS decline_rev,
                 SUM(hold_cnt)              AS hold_cnt,
                 IF('CID' = 'DATE', SUM(hold_rev), SUM(hold_rev + hold_rev_o)) AS hold_rev,
                 SUM(hold_cnt_outside)      AS hold_cnt_outside,
                 SUM(chargeback_cnt)        AS chargeback_cnt
             FROM
                 orders o,
                 campaigns c,
                 (
                    SELECT
                          o.orders_id,
                          COUNT(IF(o.orders_status IN (2,8) AND o.rebillDepth = 0, 1, NULL))                                                                         AS new_order_cnt,
                          SUM(IF(o.orders_status IN (2,8) AND o.rebillDepth = 0, ot.current_total + f_upsell_order_total(o.orders_id), 0))                           AS new_order_rev,
                          COUNT(IF(o.orders_status IN (2,8) AND o.parent_order_id > 0 AND o.rebillDepth > 0, 1, NULL))                                               AS recurring_order_cnt,
                          SUM(IF(o.orders_status IN (2,8) AND o.parent_order_id > 0 AND o.rebillDepth > 0, ot.current_total + f_upsell_order_total(o.orders_id), 0)) AS recurring_order_rev,
                          COUNT(IF(
                             o.orders_status NOT IN(7, 10, 11) AND
                             (o.payment_module_code = 1 OR IFNULL((SELECT MAX(payment_module_code) FROM upsell_orders uo WHERE uo.main_orders_id = o.orders_id), 0) = 1),
                             1, NULL))                                      AS shipping_cnt,
                          SUM(IF(
                             o.orders_status NOT IN(7, 10, 11) AND
                             (o.payment_module_code = 1 OR IFNULL((SELECT MAX(payment_module_code) FROM upsell_orders uo WHERE uo.main_orders_id = o.orders_id), 0) = 1) AND
                             o.refundType < 2,
                             ot.shipping_amount, 0))                                                                                                                 AS shipping_rev,
                          COUNT(IF(o.orders_status IN (2,8), 1, NULL))                                                                                               AS all_new_order_cnt,
                          SUM(IF(o.orders_status IN (2,8), ot.current_total + f_upsell_order_total(o.orders_id), 0))                                                 AS all_new_order_rev,
                          COUNT(IF(o.orders_status IN (10, 11), 1, NULL))                                                                                            AS pending_order_cnt,
                          SUM(IF(o.orders_status IN (10, 11), ot.current_total + f_upsell_order_total(o.orders_id), 0))                                              AS pending_order_rev,
                          COUNT(IF(o.refundType > 1, 1, NULL))                                                                                                       AS refund_void_cnt,
                          SUM(ot.refunded_amount)                                                                                                                    AS refund_void_rev,
                          SUM(IF(o.orders_status NOT IN (6,7), ot.tax_factor, 0))                                                                                    AS taxable_rev,
                          COUNT(IF(o.is_recurring AND o.orders_status IN (2,8), 1, NULL))                                                                            AS active_cnt,
                          0                                                                                                                                          AS decline_cnt,
                          0                                                                                                                                          AS decline_rev,
                          0                                                                                                                                          AS hold_cnt,
                          0                                                                                                                                          AS hold_rev,
                          0                                                                                                                                          AS hold_cnt_outside,
                          0                                                                                                                                          AS hold_rev_o,
                          COUNT(IF(o.isChargeback = 1, 1, NULL))                                                                                                     AS chargeback_cnt
                       FROM
                           v_main_order_total   ot,
                           campaigns       c,
                           orders          o
                      WHERE
                           o.deleted           = 0
                        AND
                           o.campaign_order_id = c.c_id
                        AND
                           o.orders_id         = ot.orders_id
                        AND
                           {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                           AND o.is_test_cc IN (0, 1)

                   GROUP BY
                           o.orders_id
                  UNION ALL
                     SELECT
                           o.orders_id,
                           0                                                    AS new_order_cnt,
                           0                                                    AS new_order_rev,
                           0                                                    AS recurring_order_cnt,
                           0                                                    AS recurring_order_rev,
                           0                                                    AS shipping_cnt,
                           0                                                    AS shipping_rev,
                           0                                                    AS all_new_order_cnt,
                           0                                                    AS all_new_order_rev,
                           0                                                    AS pending_order_cnt,
                           0                                                    AS pending_order_rev,
                           0                                                    AS refund_void_cnt,
                           0                                                    AS refund_void_rev,
                           0                                                    AS taxable_rev,
                           0                                                    AS active_cnt,
                           0                                                    AS decline_cnt,
                           0                                                    AS decline_rev,
                           COUNT(IF(outside = 0, 1, NULL))                      AS hold_cnt,
                           SUM(IF(outside = 0, IFNULL(o.currency_value, 0), 0)) AS hold_rev,
                           COUNT(IF(outside = 1, 1, NULL))                      AS hold_cnt_outside,
                           SUM(IF(outside = 1, IFNULL(o.currency_value, 0), 0)) AS hold_rev_o,
                           0                                                    AS chargeback_cnt
                       FROM
                           orders o,
                           (
                              SELECT
                                    o.orders_id,
                                    IFNULL(currency_value, 0) AS currency_value,
                                    IF((hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (o.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
                               FROM
                                    orders o
                               WHERE
                                    o.is_hold = 1
                                 AND
                                    (
                                       {% condition orders.t_stamp_date %} o.t_stamp {% endcondition %}
                                        OR
                                                  {% condition orders.t_stamp_date %} o.hold_date {% endcondition %}
                                    )

                           UNION ALL
                              SELECT
                                    o.orders_id,
                                    IFNULL(uo.currency_value, 0) AS currency_value,
                                    IF((uo.hold_date BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))) AND (uo.t_stamp NOT BETWEEN (SELECT ({% date_start orders.t_stamp_date %})) AND (SELECT ({% date_end orders.t_stamp_date %}))), 1, 0) AS outside
                               FROM
                                    orders        o,
                                    upsell_orders uo
                               WHERE
                                    o.orders_id = uo.main_orders_id
                                 AND
                                    uo.is_hold = 1
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
                 ) x
            WHERE
                 o.orders_id = x.orders_id
              AND
                 o.deleted   = 0
              AND
                 o.campaign_order_id = c.c_id
                 AND o.is_test_cc IN (0, 1)

         GROUP BY
                 o.orders_id
        ) o
GROUP BY
        orders_id) a    ORDER BY order_val ASC
 ;; indexes: ["orders_id"]
  }

  measure: count {
    type: count
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

  dimension: group_by_val {
    type: string
    sql: ${TABLE}.group_by_val ;;
  }

  dimension: group_by_disp {
    type: string
    sql: ${TABLE}.group_by_disp ;;
  }

  dimension: new_order_cnt {
    type: number
    sql: ${TABLE}.new_order_cnt ;;
  }

  dimension: new_order_cnt_fmt {
    type: string
    sql: ${TABLE}.new_order_cnt_fmt ;;
  }

  dimension: new_order_rev {
    type: string
    sql: ${TABLE}.new_order_rev ;;
  }

  dimension: new_order_rev_fmt {
    type: string
    sql: ${TABLE}.new_order_rev_fmt ;;
  }

  dimension: recurring_order_cnt {
    type: number
    sql: ${TABLE}.recurring_order_cnt ;;
  }

  dimension: recurring_order_cnt_fmt {
    type: string
    sql: ${TABLE}.recurring_order_cnt_fmt ;;
  }

  dimension: recurring_order_rev {
    type: string
    sql: ${TABLE}.recurring_order_rev ;;
  }

  dimension: recurring_order_rev_fmt {
    type: string
    sql: ${TABLE}.recurring_order_rev_fmt ;;
  }

  dimension: shipping_cnt {
    type: number
    sql: ${TABLE}.shipping_cnt ;;
  }

  dimension: shipping_cnt_fmt {
    type: string
    sql: ${TABLE}.shipping_cnt_fmt ;;
  }

  dimension: shipping_rev {
    type: string
    sql: ${TABLE}.shipping_rev ;;
  }

  dimension: shipping_rev_fmt {
    type: string
    sql: ${TABLE}.shipping_rev_fmt ;;
  }

  dimension: all_new_order_cnt {
    type: number
    sql: ${TABLE}.all_new_order_cnt ;;
  }

  dimension: all_new_order_cnt_fmt {
    type: string
    sql: ${TABLE}.all_new_order_cnt_fmt ;;
  }

  dimension: all_new_order_rev {
    type: string
    sql: ${TABLE}.all_new_order_rev ;;
  }

  dimension: all_new_order_rev_fmt {
    type: string
    sql: ${TABLE}.all_new_order_rev_fmt ;;
  }

  dimension: pending_order_cnt {
    type: number
    sql: ${TABLE}.pending_order_cnt ;;
  }

  dimension: pending_order_cnt_fmt {
    type: string
    sql: ${TABLE}.pending_order_cnt_fmt ;;
  }

  dimension: pending_order_rev {
    type: string
    sql: ${TABLE}.pending_order_rev ;;
  }

  dimension: pending_order_rev_fmt {
    type: string
    sql: ${TABLE}.pending_order_rev_fmt ;;
  }

  dimension: taxable_rev {
    type: string
    sql: ${TABLE}.taxable_rev ;;
  }

  dimension: taxable_rev_fmt {
    type: string
    sql: ${TABLE}.taxable_rev_fmt ;;
  }

  dimension: decline_cnt {
    type: number
    sql: ${TABLE}.decline_cnt ;;
  }

  dimension: decline_cnt_fmt {
    type: string
    sql: ${TABLE}.decline_cnt_fmt ;;
  }

  dimension: decline_rev {
    type: string
    sql: ${TABLE}.decline_rev ;;
  }

  dimension: decline_rev_fmt {
    type: string
    sql: ${TABLE}.decline_rev_fmt ;;
  }

  dimension: refund_void_cnt {
    type: number
    sql: ${TABLE}.refund_void_cnt ;;
  }

  dimension: refund_void_cnt_fmt {
    type: string
    sql: ${TABLE}.refund_void_cnt_fmt ;;
  }

  dimension: refund_void_rev {
    type: string
    sql: ${TABLE}.refund_void_rev ;;
  }

  dimension: refund_void_rev_fmt {
    type: string
    sql: ${TABLE}.refund_void_rev_fmt ;;
  }

  dimension: active_cnt {
    type: number
    sql: ${TABLE}.active_cnt ;;
  }

  dimension: active_cnt_fmt {
    type: string
    sql: ${TABLE}.active_cnt_fmt ;;
  }

  dimension: avg_rev {
    type: string
    sql: ${TABLE}.avg_rev ;;
  }

  dimension: avg_rev_fmt {
    type: string
    sql: ${TABLE}.avg_rev_fmt ;;
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
    type: string
    sql: ${TABLE}.hold_rev ;;
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

  dimension: chargeback_cnt {
    type: number
    sql: ${TABLE}.chargeback_cnt ;;
  }

  dimension: chargeback_cnt_fmt {
    type: string
    sql: ${TABLE}.chargeback_cnt_fmt ;;
  }

  dimension: chargeback_pct {
    type: string
    sql: ${TABLE}.chargeback_pct ;;
  }

  dimension: chargeback_pct_fmt {
    type: string
    sql: ${TABLE}.chargeback_pct_fmt ;;
  }

  dimension: features {
    type: string
    sql: ${TABLE}.features ;;
  }

  dimension: prod_ids {
    type: string
    sql: ${TABLE}.prod_ids ;;
  }

  dimension: orders_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.orders_id ;;
  }

  dimension_group: t_stamp {
    type: time
    sql: ${TABLE}.t_stamp ;;
  }

  measure: count_hold {
    label: "Holds/Cancels"
    type: sum
    sql: ${hold_cnt} ;;
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

  set: detail {
    fields: [
      order_val,
      group_by_type,
      sub_group_by_type,
      group_by_val,
      group_by_disp,
      new_order_cnt,
      new_order_cnt_fmt,
      new_order_rev,
      new_order_rev_fmt,
      recurring_order_cnt,
      recurring_order_cnt_fmt,
      recurring_order_rev,
      recurring_order_rev_fmt,
      shipping_cnt,
      shipping_cnt_fmt,
      shipping_rev,
      shipping_rev_fmt,
      all_new_order_cnt,
      all_new_order_cnt_fmt,
      all_new_order_rev,
      all_new_order_rev_fmt,
      pending_order_cnt,
      pending_order_cnt_fmt,
      pending_order_rev,
      pending_order_rev_fmt,
      taxable_rev,
      taxable_rev_fmt,
      decline_cnt,
      decline_cnt_fmt,
      decline_rev,
      decline_rev_fmt,
      refund_void_cnt,
      refund_void_cnt_fmt,
      refund_void_rev,
      refund_void_rev_fmt,
      active_cnt,
      active_cnt_fmt,
      avg_rev,
      avg_rev_fmt,
      hold_cnt,
      hold_cnt_fmt,
      hold_rev,
      hold_rev_fmt,
      hold_cnt_outside,
      hold_cnt_outside_fmt,
      chargeback_cnt,
      chargeback_cnt_fmt,
      chargeback_pct,
      chargeback_pct_fmt,
      features,
      prod_ids,
      orders_id,
      t_stamp_time
    ]
  }
}
