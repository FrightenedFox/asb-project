-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;


-- ### Create migration container and user ### -- 

-- create pluggable database PDBMIGRATE 
-- admin user migrate_user identified by migrate_user roles=(DBA) 
-- file_name_convert=('PDBSEED', 'PDBMIGRATE');

select pdb_name, status from cdb_pdbs;
select name, open_mode from V$PDBS;
show pdbs;

-- alter pluggable database PDBMIGRATE OPEN;

show pdbs;

-- Grant migration user all necessary privileges
alter session set container=pdbmigrate;
show con_name;
grant connect, resource, create session, create view, alter session, create sequence, create synonym, 
create database link, unlimited tablespace to migrate_user identified by migrate_user;




-- ### Unplug/Plug PDB migration ### --

-- Check compatibility with pdbworks.xml file
--SET SERVEROUTPUT ON
--DECLARE
--  l_result BOOLEAN;
--BEGIN
--  l_result := DBMS_PDB.check_plug_compatibility(
--                pdb_descr_file => 'C:\Oracle\PDBs\pdbworks.xml',
--                pdb_name       => 'PDBWORKS');
--
--  IF l_result THEN
--    DBMS_OUTPUT.PUT_LINE('compatible');
--  ELSE
--    DBMS_OUTPUT.PUT_LINE('incompatible');
--  END IF;
--END;
--/
select * from PDB_PLUG_IN_VIOLATIONS;

-- Create PDBWORKS database
CREATE PLUGGABLE DATABASE PDBWORKS USING 'C:\Oracle\PDBs\pdbworks.xml' 
SOURCE_FILE_NAME_CONVERT = ('/home/oracle/Documents/tablespace/', 'C:\Oracle\Tablespaces\', '/opt/oracle/oradata/XE/pdbworks/', 'C:\Oracle\pdbworks\')
COPY
FILE_NAME_CONVERT = ('C:\Oracle\Tablespaces\', 'C:\app\User\product\21c\oradata\XE\pdbworks', 'C:\Oracle\pdbworks\', 'C:\app\User\product\21c\oradata\XE\pdbworks');

-- List PDBS    
select scdb.PDB_NAME, scdb.STATUS, vpdb.OPEN_MODE, vcon.OPEN_TIME, vcon.CREATION_TIME
from SYS.CDB_PDBS scdb,
     V$PDBS vpdb,
     V$CONTAINERS vcon
where scdb.PDB_NAME = vpdb.NAME
  AND scdb.PDB_NAME = vcon.NAME;

-- Open PDBWORKS
alter pluggable database PDBWORKS open read write;

