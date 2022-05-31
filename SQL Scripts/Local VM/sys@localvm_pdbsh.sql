-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Check requirements on PDBSH ### --

-- SH users:
select * from SYS.DBA_USERS where USERNAME like '%SH%';


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
