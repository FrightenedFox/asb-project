-- Print user and container
select user from dual;
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Install Sales History example schema ### --

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

-- Create sh_tablespace for Sales History scheme
create tablespace sh_tablespace
datafile '/home/oracle/Documents/tablespace/sh_tablespace.dbf' size 100M
    autoextend on next 10M maxsize 5G
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
);

-- Run SH script
@sh_main *password* sh_tablespace temp *password* /home/oracle/oracle_data_files/ /home/oracle/ora_log/ v3 localhost:1521/pdbsh

-- Check if the installation was successful
select * from sh.SALES FETCH FIRST 10 ROWS ONLY;

-- Check the tablespace of SH tables
select * from all_tables where owner='SH';