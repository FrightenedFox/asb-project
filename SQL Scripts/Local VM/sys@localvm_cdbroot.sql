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
