select
    *
from
    layoffs_staging2
;
select
    *
from
    layoffs_staging2
where
    row_num > 1
;

delete from
    layoffs_staging2
where
    row_num > 1
;