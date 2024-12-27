-- find companies with spaces
select
    company
    , trim(company)
from
    layoffs_staging2
where company != trim(company)
;

-- update
update
    layoffs_staging2
set company = trim(company)
;
