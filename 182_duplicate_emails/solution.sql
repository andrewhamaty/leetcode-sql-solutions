delete P1
from 
    Person as P1, 
    Person as P2
where P1.email = P2.email
and P1.id > P2.id
;