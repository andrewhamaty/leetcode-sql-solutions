-- Method 1
with Flagged as (
    select
        *
      , case
            when exam_date = min(exam_date) over (partition by student_id, subject)
            then 1
            else 0
        end as min_exam_date
      , case
            when exam_date = max(exam_date) over (partition by student_id, subject)
            then 1
            else 0
        end as max_exam_date
        from Scores
)
, First_Scores as (
    select
        student_id
      , subject
      , score as first_score
    from Flagged
    where min_exam_date = 1
)
, Latest_Scores as (
    select
        student_id
      , subject
      , score as latest_score
    from Flagged
    where max_exam_date = 1
)
select
  FS.student_id,
  FS.subject,
  FS.first_score,
  LS.latest_score
from First_Scores as FS
inner join Latest_Scores as LS
  on FS.student_id = LS.student_id
  and FS.subject = LS.subject
where LS.latest_score > FS.first_score
order by
    LS.student_id
  , LS.subject

-- Method 2
with first_last_scores as (
    select
        student_id
      , subject
      , first_value(score) over(partition by student_id,subject order by exam_date) as first_score
      , first_value(score) over(partition by student_id,subject order by exam_date desc) as latest_score
    from scores
)
select distinct *
from first_last_scores
where first_score < latest_score
order by
    student_id
  , subject
