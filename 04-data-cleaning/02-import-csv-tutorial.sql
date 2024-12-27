use world_layoffs;

drop table if exists layoffs;
create table if not exists
    layoffs(
        company                 text
        , location              text
        , industry              text
        , total_laid_off        int
        , percentage_laid_off   text
        , date                  text
        , country               text
        , stage                 text
        , funds_raised_millions int

    );

select @@global.secure_file_priv;

truncate table layoffs;

LOAD DATA INFILE 
    '/var/lib/mysql-files/layoffs.csv' 
INTO TABLE 
    layoffs
FIELDS TERMINATED BY 
    ','
-- optionally ENCLOSED BY '"'
LINES TERMINATED BY 
    '\n'
ignore 
    1 lines
(
    company
    , location
    , industry
    , @total
    , percentage_laid_off
    , date
    , country
    , stage
    , @funds
)
set 
    total_laid_off = if(@total = 'NULL', null, @total)
    -- , percentage_laid_off = if(@percentage = 'NULL', null, @percentage)
    -- , date = if(@date = 'NULL', null, STR_TO_DATE(@date, '%m/%d/%Y'))
    , funds_raised_millions = if(left(@funds,1) = 'N', null, @funds)
;