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

select distinct
    country
from
    layoffs_staging2
order by country
;


update
    layoffs_staging2
set
    country = 'United States'
where
    country like 'united state%'
;

update
    layoffs_staging2
set
    country = trim(trailing '.' from country)
;


update
    layoffs_staging2
set
    country = trim(country)
;