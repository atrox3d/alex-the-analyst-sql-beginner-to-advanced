use world_layoffs;


-- remove duplicates
with duplicate_cte as
(
    select
        *
        , row_number() over(
            partition by
            company
            , location
            , industry
            , total_laid_off
            , percentage_laid_off
            , `date`
            , country
            , stage
            , funds_raised_millions
        ) as row_num
    from
        layoffs_staging
)
select
    *
from
    duplicate_cte
where 
    row_num > 1;
    
select * from layoffs_staging
where company = 'oda';