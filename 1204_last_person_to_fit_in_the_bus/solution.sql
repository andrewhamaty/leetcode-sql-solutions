with weight_totals as (
	select
		person_name
	  , weight
	  , turn
	  , sum(weight) over (order by turn asc) as running_total
	from Queue
)
select person_name
from weight_totals
where running_total <= 1000
order by running_total desc
limit 1;