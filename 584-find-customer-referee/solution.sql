select C.name
from Customer as C
where C.referee_id is null
  or C.referee_id != 2
;
