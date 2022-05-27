## Server parameter files (PFILES)

Two server parameter files are prepared: `pfileXE1.ora` and `pfileXE2.ora`. They are located in
the `/home/oracle/oracle_pfiles` directory. 

To start the database using them, the following example may be helpful:

```oracle
shutdown;
-- If doesn't work for too long, use: shutdown immediate;
 
startup pfile='/home/oracle/oracle_pfiles/pfileXE1.ora';
```
