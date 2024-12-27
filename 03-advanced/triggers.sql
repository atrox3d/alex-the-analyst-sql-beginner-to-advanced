drop trigger if exists employee_insert;

delimiter //
create trigger if not exists
    employee_insert
after insert on
    employee_salary
for each row
begin
    insert into employee_demographics(
        employee_id
        , first_name
        , last_name
    )
    values(
        new.employee_id
        , new.first_name
        , new.last_name
    );
end //
delimiter ;

-- test trigger
insert into
    employee_salary(
        employee_id
        , first_name
        , last_name
        , occupation
        , salary
        , dept_id
    )
values(
    13
    , 'new'
    , 'added'
    , 'something'
    , 1000000
    , null
);

select
    *
from 
    employee_salary
where
    employee_id = 13
union
select
    *
from 
    employee_demographics
where
    employee_id = 13;
