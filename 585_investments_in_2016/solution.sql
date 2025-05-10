/* Method 1 */

with Insurance2 as (
    select
        I.pid
      , I.tiv_2015
      , I.tiv_2016
      , concat(I.lat, '/', I.lon) as lat_lon
    from Insurance as I
)
, tiv_2015_counts as (
    select
        I.tiv_2015
    , count(tiv_2015) as tiv_2015_count
    from insurance as I
    group by I.tiv_2015
)
, lat_lon_counts as (
    select
        I2.lat_lon
      , count(I2.lat_lon) as lat_lon_count
    from Insurance2 as I2
    group by I2.lat_lon
)
, final as (
    select
        I2.pid
      , I2.tiv_2015
      , I2.tiv_2016
      , I2.lat_lon
      , T2C.tiv_2015_count
      , LLC.lat_lon_count
    from Insurance2 as I2
    left join tiv_2015_counts as T2C
    on I2.tiv_2015 = T2C.tiv_2015
    left join lat_lon_counts as LLC
    on I2.lat_lon = LLC.lat_lon
    where tiv_2015_count > 1
    and lat_lon_count = 1
)
select round(sum(tiv_2016), 2) as tiv_2016
from final
;

/* Method 2 */
select
    round(sum(tiv_2016), 2) as tiv_2016
from insurance
where tiv_2015 in (
    select tiv_2015
    from insurance
    group by tiv_2015
    having count(*) > 1
)
and (lat, lon) in (
    select lat, lon
    from insurance
    group by lat, lon
    having count(*) = 1
)
;
