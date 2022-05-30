-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;

-- Open all containers
alter pluggable database PDBSH open read write;
alter pluggable database PDBWORKS open read write;
alter pluggable database PDBLIB open read write;

-- ### Migrate AdventureWorks2019 ### --

-- Create PDB for migrated DB
create pluggable database PDBWORKS
    admin user adv_works_user identified by adv_works_user roles=(DBA)
    file_name_convert=('pdbseed', 'pdbworks');

-- List current containers
select pdb_name, status from cdb_pdbs;
select name, open_mode from V$PDBS;

-- Open PDBWORKS
alter pluggable database PDBWORKS open read write;



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



-- ### Own database ### --

-- List all containers
select * from V$containers;

-- Create a new PDB for database LIBRARY
create pluggable database PDBLIB admin user lib_user identified by lib_user roles=(DBA)
    file_name_convert=('pdbseed', 'pdblib');

-- Open PDBSH
select name, open_mode from V$PDBS;
alter pluggable database PDBSH open read write;
select name, open_mode from V$PDBS;



-- ### Create global users ### --

-- Create the global user for PDBSH container
create user C##GLOB_USR_SH
    identified by glob_usr_sh
    account unlock;

-- Create the global user for PDBWORKS container
create user C##GLOB_USR_WORKS
    identified by glob_usr_works
    account unlock;

-- TODO: create third global user for the last container
-- Create the global user for ... container
create user C##GLOB_USR_LIB
     identified by glob_usr_lib
     account unlock;

-- Check whether new users exist
select * from SYS.DBA_USERS where USERNAME like '%GLOB_USR%';

-- TODO: finish for the third global user
-- Create grants for all users
grant create session to C##GLOB_USR_SH container=all;
grant create session to C##GLOB_USR_WORKS container=all;
grant create session to C##GLOB_USR_LIB container=all;



-- ### System parameter file ### --

-- Create pfile
create pfile = '/home/oracle/oracle_pfiles/pfileXE.ora'
    from spfile = '/opt/oracle/dbs/spfileXE.ora';

-- Select server parameters
select NAME, ISSYS_MODIFIABLE, ISINSTANCE_MODIFIABLE, ISSES_MODIFIABLE, VALUE
from V$PARAMETER
order by ISSES_MODIFIABLE desc;

-- Select NLS system, instance and session parameters
select DB.PARAMETER "Parameter name",
       DB.VALUE "Database",
       INS.VALUE "Instance",
       SES.VALUE "Session"
from SYS.NLS_DATABASE_PARAMETERS DB,
     SYS.NLS_INSTANCE_PARAMETERS INS,
     SYS.NLS_SESSION_PARAMETERS SES
where DB.PARAMETER = INS.PARAMETER(+)
  and DB.PARAMETER = SES.PARAMETER(+);

-- Change session parameters
alter session set NLS_TERRITORY=ESTONIA;
alter session set NLS_LANGUAGE=ESTONIAN;
alter session set NLS_DATE_FORMAT='YYYY-MM-DD';
alter session set NLS_DATE_LANGUAGE=ESTONIAN;

-- Change system parameters
alter system set PROCESSES=450 scope=spfile;
alter system set OPEN_CURSORS=450 scope=memory;
alter system set SGA_TARGET=1200000000 scope=memory;
alter system set SGA_MAX_SIZE=1200000000 scope=spfile;



-- ### Unplug/Plug PDB migration ### --

-- Create pdbworks.xml file by unplugging PDBWORKS container
alter pluggable database PDBWORKS close immediate;
alter pluggable database PDBWORKS unplug into '/home/oracle/oracle_pdbs/pdbworks.xml';
drop pluggable database PDBWORKS keep datafiles;

-- Plug PDBWORKS container back
create pluggable database PDBWORKS using '/home/oracle/oracle_pdbs/pdbworks.xml' nocopy tempfile reuse;
alter pluggable database PDBWORKS open read write;





-- ### Check requirements on CDB$ROOT ### --

-- Containers:
select scdb.PDB_NAME, scdb.STATUS, vpdb.OPEN_MODE, vcon.OPEN_TIME, vcon.CREATION_TIME
from SYS.CDB_PDBS scdb,
     V$PDBS vpdb,
     V$CONTAINERS vcon
where scdb.PDB_NAME = vpdb.NAME
  AND scdb.PDB_NAME = vcon.NAME;

-- Global users:
select USERNAME, USER_ID, ACCOUNT_STATUS, EXPIRY_DATE, CREATED
from SYS.DBA_USERS
where USERNAME like 'C##%';

-- Check NLS server parameters
select TO_DATE('23-11-2022', 'dd-mm-yyyy') from dual;
select TO_NUMBER('123,456.78', '9G999999D99', 'NLS_NUMERIC_CHARACTERS=''.,''') from dual;
select TO_TIMESTAMP('10-SEP-02 14:10:10.123000','DD-MON-RR HH24:MI:SS.FF', 'NLS_DATE_LANGUAGE = American') from dual;
SELECT TO_CHAR(73231.23, 'L099G999D99') from dual;
select NAME, VALUE from V$PARAMETER where NAME in ('processes', 'sga_target', 'open_cursors');
