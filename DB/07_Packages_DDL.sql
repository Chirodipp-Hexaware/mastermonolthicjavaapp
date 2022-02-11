
CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.EMP_SAL AS 
   PROCEDURE find_sal(e_id EMPLOYEES.EMPLOYEE_ID%type); 
END emp_sal;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.EMP_SAL AS  
   
   PROCEDURE find_sal(e_id EMPLOYEES.EMPLOYEE_ID%TYPE) IS 
   e_sal EMPLOYEES.SALARY%TYPE; 
   BEGIN 
      SELECT SALARY INTO e_sal 
      FROM EMPLOYEES 
      WHERE EMPLOYEE_ID = e_id; 
      -- create temp table
      /*
        create a new table here      
      */
      dbms_output.put_line('Salary: '|| e_sal); 
   END find_sal; 
END emp_sal; 
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.PCK_ABRECHNUNG AS
-- RJE 23.07.2015 angelegt.

function Storno_fuer_Leist_faellig_JN ( p_Leistung_ID in BESTELL_POSITION.Leistung_ID%type,
                                        p_Bestellung_Id in BESTELL_POSITION.Bestellung_id%type)
                                           return varchar2;
function Storno_fuer_V_Raum_faellig_JN (p_Veranst_Raum_ID in BESTELLUNG.VERANST_RAUM_ID%type,
                                        p_Best_Beginn_Termin in BESTELLUNG.Beginn_Termin%type)
                                           return varchar2;
function Calc_V_Raum_Best_Preis_Storno (p_Veranst_Raum_ID in VERANST_RAUM.ID%type,
                                       p_Bestell_Beginn_Termin in bestellung.beginn_Termin%type,
                                       p_Bestell_Ende_Termin in bestellung.ende_Termin%type) return number;


function Get_V_Raum_Best_Preis_Normal (p_Veranst_Raum_ID in bestellung.VERANST_RAUM_ID%type,
                                       p_Bestell_Beginn_Termin in bestellung.beginn_Termin%type,
                                       p_Bestell_Ende_Termin in bestellung.ende_Termin%type) return number;


end;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.PCK_ABRECHNUNG AS
-- RJE 23.07.2015 Funktionen zur Preis- und Stornoberechnung
-- RJe 29.07.2015 überarbeitet
-- Rje 30.07.2015 Storno_fuer_Leist_faellig_JN überarbeitet
 
function Storno_fuer_Leist_faellig_JN ( p_Leistung_ID in BESTELL_POSITION.Leistung_ID%type,
                                        p_Bestellung_Id in BESTELL_POSITION.Bestellung_id%type)
                                           return varchar2 as
-- RJE 23.07.2015 Neu angelegt.
-- RJe 30.07.2015 Falls BEGINN_STORNOZEIT null ist, ist der Stornozeitpunkt egal, und es wird Storno fällig.
-- Aufruf ist NUR zum Stornierungszeitpunkt einer Leistung sinnvoll, weil sysdate
--   Prüft NUR ob für diese Bestell_Position Stornogebühren fällig werden bei der Stornierung.
--   Falls ja, darf die Bestell_Position nicht gelöscht werden, und die Stornogebühren müssen eingetragen werden.
--   Wird von Bestell_Position Trigger beim Statuswechsel aufgerufen, deshalb kann hier mit sysdate gearbeitet werden.
-- Stornogebühr ist fällig falls:
--      die Bestellung bestätigt ist
--      bei der Leistung eine Stornogebuehr eingetragen ist
--      (der Stornierungszeitpunkt innerhalb des Stornierungszeitraums liegt
--           oder BEGINN_STORNOZEIT null ist)
-- Rückgabewert: J: Stornogebühr ist fällig; N: keine Stornogebühr fällig.
--
  v_STORNOGEBUEHR leistung.STORNOGEBUEHR%type;
  v_BEGINN_STORNOZEIT leistung.BEGINN_STORNOZEIT%type;
  v_Bestell_BEGINN_TERMIN bestellung.BEGINN_TERMIN%type;
  v_Bestell_Bestaet_Status bestellung.Bestaet_Status%type;

  -- In welchem Bestellungs-Status wird eine Stornogebühr fällig:
  c_Bestell_Bestaet_Status_ST_J  bestellung.Bestaet_Status%type := 'J';

  v_RetVal varchar2(1);

  v_Meld_Wo varchar2(10);

begin
   -- Per Default N zurückgeben
   v_RetVal := 'N';
   v_Meld_Wo := 'AA';
   select l.STORNOGEBUEHR, l.BEGINN_STORNOZEIT into v_STORNOGEBUEHR, v_BEGINN_STORNOZEIT
      from leistung l where l.id = p_Leistung_ID;

   v_Meld_Wo := 'BB';
   select b.BEGINN_TERMIN, b.Bestaet_Status into v_Bestell_BEGINN_TERMIN, v_Bestell_Bestaet_Status
      from bestellung b where b.id = p_Bestellung_Id;

   v_Meld_Wo := 'CC';
   if v_Bestell_Bestaet_Status = c_Bestell_Bestaet_Status_ST_J then
     v_Meld_Wo := 'DD';
     -- Falls v_STORNOGEBUEHR NULL ist, wird KEINE Stornogebühr verlangt!
     if v_STORNOGEBUEHR is NOT null then
        v_Meld_Wo := 'D1';
        if v_BEGINN_STORNOZEIT is NULL then
           v_Meld_Wo := 'D2';
           -- Storno ist fällig
           v_RetVal := 'J';
        else
          -- Prüfen ob wir im Stornozeitraum liegen
          --    v_BEGINN_STORNOZEIT ist in Stunden
          if sysdate + (v_BEGINN_STORNOZEIT/24) > v_Bestell_BEGINN_TERMIN then
             v_Meld_Wo := 'D2';
             v_RetVal := 'J';
          end if;
        end if;  -- v_BEGINN_STORNOZEIT is NULL
     end if;
   end if;
   return v_RetVal;

 exception
     when no_data_found then
        raise_application_error(-20606, 'Fehler no_data in Function PCK_Abrechnung.Storno_fuer_Leist_faellig_JN (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
         return 'N';
    when others then
        raise_application_error(-20607, 'Fehler in Function PCK_Abrechnung.Storno_fuer_Leist_faellig_JN (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
        return 'N';
 end Storno_fuer_Leist_faellig_JN;
 -- ******************************************************************************************
function Storno_fuer_V_Raum_faellig_JN (p_Veranst_Raum_ID in BESTELLUNG.VERANST_RAUM_ID%type,
                                        p_Best_Beginn_Termin in BESTELLUNG.Beginn_Termin%type)
                                           return varchar2 as
-- RJE 23.07.2015 Neu angelegt.
-- Aufruf ist NUR zum Stornierungszeitpunkt eines Veranstaltungsraumes
-- (=Bestellung zu einem Veranst-Raum) sinnvoll, weil sysdate verwendet wird.
--   Prüft NUR ob für diese V_Raum_Bestellung Stornogebühren fällig werden bei der Stornierung.
--   Wird von Bestellung Trigger beim Statuswechsel aufgerufen, deshalb kann hier mit sysdate gearbeitet werden.
-- Stornogebühr ist fällig falls:
--      VERANST_RAUM.STORNOGEBUEHR (=Prozentwert) is not null
--        Falls VERANST_RAUM.STORNOZEITRAUM gefüllt ist, muss der Stornierungszeitpunkt darin liegen.
--        Falls VERANST_RAUM.STORNOZEITRAUM NICHT gefüllt ist, fallen unabhängig vom
--                  Zeitraum Stornogebühren an.
-- Rückgabewert: J: Stornogebühr ist fällig; N: keine Stornogebühr fällig.
--
  v_V_Raum_Stornogebuehr        VERANST_RAUM.STORNOGEBUEHR%type;
  v_V_Raum_Stornozeitraum       VERANST_RAUM.STORNOZEITRAUM%type;



  v_RetVal varchar2(1);

  v_Meld_Wo varchar2(10);

    begin
   -- Per Default N zurückgeben
   v_RetVal := 'N';
   v_Meld_Wo := 'AA';
   select vr.STORNOGEBUEHR, vr.STORNOZEITRAUM into v_V_Raum_Stornogebuehr, v_V_Raum_Stornozeitraum
      from VERANST_RAUM vr where vr.id = p_Veranst_Raum_ID;

   v_Meld_Wo := 'BB';
   -- NUR falls VERANST_RAUM.STORNOGEBUEHR is NOT NULL können Stornogebühren anfallen:
   if v_V_Raum_Stornogebuehr is NOT null then
      v_Meld_Wo := 'CC';
      -- Gilt eine Zeitraum Logik?
      if v_V_Raum_Stornozeitraum is NOT null then
         v_Meld_Wo := 'DD';
         -- Zeitraumlogik, also prüfen, ob gerade eben (sysdate) Stornogebühren fällig werden:
         -- v_V_Raum_Stornozeitraum wird in TAGEN angegeben, deshalb ein trunc(sysdate)
         if trunc(sysdate) between (p_Best_Beginn_Termin - v_V_Raum_Stornozeitraum) and p_Best_Beginn_Termin then
            v_Meld_Wo := 'EE';
            --Stornozeit innerhalb Stornozeitraum
            v_RetVal := 'J';
         else
            v_Meld_Wo := 'FF';
            v_RetVal := 'N';
         end if;
      else
         -- Keine Zeitraum-Logik für die Stornogebühr, also wird Stornogebühr fällig:
         v_Meld_Wo := 'GG';
         v_RetVal := 'J';
      end if;
      v_Meld_Wo := 'HH';
   else
      v_Meld_Wo := 'II';
      v_RetVal := 'N';
   end if;

   return v_RetVal;

 exception
     when no_data_found then
        raise_application_error(-20606, 'Fehler NO_DATA in Function PCK_Abrechnung.Storno_fuer_V_Raum_faellig_JN (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
         return 'N';
    when others then
        raise_application_error(-20607, 'Fehler in Function PCK_Abrechnung.Storno_fuer_V_Raum_faellig_JN (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
        return 'N';
 end Storno_fuer_V_Raum_faellig_JN;
-- ******************************************************************************************
function Get_V_Raum_Best_Preis_Normal (p_Veranst_Raum_ID in bestellung.VERANST_RAUM_ID%type,
                                       p_Bestell_Beginn_Termin in bestellung.beginn_Termin%type,
                                       p_Bestell_Ende_Termin in bestellung.ende_Termin%type) return number as
-- RJE 23.07.2015 Neu angelegt. Gibt den Normalpreis (NICHT Storno) für eine
--     Veranst_Raum_Bestellung zurück.

  v_Meld_Wo varchar2(10);

  -- Nutzungspauschale für den GESAMT-V_Raum und Stunde:
  v_Nutzpausch_V_Raum_Ges_Stunde number;
  -- Anzahl der Kostenbelastungs-Stunden; Ein Veranst_Raum verursacht nur VERANST_RAUM.KOSTENBELASTUNG_VON .. Bis)
  --     eine Kostenbelastung
  v_Anz_Kostenbel_Stunden number;
  v_Preis_Normal number;

begin
   v_Preis_Normal := null;
   v_Meld_Wo := 'AAA';

   if p_Veranst_Raum_ID is NOT null and p_Bestell_Beginn_Termin is not null
          and p_Bestell_Ende_Termin is not null then
      v_Meld_Wo := 'BBB';
      -- In der Veranst_Raum.NUTZUNGSPAUSCHALE stehen die Euro pro qm und Stunde
      --   GET_KOSTEN_PRO_RAUM macht das mal Anz_QM,
      --      also kommen die Euro für den Gesamtraum pro Stunde raus.
      --v_Nutzpausch_V_Raum_Ges_Stunde := GET_KOSTEN_PRO_RAUM(p_Veranst_Raum_ID,
                                                              -- p_Bestell_Beginn_Termin,
                                                              -- p_Bestell_Ende_Termin);
      -- Anzahl der Kostenbelastungs-Stunden. GET_SUMME_ZEIT_PRO_RAUM2
      --    gibt Tage zurück, deshalb * 24
      -- v_Anz_Kostenbel_Stunden := GET_SUMME_ZEIT_PRO_RAUM2(p_Veranst_Raum_ID,
                                                          -- p_Bestell_Beginn_Termin,
                                                          -- p_Bestell_Ende_Termin) * 24;

      v_Preis_Normal := v_Nutzpausch_V_Raum_Ges_Stunde * v_Anz_Kostenbel_Stunden;
      v_Meld_Wo := 'CCC';
   end if;

   v_Meld_Wo := 'DDD';

   return v_Preis_Normal;
 exception
     when no_data_found then
        raise_application_error(-20606, 'Fehler no_data in Function PCK_Abrechnung.Get_V_Raum_Best_Preis_Normal (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
         return null;
    when others then
        raise_application_error(-20607, 'Fehler in Function PCK_Abrechnung.Get_V_Raum_Best_Preis_Normal (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
        return null;

end Get_V_Raum_Best_Preis_Normal;

    function Calc_V_Raum_Best_Preis_Storno (p_Veranst_Raum_ID in VERANST_RAUM.ID%type,
                                       p_Bestell_Beginn_Termin in bestellung.beginn_Termin%type,
                                       p_Bestell_Ende_Termin in bestellung.ende_Termin%type) return number as
-- RJE 23.07.2015 Neu angelegt. BERECHNET den Stornopreis (NICHT Normalpreis) für
--    eine Veranstaltungs-Raum-Bestellung und gibt diesen zurück.
-- der Aufruf ist NUR sinnvoll zum Stornierungszeitpunkt, weil der Stornopreis in der Spalte
-- bestellung.VERANST_RAUM_STORNO_GEB_EURO gespeichert wird.

  v_Meld_Wo varchar2(10);

  v_Preis_Normal number;

  v_Stornogebuehr_Proz    VERANST_RAUM.STORNOGEBUEHR%type;
  v_Preis_Storno number;

begin
   v_Preis_Normal := null;
   v_Preis_Storno := null;
   v_Meld_Wo := 'AAA';
   v_Preis_Normal := PCK_Abrechnung.Get_V_Raum_Best_Preis_Normal (p_Veranst_Raum_ID,
                                       p_Bestell_Beginn_Termin,
                                       p_Bestell_Ende_Termin);
   if v_Preis_Normal > 0 then
      --
      select vr.STORNOGEBUEHR into v_Stornogebuehr_Proz from VERANST_RAUM vr where
          vr.id = p_Veranst_Raum_ID;
      v_Preis_Storno := v_Preis_Normal * v_Stornogebuehr_Proz / 100;

   end if;

   return v_Preis_Storno;

 exception
     when no_data_found then
        raise_application_error(-20606, 'Fehler no_data in Function PCK_Abrechnung.Calc_V_Raum_Best_Preis_Storno (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
         return null;
    when others then
        raise_application_error(-20607, 'Fehler in Function PCK_Abrechnung.Calc_V_Raum_Best_Preis_Storno (' || v_Meld_Wo ||
           '). Error: ' || substr(dbms_utility.FORMAT_ERROR_BACKTRACE,1,300));
        return null;

end Calc_V_Raum_Best_Preis_Storno;
end PCK_Abrechnung;
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.GLO_TYPE AS
-- ------------------------------------------------- (c) NIS Rheinsberg GmbH ---
-- PL/SQL PACKAGE : GLO_TYPE
-- BESCHREIBUNG   : Allgemeine Typ-Definitionen
-- HISTORIE       : 18.02.1999 hh Erstellung
-- -----------------------------------------------------------------------------
-- PL/SQL-Table aus Id's, für das Umgehen des 'Mutating Table' Problems.
-- Dazu können in einem Row-Level-Trigger einzelne ID's in so einem Table
-- gesichert werden und anschließend in einem After-Statement-Trigger gelesen
-- und verarbeitet werden.
--
TYPE TNumberTable
IS TABLE OF Number NOT NULL INDEX BY BINARY_INTEGER;
--
TYPE TVarcharTable
IS TABLE OF Varchar2(2000) NOT NULL INDEX BY BINARY_INTEGER;
--
--globaler Typ
TEmailAdresse varchar2(1000);
--subtype TEmailAdresse is VARCHAR2(1000);
--
END;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.GLO_TYPE AS
-- This is a copy of the Hora PACKAGE BODY default template. Please modify file
-- D:\Programme\KeepTool\Hora4\Templates\ or change file name in the registry below
-- HKEY_CURRENT_USER\Software\KeepTool\Hora\3.0\Forms\dmPlSql\Templates
END;
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.TAB_DATEI_AUSGABE AS
-- ------------------------------------------------- (c) NIS Rheinsberg GmbH ---
-- PL/SQL PACKAGE : DATEI_AUSGABE
-- BESCHREIBUNG   : Dateiausgabe
-- HISTORIE       : 09.12.1999 hh Erstellung
--                  19.12.2012 hp Fix Übergabe ABemerkung auf 256 Zeichen reduziert
-- -----------------------------------------------------------------------------
--
-- Beispiel:
-- begin
--   tab_datei_ausgabe.BeginDatei( 'besteller@boehrringer-ingelheim.com', 4711, 'EMail', 'C:\Temp\Test.txt');
--   tab_datei_ausgabe.WriteLine( 'Erste Zeile in der EMail');
--   ...
--   tab_datei_ausgabe.WriteLine( 'Letzte Zeile in der EMail');
--   tab_datei_ausgabe.Abschicken;
-- exception
--   when others then
--     tab_datei_ausgabe.Verwerfen;
--     raise;
-- end;
--
  procedure BeginDatei(
    ABemerkung in datei_ausgabe.bemerkung%type,
    AReferenzId in datei_ausgabe.REFERENZ_ID%TYPE,
    ADateiTyp datei_ausgabe.DATEI_TYP%type,
    ADateiName datei_ausgabe.datei_name%type);
  procedure WriteLine( ALine in varchar2);
  --wenn der Text gleich als CLOB vorliegt
  procedure WriteTextAsClob( ATextField in clob);
  procedure Abschicken;
  procedure Verwerfen;
  procedure WriteToFile( AId in datei_ausgabe.id%type);
END;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.TAB_DATEI_AUSGABE AS
  FClob CLob;
  FCRLF Varchar2(2):= chr(13)||chr(10);
  FBemerkung datei_ausgabe.bemerkung%type;
  FReferenzId datei_ausgabe.REFERENZ_ID%type;
  FDateiTyp datei_ausgabe.DATEI_TYP%type;
  FDateiName datei_ausgabe.datei_name%type;
procedure BeginDatei(
  ABemerkung in datei_ausgabe.bemerkung%type,
  AReferenzId in datei_ausgabe.REFERENZ_ID%TYPE,
  ADateiTyp datei_ausgabe.DATEI_TYP%type,
  ADateiName datei_ausgabe.datei_name%type)
is
begin
  dbms_lob.createtemporary( FClob, True, DBMS_LOB.SESSION);
--  nur für 8.0.5 Kompatibilität
--  dbms_lob.createtemporary( FClob, True, 10);
  FBemerkung := substr(ABemerkung,1,255);
  FReferenzId := AReferenzId;
  FDateiTyp := ADateiTyp;
  FDateiName := ADateiName;
end;
--neue Version fü 8.0.5 Kompatibilität
/*
procedure WriteLine( ALine in varchar2)
is
  Amount Binary_Integer;
  TempCLob Clob;
begin
   --Zwischen Variable
   TempCLob := null;
	dbms_lob.createtemporary( TempCLob, True, 10);
  if ALine is null
  then
     Amount := 1;
  	  dbms_lob.write(TempCLob,  Amount, Amount ,''|| FCRLF);
  else
     Amount := Length(ALine) + 2 ;
	  dbms_lob.write(TempCLob,  Amount , Amount ,ALine|| FCRLF);
  end if;
   --Anfügen
   dbms_lob.append( FClob, TempCLob);
end;*/
--Version für 8.1.5.
procedure WriteLine( ALine in varchar2)
is
  Amount Binary_Integer;
begin
  if ALine is null
  then
     Amount := 0;
  else
     Amount := Length(ALine);
  end if;
  dbms_lob.writeappend( FClob, Amount+2, ALine || FCRLF);
end;
--wenn der Text gleich als CLOB vorliegt
procedure WriteTextAsClob( ATextField in clob)
is
  Amount Binary_Integer;
begin
  Amount := dbms_lob.GETLENGTH(ATextField);
  dbms_lob.writeappend( FClob, Amount, ATextField);
end;
--
procedure Abschicken
is
begin
  insert into datei_ausgabe (DATEI_NAME, DATEI_INHALT, DATEI_TYP, REFERENZ_ID, BEMERKUNG)
  values( FDateiName, FClob, FDateityp, FReferenzId, FBemerkung);
  FBemerkung := null;
  FReferenzId := null;
  FDateiTyp := null;
--  dbms_lob.close( FClob);
end;
procedure Verwerfen
is
begin
  FBemerkung := null;
  FReferenzId := null;
  FDateiTyp := null;
--  dbms_lob.close( FClob);
end;
procedure WriteToFile( AId in datei_ausgabe.id%type)
is
  Buffer Varchar2(20);
  Pos Number;
  Amount binary_integer;
  DateiInhalt CLob;
  DateiName varchar2(256);
begin
  SELECT DATEI_INHALT, DATEI_NAME into DateiInhalt, DateiName FROM datei_ausgabe WHERE ID = AId;
  Amount := 200;
  Pos := 1;
  begin
    loop
      Amount := dbms_lob.instr( DateiInhalt, FCrLf, Pos+1, 1)-Pos;
      if Amount+1 >= dbms_lob.getlength( DateiInhalt) then
        Amount := dbms_lob.getlength( DateiInhalt) - Pos +2;
      end if;
      if Amount <= 0 then
        raise no_data_found;
      end if;
			Buffer := '';
      dbms_lob.read( DateiInhalt, Amount, Pos, Buffer);
      Pos := Pos + Amount+2;
      dbms_output.put_line( Buffer);
    end loop;
  exception
    when no_data_found then
      null;
  end;
end;
END;

/

CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.PCK_CRESTRONFUSION_EXPORT AUTHID DEFINER  AS
/*
MNI 24.01.2018 - Als Kopie von CARA_AMZEIGE_HEADLINE angelegt und verändert

-- Pro PHYSIKALISCHEM Raum wird je eine Datei für Crestron Panel-Anzeige angelegt

-- Logik:
-- Pro PHYSIKALISCHER Raum wird je eine Datei angelegt
Dateiname:
[Raumbezeichnung]+[.cre]          // Raumbezeichnung:  Gebäude_Stockwerk_Sektor_Nummer
Beispiel: G91_00_A010_00.cre

-- Inhalt: gerade laufende, oder zukünftige Veranstaltungen


Dateiaufbau nach folgendem Schema:
  Erste Zeile enthält Überschrift mit Bsp:
     G71.02.096.00;G71.02 Berkeley (16 P.)
         -- Raumnummer ohne Standort analog zum Filename, aber mit . statt _
         -- Name des Veranstatlungsraumes, in dem dieser Raum als EINZIGER Raum enthalten ist.
  Aller weiteren Zeilen:
-    Elemente in einer Zeile werden mit Strichpunkte(;) getrennt
-    Dateiaufbauschema nicht in Datei enthalten
-    Sortiert nach Beginn_Datum, dann nach Beginn_Zeit
-    Daten von gestern sollen nicht mehr enthalten sein
-    Mindestbelegungszeit: 30 min, d.h. falls vom Anwender in Carmen anders gebucht (z.B. 08:12), dann sollte folgendermaßen gerundet werden:
-    Beginn_Zeit = 08:12  ? vorziehen = 08:00
-    Ende_Zeit    = 08:15  ? nachziehen = 08:30

Ramses Datenbank Logik;
Für eine Veranstaltung können mehrere Bestellung für Veranst_Räume (Dienst_Typ = R) vorliegen.
Eine Bestellung definiert Beginn und Ende in einem Veranst-Raum

*/
procedure Create_CrestronFusion_ExpFiles;
function get_next_execution_time (p_ab in date) return date;
function Get_Marb_Name_from_ID (p_M_ID MITARBEITER.ID%TYPE) RETURN varchar2;
function round_up_half_hour(p_date IN date) RETURN date;
function get_raum_verraum_bez (p_raumid in RAUM_IN_VERANST_RAUM.RAUM_ID%type) return VERANST_RAUM.bezeichnung1%type;
END;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.PCK_CRESTRONFUSION_EXPORT AS

-- Pro PHYSIKALISCHEM Raum wird je eine Datei für die Panel-Anzeige angelegt
-- Historie:    24.01.2018 MNI ErstErstellung
-- Änderungen:

const_CrestronFusion_Datei_TYP varchar2(10) := 'CRE'; -- Für FileExtension und Eintrag in Datei_Ausgabe
const_Delim varchar2(1) := ',';

-- NICHT am Wochenende und nicht in der Nacht
--  D: Tag der Woche, beginnend mit dem ersten Tag der Woche (dies variiert in Abhängigkeit der NLS-Einstellungen - in DE ist dies der Montag, in USA der Sonntag)
-- select to_char(sysdate,'D') from dual;
const_aktualisieren_von varchar2(15) := '06:00:00';
const_aktualisieren_bis varchar2(15) := '20:00:00';
-- Die Wochentage stehen DIREKT in der Routine get_next_execution_time, weil ein alter session in Kombination mit einem Job nicht geht.
-- die Datenbank und die Session darf NICHT auf nls_territory=German eingestellt sein, sonst ist der Montag der erste Tag!

-- Wer bekommt die Error Mail, falls etwas schief geht?
const_Error_Mail_Empfaenger varchar2(60) := 'HERKOMME;NIESSER;JERGRO';
const_Error_Mail_File_Prae varchar2(150) := '\\BIBFS03\DATA1\\SERVICE\MAILSERV\ramses\Err_';

function get_ascii_Dir_name (p_standort_ID in number) return varchar2 is
/*
*/

const_ASCII_Dir_Biberach varchar2(300) := '\\INHAS64266\CarmenExports\bib\';
const_ASCII_Dir_Ingelheim varchar2(300) := '\\INHAS64266\CarmenExports\ing\';
const_ASCII_Dir_Dortmund varchar2(300) := '\\INHAS64266\CarmenExports\dtm\';
const_ASCII_Dir_Wien varchar2(300) := '\\INHAS64266\CarmenExports\vie\';
const_ASCII_Dir_Hannover varchar2(300) := '\\INHAS64266\CarmenExports\haj\';
const_ASCII_Dir_Mainz varchar2(300) := '\\INHAS64266\CarmenExports\maz\';
const_ASCII_Dir_ERROR varchar2(300) := '\\INHAS64266\CarmenExports\ERROR\';

v_ret_Ascii_Dir varchar2(300);

begin

  CASE  p_standort_ID
     WHEN 1 THEN v_ret_Ascii_Dir := const_ASCII_Dir_Biberach;
     WHEN 2 THEN v_ret_Ascii_Dir := const_ASCII_Dir_Ingelheim;
     WHEN 23 THEN  v_ret_Ascii_Dir := const_ASCII_Dir_Dortmund;
     WHEN 63 THEN  v_ret_Ascii_Dir := const_ASCII_Dir_Wien;
     WHEN 107 THEN  v_ret_Ascii_Dir := const_ASCII_Dir_Hannover;
     WHEN 245 THEN  v_ret_Ascii_Dir := const_ASCII_Dir_Mainz;
     ELSE v_ret_Ascii_Dir := const_ASCII_Dir_ERROR;
  END CASE;

  return v_ret_Ascii_Dir;

exception
   when others then
      v_ret_Ascii_Dir := const_ASCII_Dir_ERROR;
      return v_ret_Ascii_Dir;

end get_ascii_Dir_name;


FUNCTION round_up_half_hour(p_date IN date) RETURN date IS
   l_result date;
-- rundet auf halbe Stunden auf. Aus 18:12 wird 18:30
-- RUNDEN darf nur 4 Nachkommastellen haben, sonst rundet oracle immer noch falsch
   l_anz_halbe_stunden number(28,10);
   c_halbe_stunde number(28,10) := 1/48;
   l_tagesanteil number(28,10);

BEGIN
   l_anz_halbe_stunden := (p_date-trunc(p_date)) / c_halbe_stunde;
   -- dbms_output.put_line('anz_Halbe roh: ' || l_anz_halbe_stunden);
   -- !!! Sonst macht Oracle Rundungsfehler
   -- FALSCH : !!!!!l_anz_halbe_stunden := round(l_anz_halbe_stunden,7);
   l_anz_halbe_stunden := round(l_anz_halbe_stunden,4);
   -- dbms_output.put_line('anz_Halbe: ' || l_anz_halbe_stunden);
   -- dbms_output.put_line('ceil: ' || ceil(l_anz_halbe_stunden));

   l_tagesanteil := c_halbe_stunde * (ceil(l_anz_halbe_stunden));
   -- dbms_output.put_line('l_tagesanteil: ' || l_tagesanteil);
   l_result := trunc(p_date) + l_tagesanteil;
   RETURN l_result;
exception when others then
  return NULL;
END;

function get_raum_verraum_bez (p_raumid in RAUM_IN_VERANST_RAUM.RAUM_ID%type) return VERANST_RAUM.bezeichnung1%type is

 cursor c_raum_verraum_bez (c_raumid in RAUM_IN_VERANST_RAUM.RAUM_ID%type) is
    select rvr2.VERANST_RAUM_ID, vr2.BEZEICHNUNG1, vr2.FON, count(*) as Anz_raeume from
              RAUM_IN_VERANST_RAUM rvr2, VERANST_RAUM vr2, RAUM_TYP rt, RAUM_IN_VERANST_RAUM rvree  where
         vr2.id = rvr2.veranst_raum_id
         and vr2.deldat is null
         and rvr2.raum_id = c_raumid
         and vr2.RAUM_TYP_ID = rt.id
         and rt.bezeichnung <> 'Büro'
         and rvree.veranst_raum_id = vr2.id
         group by rvr2.VERANST_RAUM_ID, vr2.BEZEICHNUNG1, vr2.FON
         order by count(*) asc, vr2.BEZEICHNUNG1 asc;


 v_veranst_raum_id      VERANST_RAUM.id%type;
 v_veranst_raum_bez     VERANST_RAUM.BEZEICHNUNG1%type;
 v_veranst_raum_fon     VERANST_RAUM.FON%type;
 v_ret_bez              varchar2(300);
 v_veranst_raum_found   boolean;
 v_Anz_Raeume_akt       number(7,0);
 v_Anz_Raeume_vorher    number(7,0);
 v_Fertig               boolean;

begin
   v_veranst_raum_found := false;
   v_ret_bez := null;
   v_Anz_Raeume_akt := 0;
   v_Anz_Raeume_vorher := 0;
   v_Fertig := false;
   open c_raum_verraum_bez(p_raumid);
   fetch c_raum_verraum_bez into v_veranst_raum_id, v_veranst_raum_bez, v_veranst_raum_fon, v_Anz_Raeume_akt;
   v_Anz_Raeume_vorher := v_Anz_Raeume_akt;

   While c_raum_verraum_bez%found and NOT v_Fertig loop
      v_veranst_raum_found := true;
      v_veranst_raum_fon := replace(v_veranst_raum_fon,'.');
      v_veranst_raum_fon := replace(v_veranst_raum_fon,'-');
      v_veranst_raum_fon := replace(v_veranst_raum_fon,'_');

      if v_Anz_Raeume_vorher = v_Anz_Raeume_akt then
        if v_ret_bez is NOT null then
           v_ret_bez := v_ret_bez || ' // ';
        end if;
        if trim(v_veranst_raum_fon) is null then
           v_ret_bez := substr(v_ret_bez || trim(v_veranst_raum_bez),1,300);
        else
           v_ret_bez := substr(v_ret_bez || trim(v_veranst_raum_bez) || '  Tel: ' || v_veranst_raum_fon,1,300);
        end if;
        -- Gibt es ev. ZWEI Veranst-Räume NUR mit diesem Raum?
        fetch c_raum_verraum_bez into v_veranst_raum_id, v_veranst_raum_bez, v_veranst_raum_fon, v_Anz_Raeume_akt;
      else
         v_Fertig := true;
      end if;
   end loop;
   close c_raum_verraum_bez;
   if NOT v_veranst_raum_found then
      -- Raum ist keinem einzelnen oder einem gelöschten Veranst-Raum zugeordnet
      v_ret_bez := 'Error: Kein def. Veranst-Raum';
   end if;


   return v_ret_bez;

exception
   when others then
      v_ret_bez := substr('Error: ' || sqlerrm,1,30);
      return v_ret_bez;

end get_raum_verraum_bez;

function get_next_execution_time (p_ab in date) return date is

 result date;
 -- p_ab dient nur zum entwickeln.
 dstart date;
 ab date;
 i number := 0;
 Anfang number;    -- Minuten des Tages, bis zu denen keine Rechnung erfolgt
 Ende number;      -- Minuten des Tages, ab denen keine Rechnung erfolgt
begin

 if p_ab is null then
    ab := sysdate;
 else
    ab := p_ab;
 end if;

 dstart := trunc(ab) +  (trunc((ab - trunc(ab)) * 24 * 4 )  + 1)/(24 * 4);
 Anfang := to_date('1.1.1900 ' || const_aktualisieren_von, 'dd.mm.yyyy hh24:mi:ss') - trunc(to_date('1.1.1900','dd.mm.yyyy'));
 Ende := to_date('1.1.1900 ' || const_aktualisieren_bis, 'dd.mm.yyyy hh24:mi:ss') - trunc(to_date('1.1.1900','dd.mm.yyyy'));

 if ende <= Anfang then
  raise_application_error(-20500, 'Die Konstanten  CONST_AKTUALISIEREN_VON muss vor CONST_AKTUALISIEREN_BIS liegen!');
 end if;
 loop
   result := dstart + i/96;   -- 1/4 Stunden
   i := i+1;
   if (result - trunc(result)) >= Anfang and  (result - trunc(result)) <= Ende
      -- Die Wochentage sind AMERIKANISCH, also Sonntag ist die 1
      and (to_char(result,'D') IN (2,3,4,5,6)) then
     exit ;
   end if;
 end loop;
 return result;
end get_next_execution_time;

function Get_Marb_Name_from_ID (p_M_ID MITARBEITER.ID%TYPE) RETURN varchar2 as
retval varchar2(50);

BEGIN
  begin
    -- kein const_Delim
    Select m.nachname || ' ' || m.vorname  into retval from MITARBEITER m
      WHERE m.ID = p_M_ID;

  exception
    When others Then
    retval := NULL;
  end;
  Return retval;
END Get_Marb_Name_from_ID;

procedure  Create_CrestronFusion_ExpFiles as


  v_Zeile varchar2(4000);
  v_MailContent varchar2(3500);
  v_Filename varchar2(400);
  v_Datei_Nummer number;
  v_Meld_Wo varchar2(30);
  const_Anz_Tage_aufheben number(3,0):= 2;

begin
  v_Meld_Wo := 'AAA';
  -- RJE Alte Einträge löschen:
  delete from DATEI_AUSGABE
    where DATEI_TYP = const_CrestronFusion_Datei_TYP
    and TERMIN_GESCHRIEBEN is not null
    and TERMIN_FREIGABE < sysdate - const_Anz_Tage_aufheben;

  v_Meld_Wo := 'AAB';
  for rec in (
    SELECT DISTINCT cr.STANDORT_ID, cr.raum_id, cr.raum_nr_ges_geb, cr.Raum_nr_Punkt, cr.raum_verraum_Bez from CRESTRON_FUSION_RAUM cr -- ein Raum kann in verschiedenen Veranstaltungsräumen sein
  ) loop
      v_filename := get_ascii_Dir_name(rec.STANDORT_ID) || rec.raum_nr_ges_geb || '.' || const_CrestronFusion_Datei_TYP;
      tab_datei_ausgabe.begindatei ( rec.raum_nr_ges_geb, NULL, const_CrestronFusion_Datei_TYP, v_filename);
      v_Meld_Wo := 'AAC';
      v_Zeile := rec.Raum_nr_Punkt || const_Delim || rec.raum_verraum_Bez;
      TAB_DATEI_AUSGABE.WriteLine( v_Zeile);
      v_Meld_Wo := 'AAD';

     for rec_zeile in (
       SELECT cal.BEGINN_PUFFER_Datum_Char,
              cal.beginn_PUFFER_Zeit_norm,
              cal.ENDE_TERMIN_DATUM_CHAR,
              cal.ENDE_TERMIN_ZEIT_NORM,
              cal.THEMA_NORM,
              cal.MITARBEITER_ID,
              cal.BETREUER,
              cal.VR_RAUM_NAME from CRESTRON_FUSION_EXP_FILE cal where cal.RAUM_ID = rec.raum_id
              order by cal.BEGINN_TERMIN_DATE asc
     ) loop
         v_Zeile := --rec_zeile.BETREUER
            Get_Marb_Name_from_ID(rec_zeile.MITARBEITER_ID)  || ' - ' || rec_zeile.thema_norm || const_Delim ||
            rec_zeile.BEGINN_PUFFER_Datum_Char || const_Delim ||
            rec_zeile.beginn_PUFFER_Zeit_norm || const_Delim ||
            rec_zeile.ENDE_TERMIN_Datum_Char || const_Delim ||
            rec_zeile.ENDE_TERMIN_Zeit_norm;
         TAB_DATEI_AUSGABE.WriteLine( v_Zeile);
         v_Meld_Wo := 'BBB';
     end loop;
     v_Meld_Wo := 'CCC';
     tab_datei_ausgabe.Abschicken;
     v_Meld_Wo := 'DDD';
      -- dbms_output.put_line('AAA');
  end loop;
  v_Meld_Wo := 'EEE';
  commit;
  v_Meld_Wo := 'FFF';
exception
   when others then
    v_MailContent := substr(const_Error_Mail_Empfaenger || utl_tcp.CRLF || 'FEHLER in PCK_CrestronFusion_EXPORT.Create_CrestronFusion_ExpFiles' || utl_tcp.CRLF,1,3000);
    v_MailContent := substr(v_MailContent || sqlerrm || utl_tcp.CRLF,1,3000);
    v_MailContent := substr(v_MailContent || 'bei v_Meld_Wo: ' || v_Meld_Wo || utl_tcp.CRLF,1,3000);

    tab_datei_ausgabe.Verwerfen;
    rollback;
    v_Filename := substr(const_Error_Mail_File_Prae || to_char(sysdate,'dd_mm_yyyy_hh24_mi_ss'),1,400) ;
    insert into Datei_Ausgabe
       (DATEI_NAME,                        DATEI_INHALT,  DATEI_TYP, REFERENZ_ID, BEMERKUNG, TERMIN_FREIGABE)
     values
       (v_Filename, v_MailContent,                        'ERR',     NULL, 'PCK_CrestronFusion_EXPORT.Create_CrestronFusion_ExpFiles', sysdate);
     commit;
end Create_CrestronFusion_ExpFiles;

END PCK_CrestronFusion_EXPORT;
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.MY_NEW_PACK 
IS
PROCEDURE auto_as;
PROCEDURE auto_is;
END my_new_pack;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.MY_NEW_PACK 
IS
PROCEDURE auto_as as
  vname varchar(20) :='manish';
 begin 
 dbms_output.enable();
 dbms_output.put_line('what is my name?'||vname);
end auto_as;

PROCEDURE auto_is is
  vname varchar(20) :='manish';
 begin 
 dbms_output.enable();
 dbms_output.put_line('what is my name?'||vname);
end auto_is;

END my_new_pack;
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.EMP_MGMT AS 
   FUNCTION hire (last_name VARCHAR2, job_id VARCHAR2, 
      manager_id NUMBER, salary NUMBER, 
      commission_pct NUMBER, department_id NUMBER) 
      RETURN NUMBER; 
   FUNCTION create_dept(department_id NUMBER, location_id NUMBER) 
      RETURN NUMBER; 
   PROCEDURE remove_emp(employee_id NUMBER); 
   PROCEDURE remove_dept(department_id NUMBER); 
   PROCEDURE increase_sal(employee_id NUMBER, salary_incr NUMBER); 
   PROCEDURE increase_comm(employee_id NUMBER, comm_incr NUMBER); 
   no_comm EXCEPTION; 
   no_sal EXCEPTION; 
END emp_mgmt;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.EMP_MGMT AS 
   tot_emps NUMBER; 
   tot_depts NUMBER; 
FUNCTION hire 
   (last_name VARCHAR2, job_id VARCHAR2, 
    manager_id NUMBER, salary NUMBER, 
    commission_pct NUMBER, department_id NUMBER) 
   RETURN NUMBER IS new_empno NUMBER; 
BEGIN 
   SELECT employees_seq.NEXTVAL 
      INTO new_empno 
      FROM DUAL; 
   INSERT INTO employees 
      VALUES (new_empno, 'First', 'Last','first.last@oracle.com', 
              '(123)123-1234','18-JUN-02','IT_PROG',90000000,00, 
              100,110); 
      tot_emps := tot_emps + 1; 
   RETURN(new_empno); 
END; 
FUNCTION create_dept(department_id NUMBER, location_id NUMBER) 
   RETURN NUMBER IS 
      new_deptno NUMBER; 
   BEGIN 
      SELECT departments_seq.NEXTVAL 
         INTO new_deptno 
         FROM dual; 
      INSERT INTO departments 
         VALUES (new_deptno, 'department name', 100, 1700); 
      tot_depts := tot_depts + 1; 
      RETURN(new_deptno); 
   END; 
PROCEDURE remove_emp (employee_id NUMBER) IS 
   BEGIN 
      DELETE FROM employees 
      WHERE employees.employee_id = remove_emp.employee_id; 
      tot_emps := tot_emps - 1; 
   END; 
PROCEDURE remove_dept(department_id NUMBER) IS 
   BEGIN 
      DELETE FROM departments 
      WHERE departments.department_id = remove_dept.department_id; 
      tot_depts := tot_depts - 1; 
      SELECT COUNT(*) INTO tot_emps FROM employees; 
   END; 
PROCEDURE increase_sal(employee_id NUMBER, salary_incr NUMBER) IS 
   curr_sal NUMBER; 
   BEGIN 
      SELECT salary INTO curr_sal FROM employees 
      WHERE employees.employee_id = increase_sal.employee_id; 
      IF curr_sal IS NULL 
         THEN RAISE no_sal; 
      ELSE 
         UPDATE employees 
         SET salary = salary + salary_incr 
         WHERE employee_id = employee_id; 
      END IF; 
   END; 
PROCEDURE increase_comm(employee_id NUMBER, comm_incr NUMBER) IS 
   curr_comm NUMBER; 
   BEGIN 
      SELECT commission_pct 
      INTO curr_comm 
      FROM employees 
      WHERE employees.employee_id = increase_comm.employee_id; 
      IF curr_comm IS NULL 
         THEN RAISE no_comm; 
      ELSE 
         UPDATE employees 
         SET commission_pct = commission_pct + comm_incr; 
      END IF; 
   END; 
END emp_mgmt;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.PCK_STUNDEN_AUSW AS
procedure FILL_STUNDEN;
procedure STUNDEN_AUSWERTUNG;
END PCK_STUNDEN_AUSW;
/

CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ORA_MIGRA.PCK_STUNDEN_AUSW AS
-- RJE 03.11.2015 angelegt
-- NUR für individuelle Stundenauswertung Herr Rottkemper
-- ******************************************************************
procedure FILL_STUNDEN as
-- RJe 03.11.2015 Soll die Tabelle STUNDEN füllen.
--    Die Tabelle Stunden liefert die Stunden-Intervalle für die Stunden-Auswertung

 

-- Wieviele Tage in die Zukunft sollen die Stunden angelegt werden:
const_Anz_Tage_In_Zukunft number(5,0) := 400;
const_Stunden_Ab date := to_date('01.01.2066','dd.mm.yyyy');



v_Max_Stunden_Bisher STUNDEN.Beginn%Type;
v_Akt_Datum date;
v_Anz_Tage_anzulegen number(6,0);
v_Anzulegender_Tag date;



v_i number(6,0);



begin
   -- select max(Beginn)  from STUNDEN;
   select max(Beginn) into v_Max_Stunden_Bisher from STUNDEN;
   -- Initialisierung:
   if v_Max_Stunden_Bisher is null then
      v_Max_Stunden_Bisher := const_Stunden_Ab;
   end if;



   v_Akt_Datum := trunc(sysdate);
   v_Max_Stunden_Bisher := trunc(v_Max_Stunden_Bisher);
   v_Anz_Tage_anzulegen := v_Akt_Datum - v_Max_Stunden_Bisher + const_Anz_Tage_In_Zukunft;
   -- dbms_output.put_line('v_Anz_Tage_anzulegen: ' || v_Anz_Tage_anzulegen);



   v_i := 1;



   while v_i < v_Anz_Tage_anzulegen loop
     v_Anzulegender_Tag := v_Max_Stunden_Bisher + v_i;



     insert into STUNDEN (Beginn, Ende)
      select to_date(to_char(v_Anzulegender_Tag,'dd.mm.yyyy ') || sm.Beginn_chr,'dd.mm.yyyy hh24:mi:ss'),
         to_date(to_char(v_Anzulegender_Tag,'dd.mm.yyyy ') || sm.Ende_chr,'dd.mm.yyyy hh24:mi:ss') from
            STUNDEN_META sm;
     commit;
     v_i := v_i +1;
   end loop;



end FILL_STUNDEN;
-- ******************************************************************
procedure STUNDEN_AUSWERTUNG as
/*
-- ==== Auswertung:



select s.beginn, s.ende, b.VERANST_RAUM_ID, b.BEGINN_PUFFER, b.ENDE_TERMIN from bestellung b, stunden s where
  -- nur Raum-Bestellungen
  b.DIENST_TYP = 'R'
  and b.BESTAET_STATUS = 'J'
        and (
           ((BEGINN_PUFFER > s.beginn) AND (BEGINN_PUFFER < s.ende)) or
           ((ENDE_TERMIN > s.beginn) AND (ENDE_TERMIN < s.ende)) or
           ((BEGINN_PUFFER <= s.beginn) AND (ENDE_TERMIN >= s.ende)) or
           ((BEGINN_PUFFER > s.beginn) AND (ENDE_TERMIN < s.ende)) or
           ((BEGINN_PUFFER = s.beginn) AND (ENDE_TERMIN = s.ende))
           )
  and b.VERANST_RAUM_ID = 6569;
*/




begin
   null;
end STUNDEN_AUSWERTUNG;
END;
/

  CREATE OR REPLACE NONEDITIONABLE PACKAGE ORA_MIGRA.TRANS_DATA AUTHID DEFINER AS
  TYPE TimeRec IS RECORD (
    minutes SMALLINT,
    hours   SMALLINT);
  TYPE TransRec IS RECORD (
    category VARCHAR2(10),
    account  INT,
    amount   REAL,
    time_of  TimeRec);
  minimum_balance     CONSTANT REAL := 10.00;
  number_processed    INT;
  insufficient_funds  EXCEPTION;
  PRAGMA EXCEPTION_INIT(insufficient_funds, -4097);
END trans_data;
/

/*

DROP PACKAGE BODY ORA_MIGRA.GLO_TYPE ;
DROP PACKAGE BODY ORA_MIGRA.TAB_DATEI_AUSGABE ;
DROP PACKAGE BODY ORA_MIGRA.PCK_STUNDEN_AUSW ;
DROP PACKAGE BODY ORA_MIGRA.EMP_SAL ;
DROP PACKAGE BODY ORA_MIGRA.MY_NEW_PACK ;
DROP PACKAGE BODY ORA_MIGRA.TAB_BESTELLUNG ;
DROP PACKAGE BODY ORA_MIGRA.PCK_CRESTRONFUSION_EXPORT ;
DROP PACKAGE BODY ORA_MIGRA.EMP_MGMT ;
DROP PACKAGE BODY ORA_MIGRA.PCK_ABRECHNUNG ;
DROP PACKAGE BODY ORA_MIGRA.TAB_BESTELLUNG_NEW ;
DROP PACKAGE ORA_MIGRA.TRANS_DATA ;
DROP PACKAGE ORA_MIGRA.TAB_BESTELLUNG_NEW ;
DROP PACKAGE ORA_MIGRA.PCK_STUNDEN_AUSW ;
DROP PACKAGE ORA_MIGRA.TAB_BESTELLUNG ;
DROP PACKAGE ORA_MIGRA.EMP_MGMT ;
DROP PACKAGE ORA_MIGRA.MY_NEW_PACK ;
DROP PACKAGE ORA_MIGRA.TAB_DATEI_AUSGABE ;
DROP PACKAGE ORA_MIGRA.PCK_CRESTRONFUSION_EXPORT ;
DROP PACKAGE ORA_MIGRA.GLO_TYPE ;
DROP PACKAGE ORA_MIGRA.EMP_SAL ;
DROP PACKAGE ORA_MIGRA.PCK_ABRECHNUNG ;

*/
