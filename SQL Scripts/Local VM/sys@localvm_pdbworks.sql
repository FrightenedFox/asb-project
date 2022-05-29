-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;


-- ### Unplug/Plug PDB migration ### --

-- Check that users and data are present
select * from SYS.DBA_USERS where USERNAME like '%WORKS%' order by EXPIRY_DATE desc;
select * from HUMANRESOURCES_ADVENTUREWORKS2019.DEPARTMENT;
select * from SALES_ADVENTUREWORKS2019.SALESORDERHEADER;
select * from SYS.USER_TABLESPACES where TABLESPACE_NAME like '%WORKS%';
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like 'ADV_WORKS%' or GRANTEE='C##GLOB_USR_WORKS';
select * from SYS.ROLE_SYS_PRIVS where ROLE='PDBWORKS_NORMAL_ROLE';
select * from SYS.DBA_PROFILES where PROFILE='PDBWORKS_USERS_PROFILE' order by RESOURCE_TYPE, RESOURCE_NAME;