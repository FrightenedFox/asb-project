# Dziennik realizacji projektu

`[XXXX]` - ID zrzutu ekranu, który odpowiada temu punktu realizacji projektu.

## Instalacja bazy danych

- `[screen from server]` W celu umożliwienia jednoczesnej pracy nad projektem został przygotowany stary komputer, który
  będzie występować w roli serwera. Na tym komputerze został zainstalowany system operacyjny Red Hat Enterprise Linux 8.

- Na serwerze
  [zainstalowano](https://docs.oracle.com/en/database/oracle/oracle-database/21/xeinl/installing-oracle-database-xe.html#GUID-728E4F0A-DBD1-43B1-9837-C6A460432733)
  system bazodanowy Oracle Database 21c Express Edition.

- `[0300]` Połączenie z serwerem nawiązano za pomocą słuchacza bazy danych protokołu SSH.

- Postanowiono realizować projekt używając trzech schematów baz danych, a mianowicie:
    - `[002*]` **AdventureWorks (AW)** - przykładowa baza danych systemu bazodanowego Microsoft SQL Serwer;
    - [**Sales History (SH)**](https://github.com/oracle-samples/db-sample-schemas)  - przykładowa baza danych systemu
      bazodanowego Oracle Database;
    - **Biblioteka** - baza danych zrobiona na zajęciach projektowych na przedmiocie "Bazy Danych" na semestrze III

## Migracja **Advanture Works**

- `[0010]` Zainstalowano system bazodanowy Microsoft SQL Serwer 2019 w celu przeprowadzenia migracji bazy danych
  AdventureWorks do systemu bazodanowego Oracle Database.

- `[0060-0121]` Dla potrzeb migracji bazy danych AdventureWorks utworzono dwa kontenery: kontener migracyjny dla
  zapisywania wszystkich logów i metadanych oraz kontener docelowy.

- `[0030-0050, 0130-0150]` Skutecznie przeprowadzono migrację bazy danych AdventureWorks na kontener `PDBWORKS` za
  pośrednictwem narzędzia SQL Developer. W tym celu jednocześnie trzy systemy bazodanowe zostały połączone z programem
  SQL Developer:
    1. SQL Serwer, na którym właśnie znajdowała się baza AdventureWorks;
    2. System Oracle Database, postawiony na serwerze, który przyjmował przeniesioną bazę;
    3. System Oracle Database, postawiony na maszynie wirtualnej, który obsługiwał kontener migracyjny.

## Oracle Sample **Sales History**

- `[031*]` Utworzono nowy kontener `PDBSH` w celu późniejszego zainstalowania na nim schematu Sales History (dalej SH).

- `[0160-0190]` Pobrano i zainstalowano schemat SH na kontenerze `PDBSH`. Użyto instrukcji zaproponowanej w
  repozytorium [db-sample-schemas](https://github.com/oracle-samples/db-sample-schemas). Dokonano skutecznego połączenia
  się z kontenerem `PDBSH`.

## Own database **Biblioteka**

- Utworzono kontener `PDBLIB` dla zainstalowania własnego schematu Biblioteka.

- `[0420-0430]` Utworzono tabele schematu bazodanowego *Biblioteka*. Wygenerowano diagram relacyjnej bazy danych.

## Users, tablespaces, profiles and roles

- Utworzono przestrzenie tabel w kontenerach:
    - `[032*]` `ADV_WORKS_TS` i `ADV_WORKS_TEMP_TS` w kontenerze `PDBWORKS`;
    - `[033*]` `SH_TABLESPACE` i `SH_TEMP_TABLESPACE` w kontenerze `PDBSH`;
    - `[0410]` `LIB_TABLESPACE` i `LIB_TEMP_TABLESPACE` w kontenerze `PDBLIB`;

- `[034*]` Na kontenerze `PDBWORKS` utworzono:
    - dwie roli:
        - `PDBWORKS_ADMIN_ROLE`, która przejęła upoważnienia roli `IMP_FULL_DATABASE`;
        - `PDBWORKS_VIEWER_ROLE`, która pozwala tylko i wyłącznie na przeglądanie i komentowanie tabel;
    - profil `PDBWORKS_USERS_PROFILE`;
    - dwóch użytkowników lokalnych:
        - `ADV_WORKS_USER` z rolami `PDB_DBA`, `PDBWORKS_ADMIN_ROLE` i profilem `PDBWORKS_USERS_PROFILE`;
        - `ADV_WORKS_VIEWER` z rolą `PDBWORKS_VIEWER_ROLE` i profilem `PDBWORKS_USERS_PROFILE`.

- `[035*]` Na kontenerze `PDBSH` utworzono:
    - rolę `PDBSH_USER_ROLE`, która pozwala na edycję i przeglądanie wszystkich tabel na kontenerze;
    - profil `PDBSH_USERS_PROFILE`;
    - dwóch użytkowników lokalnych:
        - `SH_USER` z rolą `PDB_DBA` i profilem `PDBSH_USERS_PROFILE`;
        - `SH_SECOND_USER` z rolą `PDBSH_USER_ROLE` i profilem `PDBSH_USERS_PROFILE`.

- `[040*]` Na kontenerze `PDBLIB` utworzono:
    - dwie roli:
        - `PDBLIB_ADMIN_ROLE`, która pozwala na edycję i przeglądanie wszystkich tabel na kontenerze;
        - `PDBLIB_USER_ROLE`, która pozwala przeglądać i minimalnie edytować parametry kontenera;
    - profil `PDBLIB_USERS_PROFILE`;
    - dwóch użytkowników lokalnych:
        - `LIB_ADMIN` z rolą `PDBLIB_ADMIN_ROLE` i profilem `PDBLIB_USERS_PROFILE`;
        - `LIB_USER` z rolą `PDBLIB_USER_ROLE` i profilem `PDBLIB_USERS_PROFILE`.

- `[0460]` Utworzono użytkowników globalnych na kontenerze `CDB$ROOT`:
    - `C##GLOB_USR_SH`, który otrzymał rolę `PDBSH_USER_ROLE` na kontenerze `PDBSH` oraz 100M pamięci na przestrzeni
      tabel `SH_TABLESPACE` i dostęp do przestrzeni `SH_TEMP_TABLESPACE`;
    - `C##GLOB_USR_WORKS`, który otrzymał rolę `PDBWORKS_ADMIN_ROLE` na kontenerze `PDBWORKS` oraz 100M na przestrzeni
      tabel `ADV_WORKS_TS` i dostęp do przestrzeni `ADV_WORKS_TEMP_TS`;
    - `C##GLOB_USR_LIB`, który otrzymał rolę `PDBLIB_USER_ROLE` na kontenerze `PDBLIB` oraz 100M na przestrzeni
      tabel `LIB_TABLESPACE` i dostęp do przestrzeni `LIB_TEMP_TABLESPACE`.

- `[036*]` Na końcu większości plików `.sql` przygotowano skrypty, które pozwalają sprawdzić wykonanie wymagań projektu.

## Konfiguracja `listener.ora`, `tnsnames.ora`, `pfileXE` i parametrów NLS

- `[037*]` Przygotowano aliasy listenerów dla każdego kontenera. Utworzono nowe pliki `listener.ora` i `tnsnames.ora`.
  Każdy kontener otrzymał osobny port listenera:

  | Kontener   | Port  |
        | :--------: | :---: |
  | `CDB$ROOT` | 1521  |
  | `PDBWORKS` | 57001 |
  | `PDBSH`    | 57002 |
  | `PDBLIB`   | 57003 |

- `[038*]` Utworzono plik parametrów serwera `pfileXE.ora` jako kopię pliku `spfileXE.ora`. Przygotowano dwie wariacji
  pliku `pfileXE.ora`: `pfileXE1.ora` oraz `pfileXE2.ora`.

- `[039*]` Przygotowano skrypt dla sprawdzenia zmian parametrów NLS.

## Plug/Unplug

- `[0270]` Utworzono plik `pdbworks.xml` poprzez odpięcie kontenera `PDBWORKS`.

- `[028*]` Plik `pdbworks.xml` oraz pliki bazodanowe `*.dbf` zostały przeniesione do lokalnej maszyny wirtualnej.

- `[0290]` Kontener `PDBWORKS` został ponownie podłączony do bazy danych.

- `[021*]` Sprawdzono kompatybilność pliku `pdbworks.xml` z bazą danych na maszynie wirtualnej. Ponieważ wersja SZBD
  Oracle na serwerze wynosi 21.3.0, a na maszynie wirtualnej - 18.0.0, to niema możliwości podłączenia
  kontenera `PDBWORKS` do aktualnego systemu bazodanowego na maszynie wirtualnej.

- `[0220]` Zaktualizowano SZBD Oracle na maszynie wirtualnej do wersji 21.3.0. Tym razem plik `pdbworks.xml` już jest
  kompatybilny.

- `[023*]` Skutecznie utworzono nowy kontener `PDBWORKS` na maszynie wirtualnej używając pliku `pdbworks.xml`.

- `[0240-0252]` Otworzono kontener `PDBWORKS` na maszynie wirtualnej (`OPEN READ WRITE`) oraz sprawdzono integralność
  jego danych.

- `[044*]` Utworzono pliki metadanych `pdbsh.xml` i `pdblib.xml` poprzez odpięcie kontenerów `PDBSH` i `PDBLIB`.
  Wspomniany pliki oraz pliki bazodanowe `*.dbf` zostały przeniesione do lokalnej maszyny wirtualnej.

- `[045*]` Sprawdzono kompatybilność pliku metadanych `pdbsh.xml` z bazą danych na maszynie wirtualnej. Wszystko jest
  ok. Zatem skutecznie utworzono nowy kontener `PDBSH` na maszynie wirtualnej używając pliku `pdbsh.xml` oraz plików
  bazodanowych `*.dbf`. Otworzono kontener i sprawdzono integralność jego danych.

## TBD

- [X] Plug/Unplug all containers
- [X] Create `PDBLIB` and insert data
- [ ] Transfer new `tnsnames.ora` and `lisetener.ora`
- [ ] Prepare DataGrip connections with all users
