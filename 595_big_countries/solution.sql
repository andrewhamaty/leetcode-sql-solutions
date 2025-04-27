select 
    W.name
  , W.population
  , W.area
from World as W
where W.area >= 3000000
or W.population >= 25000000
;
