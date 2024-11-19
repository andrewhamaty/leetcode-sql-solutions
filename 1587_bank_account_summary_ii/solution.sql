with Account_Balances as (
    select
        U.name,
        sum(T.amount) over (partition by U.name) as balance
    from Users as U
    left join Transactions as T 
        on U.account = T.account
)
select
    distinct AB.name,
    AB.balance
from Account_Balances as AB
where AB.balance > 10000;