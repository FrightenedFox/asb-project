-- Print user and container
select user from dual;
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Migrate AdventureWorks2019 ### --

-- Check if the migration was successful
select * from humanresources_adventureworks2019.department;
