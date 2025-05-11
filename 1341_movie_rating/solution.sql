with users_counted as (
    select
        U.name
      , count(MR.user_id) as count
    from MovieRating as MR
    inner join Users as U
      on MR.user_id = U.user_id
    group by U.name
    order by
        count desc
      , U.name asc
    limit 1
)
, movie_ratings as (
    select
        M.title
      , avg(MR.rating) as avg_rating
    from MovieRating as MR
    inner join Movies as M
      on MR.movie_id = M.movie_id
    where created_at <= '2020-02-28'
    and created_at >= '2020-02-01'
    group by M.title
    order by
        avg_rating desc
      , M.title asc
    limit 1
)
select name as results
from users_counted

union all

select title as results
from movie_ratings
