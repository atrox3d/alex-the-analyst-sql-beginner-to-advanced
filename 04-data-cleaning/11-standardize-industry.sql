select distinct
    industry
from
    layoffs_staging2
order by
    industry
;

select
    trim(industry)
    , count(trim(industry))
from
    layoffs_staging2
group by 
    industry
having
    industry = ''
order by
    industry
;

update
    layoffs_staging2
set
    industry = null
where
    trim(industry) = ''
;

select
    t1.company
    , t1.industry
    , t2.industry
from
    layoffs_staging2 t1
join
    layoffs_staging2 t2
on
    t1.company = t2.company
where
    t1.industry is null
    and t2.industry is not null
order by
    company
;


update
    layoffs_staging2 t1
join
    layoffs_staging2 t2
on
    t1.company = t2.company
set 
    t1.industry = t2.industry
where
    t1.industry is null
    and t2.industry is not null
;