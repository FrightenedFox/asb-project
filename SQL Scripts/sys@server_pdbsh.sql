-- Print user and container
select user from dual;
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Add Sales History example scheme ### --

-- Grant user all necessary permissions
grant connect, resource, create session, create view, alter session, create sequence, create synonym,
create database link, unlimited tablespace to sh_user identified by sh_user;


-- Create users tablespace in the PDBSH
select * from dba_tablespaces;
create tablespace users
datafile '/home/oracle/Documents/tablespace/users_tablespace.dbf' size 50M
    autoextend on next 1m maxsize 500m
    minimum extent 5k
    default storage (
    initial 10k
    next 10k
    pctincrease 0
    );


-- Check if the insertion was successful
select * from sh.SALES FETCH FIRST 10 ROWS ONLY;
