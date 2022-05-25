-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Migrate AdventureWorks2019 ### --

-- Create PDB for migrated DB
create pluggable database PDBWORKS
admin user adv_works_user identified by adv_works_user roles=(DBA)
file_name_convert=('pdbseed', 'pdbworks');

select pdb_name, status from cdb_pdbs;
select name, open_mode from V$PDBS;

-- Open PDBWORKS
alter pluggable database PDBWORKS open read write;

-- Grant user all necessary privileges
alter session set container=PDBWORKS;
select SYS_CONTEXT('userenv', 'con_name') "Container name";
grant connect, resource, create session, create view, alter session, create sequence, create synonym,
create database link, unlimited tablespace to adv_works_user identified by adv_works_user;



-- ### Install Sales History example schema ### --

-- List all containers
select * from V$containers;

-- Create new PDB for SH schema
create pluggable database PDBSH admin user sh_user identified by sh_user roles=(DBA)
file_name_convert=('pdbseed', 'pdbsh');

-- Open PDBSH
select  pdb_name, status from SYS.CDB_PDBS;
select name, open_mode from V$PDBS;
alter pluggable database PDBSH open read write;
select name, open_mode from V$PDBS;

-- Drop container XEPDB1
select * from V$containers;
alter pluggable database xepdb1 close immediate;
alter pluggable database xepdb1 unplug into 'home/oracle/Documents/xepdb1.xml';
drop pluggable database xepdb1 including datafiles;

-- Unlock SYSTEM user
ALTER USER SYSTEM ACCOUNT UNLOCK;



-- ### Create global users ###

-- Set default script security settings
alter session set "_ORACLE_SCRIPT"=true;

-- Turn on kernel resource limits
alter system set resource_limit=true;

-- Create main tablespace for future users
create tablespace glob_usr_ts
datafile '/home/oracle/Documents/tablespace/glob_usr_ts.dbf' size 50M
    autoextend on next 5M maxsize 500M
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
);

-- Create temporary tablespace for future users
create temporary tablespace glob_usr_temp_ts
    tempfile '/home/oracle/Documents/tablespace/glob_usr_temp_ts.dbf' size 200 M
    reuse extent management local uniform size 10 M;



-- NOTE: everything that follows is dropped
drop user c##glob_usr_1;
drop user c##glob_usr_2;
drop profile c##glob_usr_profile;
drop role c##glob_usr_role_1;
drop role c##glob_usr_role_2;



-- Create profile for global users
create profile c##glob_usr_profile limit
    sessions_per_user 5
    connect_time 120
    idle_time 60
    password_reuse_time 3
    password_reuse_max 7
    failed_login_attempts 9
    password_lock_time 1
    password_life_time 300
    password_grace_time 60;

-- Create roles for global users
create role c##glob_usr_role_1;
create role c##glob_usr_role_2;

-- Grant all necessary permissions
grant create any sql profile,
    drop any sql profile,   grant any object privilege,
    drop any context,       create any context,
    create any type,        alter any type,
    drop any type,          create profile,
    drop profile,           alter profile,
    alter database,         create any view,
    drop any view,          drop any index,
    create any index,       delete any table,
    create any table,       alter any table,
    update any table,       insert any table,
    select any table,       comment any table,
    drop any table,         drop tablespace,
    alter tablespace,       create tablespace,
    create session,         audit system
    to c##glob_usr_role_1 with admin option;
grant IMP_FULL_DATABASE to c##glob_usr_role_2;

-- Check the permissions are granted successfully
select * from ROLE_SYS_PRIVS where role='GLOB_USR_ROLE_1';
select * from ROLE_SYS_PRIVS where role='GLOB_USR_ROLE_2';
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like '%GLOB_USR_ROLE%';

-- Create global users
create user c##glob_usr_1
    identified by psswd
    default tablespace glob_usr_ts
    temporary tablespace glob_usr_temp_ts
    quota unlimited on glob_usr_ts
    profile c##glob_usr_profile
    account unlock;
create user c##glob_usr_2
    identified by psswd
    default tablespace glob_usr_ts
    temporary tablespace glob_usr_temp_ts
    quota 150M on glob_usr_ts
    profile c##glob_usr_profile
    account unlock
    container=all;

-- Grant roles to global users
grant c##glob_usr_role_1 to c##glob_usr_1 with admin option container=all;
grant c##glob_usr_role_2 to c##glob_usr_2 container=all;

-- Check granted roles
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like 'C##GLOB_USR_%';



-- ### Testing zone ###

create user c##glob_usr_1
    profile c##glob_usr_profile
    account unlock
    identified by glob;
grant create session to c##glob_usr_1 container=all;
connect sys/psswd as sysdba;
connect c##glob_usr_1/glob@localhost:1521/pdbworks;
alter session set "_ORACLE_SCRIPT"=true;

create user test_usr identified by tst;
drop user test_usr;
select * from dba_users where USERNAME like '%GLOB%';
select * from dba_profiles where PROFILE like '%GLOB%';
select * from SYS.DBA_TABLESPACES;
