-- CTEs

-- base query
select
    gender
    , avg(salary)
    , max(salary)
    , min(salary)
    , count(salary)
from 
    employee_demographics as dem
join 
    employee_salary as sal
on
    dem.employee_id = sal.employee_id
group by 
    gender;


-- use as CTE
with cte_example AS
(
    select
        gender
        , avg(salary)   as avg_sal
        , max(salary)   as max_sal
        , min(salary)   as min_sal
        , count(salary) as count_sal
    from 
        employee_demographics as dem
    join 
        employee_salary as sal
    on
        dem.employee_id = sal.employee_id
    group by 
        gender
)
select
    avg(avg_sal)
from 
    cte_example
;

-- rewrite as subquery
select
    avg(avg_sal)
from
    (
        select
            gender
            , avg(salary)   as avg_sal
            , max(salary)   as max_sal
            , min(salary)   as min_sal
            , count(salary) as count_sal
        from 
            employee_demographics as dem
        join 
            employee_salary as sal
        on
            dem.employee_id = sal.employee_id
        group by gender
    ) as sq
    ;

-- cannot use ctes after the statement end
select
    avg(avg_sal)
from 
    cte_example
;

-- multiple ctes
with cte_example AS
(
    select
        employee_id
        , gender
        , birth_date
    from 
        employee_demographics
    where
        birth_date > '1985-01-01'
),
cte_example2 as
(
    select
        employee_id
        , salary
    from 
        employee_salary
    where
        salary > 50000
)
select
    *
from 
    cte_example
join
    cte_example2
on
    cte_example.employee_id = cte_example2.employee_id
;

-- naming ctes fields
with cte_example(
    gender
    , avg_sal
    , max_sal
    , min_sal
    , count_sal
) AS
(
    select
        gender
        , avg(salary)
        , max(salary)
        , min(salary)
        , count(salary)
    from 
        employee_demographics as dem
    join 
        employee_salary as sal
    on
        dem.employee_id = sal.employee_id
    group by 
        gender
)
select
    avg(avg_sal)
from 
    cte_example
;



