use world_layoffs;

create table layoffs_staging2 as
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
;

