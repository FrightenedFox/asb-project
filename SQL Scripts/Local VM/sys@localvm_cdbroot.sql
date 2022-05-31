-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Create migration container and user ### -- 

create pluggable database PDBMIGRATE 
    admin user migrate_user identified by migrate_user roles=(DBA) 
    file_name_convert=('PDBSEED', 'PDBMIGRATE');

-- List PDBs
select pdb_name, status from cdb_pdbs;

-- Which PDBs are open
select name, open_mode from V$PDBS;

-- Open PDBMIGRATE database 
alter pluggable database PDBMIGRATE OPEN;

-- List PDBS    
select scdb.PDB_NAME, scdb.STATUS, vpdb.OPEN_MODE, vcon.OPEN_TIME, vcon.CREATION_TIME
from SYS.CDB_PDBS scdb,
     V$PDBS vpdb,
     V$CONTAINERS vcon
where scdb.PDB_NAME = vpdb.NAME
  AND scdb.PDB_NAME = vcon.NAME;

-- Grant migration user all necessary privileges
alter session set container=pdbmigrate;
show con_name;
grant connect, resource, create session, create view, alter session, create sequence, create synonym, 
create database link, unlimited tablespace to migrate_user identified by migrate_user;

-- Drop XEPDB1 
alter pluggable database xepdb1 close immediate;
alter pluggable database xepdb1 unplug into 'C:\Oracle\PDBs\xepdb1.xml';
drop pluggable database xepdb1 including datafiles;



-- ### Unplug/Plug PDB migration ### --

-- Check compatibility with pdbworks.xml file
SET SERVEROUTPUT ON;
DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
                pdb_descr_file => 'C:\Oracle\PDBs\pdbworks.xml',
                pdb_name       => 'PDBWORKS');

  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
/
select * from PDB_PLUG_IN_VIOLATIONS;

-- Create PDBWORKS database
CREATE PLUGGABLE DATABASE PDBWORKS USING 'C:\Oracle\PDBs\pdbworks.xml' 
SOURCE_FILE_NAME_CONVERT = ('/home/oracle/Documents/tablespace/', 'C:\Oracle\Tablespaces\', '/opt/oracle/oradata/XE/pdbworks/', 'C:\Oracle\Oradata\pdbworks\')
COPY
FILE_NAME_CONVERT = ('C:\Oracle\Tablespaces\', 'C:\app\User\product\21c\oradata\XE\pdbworks', 'C:\Oracle\Oradata\pdbworks\', 'C:\app\User\product\21c\oradata\XE\pdbworks');

-- Open PDBWORKS
alter pluggable database PDBWORKS open read write;

-- Check compatibility with pdbsh.xml file
SET SERVEROUTPUT ON;
DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
                pdb_descr_file => 'C:\Oracle\PDBs\pdbsh.xml',
                pdb_name       => 'PDBSH');

  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
/
select * from PDB_PLUG_IN_VIOLATIONS;

-- Create PDBSH database
CREATE PLUGGABLE DATABASE PDBSH USING 'C:\Oracle\PDBs\pdbsh.xml' 
SOURCE_FILE_NAME_CONVERT = ('/home/oracle/Documents/tablespace/', 'C:\Oracle\Tablespaces\', '/opt/oracle/oradata/XE/pdbsh/', 'C:\Oracle\Oradata\pdbsh\')
COPY
FILE_NAME_CONVERT = ('C:\Oracle\Tablespaces\', 'C:\app\User\product\21c\oradata\XE\pdbsh', 'C:\Oracle\Oradata\pdbsh\', 'C:\app\User\product\21c\oradata\XE\pdbsh');

-- Open PDBSH
alter pluggable database PDBSH open read write;
  
-- Check compatibility with pdblib.xml file
SET SERVEROUTPUT ON;
DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
                pdb_descr_file => 'C:\Oracle\PDBs\pdblib.xml',
                pdb_name       => 'PDBLIB');

  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
/
select * from PDB_PLUG_IN_VIOLATIONS;

-- Create PDBLIB database
CREATE PLUGGABLE DATABASE PDBLIB USING 'C:\Oracle\PDBs\pdblib.xml' 
SOURCE_FILE_NAME_CONVERT = ('/home/oracle/Documents/tablespace/', 'C:\Oracle\Tablespaces\', '/opt/oracle/oradata/XE/pdblib/', 'C:\Oracle\Oradata\pdblib\')
COPY
FILE_NAME_CONVERT = ('C:\Oracle\Tablespaces\', 'C:\app\User\product\21c\oradata\XE\pdblib', 'C:\Oracle\Oradata\pdblib\', 'C:\app\User\product\21c\oradata\XE\pdblib');

-- Open PDBLIB
alter pluggable database PDBLIB open read write;

-- List PDBS    
select scdb.PDB_NAME, scdb.STATUS, vpdb.OPEN_MODE, vcon.OPEN_TIME, vcon.CREATION_TIME
from SYS.CDB_PDBS scdb,
     V$PDBS vpdb,
     V$CONTAINERS vcon
where scdb.PDB_NAME = vpdb.NAME
  AND scdb.PDB_NAME = vcon.NAME;
