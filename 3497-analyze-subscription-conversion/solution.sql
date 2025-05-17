/* Using Postgres */

-- Method 1
with PayingUsers as (
    -- paying users
    select distinct *
    from UserActivity
    where activity_type = 'paid'
)
, PayingUsersActivity as (
    select distinct
        UA.user_id
      , UA.activity_date
      , UA.activity_type
      , UA.activity_duration
    from UserActivity as UA
    inner join PayingUsers as PU
      on UA.user_id = PU.user_id
)
, TrialAverageDurations as (
    select
        user_id
      , round(avg(activity_duration), 2) as trial_avg_duration
    from PayingUsersActivity
    where activity_type = 'free_trial'
    group by user_id
)
, PaidAverageDurations as (
    select
        user_id
      , round(avg(activity_duration), 2) as paid_avg_duration
    from PayingUsersActivity
    where activity_type = 'paid'
    group by user_id
)
select
    TAD.user_id
  , TAD.trial_avg_duration
  , PAD.paid_avg_duration
from TrialAverageDurations as TAD
full outer join PaidAverageDurations as PAD
  on TAD.user_id = PAD.user_id
order by user_id asc
;

-- Method 2
with AverageDurations as (
    select
        user_id
      , round(avg(activity_duration) filter (where activity_type = 'free_trial'), 2) as trial_avg_duration
      , round(avg(activity_duration) filter (where activity_type = 'paid'), 2) as paid_avg_duration
    from UserActivity
    group by user_id
)
select *
from AverageDurations
where paid_avg_duration is not null
order by user_id asc
;
