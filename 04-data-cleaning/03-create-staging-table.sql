use world_layoffs;

select
    *
from 
    layoffs;

-- standardize data
-- Null or blank values
-- remove any columns

-- create stagin table
create table 
    layoffs_staging
like
    layoffs;

insert into 
    layoffs_staging
select
    *
from
    layoffs;

