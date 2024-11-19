with user_balance as (
    select
        U.name
      , sum(T.amount) as balance
    from Transactions as T
    join Users as U 
        on T.account = U.account
    group by U.name
)
select *
from user_balance
where balance > 10000;