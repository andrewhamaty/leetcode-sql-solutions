select 
    R.contest_id, 
    round(
        count(R.user_id) * 100.0 / (select count(distinct U.user_id) from Users as U)
        , 2) as percentage
from Register as R
left join Users as U 
    on U.user_id = R.user_id
group by R.contest_id
order by 
    percentage desc, 
    R.contest_id
;