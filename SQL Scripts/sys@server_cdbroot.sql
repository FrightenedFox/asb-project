show user;
show con_name;

-- ### Create PDB for migrated DB ### --

-- create pluggable database PDBWORKS
-- admin user adv_works_user identified by adv_works_user roles=(DBA) 
-- file_name_convert=('pdbseed', 'pdbworks');

select pdb_name, status from cdb_pdbs;
select name, open_mode from V$PDBS;
show pdbs;

-- alter pluggable database PDBWORKS open;

show pdbs;

-- Grant user all necessary privileges 
alter session set container=pdbworks;
show con_name;
grant connect, resource, create session, create view, alter session, create sequence, create synonym, 
create database link, unlimited tablespace to adv_works_user identified by adv_works_user;
