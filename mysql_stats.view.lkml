view: mysql_stats {
  derived_table: {
    sql: SELECT
          plist.id, plist.user, plist.host, plist.db,
          plist.command, plist.TIME, plist.state,
          plist.info, trx.trx_state,
          trx.trx_wait_started,
          trx.trx_query, blockerw.blocking_trx_id,
          (CASE
              WHEN (blockerw.blocking_trx_id IS NOT NULL) THEN 'Blocked'
              WHEN (lockedtr.trx_id IS NOT NULL) THEN 'Locked'
              ELSE ''
          END) is_blocker
      FROM
          information_schema.PROCESSLIST AS plist
              LEFT OUTER JOIN
          information_schema.innodb_trx AS trx ON trx.Trx_MySQL_Thread_ID = plist.id
              LEFT OUTER JOIN
          information_schema.innodb_lock_waits blockerw ON blockerw.blocking_trx_id = trx.trx_id
              LEFT OUTER JOIN
          information_schema.innodb_lock_waits lockedw ON lockedw.requesting_trx_id = trx.trx_id
              LEFT OUTER JOIN
          information_schema.innodb_trx lockedtr ON lockedtr.trx_id = lockedw.blocking_trx_id
      where plist.command NOT IN ('Sleep', 'Binlog Dump')
      ORDER BY time DESC;
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user {
    type: string
    sql: ${TABLE}.user ;;
  }

  dimension: host {
    type: string
    sql: ${TABLE}.host ;;
  }

  dimension: db {
    type: string
    sql: ${TABLE}.db ;;
  }

  dimension: command {
    type: string
    sql: ${TABLE}.command ;;
  }

  dimension: time {
    type: number
    sql: ${TABLE}.TIME ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: info {
    type: string
    sql: ${TABLE}.info ;;
  }

  dimension: trx_state {
    type: string
    sql: ${TABLE}.trx_state ;;
  }

  dimension_group: trx_wait_started {
    type: time
    sql: ${TABLE}.trx_wait_started ;;
  }

  dimension: trx_query {
    type: string
    sql: ${TABLE}.trx_query ;;
  }

  dimension: blocking_trx_id {
    type: string
    sql: ${TABLE}.blocking_trx_id ;;
  }

  dimension: is_blocker {
    type: string
    sql: ${TABLE}.is_blocker ;;
  }

  set: detail {
    fields: [
      id,
      user,
      host,
      db,
      command,
      time,
      state,
      info,
      trx_state,
      trx_wait_started_time,
      trx_query,
      blocking_trx_id,
      is_blocker
    ]
  }
}
