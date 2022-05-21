-- Print user and container
select user from dual;
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;

select * from all_users;

-- ### Migrate AdventureWorks2019 ### --

-- Check if the migration was successful
select * from humanresources_adventureworks2019.department;

-- Create adv_works_ts for Adventure Works scheme
create tablespace adv_works_ts
datafile '/home/oracle/Documents/tablespace/adv_works_ts.dbf' size 50M
    autoextend on next 5M maxsize 1G
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
);

-- TODO: move tables (and indexes, if possible) to adv_works_ts tablespace
select * from all_tables where owner='HUMANRESOURCES_ADVENTUREWORKS2019';
select * from SYS.ALL_INDEXES where TABLE_OWNER='HUMANRESOURCES_ADVENTUREWORKS2019';
