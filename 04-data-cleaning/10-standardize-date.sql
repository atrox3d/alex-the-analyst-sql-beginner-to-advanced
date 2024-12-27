select
    `date`
    -- , str_to_date(`date`, '%m/%d/%Y')
from
    layoffs_staging2
;

update
    layoffs_staging2
set
    `date` = str_to_date(`date`, '%m/%d/%Y')
;

alter table
    layoffs_staging2
modify column
    `date`date;