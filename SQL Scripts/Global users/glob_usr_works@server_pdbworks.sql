-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;





-- ### Check requirements on PDBWORKS for global user C##GLOB_USR_WORKS ### --

-- c##glob_usr_works HAS access to DBA (NO errors should appear):
select * from SYS.DBA_USERS;

-- c##glob_usr_works HAS access to Adventure Works (NO errors should appear):
select * from HUMANRESOURCES_ADVENTUREWORKS2019.DEPARTMENT;
select * from SALES_ADVENTUREWORKS2019.SALESORDERHEADER;

-- c##glob_usr_works has NO access to SH (an error SHOULD appear):
select * from SH.SALES FETCH FIRST 10 ROWS ONLY;

-- c##glob_usr_works HAS access to SYS (NO errors should appear):
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER like '%ADVENTUREWORKS2019%';

-- c##glob_usr_works HAS access to SYS, but on this container there are NO SH tables
-- (NO errors should appear, NO rows should be found):
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER='SH';

-- c##glob_usr_works CAN create tables (NO errors should appear):
create table UZYTKOWNICY_WORKS(
    imie varchar2(50),
    nazwisko varchar2(50)
);

-- c##glob_usr_works CAN insert into tables (NO errors should appear):
insert into UZYTKOWNICY_WORKS (imie, nazwisko)
values ('Agnieszka', 'Kowalska');
commit;

-- Check table UZYTKOWNICY_WORKS:
select * from UZYTKOWNICY_WORKS;

-- Tables created by c##glob_usr_works should be in ADV_WORKS_TS:
select OWNER, TABLE_NAME, TABLESPACE_NAME, STATUS
from SYS.ALL_TABLES
where TABLE_NAME = 'UZYTKOWNICY_WORKS';
