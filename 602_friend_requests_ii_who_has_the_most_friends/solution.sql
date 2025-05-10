with unioned as (
    select requester_id as id
    from RequestAccepted

    union all

    select accepter_id as id
    from RequestAccepted
)
, counted as (
    select
        id
    , count(id) as num
    from unioned
    group by id
    order by num desc
)
select
    id
  , num
  , dense_rank() over (partition by id order by num desc)
from counted
;
