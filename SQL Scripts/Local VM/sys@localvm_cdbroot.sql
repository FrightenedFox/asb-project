show user;
show con_name;

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





