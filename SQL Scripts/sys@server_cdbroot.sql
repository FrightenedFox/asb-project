-- Print user and container
select user from dual;
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;



-- ### Migrate AdventureWorks2019 ### --

-- Create PDB for migrated DB
create pluggable database PDBWORKS
admin user adv_works_user identified by adv_works_user roles=(DBA)
file_name_convert=('pdbseed', 'pdbworks');

select pdb_name, status from cdb_pdbs;
select name, open_mode from V$PDBS;

-- Open PDBWORKS
alter pluggable database PDBWORKS open read write;

-- Grant user all necessary privileges
alter session set container=pdbworks;
show con_name;
grant connect, resource, create session, create view, alter session, create sequence, create synonym,
create database link, unlimited tablespace to adv_works_user identified by adv_works_user;



-- ### Add Sales History example scheme ### --

-- List all containers
select * from V$containers;

-- Create new PDB for SH scheme
create pluggable database PDBSH admin user sh_user identified by sh_user roles=(DBA)
file_name_convert=('pdbseed', 'pdbsh');

-- Open PDBSH
select  pdb_name, status from SYS.CDB_PDBS;
select name, open_mode from V$PDBS;
alter pluggable database PDBSH open read write;
select name, open_mode from V$PDBS;

-- Drop container XEPDB1
-- (paste code here, please)

-- Unlock SYSTEM user
ALTER USER SYSTEM ACCOUNT UNLOCK;
