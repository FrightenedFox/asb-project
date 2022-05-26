# Dziennik realizacji projektu

## Instalacja bazy danych

- W celu umożliwienia jednoczesnej pracy nad projektem został przygotowany stary komputer, który będzie występować w roli serwera. Na tym komputerze został zainstalowany  system operacyjny Red Hat Enterprise Linux 8.
- Na serwerze zainstalowano system bazodanowy Oracle Database 21c Express Edition. 
- Połączenie z serwerem nawiązano za pomocą słuchacza bazy danych protokołu SSH.
- Postanowiono realizować projekt używając trzech schematów baz danych, a mianowicie:
  - **AdventureWorks (AW)** - przykładowa baza danych systemu bazodanowego Microsoft SQL Serwer;
  - [**Sales History (SH)**](https://github.com/oracle-samples/db-sample-schemas)  - przykładowa baza danych systemu bazodanowego Oracle Database;
  - *Inny*...
- Zainstalowano system bazodanowy Microsoft SQL Serwer 2019 w celu przeprowadzenia migracji bazy danych AdventureWorks do systemu bazodanowego Oracle Database.
- Dla potrzeb migracji bazy danych AdventureWorks utworzono dwa kontenery: kontener migracyjny dla zapisywania wszystkich logów i metadanych oraz kontener docelowy.
- Skutecznie przeprowadzono migrację bazy danych AdventureWorks na kontener `PDBWORKS` za pośrednictwem narzędzia SQL Developer. W tym celu jednocześnie trzy systemy bazodanowe zostały połączone z programem SQL Developer: 
  1. SQL Serwer, na którym właśnie znajdowała się baza AdbentureWorks;
  2. System Oracle Database, postawiony na serwerze, który przyjmował przeniesioną bazę;
  3. System Oracle Database, postawiony na maszynie wirtualnej, który obsługiwał kontener migracyjny.
- Został usunięty zbędny kontener `XEPDB1`.
- Utworzono nowy kontener `PDBSH` w celu późniejszego zainstalowania na nim schematu Sales History (dalej SH).
- Utworzono przestrzenie tabel w kontenerach:
  - `SH_TABLESPACE` i `SH_TEMP_TABLESPACE` w kontenerze `PDBSH`;
  - `ADV_WORKS_TS` i `ADV_WORKS_TEMP_TS` w kontenerze `PDBWORKS`;
  - ...
- Pobrano i zainstalowano schemat SH na kontenerze `PDBSH`. Użyto instrukcji zaproponowanej w repozytorium [db-sample-schemas](https://github.com/oracle-samples/db-sample-schemas).
- Na kontenerze `PDBWORKS` utworzono:
  - dwie roli:
    - `PDBWORKS_ADMIN_ROLE`, która przejęła upoważnienia roli `IMP_FULL_DATABASE`;
    - `PDBWORKS_VIEWER_ROLE`, która pozwala tylko i wyłącznie na przeglądanie i komentowanie tabel;
  - profil `PDBWORKS_USERS_PROFILE`;
  - dwóch użytkowników lokalnych:
    - `ADV_WORKS_USER` z rolami `PDB_DBA`, `PDBWORKS_ADMIN_ROLE` i profilem `PDBWORKS_USERS_PROFILE`;
    - `ADV_WORKS_VIEWER` z rolą `PDBWORKS_VIEWER_ROLE` i profilem `PDBWORKS_USERS_PROFILE`.
- Na kontenerze `PDBSH` utworzono:
  - rolę `PDBSH_USER_ROLE`, która pozwala na edycję i przeglądanie wszystkich tabel na kontenerze;
  - profil `PDBSH_USERS_PROFILE`;
  - dwóch użytkowników lokalnych:
    - `SH_USER` z rolą `PDB_DBA` i profilem `PDBSH_USERS_PROFILE`;
    - `SH_SECOND_USER` z rolą `PDBSH_USER_ROLE` i profilem `PDBSH_USERS_PROFILE`.
- Utworzono użytkowników globalnych na kontenerze `CDB$ROOT`:
  - `C##GLOB_USR_SH`, który otrzymał rolę `PDBSH_USER_ROLE` na kontenerze `PDBSH` oraz 100M pamięci na przestrzeni tabel `SH_TABLESPACE` i dostęp do przestrzeni `SH_TEMP_TABLESPACE`;
  - `C##GLOB_USR_WORKS`, który otrzymał rolę `PDBWORKS_ADMIN_ROLE` na kontenerze `PDBWORKS` oraz 100M na przestrzeni tabel `ADV_WORKS_TS` i dostęp do przestrzeni `ADV_WORKS_TEMP_TS`;
  - ...
- Na końcu większości plików `.sql` przygotowano skrypty, które pozwalają sprawdzić wykonanie wymagań projektu.
- ...
