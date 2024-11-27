select 
    AD.actor_id,
    AD.director_id
from ActorDirector as AD
group by
    AD.actor_id,
    AD.director_id
having count(AD.timestamp)>=3
;