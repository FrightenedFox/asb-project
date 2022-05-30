-- connection with PDBLIB    
-- alter session set container = PDBLIB;
-- show con_name;

-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Own database ### --

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

-- Turn on system limits for PDBLIB container
alter system set resource_limit=true;

-- Create profile for PDBLIB administrators
create profile pdblib_users_profile limit
    sessions_per_user 21
    connect_time 200
    idle_time 100
    password_reuse_time 3
    password_reuse_max 11
    failed_login_attempts 23
    password_lock_time 1
    password_life_time 320
    password_grace_time 88;

-- Create PDBLIB admin role
create role pdblib_admin_role;

-- Create PDBLIB user role
create role pdblib_user_role;

-- Grant PDBLIB admin role necessary privileges
grant
    drop any context,   create any context,
    create any type,    alter any type,     drop any type,
    create any view,    drop any view,
    create any index,   drop any index,
    create any table,   delete any table,   alter any table,
    update any table,   insert any table,   select any table,
    comment any table,  drop any table,
    create session
    to pdblib_admin_role;

-- Grant PDBLIB user role necessary privileges
grant connect,  resource, create session, create view, alter session, create sequence, create synonym,
    create database link to pdblib_user_role;

-- Create PDBLIB admin
create user LIB_ADMIN
    identified by lib_admin
    default tablespace LIB_TABLESPACE
    temporary tablespace LIB_TEMP_TABLESPACE
    quota 2G on LIB_TABLESPACE
    profile pdblib_users_profile
    account unlock;

-- Create PDBLIB user
create user LIB_USER
    identified by lib_user
    default tablespace LIB_TABLESPACE
    temporary tablespace LIB_TEMP_TABLESPACE
    quota 2G on LIB_TABLESPACE
    profile pdblib_users_profile
    account unlock;

-- Grant privileges to LIB_ADMIN
grant pdblib_admin_role to LIB_ADMIN with admin option;
alter user LIB_ADMIN default role pdblib_admin_role;

-- Grant privileges to LIB_USER
grant pdblib_user_role to LIB_USER;
alter user LIB_USER default role pdblib_user_role;

-- Grant C##GLOB_USR_LIB pdblib_user_role
grant pdblib_user_role to C##GLOB_USR_LIB;

-- Give C##GLOB_USR_SH tablespace on pdblib
alter user C##GLOB_USR_LIB
    default tablespace LIB_TABLESPACE
    quota 100M on LIB_TABLESPACE
    temporary tablespace LIB_TEMP_TABLESPACE;





-- ### Check requirements on PDBLIB ### --

-- PDBLIB users:
select * from SYS.DBA_USERS where USERNAME like '%LIB%';

-- TODO: LIB tables:

-- TODO: LIB tables tablespaces:
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER like '%LIB%';

-- LIB_TABLESPACE parameters:
select * from SYS.USER_TABLESPACES where TABLESPACE_NAME like '%LIB%';

-- LIB users roles:
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like '%LIB%';

-- PDBSH_USER_ROLE privileges:
select * from SYS.ROLE_SYS_PRIVS where ROLE='PDBLIB_USER_ROLE';

-- PDBSH_USERS_PROFILE limits:
select * from SYS.DBA_PROFILES where PROFILE='PDBLIB_USERS_PROFILE' order by RESOURCE_TYPE, RESOURCE_NAME;