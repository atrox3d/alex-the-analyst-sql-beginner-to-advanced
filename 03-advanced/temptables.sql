-- Active: 1733835599159@@127.0.0.1@3306@Parks_and_Recreation
-- tempory tables

-- first way: declare structure and insert values
create temporary table
    temp_table 
    (
        first_name varchar(50)
        , last_name varchar(50)
        , favorite_movie varchar(100)
    );


select
    *
from
    temp_table;


insert into
    temp_table
values
    ('name', 'surname', 'title');


-- second way: create from query
select * from employee_salary;


create temporary table
    salary_over_50k
select
    *
from
    employee_salary
where 
    salary >= 50000;

-- does not exist after disconnection
select * from salary_over_50k;

