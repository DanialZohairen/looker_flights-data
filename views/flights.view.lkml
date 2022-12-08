# The name of this view in Looker is "Flights"
view: flights {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `iremlin-palace.Hackathon.Flights`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Dest Airport Lat" in Explore.

  dimension: dest_airport_lat {
    type: string
    sql: ${TABLE}.Dest_airport_lat ;;
  }

  dimension: flight_id {
    primary_key: yes
    type: string
    sql: concat(${origin_airport},${destination_airport},${fly_date}) ;;
  }

  dimension: dest_airport_long {
    type: string
    sql: ${TABLE}.Dest_airport_long ;;
  }

  dimension: destination_airport {
    type: string
    sql: ${TABLE}.Destination_airport ;;
  }

  dimension: destination_city {
    type: string
    sql: ${TABLE}.Destination_city ;;
    map_layer_name: us_states
  }

  dimension: destination_population {
    type: number
    sql: ${TABLE}.Destination_population ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_destination_population {
    type: sum
    sql: ${destination_population} ;;
  }

  measure: average_destination_population {
    type: average
    sql: ${destination_population} ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.Distance ;;
  }

  dimension: flights {
    type: number
    sql: ${TABLE}.Flights ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fly {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Fly_date ;;
  }

  dimension: org_airport_lat {
    type: string
    sql: ${TABLE}.Org_airport_lat ;;
  }

  dimension: org_airport_long {
    type: string
    sql: ${TABLE}.Org_airport_long ;;
  }

  dimension: origin_airport {
    type: string
    sql: ${TABLE}.Origin_airport ;;
  }

  dimension: origin_city {
    type: string
    sql: ${TABLE}.Origin_city ;;
    map_layer_name: us_map
  }

  dimension: states {
    type: string
    # sql:
    # case
    # when split(${origin_city}, ",")[offset(1)] = 'OR' then 'Oregon'
    # when split(${origin_city}, ",")[offset(1)] = 'WA' then 'Washington'
    # when split(${origin_city}, ",")[offset(1)] = 'SD' then 'South Dakota'
    # when split(${origin_city}, ",")[offset(1)] = 'TX' then 'Texas'
    # else 'Other'
    # end
    # ;;
    sql:
    trim(split(${origin_city}, ",")[offset(1)])
    ;;
    map_layer_name: us_states
  }

  dimension: origin_population {
    type: number
    sql: ${TABLE}.Origin_population ;;
  }

  dimension: passengers {
    type: number
    sql: ${TABLE}.Passengers ;;
  }

  dimension: seats {
    type: number
    sql: ${TABLE}.Seats ;;
  }

  dimension: origin {
    type: location
    sql_latitude: ${org_airport_lat} ;;
    sql_longitude: ${org_airport_long} ;;
  }

  dimension: destination {
    type: location
    sql_latitude: ${dest_airport_lat} ;;
    sql_longitude: ${dest_airport_long} ;;
  }

  measure: sum_passengers {
    type: sum
    sql: ${passengers} ;;
  }

  measure: sum_flights {
    type: sum
    sql: ${flights} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
