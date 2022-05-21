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

-- List tablespaces
select * from dba_tablespaces;
select * from user_tablespaces;

-- List tables
select * from all_tables where owner='SYS';
