-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;

-- Print all users
select * from all_users;



-- ### Migrate AdventureWorks2019 ### --

-- Check if the migration was successful
select * from HUMANRESOURCES_ADVENTUREWORKS2019.DEPARTMENT;



-- ### Create users, roles and profiles ### --

-- Create adv_works_ts for Adventure Works users
create tablespace adv_works_ts
    datafile '/home/oracle/Documents/tablespace/adv_works_ts.dbf' size 50M
    autoextend on next 5M maxsize 1G
    minimum extent 1M
    default storage (
    initial 2M
    next 2M
    pctincrease 0
    );

-- Create temporary tablespace for Adventure Works users
create temporary tablespace adv_works_temp_ts
    tempfile '/home/oracle/Documents/tablespace/adv_works_temp_ts.dbf' size 100 M
    reuse extent management local uniform size 10 M;

-- Set adv_works_ts and adv_works_temp_ts as default tablespaces for adv_works_user
alter user ADV_WORKS_USER
    default tablespace ADV_WORKS_TS quota UNLIMITED on ADV_WORKS_TS
    temporary tablespace ADV_WORKS_TEMP_TS;

-- Turn on system limits for this container
alter system set resource_limit=true;

-- Create profile for PDBWORKS users
create profile pdbworks_users_profile limit
    sessions_per_user 5
    connect_time 120
    idle_time 60
    password_reuse_time 3
    password_reuse_max 7
    failed_login_attempts 9
    password_lock_time 1
    password_life_time 300
    password_grace_time 60;

-- Set pdbworks_users_profile to ADV_WORKS_USER
alter user ADV_WORKS_USER profile pdbworks_users_profile;

-- Create PDBWORKS admin role
create role pdbworks_admin_role;

-- Grant PDBWORKS admin user role necessary permissions
grant IMP_FULL_DATABASE to pdbworks_admin_role with admin OPTION;

-- Create PDBWORKS viewer role
create role pdbworks_normal_role;

-- Grant PDBWORKS admin role necessary permissions
grant
    select any table,
    comment any table,
    create session
    to pdbworks_normal_role;

-- Create PDBWORKS viewer user
create user adv_works_viewer
    identified by adv_works_viewer
    default tablespace adv_works_ts
    temporary tablespace adv_works_temp_ts
    quota unlimited on adv_works_ts
    profile pdbworks_users_profile
    account unlock;

-- Grant appropriate permissions to different users
grant pdbworks_admin_role to ADV_WORKS_USER;
alter user ADV_WORKS_USER default role pdbworks_admin_role;
grant pdbworks_normal_role to ADV_WORKS_VIEWER;
alter user ADV_WORKS_VIEWER default role pdbworks_normal_role;
-- ADV_WORKS_USER can do basically everything,
-- while ADV_WORKS_VIEWER can only view tables and comment them.

-- Grant C##GLOB_USR_WORKS
grant pdbworks_admin_role to C##GLOB_USR_WORKS;

-- Give C##GLOB_USR_WORKS tablespace on PDBSH
alter user C##GLOB_USR_WORKS
    default tablespace ADV_WORKS_TS
    quota 100M on ADV_WORKS_TS
    temporary tablespace ADV_WORKS_TEMP_TS;







-- ### Check requirements ### --

-- ADVENTURE WORKS users:
select * from SYS.DBA_USERS where USERNAME like '%ADV%' order by EXPIRY_DATE desc;

-- ADVENTURE WORKS tables:
select * from HUMANRESOURCES_ADVENTUREWORKS2019.DEPARTMENT;
select * from SALES_ADVENTUREWORKS2019.SALESORDERHEADER;

-- ADVENTURE WORKS tablespace parameters:
select * from SYS.USER_TABLESPACES where TABLESPACE_NAME like '%WORKS%';

-- ADVENTURE WORKS users roles:
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like 'ADV_WORKS%' or GRANTEE='C##GLOB_USR_WORKS';

-- PDBWORKS_NORMAL_ROLE privileges:
select * from SYS.ROLE_SYS_PRIVS where ROLE='PDBWORKS_NORMAL_ROLE';

-- PDBWORKS_USERS_PROFILE limits:
select * from SYS.DBA_PROFILES where PROFILE='PDBWORKS_USERS_PROFILE' order by RESOURCE_TYPE, RESOURCE_NAME;
