with cte as (
    select 
        S.user_id,
        C.action,
        case
            when C.action = 'confirmed'
            then 1
            else 0
        end as message_confirmed
    from Signups as S
    left join Confirmations as C
        on S.user_id = C.user_id
)
select
    cte.user_id,
    round(sum(cte.message_confirmed) / count(*), 2) as confirmation_rate
from cte
group by cte.user_id;