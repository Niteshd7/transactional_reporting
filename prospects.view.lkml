view: prospects {
  sql_table_name: {{ _access_filters["client.schema_name"] }}.prospects      ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${campaign_id} || '_' || ${prospects_id}
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: prospects_id {
    type: number
    sql: ${TABLE}.prospects_id ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: step_id {
    type: number
    sql: ${TABLE}.step_id ;;
  }

  dimension: status_id {
    type: number
    sql: ${TABLE}.status_id ;;
  }

  dimension: update_id {
    type: number
    sql: ${TABLE}.update_id ;;
  }

  dimension: create_id {
    type: number
    sql: ${TABLE}.create_id ;;
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: p_first_name {
    type: string
    sql: ${TABLE}.pFirstName ;;
  }

  dimension: p_last_name {
    type: string
    sql: ${TABLE}.pLastName ;;
  }

  dimension: p_address {
    type: string
    sql: ${TABLE}.pAddress ;;
  }

  dimension: p_address2 {
    type: string
    sql: ${TABLE}.pAddress2 ;;
  }

  dimension: p_city {
    type: string
    sql: ${TABLE}.pCity ;;
  }

  dimension: p_state {
    type: string
    sql: ${TABLE}.pState ;;
  }

  dimension: p_zip {
    type: string
    sql: ${TABLE}.pZip ;;
  }

  dimension: p_country {
    type: string
    sql: ${TABLE}.pCountry ;;
  }

  dimension: p_phone {
    type: string
    sql: ${TABLE}.pPhone ;;
  }

  dimension: p_email {
    type: string
    sql: ${TABLE}.pEmail ;;
  }

  dimension: p_ipaddress {
    type: string
    sql: ${TABLE}.pIPAddress ;;
  }

  dimension: p_ipaddress_location {
    type: string
    sql: ${TABLE}.pIPAddressLocation ;;
  }

  dimension: p_notes {
    type: string
    sql: ${TABLE}.pNotes ;;
  }

  dimension_group: p_date {
    type: time
    sql: ${TABLE}.pDate ;;
    convert_tz: no
  }

  dimension_group: update_in {
    type: time
    sql: ${TABLE}.update_in ;;
    convert_tz: no
  }

  dimension: p_afid {
    type: string
    sql: ${TABLE}.pAFID ;;
  }

  dimension: p_sid {
    type: string
    sql: ${TABLE}.pSID ;;
  }

  dimension: p_affid {
    type: string
    sql: ${TABLE}.pAFFID ;;
  }

  dimension: p_c1 {
    type: string
    sql: ${TABLE}.pC1 ;;
  }

  dimension: p_c2 {
    type: string
    sql: ${TABLE}.pC2 ;;
  }

  dimension: p_c3 {
    type: string
    sql: ${TABLE}.pC3 ;;
  }

  dimension: p_bid {
    type: string
    sql: ${TABLE}.pBID ;;
  }

  dimension: p_aid {
    type: string
    sql: ${TABLE}.pAID ;;
  }

  dimension: p_opt {
    type: string
    sql: ${TABLE}.pOPT ;;
  }

  dimension: p_sent_prospect {
    type: yesno
    sql: ${TABLE}.pSentProspect ;;
  }

  dimension: p_state_id {
    type: string
    sql: ${TABLE}.pState_id ;;
  }

  dimension: p_click_id {
    type: string
    sql: ${TABLE}.pClickID ;;
  }

  dimension: sent_to_autoresponder {
    type: yesno
    sql: ${TABLE}.sent_to_autoresponder ;;
  }

  measure: count_prospects {
    type: count_distinct
    sql: ${prospects_id} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      prospects_id,
      orders_id,
      campaign_id,
      step_id,
      status_id,
      update_id,
      create_id,
      deleted,
      active,
      p_first_name,
      p_last_name,
      p_address,
      p_address2,
      p_city,
      p_state,
      p_zip,
      p_country,
      p_phone,
      p_email,
      p_ipaddress,
      p_ipaddress_location,
      p_notes,
      p_date_time,
      update_in_time,
      p_afid,
      p_sid,
      p_affid,
      p_c1,
      p_c2,
      p_c3,
      p_bid,
      p_aid,
      p_opt,
      p_sent_prospect,
      p_state_id,
      p_click_id,
      sent_to_autoresponder
    ]
  }
}
