--question 1 

-- creating tables 
--table where data is stored in bucket
CREATE EXTERNAL TABLE `rare-sound-412302.ny_green_taxi_2022.rides`
  OPTIONS (
    format ="PARQUET",
    uris = ['gs://hw_3_nyssa_bucket/*.parquet']
    );
-- materialized table 
CREATE TABLE `rare-sound-412302.ny_green_taxi_2022.rides_ddl`
 AS
SELECT
  *
FROM `rare-sound-412302.ny_green_taxi_2022.rides`;

-- partitioned and clustered
CREATE TABLE `rare-sound-412302.ny_green_taxi_2022.rides_ddl_optimized`
partition by date(lpep_pickup_datetime)
cluster by PULocationID
AS
SELECT
  *
FROM `rare-sound-412302.ny_green_taxi_2022.rides_ddl`;




--queries for questions

select count(*) 
from rare-sound-412302.ny_green_taxi_2022.rides
where fare_amount=0;



select count(distinct PULocationID)
from `rare-sound-412302.ny_green_taxi_2022.rides_ddl_optimized`
WHERE lpep_pickup_datetime >= TIMESTAMP('2022-06-01')
  AND lpep_pickup_datetime <= TIMESTAMP('2022-06-30');