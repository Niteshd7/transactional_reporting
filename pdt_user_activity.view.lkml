view: pdt_user_activity {
  derived_table: {
    sql: SELECT  * FROM (         SELECT
               oh.orders_id AS order_id,
               oh.user,
               a.admin_fullname,
               IFNULL(ohg.name, oht.name)          AS activity,
               DATE_FORMAT(oh.t_stamp, '%m/%d/%Y') AS t_stamp,
               COUNT(1)                            AS cnt
           FROM
               admin          a,
               orders_history oh,
               tlkp_orders_history_type oht
LEFT OUTER JOIN
               tlkp_orders_history_group ohg
             ON
               oht.group_id = ohg.id
          WHERE
               oh.deleted = 0
            AND
               oh.orders_id != 0
            AND
               oh.user = a.admin_id
            AND
               oh.user > 1
            AND
               oh.user NOT IN (999000,999998,999999)
            AND
               oht.active = 1
            AND
               (
                  IF
                  (
                     oh.type = 'recurring' AND oh.status IN ('hold', 'stop'),
                     CONCAT(oh.type, '-', oh.status),
                     oh.type
                  )
               ) = oht.type_id
               AND ({% condition date_select %} oh.t_stamp {% endcondition %})

       GROUP BY
               order_id
      UNION ALL
         SELECT
               oh.orders_id AS order_id,
               oh.user,
               a.admin_fullname,
               IFNULL(ohg.name, oht.name)          AS activity,
               DATE_FORMAT(oh.t_stamp, '%m/%d/%Y') AS t_stamp,
               COUNT(1)                            AS cnt
           FROM
               admin          a,
               orders_history oh,
               tlkp_orders_history_type oht
LEFT OUTER JOIN
               tlkp_orders_history_group ohg
             ON
               oht.group_id = ohg.id
          WHERE
               oh.deleted = 1
            AND
               oh.user = a.admin_id
            AND
               oh.user > 1
            AND
               oh.user NOT IN (999000,999998,999999)
            AND
               oht.active = 1
            AND
               oh.type = 'deleted-order'
            AND
               oh.type = oht.type_id
               AND ({% condition date_select %} oh.t_stamp {% endcondition %})

       GROUP BY
               order_id) a    ORDER BY admin_fullname ASC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: date_select {
    type: date
    default_value: "today"
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}.user ;;
  }

  dimension: admin_fullname {
    type: string
    sql: ${TABLE}.admin_fullname ;;
  }

  dimension: activity {
    type: string
    sql: ${TABLE}.activity ;;
  }

  dimension: t_stamp {
    type: string
    sql: ${TABLE}.t_stamp ;;
  }

  dimension: cnt {
    type: number
    sql: ${TABLE}.cnt ;;
  }

  measure: count_activity {
    type: sum
    sql: ${cnt} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      order_id,
      user,
      admin_fullname,
      activity,
      t_stamp
    ]
  }
}
