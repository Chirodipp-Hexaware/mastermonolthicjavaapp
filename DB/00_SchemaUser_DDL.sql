Alter Session set "_ORACLE_SCRIPT"=TRUE;
CREATE user ORA_MIGRA 
IDENTIFIED BY wordpass account unlock;

GRANT create session TO ORA_MIGRA;
grant create type to ORA_MIGRA;
grant create sequence to ORA_MIGRA;
grant create table to ORA_MIGRA;
grant create view to ORA_MIGRA;
grant create materialized view to ORA_MIGRA;
GRANT CREATE PROCEDURE to ORA_MIGRA;
GRANT unlimited tablespace to ORA_MIGRA;
grant dba to ORA_MIGRA;

