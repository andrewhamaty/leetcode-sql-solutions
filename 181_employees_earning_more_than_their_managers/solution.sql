select E2.name as Employee
from Employee as E1
inner join Employee as E2 
    on E1.id = E2.managerID
where E1.salary < e2.salary