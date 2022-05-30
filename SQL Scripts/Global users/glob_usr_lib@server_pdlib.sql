-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;





-- ### Check requirements on PDBLIB for global user C##GLOB_USR_LIB ### --

-- c##glob_usr_lib has NO access to DBA (an error SHOULD appear):
select * from SYS.DBA_USERS;

-- TODO: select from PDBLIB tables -> c##glob_usr_lib HAS access to LIB (NO errors should appear):

-- c##glob_usr_lib has NO access to Adventure Works or SH (an error SHOULD appear):
select * from SALES_ADVENTUREWORKS2019.SALESORDERHEADER;
select * from SH.COUNTRIES;

-- c##glob_usr_lib HAS access to SYS (NO errors should appear):
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER like '%LIB%';

-- c##glob_usr_lib HAS access to SYS, but on this container there are NO Adventure Works or SH tables
-- (NO errors should appear, NO rows should be found):
select OWNER, TABLE_NAME, TABLESPACE_NAME
from SYS.ALL_TABLES
where OWNER like '%ADVENTUREWORKS2019%'
   or OWNER like '%SH%';


-- c##glob_usr_lib CAN create tables (NO errors should appear):
create table STUDENCI_LIB(
    imie varchar2(50),
    nazwisko varchar2(50)
);

-- c##glob_usr_sh CAN insert into tables (NO errors should appear):
insert into STUDENCI_LIB (imie, nazwisko)
values ('Jakub', 'Nowak');
commit;

-- Check table PRACOWNICY_SH:
select * from STUDENCI_LIB;

-- Tables created by c##glob_usr_sh should be in LIB_TABLESPACE:
select OWNER, TABLE_NAME, TABLESPACE_NAME, STATUS
from SYS.ALL_TABLES
where TABLE_NAME = 'STUDENCI_LIB';

-- Drop table STUDENCI_LIB
drop table STUDENCI_LIB;
