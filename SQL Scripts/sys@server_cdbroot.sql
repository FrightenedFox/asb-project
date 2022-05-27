-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;

-- Open all containers
alter pluggable database PDBSH open read write;
alter pluggable database PDBWORKS open read write;



-- ### Migrate AdventureWorks2019 ### --

-- Create PDB for migrated DB
create pluggable database PDBWORKS
    admin user adv_works_user identified by adv_works_user roles=(DBA)
    file_name_convert=('pdbseed', 'pdbworks');

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
-- create user C##GLOB_USR_
--     identified by psswd
--     account unlock;

-- Check whether new users exist
select * from SYS.DBA_USERS where USERNAME like '%GLOB_USR%';

-- TODO: finish for the third global user
-- Create grants for all users
grant create session to C##GLOB_USR_SH container=all;
grant create session to C##GLOB_USR_WORKS container=all;
-- grant create session to C##GLOB_USR_ container=all;



-- ### System parameter file ### --
create pfile = '/home/oracle/oracle_pfiles/pfileXE.ora' from spfile = '/opt/oracle/dbs/spfileXE.ora';




-- ### Check requirements ### --

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

