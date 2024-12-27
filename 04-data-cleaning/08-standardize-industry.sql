select distinct
    industry
from
    layoffs_staging2
where
    industry like 'crypto%'
order BY
    industry
;

update
    layoffs_staging2
set
    industry = 'Crypto'
where
    industry like 'crypto%'
;