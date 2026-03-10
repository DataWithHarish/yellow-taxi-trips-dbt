select 
    data:VendorID::INT      AS vendor_id,
    to_timestamp_ntz(data:tpep_pickup_datetime::NUMBER / 1000000) 
        AS pickup_datetime,

    to_timestamp_ntz(data:tpep_dropoff_datetime::NUMBER / 1000000) 
        AS dropoff_datetime,
    datediff(minute,pickup_datetime,dropoff_datetime) as trip_duration_in_min,
    date(pickup_datetime) as trip_date,
    extract(hour from pickup_datetime) as pickup_hour,
    data:passenger_count::INT   AS passenger_count,
    data:trip_distance::FLOAT   AS trip_distance,
    data:RatecodeID::INT        AS rate_code_id,
    data:store_and_fwd_flag::STRING AS store_and_fwd_flag,
    data:PULocationID::INT      AS pickup_location_id,
    data:DOLocationID::INT      AS dropoff_location_id,
    data:payment_type::INT      AS Payment_type,
    data:fare_amount::FLOAT     AS fare_amount,
    data:extra::FLOAT           AS extra,
    data:mta_tax::FLOAT         AS mta_tax,
    coalesce(data:tip_amount::FLOAT,0)     AS tip_amount,
    coalesce(data:tolls_amount::FLOAT,0)   AS tolls_amount,
    data:improvement_surcharge::FLOAT AS improvement_surcharge,
    data:total_amount::FLOAT         AS total_amount,
    data:congestion_surcharge::FLOAT AS congestion_surcharge,
    coalesce(data:airport_fee::FLOAT,0)          AS airport_fee,
    coalesce(data:cbd_congestion_fee::FLOAT,0)   AS cbd_congestion_fee

from {{ source('taxi_data', 'taxi_trips_raw') }}