select W1.id
from 
    Weather as W1, 
    Weather as W2
where datediff(W1.recordDate, W2.recordDate) = 1 
and W1.temperature > W2.temperature;