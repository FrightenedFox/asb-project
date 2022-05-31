-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



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