## Database users credentials

|        Login        |      Password      |
|:-------------------:|:------------------:|
|  `C##GLOB_USR_SH`   |   `glob_usr_sh`    |
| `C##GLOB_USR_WORKS` |   `glob_usr_sh`    |
|        `SH`         | _Oracle Password_  |
|      `SH_USER`      |     `sh_user`      |
|  `SH_SECOND_USER`   |  `sh_second_user`  |
|  `ADV_WORKS_USER`   |  `adv_works_user`  |
| `ADV_WORKS_VIEWER`  | `adv_works_viewer` |

## Server parameter files (PFILES)

Two server parameter files are prepared: `pfileXE1.ora` and `pfileXE2.ora`. They are located in
the `/home/oracle/oracle_pfiles` directory. 

To start the database using them, the following example may be helpful:

```oracle
shutdown;
-- If doesn't work for too long, use: shutdown immediate;
 
startup pfile='/home/oracle/oracle_pfiles/pfileXE1.ora';
```