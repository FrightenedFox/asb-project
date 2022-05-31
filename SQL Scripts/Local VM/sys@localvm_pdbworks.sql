-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Check requirements on PDBWORKS ### --

-- ADVENTURE WORKS users:
select * from SYS.DBA_USERS where USERNAME like '%WORKS%' order by EXPIRY_DATE desc;

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
