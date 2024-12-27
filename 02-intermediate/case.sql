-- Active: 1733835599159@@127.0.0.1@3306@Parks_and_Recreation
use Parks_and_Recreation;

select 
    first_name, last_name, age,
    case
        when age in (29, 35) then 'test in'
        when age <= 30 then 'young'
        when age between 31 and 50 then 'old'
        when age >= 50 then "on death's door"
    end as age_bracket
from employee_demographics;

-- WRONG
-- cannot use variable in case with comparison
select 
    first_name, last_name, age,
    case age
        when <= 30 then 'young'
        when between 31 and 50 then 'old'
        when >= 50 then "on death's door"
    end as age_bracket
from employee_demographics;

-- CORRECT
-- cano only use fixed values
select 
    first_name, last_name, age,
    case age
        when 36 then 'young'
        when 44 then 'old'
        when 61 then "on death's door"
        else 'N/A'
    end as age_bracket
from employee_demographics;
