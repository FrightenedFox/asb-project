-- Print user
select user from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;





-- ### Check requirements on PDBSH for global user C##GLOB_USR_SH ### --

-- c##glob_usr_sh has NO access to DBA (an error SHOULD appear):
select * from SYS.DBA_USERS;

-- c##glob_usr_sh HAS access to SH (NO errors should appear):
select * from SH.SALES FETCH FIRST 10 ROWS ONLY;
select * from SH.COUNTRIES ORDER BY COUNTRY_NAME DESC;

-- c##glob_usr_sh has NO access to Adventure Works (an error SHOULD appear):
select * from SALES_ADVENTUREWORKS2019.SALESORDERHEADER;

-- c##glob_usr_sh HAS access to SYS (NO errors should appear):
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER='SH';

-- c##glob_usr_sh HAS access to SYS, but on this container there are NO Adventure Works tables
-- (NO errors should appear, NO rows should be found):
select OWNER, TABLE_NAME, TABLESPACE_NAME from SYS.ALL_TABLES where OWNER like '%ADVENTUREWORKS2019%';

-- c##glob_usr_sh CAN create tables (NO errors should appear):
create table PRACOWNICY_SH(
    imie varchar2(50),
    nazwisko varchar2(50)
);

-- c##glob_usr_sh CAN insert into tables (NO errors should appear):
insert into PRACOWNICY_SH (imie, nazwisko)
values ('Jan', 'Kowalski');
commit;

-- Check table PRACOWNICY_SH:
select * from PRACOWNICY_SH;

-- Tables created by c##glob_usr_sh should be in SH_TABLESPACE:
select OWNER, TABLE_NAME, TABLESPACE_NAME, STATUS
from SYS.ALL_TABLES
where TABLE_NAME = 'PRACOWNICY_SH';
