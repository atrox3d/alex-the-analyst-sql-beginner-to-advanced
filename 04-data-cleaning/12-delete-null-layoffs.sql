select
    *
from
    layoffs_staging2
where
    total_laid_off is null
and percentage_laid_off is null;

delete from
    layoffs_staging2
where
    total_laid_off is null
and percentage_laid_off is null;
