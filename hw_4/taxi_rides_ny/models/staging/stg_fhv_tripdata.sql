{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *,
  from {{ source('staging','fhv_tripdata') }}
  where dispatching_base_num is not null 
)
select

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
   dispatching_base_num,
   PUlocationID as pickup_locationid,
   DOlocationID as dropoff_locationid,
   SR_Flag,
   Affiliated_base_number
from tripdata


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}