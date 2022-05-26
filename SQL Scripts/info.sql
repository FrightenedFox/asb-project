-- Get username
select user
from dual;

-- Get container name
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;

-- Get info about tablespaces
select df.tablespace_name,
       df.file_name,
       df.size_mb,
       f.free_mb,
       df.max_size_mb,
       f.free_mb + (df.max_size_mb - df.size_mb) as max_free_mb
from (select file_id,
             file_name,
             tablespace_name,
             trunc(bytes / 1024 / 1024)                     as size_mb,
             trunc(greatest(bytes, maxbytes) / 1024 / 1024) as max_size_mb
      from SYS.DBA_DATA_FILES) df,
     (select trunc(sum(BYTES) / 1024 / 1024) as free_mb,
             file_id
      from SYS.DBA_FREE_SPACE
      group by file_id) f
where df.FILE_ID = f.FILE_ID (+)
order by df.TABLESPACE_NAME,
         df.FILE_NAME;

-- List users
select * from SYS.DBA_USERS;

-- List tablespaces
select * from SYS.DBA_TABLESPACES;
select * from SYS.USER_TABLESPACES;

-- List tables
select * from SYS.ALL_TABLES where OWNER='SYS';

-- List all possible privileges
select * from SYS.SESSION_PRIVS order by PRIVILEGE;

-- List roles
select * from SYS.DBA_ROLE_PRIVS where GRANTEE like 'ADV_W%';
select * from SYS.DBA_SYS_PRIVS where GRANTEE like 'ADV_W%';

-- List role privileges
select * from SYS.ROLE_SYS_PRIVS where ROLE like 'PDBWORKS_%';
select * from SYS.ROLE_TAB_PRIVS where ROLE like 'PDBWORKS_%';

-- List profile limits
select * from SYS.DBA_PROFILES where PROFILE='PDBSH_USERS_PROFILE' order by RESOURCE_TYPE, RESOURCE_NAME;