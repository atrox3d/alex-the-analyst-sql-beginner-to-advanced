use Parks_and_Recreation;


-- subquery in WHERE
select *
from employee_demographics
where employee_id in (
    select employee_id
    from employee_salary
    where dept_id = 1
)
;

-- subquery in SELECT
select 
    first_name, salary, 
    (
        select avg(salary)
        from employee_salary
    )
from employee_salary;

-- subquery in FROM
select avg(maxage)
from (
    select 
        gender,
        avg(age)   as avgage,
        max(age)   as maxage,
        min(age)   as minage,
        count(age) as countage
    from 
        employee_demographics
        group by gender
) as stats
;