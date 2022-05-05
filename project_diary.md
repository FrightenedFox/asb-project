# Dziennik realizacji projektu

## Instalacja bazy danych

- W celu umożliwienia jednoczesnej pracy nad projektem został przygotowany stary komputer, który będzie występować w roli serwera. Na tym komputerze został zainstalowany  system operacyjny Red Hat Enterprise Linux 8.
- Na serwerze zainstalowano system bazodanowy Oracle Database 21c Express Edition. 
- Połączenie z serwerem nawiązano za pomocą słuchacza bazy danych protokołu SSH.
- Postanowiono realizować projekt używając trzech schematów baz danych, a mianowicie:
  - **AdventureWorks (AW)** - przykładowa baza danych systemu bazodanowego Microsoft SQL Serwer;
  - [**Sales History (SH)**](https://github.com/oracle-samples/db-sample-schemas)  - przykładowa baza danych systemu bazodanowego Oracle Database;
  - *Inne*...
- Zainstalowano system bazodanowy Microsoft SQL Serwer 2019 w celu przeprowadzenia migracji bazy danych AdventureWorks do systemu bazodanowego Oracle Database.
- Dla potrzeb migracji bazy danych AdventureWorks utworzono dwa kontenery: kontener migracyjny dla zapisywania wszystkich logów i metadanych oraz kontener docelowy.
- Skutecznie przeprowadzono migrację bazy danych AdventureWorks za pośrednictwem narzędzia SQL Developer. W tym celu jednocześnie trzy systemy bazodanowe zostały połączone z programem SQL Developer: 
  1. SQL Serwer, na którym właśnie znajdowała się baza AdbentureWorks;
  2. System Oracle Database, postawiony na serwerze, który przyjmował przeniesioną bazę;
  3. System Oracle Database, postawiony na maszynie wirtualnej, który obsługiwał kontener migracyjny.
- Został usunięty zbędny kontener XEPDB1.
- Utworzono nowy kontener PDBSH w celu późniejszego zainstalowania na nim schematu Sales History (dalej SH).
- Pobrano i zainstalowano schemat SH na kontenerze PDBSH. Użyto instrukcji zaporoponowanej w repozytorium [db-sample-schemas](https://github.com/oracle-samples/db-sample-schemas).
- ...
