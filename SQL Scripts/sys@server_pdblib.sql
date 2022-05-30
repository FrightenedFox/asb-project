-- connection with PDBLIB    
alter session set container = PDBLIB;
show con_name;

-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;


-- ### Own database ### --

-- Grant user all necessary permissions
grant connect, resource, create session, create view, alter session, create sequence, create synonym,
    create database link, unlimited tablespace to lib_user identified by lib_user;

-- Create tablespace for PDBLIB
create tablespace lib_tablespace
    datafile '/home/oracle/Documents/tablespace/lib_tablespace.dbf' size 100M
    autoextend on next 10M maxsize 5G
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
    );

-- Create temporary tablespace for PDBLIB
create temporary tablespace lib_temp_tablespace
    tempfile '/home/oracle/Documents/tablespace/lib_temp_tablespace.dbf' size 500 M
    reuse extent management local uniform size 10 M;
