with cte as (
	select
		*
	  , case
	  		when amount % 2 = 0
	  		then 'even'
	  		else 'odd'
	  	end as flag
	from transactions
)
select
	sum(amount) over (partition by transaction_date, flag)
from cte



--
with sums as (
	select distinct
		transaction_date
	  , sum(amount) filter (where amount % 2 = 1) over (partition by transaction_date) as odd_sum
	  , sum(amount) filter (where amount % 2 = 0) over (partition by transaction_date) as even_sum
	from transactions
)
select
	transaction_date
  , case
  		when odd_sum is null
  		then 0
  		else odd_sum
  	end as odd_sum
  , case
  		when even_sum is null
  		then 0
  		else even_sum
  	end as even_sum
from sums
order by transaction_date asc
;