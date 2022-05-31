-- Print user
select user
from dual;

-- Print container
select SYS_CONTEXT('userenv', 'con_name') "Container name"
FROM DUAL;


-- ### Generate tables for Library database ### --

-- Create table Autor
CREATE TABLE Autor
(
    ID_AUTORA     varchar(255) NOT NULL PRIMARY KEY,
    IMIE          varchar(255) NOT NULL,
    NAZWISKO      varchar(255) NOT NULL,
    ROK_URODZENIA number
);

-- Create table Autorzy
CREATE TABLE Autorzy
(
    ID_ZESPOLU varchar(255) NOT NULL PRIMARY KEY,
    ID_AUTOROW varchar(255) NOT NULL
);

-- Create table Gatunek
CREATE TABLE Gatunek
(
    ID_GATUNKU    varchar(255) NOT NULL PRIMARY KEY,
    NAZWA_GATUNKU varchar(255) NOT NULL
);

-- Create table Wydawnictwo
CREATE TABLE Wydawnictwo
(
    ID_WYDAWNICTWA    varchar(255) NOT NULL PRIMARY KEY,
    NAZWA_WYDAWNICTWA varchar(255) NOT NULL
);

-- Create table Ksiazka
CREATE TABLE Ksiazka
(
    ID_KSIAZKI     NUMBER       NOT NULL PRIMARY KEY,
    TYTUL          varchar(255) NOT NULL,
    AUTOR          varchar(255),
    AUTORZY        varchar(255),
    DATA_WYDANIA   NUMBER       NOT NULL,
    GATUNEK        varchar(255) NOT NULL,
    WYDAWNICTWO    varchar(255) NOT NULL,
    RODZAJ_OKLADKI varchar(255) NOT NULL,
    LICZBA_STRON   NUMBER       NOT NULL
);

-- Create constraints for Ksiazka table
ALTER TABLE Ksiazka
    ADD CONSTRAINT "Gatunek FK" FOREIGN KEY (GATUNEK) REFERENCES Gatunek (ID_GATUNKU);
ALTER TABLE Ksiazka
    ADD CONSTRAINT "Wydawnictwo FK" FOREIGN KEY (WYDAWNICTWO) REFERENCES Wydawnictwo (ID_WYDAWNICTWA);
ALTER TABLE Ksiazka
    ADD CONSTRAINT "Autor FK" FOREIGN KEY (AUTOR) REFERENCES Autor (ID_AUTORA);
ALTER TABLE Ksiazka
    ADD CONSTRAINT "Autorzy FK" FOREIGN KEY (AUTORZY) REFERENCES Autorzy (ID_ZESPOLU);

-- Create table Czytelnik
CREATE TABLE Czytelnik
(
    ID_CZYTELNIKA   varchar(255) NOT NULL PRIMARY KEY,
    IMIE            varchar(255) NOT NULL,
    NAZWISKO        varchar(255) NOT NULL,
    EMAIL           varchar(255) NOT NULL UNIQUE,
    NR_TELEFONU     varchar(255) NOT NULL UNIQUE,
    ADRES           varchar(255) NOT NULL,
    DATA_DOLACZENIA DATE
);

-- Create constraints for Czytelnik table
ALTER TABLE CZYTELNIK
    ADD CONSTRAINT NR_TELEFONU CHECK (regexp_like(NR_TELEFONU, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'));
alter table CZYTELNIK
    drop constraint NR_TELEFONU;

-- Create table Bibliotekarz
CREATE TABLE Bibliotekarz
(
    ID_BIBLIOTEKARZA  varchar(255) NOT NULL PRIMARY KEY,
    IMIE              varchar(255) NOT NULL,
    NAZWISKO          varchar(255) NOT NULL,
    DATA_ZATRUDNIENIA DATE         NOT NULL
);

-- Create table Rejestr_wypozyczen
CREATE TABLE Rejestr_wypozyczen
(
    NR_ZAMOWIENIA                     varchar(255) NOT NULL PRIMARY KEY,
    ID_BIBLIOTEKARZA                  varchar(255) NOT NULL,
    ID_CZYTELNIKA                     varchar(255) NOT NULL,
    ID_KSIAZKI                        NUMBER       NOT NULL,
    DATA_WYPOZYCZENIA                 DATE,
    DOZWOLONY_OKRES_WYPOZYCZENIA_MIES NUMBER
);

-- Create constraints for table Rejestr_wypozycen
ALTER TABLE Rejestr_wypozyczen
    ADD CONSTRAINT "Bibliotekarz FK" FOREIGN KEY (ID_BIBLIOTEKARZA) REFERENCES BIBLIOTEKARZ (ID_BIBLIOTEKARZA);
ALTER TABLE Rejestr_wypozyczen
    ADD CONSTRAINT "Czytelnik FK" FOREIGN KEY (ID_CZYTELNIKA) REFERENCES CZYTELNIK (ID_CZYTELNIKA);
ALTER TABLE Rejestr_wypozyczen
    ADD CONSTRAINT "Ksiazka FK" FOREIGN KEY (ID_KSIAZKI) REFERENCES KSIAZKA (ID_KSIAZKI);



-- ### Insert data into Library database ### ---

-- Insert data into Autor table
insert all
    into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CD-1812', 'Charles', 'Dickens', 1812)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JT-1892', 'John Ronald Reuel', 'Tolkien', 1892)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AE-1900', 'Antoine', 'de Saint-Exupéry', 1900)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JK-1965', 'Joanne J.K', 'Rowling', 1965)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AC-1890', 'Agatha', 'Christie', 1890)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CX-1715', 'Cao', 'Xueqin', 1715)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CL-1898', 'Clive', 'Lewis', 1898)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('DB-1964', 'Daniel', 'Brown', 1900)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('NH-1883', 'Napoleon', 'Hill', 1883)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JS-1919', 'Jerome David', 'Salinger', 1919)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('PC-1947', 'Paulo', 'Coelho', 1947)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('EW-1899', 'Elwyn', 'White', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('VN-1899', 'Vladimir', 'Nabokov', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JM-1883', 'Johnston', 'McCulley', 1883)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AS-1820', 'Anna', 'Sewell', 1820)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('LM-1874', 'Lucy', 'Maud Montgomery', 1874)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JH-1929', 'Jack', 'Higgins', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CC-1937', 'Colleen', 'McCullough', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('MM-1900', 'Margaret', 'Marsh', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AF-1929', 'Anne', 'Frank', 1899)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AP-1970', 'Andrzej', 'Pikoń', 1970)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('MM-1980', 'Marcin', 'Moskala', 1980)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AB-1965', 'Alan', 'Beaulieu', 1965)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('MZ-1979', 'Mateusz', 'Żeromski', 1979)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('RH-1951', 'Rob', 'Halford', 1951)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('RM-1987', 'Remigiusz', 'Mróz', 1987)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('NB-1970', 'Natalia', 'De Barbaro', 1970)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JM-1981', 'Joseph', 'Murphy', 1981)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AM-1969', 'Agnieszka', 'Maciąg', 1969)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('RL-1965', 'Riley', 'Lucinda', 1965)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CH-1979', 'Coleen', 'Hoover', 1979)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JB-1978', 'Julia', 'Brylewska', 1978)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CR-1980', 'Cora', 'Reilly', 1980)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('BM-1951', 'Beata', 'Majewska', 1951)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('HM-1971', 'Heather', 'Morris', 1971)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CM-1991', 'Casey', 'McQuiston', 1991)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AA-1977', 'Agnieszka', 'Antosiewicz', 1977)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('ML-1982', 'Marta', 'Łabecka', 1982)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('PH-1987', 'Paulina', 'Hendel', 1987)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('HC-1970', 'Hania', 'Czaban', 1970)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('DR-1999', 'Dominik', 'Rupiński', 1999)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('WL-1995', 'Weronika', 'Łodyga', 1995)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('RD-1969', 'Rafał', 'Dębski', 1969)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('JN-1989', 'Jennifer', 'Niven', 1989)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('MZ-1971', 'Magdalena', 'Zarębska', 1971)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('RO-1903', 'George', 'Orwell', 1903)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('CC-1975', 'Conrad', 'Chavez', 1975)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('AF-1992', 'Andrew', 'Fulkner', 1992)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('WK-1905', 'Włodzimierz', 'Krysicki', 1905)
into AUTOR(ID_AUTORA, IMIE, NAZWISKO, ROK_URODZENIA)
VALUES ('WW-1962', 'Wiesław', 'Włodarski', 1962)
SELECT *
FROM AUTOR;

-- Insert data into Autorzy table
INSERT INTO AUTORZY(ID_ZESPOLU, ID_AUTOROW)
VALUES ('zesp-001', 'CC-1975, AF-1992');
INSERT INTO AUTORZY(ID_ZESPOLU, ID_AUTOROW)
VALUES ('zesp-002', 'CC-1905, AF-1962');

-- Insert data into Bibliotekarz table
insert all
    into BIBLIOTEKARZ(ID_BIBLIOTEKARZA, IMIE, NAZWISKO, DATA_ZATRUDNIENIA)
VALUES ('b-01', 'Adam', 'Żurek', TO_DATE('01.04.2010', 'dd.mm.yyyy'))
into BIBLIOTEKARZ(ID_BIBLIOTEKARZA, IMIE, NAZWISKO, DATA_ZATRUDNIENIA)
VALUES ('b-02', 'Maria', 'Żurek', TO_DATE('01.04.2010', 'dd.mm.yyyy'))
into BIBLIOTEKARZ(ID_BIBLIOTEKARZA, IMIE, NAZWISKO, DATA_ZATRUDNIENIA)
VALUES ('b-03', 'Anna', 'Kuśnierz', TO_DATE('12.09.2010', 'dd.mm.yyyy'))
into BIBLIOTEKARZ(ID_BIBLIOTEKARZA, IMIE, NAZWISKO, DATA_ZATRUDNIENIA)
VALUES ('b-04', 'Karolina', 'Kowalczyk', TO_DATE('12.09.2010', 'dd.mm.yyyy'))
into BIBLIOTEKARZ(ID_BIBLIOTEKARZA, IMIE, NAZWISKO, DATA_ZATRUDNIENIA)
VALUES ('b-05', 'Krzysztof', 'Moskwa', TO_DATE('01.10.2015', 'dd.mm.yyyy'))
select *
from bibliotekarz;

-- Insert data into Czytelnik table
insert all
    into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz1', 'Piotr', 'Kowalski', 'pkowalski@bd.pl', '123456789', 'Warszawa 5', TO_DATE('17.12.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz2', 'Anna', 'Nowak', 'anowak@bd.pl', '123456121', 'Warszawa 10', TO_DATE('21.01.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz3', 'Wojciech', 'Zieliński', 'wzielinski@bd.pl', '123456122', 'Warszawa 11',
        TO_DATE('09.05.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz4', 'Marcin', 'Wójcik', 'mwojcik@bd.pl', '123456124', 'Warszawa 12', TO_DATE('04.05.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz5', 'Matylda', 'Kamińska', 'mkaminska@bd.pl', '123456125', 'Warszawa 13',
        TO_DATE('01.02.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz6', 'Paweł', 'Wiśniewski', 'pwisniewski@bd.pl', '123456126', 'Warszawa 14',
        TO_DATE('08.05.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz7', 'Weronika', 'Kowalczyk', 'wkowalczyk@bd.pl', '123456127', 'Warszawa 15',
        TO_DATE('06.06.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz8', 'Angelika', 'Szymańska', 'aszymanska@bd.pl', '123456128', 'Warszawa 16',
        TO_DATE('27.06.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz9', 'Maria', 'Woźniak', 'mwozniak@bd.pl', '123456129', 'Warszawa 123', TO_DATE('28.03.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz10', 'Julia', 'Kozłowska', 'jkozlowska@bd.pl', '123456120', 'Warszawa 21',
        TO_DATE('01.02.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz11', 'Maciej', 'Dąbrowski', 'mdabrowski@bd.pl', '123556120', 'Warszawa 124',
        TO_DATE('05.02.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz12', 'Patrycja', 'Kaczmarek', 'pkaczmarek@bd.pl', '123556121', 'Warszawa 125',
        TO_DATE('06.06.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz13', 'Monika', 'Krawczyk', 'mkrawczyk@bd.pl', '123556122', 'Warszawa 135',
        TO_DATE('08.09.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz14', 'Piotr', 'Mazur', 'pmazur@bd.pl', '123556123', 'Warszawa 136', TO_DATE('19.02.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz15', 'Hanna', 'Wysocka', 'hwysocka@bd.pl', '123556124', 'Warszawa 137', TO_DATE('06.07.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz16', 'Antoni', 'Wojciechowski', 'awojciechowski@bd.pl', '123556125', 'Warszawa 143',
        TO_DATE('04.12.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz17', 'Laura', 'Mikołajczyk', 'lmikolajczyk@bd.pl', '123556126', 'Warszawa 144',
        TO_DATE('07.08.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz18', 'Maja', 'Lewandowska', 'mlewandowska@bd.pl', '123556127', 'Warszawa 145',
        TO_DATE('09.09.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz19', 'Zofia', 'Zając', 'zzajac@bd.pl', '123556128', 'Warszawa 148', TO_DATE('18.03.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz20', 'Zuzanna', 'Jabłońska', 'zjablonska@bd.pl', '123556129', 'Warszawa 149',
        TO_DATE('16.08.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz21', 'Oliwia', 'Wróbel', 'owrobel@bd.pl', '123656130', 'Warszawa 150', TO_DATE('05.09.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz22', 'Alicja', 'Król', 'akrol@bd.pl', '123656131', 'Warszawa 151', TO_DATE('06.12.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz23', 'Laura', 'Majewska', 'lmajewska@bd.pl', '123656132', 'Warszawa 157',
        TO_DATE('25.07.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz24', 'Oliwier', 'Malinowski', 'omalinowski@bd.pl', '123656133', 'Warszawa 158',
        TO_DATE('12.12.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz25', 'Filip', 'Adamczyk', 'fadamczyk@bd.pl', '123656134', 'Warszawa 159',
        TO_DATE('09.11.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz26', 'Franciszek', 'Nowicki', 'fnowicki@bd.pl', '123656135', 'Warszawa 165',
        TO_DATE('07.08.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz27', 'Aleksander', 'Dudek', 'adudek@bd.pl', '123656136', 'Warszawa 166', TO_DATE('09.09.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz28', 'Mikołaj', 'Górski', 'mgorski@bd.pl', '123656137', 'Warszawa 167', TO_DATE('06.03.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz29', 'Stanisław', 'Pawlak', 'spawlak@bd.pl', '123656138', 'Warszawa 172',
        TO_DATE('29.02.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz30', 'Szymon', 'Olszewski', 'solszewski@bd.pl', '123656139', 'Warszawa 173',
        TO_DATE('25.05.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz31', 'Jakub', 'Jaworski', 'jjaworski@bd.pl', '123656140', 'Warszawa 174',
        TO_DATE('04.04.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz32', 'Jan', 'Stępień', 'jstepien@bd.pl', '123656141', 'Warszawa 179', TO_DATE('03.10.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz33', 'Adam', 'Sikora', 'asikora@bd.pl', '123656142', 'Warszawa 180', TO_DATE('02.11.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz34', 'Zbigniew', 'Walczak', 'zwalczak@bd.pl', '123656143', 'Warszawa 181',
        TO_DATE('08.08.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz35', 'Marek', 'Baran', 'mbaran@bd.pl', '123656144', 'Warszawa 185', TO_DATE('09.12.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz36', 'Mariusz', 'Szewczyk', 'mszewczyk@bd.pl', '123656145', 'Warszawa 186',
        TO_DATE('08.07.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz37', 'Michał', 'Tomaszewski', 'mtomaszewski@bd.pl', '123656146', 'Warszawa 187',
        TO_DATE('05.11.2020', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz38', 'Mateusz', 'Zalewski', 'mzalewski@bd.pl', '123656147', 'Warszawa 190',
        TO_DATE('26.10.2019', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz39', 'Bartosz', 'Pietrzak', 'bpietrzak@bd.pl', '123656148', 'Warszawa 191',
        TO_DATE('17.02.2018', 'dd.mm.yyyy'))
into CZYTELNIK(ID_CZYTELNIKA, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ADRES, DATA_DOLACZENIA)
VALUES ('cz40', 'Natalia', 'Marciniak', 'nmarciniak@bd.pl', '123656149', 'Warszawa 192',
        TO_DATE('28.09.2019', 'dd.mm.yyyy'))
select *
from CZYTELNIK;

-- Insert data into Gatunek table
insert all
    into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-001', 'powieść historyczna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-002', 'powieść high fantasy')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-003', 'powiastka filozoficzna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-004', 'powieść kryminalna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-005', 'powieść science-fiction')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-006', 'rozwój osobisty')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-007', 'powieść fantasy')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-008', 'powieść sensacyjna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-009', 'poradnik psychologiczny')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-010', 'powieść psychologiczna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-011', 'powieść fantastyczna')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-012', 'romans')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-013', 'powieść')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-014', 'powieść obyczajowa')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-015', 'powieść dziecięca')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-016', 'autobiografia')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-017', 'informatyka')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-018', 'thriller')
into GATUNEK(ID_GATUNKU, NAZWA_GATUNKU)
VALUES ('gat-019', 'powieść młodzieżowa')
select *
from GATUNEK;

-- Insert data into Wydawnictwo table
insert all
    into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-001', 'GERG')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-002', 'Muza S.A')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-003', 'Iskry')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-004', 'Media Rodzina')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-005', 'Dolnośląskie')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-006', 'Penguin Classic')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-007', 'Czytelnik')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-008', 'Sonia Draga')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-009', 'Zysk i S-ka')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-010', 'Helion')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-011', 'GREG')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-012', 'Gandalf')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-013', 'Czwarta Strona')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-014', 'Wydawnictwo Agora')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-015', 'Świat Książki')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-016', 'Wydawnictwo Otwarte')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-017', 'Wydawnictwo Albatros')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-018', 'Wydawnictwo NieZwykłe')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-019', 'Miraż')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-020', 'Marginesy')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-021', 'Prószyński i S-ka')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-022', 'Editio')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-023', 'We needYa')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-024', 'Ya!')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-025', 'Young')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-026', 'Jaguar')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-027', 'Bukowy Las')
into WYDAWNICTWO(ID_WYDAWNICTWA, NAZWA_WYDAWNICTWA)
VALUES ('wyd-028', 'Nowa Baśń')
SELECT *
from wydawnictwo;

-- Insert data into Ksiazka table
insert all
    into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (1, 'Opowieść o dwóch miastach', 'CD-1812', NULL, 1859, 'gat-001', 'wyd-002', 'twarda', 1425)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (2, 'Władca Pierścieni', 'JT-1892', NULL, 1955, 'gat-002', 'wyd-002', 'twarda', 1435)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (3, 'Hobbit, czyli tam i z powrotem', 'JT-1892', NULL, 1937, 'gat-002', 'wyd-003', 'miękka', 280)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (4, 'Mały Książę', 'AE-1900', NULL, 1943, 'gat-003', 'wyd-011', 'miękka', 96)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (5, 'Harry Potter i Kamień Filozoficzny', 'JK-1965', NULL, 1997, 'gat-007', 'wyd-004', 'twarda', 328)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (6, 'I nie było już nikogo', 'AC-1890', NULL, 1939, 'gat-004', 'wyd-005', 'miękka', 216)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (7, 'Sen czerwonego pawilonu', 'CX-1715', NULL, 1791, 'gat-001', 'wyd-006', 'miękka', 384)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (9, 'Lew, czarownica i stara szafa', 'CL-1898', NULL, 1950, 'gat-007', 'wyd-004', 'miękka', 182)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (10, 'Kod Leonarda da Vinci', 'DB-1964', NULL, 2003, 'gat-008', 'wyd-008', 'twarda', 568)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (11, 'Myśl i bogać się. Jak zrealizować ambicje i osiągnąć sukces', 'NH-1883', NULL, 2006, 'gat-009', 'wyd-009',
        'miękka', 400)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (12, 'Buszujący w zbożu', 'JS-1919', NULL, 1951, 'gat-010', 'wyd-001', 'twarda', 425)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (13, 'Alchemik', 'PC-1947', NULL, 1988, 'gat-003', 'wyd-003', 'miękka', 280)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (14, 'Harry Potter i Komnata Tajemnic', 'JK-1965', NULL, 1998, 'gat-007', 'wyd-011', 'miękka', 624)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (15, 'Harry Potter i więzień Azkabanu', 'JK-1965', NULL, 1998, 'gat-007', 'wyd-004', 'twarda', 328)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (16, 'Harry Potter i Zakon Feniksa', 'JK-1965', NULL, 2003, 'gat-007', 'wyd-004', 'miękka', 216)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (17, 'Pajęczyna Szarloty', 'EW-1899', NULL, 1952, 'gat-011', 'wyd-006', 'miękka', 384)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (18, 'Lolita', 'VN-1899', NULL, 1955, 'gat-012', 'wyd-007', 'twarda', 363)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (19, 'The Curse of Capistrano', 'JM-1883', NULL, 1919, 'gat-013', 'wyd-004', 'miękka', 182)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (20, 'Czarny Książę', 'AS-1820', NULL, 1877, 'gat-012', 'wyd-008', 'twarda', 468)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (21, 'Ania z Zielonego Wzgórza', 'LM-1874', NULL, 1908, 'gat-015', 'wyd-008', 'twarda', 368)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (22, 'Orzeł wylądował', 'JH-1929', NULL, 1975, 'gat-008', 'wyd-008', 'twarda', 156)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (23, 'Ptaki ciernistych krzewów', 'CC-1937', NULL, 1977, 'gat-012', 'wyd-008', 'twarda', 268)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (24, 'Przeminęło z wiatrem', 'MM-1900', NULL, 1936, 'gat-012', 'wyd-011', 'twarda', 550)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (25, 'Dziennik Anne Frank', 'AF-1929', NULL, 1947, 'gat-016', 'wyd-004', 'miękka', 182)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (26, 'AutoCAD 2021 PL', 'AP-1970', NULL, 2021, 'gat-017', 'wyd-010', 'miękka', 240)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (27, 'JavaScript od podstaw', 'MM-1980', NULL, 2021, 'gat-017', 'wyd-012', 'miękka', 290)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (28, 'Wyznanie. Autobiografia wokalisty Judas Priest', 'RH-1951', NULL, 2021, 'gat-016', 'wyd-002', 'miękka',
        430)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (29, 'Wprowadzenie do SQL, Jak generować, pobierać i obsługiwać dane', 'AB-1965', NULL, 2021, 'gat-017',
        'wyd-010', 'miękka', 336)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (30, 'Agile &Scrum', 'MZ-1979', NULL, 2021, 'gat-017', 'wyd-010', 'miękka', 208)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (31, 'Wybaczam ci', 'RM-1987', NULL, 2020, 'gat-018', 'wyd-013', 'miękka', 258)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (32, 'Czuła przewodniczka. Kobieca droga do siebie', 'NB-1970', NULL, 2018, 'gat-006', 'wyd-014', 'miękka', 209)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (33, 'Potęga podświadomości', 'JM-1981', NULL, 2009, 'gat-006', 'wyd-015', 'miękka', 352)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (34, 'Dobrostan. O szczęśliwym, bogatym i spełnionym życiu', 'AM-1969', NULL, 2011, 'gat-006', 'wyd-016',
        'miękka', 276)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (35, 'Zaginiona siostra. Siedem sióstr', 'RL-1965', NULL, 2013, 'gat-014', 'wyd-017', 'miękka', 286)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (36, 'It Ends with Us', 'CH-1979', NULL, 2021, 'gat-012', 'wyd-016', 'miękka', 368)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (37, 'Maybe Someday', 'CH-1979', NULL, 2021, 'gat-012', 'wyd-016', 'miękka', 384)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (38, 'Layla', 'CH-1979', NULL, 2021, 'gat-012', 'wyd-016', 'miękka', 336)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (39, 'Maybe Now. Maybe Not', 'CH-1979', NULL, 2021, 'gat-012', 'wyd-016', 'miękka', 464)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (40, 'Hopeless', 'CH-1979', NULL, 2021, 'gat-012', 'wyd-016', 'miękka', 384)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (41, 'Devil. Inferno.', 'JB-1978', NULL, 2021, 'gat-012', 'wyd-018', 'miękka', 354)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (42, 'Złączeni honorem', 'CR-1980', NULL, 2019, 'gat-012', 'wyd-016', 'miękka', 285)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (43, 'Jego wróg', 'BM-1951', NULL, 2022, 'gat-012', 'wyd-019', 'miękka', 432)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (44, 'Trzy siostry', 'HM-1971', NULL, 2021, 'gat-001', 'wyd-020', 'miękka', 430)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (45, 'Red, White & Royal Blue', 'CM-1991', NULL, 2021, 'gat-001', 'wyd-021', 'miękka', 476)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (46, 'Mądre bajki', 'AA-1977', NULL, 2021, 'gat-015', 'wyd-011', 'twarda', 64)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (47, 'Flaw(less). Opowiedz mi naszą historię', 'ML-1982', NULL, 2022, 'gat-019', 'wyd-022', 'miękka', 344)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (48, 'Wisielcza Góra', 'PH-1987', NULL, 2021, 'gat-019', 'wyd-023', 'miękka', 456)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (49, 'Cały ten czas', 'HC-1970', NULL, 2022, 'gat-019', 'wyd-023', 'miękka', 408)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (50, 'So sweet challenge', 'DR-1999', NULL, 2021, 'gat-019', 'wyd-024', 'miękka', 208)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (51, 'Hurt/Comfort', 'WL-1995', NULL, 2020, 'gat-019', 'wyd-025', 'miękka', 424)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (52, 'Gniazdo. Żelazny kruk.', 'RD-1969', NULL, 2020, 'gat-019', 'wyd-026', 'miękka', 288)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (53, 'Wszystkie jasne miejsca', 'JN-1989', NULL, 2015, 'gat-019', 'wyd-027', 'miękka', 424)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (54, 'Będziesz serca biciem', 'MZ-1971', NULL, 2021, 'gat-019', 'wyd-028', 'miękka', 300)
into KSIAZKA(ID_KSIAZKI, TYTUL, AUTOR, AUTORZY, DATA_WYDANIA, GATUNEK, WYDAWNICTWO, RODZAJ_OKLADKI, LICZBA_STRON)
VALUES (55, 'Rok 1984', 'RO-1903', NULL, 2021, 'gat-005', 'wyd-011', 'miękka', 312)
select *
from ksiazka;

-- Insert data into Rejestr Wypozyczen table
insert all
    into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                            dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0001', 'b-05', 'cz5', 10, TO_DATE('12.12.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0002', 'b-02', 'cz14', 53, TO_DATE('30.11.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0003', 'b-01', 'cz32', 14, TO_DATE('10.12.2021', 'dd.mm.yyyy'), 12)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0004', 'b-02', 'cz32', 32, TO_DATE('15.12.2021', 'dd.mm.yyyy'), 3)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0005', 'b-05', 'cz40', 16, TO_DATE('11.12.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0006', 'b-05', 'cz40', 45, TO_DATE('11.12.2021', 'dd.mm.yyyy'), 3)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0007', 'b-02', 'cz40', 2, TO_DATE('11.12.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0008', 'b-03', 'cz34', 54, TO_DATE('10.01.2022', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0009', 'b-04', 'cz1', 33, TO_DATE('10.01.2022', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0010', 'b-05', 'cz39', 13, TO_DATE('11.01.2021', 'dd.mm.yyyy'), 12)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0011', 'b-01', 'cz28', 33, TO_DATE('11.01.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0012', 'b-04', 'cz39', 12, TO_DATE('11.01.2021', 'dd.mm.yyyy'), 12)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0013', 'b-03', 'cz22', 54, TO_DATE('11.01.2021', 'dd.mm.yyyy'), 6)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0014', 'b-01', 'cz9', 13, TO_DATE('11.01.2021', 'dd.mm.yyyy'), 12)
into rejestr_wypozyczen(nr_zamowienia, id_bibliotekarza, id_czytelnika, id_ksiazki, data_wypozyczenia,
                        dozwolony_okres_wypozyczenia_mies)
VALUES ('NR-0015', 'b-03', 'cz14', 46, TO_DATE('15.01.2021', 'dd.mm.yyyy'), 6)
select *
from rejestr_wypozyczen;

-- Commit
commit;