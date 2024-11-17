with on_before_2019_08_16 as (
  select *
  from Products as P
  where P.change_date <= '2019-08-16'
),
dates_ranked as (
  select 
      *,
      dense_rank() over (partition by on_before_2019_08_16.product_id order by on_before_2019_08_16.change_date desc) as drank 
  from on_before_2019_08_16
),
after_2019_08_16 as (
  select *
  from Products as P
  where P.change_date > '2019-08-16'
  and P.product_id not in (
                          select P.product_id
                          from Products as P
                          where P.change_date <= '2019-08-16'
                          )
)
select
    dates_ranked.product_id,
    dates_ranked.new_price as price
from dates_ranked
where dates_ranked.drank = 1

union

select 
    distinct after_2019_08_16.product_id,
    10 as price
from after_2019_08_16;
