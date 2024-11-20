select 
    E.event_day as day, 
    E.emp_id,
    sum(E.out_time - E.in_time) as total_time
from Employees as E
group by 
    E.event_day,
    E.emp_id;