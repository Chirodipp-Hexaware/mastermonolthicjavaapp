
  CREATE OR REPLACE NONEDITIONABLE FUNCTION ORA_MIGRA.GET_FULL_NAME (emp_id in number) RETURN Varchar2 IS
lv_full_name Varchar2(50):= Null;
Begin
Select First_name||' '||Last_name 
Into lv_full_name
from employees 
Where Employee_id=emp_id;
return lv_full_name;
Exception
When No_data_found Then
Return 'Invalid Id';
When Others Then
Return 'Error';
End get_full_name;
/

  CREATE OR REPLACE NONEDITIONABLE FUNCTION ORA_MIGRA.SAMPLE_JAVA_PROC RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'JavaProcSample.quote() return java.lang.String';
/

  CREATE OR REPLACE NONEDITIONABLE FUNCTION ORA_MIGRA.GET_VERANSTRAUM_SEKTOR (
AVeranstRaumId VERANST_RAUM.ID%type
) RETURN varchar AS
-- -----------------------------------------------------------------------------
-- Ermittelt den Sektor eines V-Raums aus den zugeordneten BAGS-RÄUMEN
-- -----------------------------------------------------------------------------
s RAUM.SEKTOR%type;
BEGIN
  SELECT min(RM.SEKTOR) into s
  FROM VERANST_RAUM V, RAUM_IN_VERANST_RAUM R, RAUM RM
  WHERE V.ID = R.VERANST_RAUM_ID
  AND V.ETAGE_ID = R.ETAGE_ID
  AND RM.ID = R.RAUM_ID
  AND RM.ETAGEID = R.ETAGE_ID
  AND v.ID = AVeranstRaumId
  and RM.SEKTOR IS not null;
return s;
exception when no_data_found then
    return null;
END;
/

  CREATE OR REPLACE NONEDITIONABLE FUNCTION ORA_MIGRA.ETAGENSORTIERFOLGE (
  iETAGENNUMMER IN VARCHAR2 )
RETURN number IS
/* 28.6.99 von Eckelmann; bei leeren Sortierfolge wird 99 zurückgegeben
   29.6.99 Rje/Eckelmann return number statt varchar2
*/
cursor c1(cETAGENNUMMER IN VARCHAR2) is
   SELECT sortierfolge
   FROM
      etagennummern
   WHERE
      etagennummer = cEtagennummer;
iSortierfolge etagennummern.sortierfolge%type;
BEGIN
   open c1(ietagennummer);
   fetch c1 into iSortierfolge;
   if c1%notfound or iSortierfolge is null then
     iSortierfolge := 99;
   end if;
   close c1;
   RETURN(isortierfolge);
END;
/

/*

DROP FUNCTION ORA_MIGRA.GET_FULL_NAME ;
DROP FUNCTION ORA_MIGRA.SAMPLE_JAVA_PROC ;
DROP FUNCTION ORA_MIGRA.GET_VERANSTRAUM_SEKTOR ;
DROP FUNCTION ORA_MIGRA.ETAGENSORTIERFOLGE ;

*/

