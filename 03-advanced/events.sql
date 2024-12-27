show variables like 'event%';

select @@global.event_scheduler;

delimiter //
create event if not exists
    every_minute
on 
    schedule every 60 second
do
begin
    create table if not exists
        minute_log(
        time datetime
    );
    insert into
        minute_log
    values
        (now());
end //
delimiter ;

