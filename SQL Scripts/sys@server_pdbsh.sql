-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Install Sales History example schema ### --

-- Grant user all necessary permissions
grant connect, resource, create session, create view, alter session, create sequence, create synonym,
    create database link, unlimited tablespace to sh_user identified by sh_user;

-- Create users tablespace in the PDBSH
create tablespace users
    datafile '/home/oracle/Documents/tablespace/users_tablespace.dbf' size 50M
    autoextend on next 1m maxsize 500m
    minimum extent 5k
    default storage (
    initial 10k
    next 10k
    pctincrease 0
    );

-- Create tablespace for PDBSH
create tablespace sh_tablespace
    datafile '/home/oracle/Documents/tablespace/sh_tablespace.dbf' size 100M
    autoextend on next 10M maxsize 5G
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
    );

-- Create temporary tablespace for PDBSH
create temporary tablespace sh_temp_tablespace
    tempfile '/home/oracle/Documents/tablespace/sh_temp_tablespace.dbf' size 500 M
    reuse extent management local uniform size 10 M;

-- Run SH script:
--      @sh_main *password* sh_tablespace temp *password*
--      /home/oracle/oracle_data_files/ /home/oracle/ora_log/ v3 localhost:1521/pdbsh

-- Check if the installation was successful
select * from sh.SALES FETCH FIRST 10 ROWS ONLY;

-- Set default and temporary tablespace to SH and SH_USER users
alter user SH
    default tablespace SH_TABLESPACE quota unlimited on SH_TABLESPACE
    temporary tablespace SH_TEMP_TABLESPACE;
alter user SH_USER
    default tablespace SH_TABLESPACE quota unlimited on SH_TABLESPACE
    temporary tablespace SH_TEMP_TABLESPACE;



-- ### Create the second local user in PDBSH container ### --

-- Turn on system limits for PDBSH container
alter system set resource_limit=true;

-- Create profile for PDBSH users
create profile pdbsh_users_profile limit
    sessions_per_user 10
    connect_time 240
    idle_time 90
    password_reuse_time 5
    password_reuse_max 10
    failed_login_attempts 13
    password_lock_time 1
    password_life_time 365
    password_grace_time 80;

-- Set pdbsh_users_profile to the SH_USER user
alter user SH_USER profile pdbsh_users_profile;

-- Create PDBSH user role
create role pdbsh_user_role;

-- Grant PDBSH user role necessary permissions
grant
    drop any context,   create any context,
    create any type,    alter any type,     drop any type,
    create any view,    drop any view,
    create any index,   drop any index,
    create any table,   delete any table,   alter any table,
    update any table,   insert any table,   select any table,
    comment any table,  drop any table,
    create session
    to pdbsh_user_role;

-- Create PDBSH user
create user SH_SECOND_USER
    identified by sh_second_user
    default tablespace SH_TABLESPACE
    temporary tablespace SH_TEMP_TABLESPACE
    quota 2G on SH_TABLESPACE
    profile pdbsh_users_profile
    account unlock;

-- Grant SH_SECOND_USER
grant pdbsh_user_role to SH_SECOND_USER;
alter user SH_SECOND_USER default role pdbsh_user_role;

-- Grant C##GLOB_USR_SH pdbsh_user_role
grant pdbsh_user_role to C##GLOB_USR_SH;

-- Give C##GLOB_USR_SH tablespace on PDBSH
alter user C##GLOB_USR_SH
    default tablespace SH_TABLESPACE
    quota 100M on SH_TABLESPACE
    temporary tablespace SH_TEMP_TABLESPACE;





-- ### Check requirements on PDBSH ### --

-- SH users:
select * from SYS.DBA_USERS where USERNAME like 'SH%';

-- SH tables:
select * from SH.SALES FETCH FIRST 10 ROWS ONLY;
select * from SH.COUNTRIES ORDER BY COUNTRY_NAME DESC;

-- SH tables tablespaces:
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER='SH';

-- SH_TABLESPACE parameters:
select * from SYS.USER_TABLESPACES where TABLESPACE_NAME like '%SH%';

-- SH users roles:
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like '%SH%';

-- PDBSH_USER_ROLE privileges:
select * from SYS.ROLE_SYS_PRIVS where ROLE='PDBSH_USER_ROLE';

-- PDBSH_USERS_PROFILE limits:
select * from SYS.DBA_PROFILES where PROFILE='PDBSH_USERS_PROFILE' order by RESOURCE_TYPE, RESOURCE_NAME;
