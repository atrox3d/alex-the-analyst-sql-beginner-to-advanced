use Parks_and_Recreation;

-- original query
select
    gender,
    avg(salary) as 'avg-salary'
from employee_demographics as dem
join employee_salary as sal
    on dem.employee_id = sal.employee_id
group by gender
;

-- window
select
    dem.first_name, 
    dem.last_name, 
    gender,
    avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
    on dem.employee_id = sal.employee_id
-- group by gender
;
-- window
select
    dem.employee_id,
    dem.first_name, 
    dem.last_name, 
    gender,
    salary,
    row_number() 
        -- over()
        over(partition by gender order by salary desc),
    rank()
        over(partition by gender order by salary desc),
    dense_rank()
        over(partition by gender order by salary desc)
from employee_demographics as dem
join employee_salary as sal
    on dem.employee_id = sal.employee_id
-- group by gender
;
