  CREATE TABLE ORA_MIGRA.REGIONS 
   (	REGION_ID NUMBER NOT NULL ENABLE, 
	REGION_NAME VARCHAR2(25), 
	 CONSTRAINT REG_ID_PK PRIMARY KEY (REGION_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.REG_ID_PKX ON ORA_MIGRA.REGIONS (REGION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.COUNTRIES 
   (	COUNTRY_ID CHAR(2) NOT NULL ENABLE, 
	COUNTRY_NAME VARCHAR2(40), 
	REGION_ID NUMBER, 
	 CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (COUNTRY_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.COUNTRY_C_ID_PKX ON ORA_MIGRA.COUNTRIES (COUNTRY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE, 
	 CONSTRAINT COUNTR_REG_FK FOREIGN KEY (REGION_ID)
	  REFERENCES ORA_MIGRA.REGIONS (REGION_ID) DISABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.BESTELLUNG_CHANGED_MAIL_AN_AN 
   (	BESTELLUNG_ID NUMBER(28,0) NOT NULL ENABLE, 
	MAIL_SEND_DATE DATE, 
	BESTELLUNG_CHANGED_ID NUMBER(28,0) NOT NULL ENABLE, 
	AENDER_ART VARCHAR2(1) NOT NULL ENABLE, 
	DC DATE, 
	UC VARCHAR2(30), 
	DM DATE, 
	UM VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.LEISTUNG 
   (	LEIST_MUSS_GEBUCHT_WERDEN_JN CHAR(1), 
	RESSOURCE_ID FLOAT(126), 
	ID FLOAT(126), 
	LEISTUNGS_NR NUMBER(*,0), 
	BEZEICHNUNG1 CHAR(1), 
	BEZEICHNUNG2 CHAR(1), 
	PREIS_AKTUELL NUMBER(*,0), 
	PREIS_NEU NUMBER(*,0), 
	EINHEIT CHAR(1), 
	GUELTIG_AB_DATUM DATE, 
	BEGINN_STORNOZEIT NUMBER(*,0), 
	STORNOGEBUEHR NUMBER(*,0), 
	KST_KOSTENSTELLE CHAR(1), 
	DIENSTLEISTER_ID NUMBER(*,0), 
	SAP_LEISTUNGSART_ID FLOAT(126), 
	DC DATE, 
	UC CHAR(1), 
	DM DATE, 
	UM CHAR(1), 
	STORNOGEBUEHR_IN_PROZENT CHAR(1), 
	FESTPREIS CHAR(1), 
	INAKTIV CHAR(1), 
	PREIS_NACH_SAP_UEBERTR CHAR(1), 
	TAG FLOAT(126), 
	MINDEST_BESTELLMENGE FLOAT(126), 
	MAXIMALE_ANZAHL_TAG FLOAT(126), 
	BILD_NAME CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.BPELEMPLOYEES 
   (	EMPLOYEE_ID FLOAT(126) NOT NULL ENABLE, 
	FIRST_NAME VARCHAR2(20), 
	LAST_NAME VARCHAR2(25), 
	EMAIL VARCHAR2(25), 
	PHONE_FLOAT VARCHAR2(20), 
	HIRE_DATE DATE, 
	JOB_ID VARCHAR2(10), 
	SALARY NUMBER(8,2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.VERANST_RAUM 
   (	ID FLOAT(126), 
	FON CHAR(1), 
	SERIENBUCHUNG CHAR(1), 
	SCHLUESSEL_NR CHAR(1), 
	ANZEIGE_KENNZEICHEN CHAR(1), 
	BEMERKUNG CHAR(1), 
	KST_KOSTENSTELLE CHAR(1), 
	RAUM_TYP_ID NUMBER(*,0), 
	SPERR_TYP_ID NUMBER(*,0), 
	STUHL_TYP_ID NUMBER(*,0), 
	DC DATE, 
	UC CHAR(1), 
	DM DATE, 
	UM CHAR(1), 
	GRUPPE_ID NUMBER, 
	ANZAHL_RAEUME NUMBER(*,0), 
	ETAGE_ID NUMBER, 
	BEZEICHNUNG1 CHAR(1), 
	TEILBAR CHAR(1), 
	AKTIV CHAR(1), 
	NUTZUNGSPAUSCHALE FLOAT(126), 
	STORNOZEITRAUM NUMBER(*,0), 
	STORNOGEBUEHR NUMBER(*,0), 
	PREIS_NACH_SAP_UEBERTR CHAR(1), 
	DELDAT DATE, 
	KOSTENBELASTUNG_VON FLOAT(126), 
	KOSTENBELASTUNG_BIS FLOAT(126), 
	ZUSAETZLICHE_BUCHUNGSINFO CHAR(1), 
	ANZAHL_SITZPLAETZE NUMBER(*,0), 
	SAP_ABRECHNUNG_JN CHAR(1), 
	BESTUHLUNGSAEND_DL_ID FLOAT(126), 
	STORNOBEDINGUNGEN CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.BESTELLUNG_CHANGED_MAIL_AN_DL 
   (	BESTELLUNG_ID NUMBER(28,0) NOT NULL ENABLE, 
	MAIL_SEND_DATE DATE, 
	BESTELLUNG_CHANGED_ID NUMBER(28,0) NOT NULL ENABLE, 
	AENDER_ART VARCHAR2(1) NOT NULL ENABLE, 
	DC DATE, 
	UC VARCHAR2(30), 
	DM DATE, 
	UM VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.SAP_ABRECHNUNGS_TERMINE 
   (	ID NUMBER NOT NULL ENABLE, 
	TERMIN DATE NOT NULL ENABLE, 
	ABRECHNUNG_ERFOLGT_AM DATE, 
	SAP_WELT_ID NUMBER(7,0) NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.MITARBEITER_BI_ALLE 
   (	ID NUMBER(7,0), 
	THOMAEMA VARCHAR2(1), 
	INAKTIV VARCHAR2(1), 
	ANREDE VARCHAR2(10), 
	TITEL VARCHAR2(15), 
	VORNAME VARCHAR2(30), 
	VORSATZWORT VARCHAR2(15), 
	NACHNAME VARCHAR2(30), 
	KUERZEL VARCHAR2(10), 
	USERNAME VARCHAR2(8), 
	ORGEINHEITID NUMBER(7,0), 
	ERSTTELEFON VARCHAR2(6), 
	KOSTENSTELLE NUMBER(9,0), 
	ETAGE VARCHAR2(2), 
	GEBAEUDE VARCHAR2(6), 
	EXT_TELEFON VARCHAR2(20), 
	MAIL_ADRESSE VARCHAR2(256), 
	USI_KUERZEL VARCHAR2(6), 
	USERNAME_ALT VARCHAR2(8), 
	HAUSPOSTZAHL VARCHAR2(30), 
	RAUMID NUMBER(28,0), 
	SEKTOR VARCHAR2(1), 
	RAUM_HAUPT_NR VARCHAR2(10), 
	RAUM_UNTER_NR VARCHAR2(2), 
	FAX VARCHAR2(8), 
	TECHNISCHER_USER VARCHAR2(1) DEFAULT 'N', 
	BETR_MITARBEITER_ID NUMBER(7,0), 
	SMTP_ADRESSE VARCHAR2(128), 
	DC DATE DEFAULT sysdate, 
	STANDORTID NUMBER(28,0), 
	IMPORT_JN VARCHAR2(1) DEFAULT 'J', 
	MITARBEITER_BI_ID VARCHAR2(15), 
	USERNAME_IMPORT VARCHAR2(30), 
	DELDAT DATE, 
	SLAVE_ACCOUNT VARCHAR2(1) DEFAULT 'N', 
	MENSCH_JN VARCHAR2(1) DEFAULT 'J', 
	AUSWEISNUMMER VARCHAR2(10), 
	MITARB_BI_ID_POT_TEMP VARCHAR2(10), 
	KEIN_ARBEITSPLATZ_PAMI VARCHAR2(1), 
	KEIN_ARBEITSPLATZ_SAP VARCHAR2(1), 
	KEIN_ARBEITSPLATZ VARCHAR2(1), 
	EXTERNE_FIRMA VARCHAR2(65), 
	MOBILTELEFON VARCHAR2(25), 
	AD_ACCOUNT_AKTIV VARCHAR2(1), 
	DEFAULT_MAILADRESSE VARCHAR2(256), 
	ISMANAGER_JN VARCHAR2(1), 
	MITARBEITER_BI_ID_SAVE VARCHAR2(10), 
	AKTIV_JN_BI VARCHAR2(1), 
	AUSWEIS_ABLAUFDATUM DATE, 
	AUSTRITTSDATUM_SOLL DATE, 
	IMMER_IN_MARB_VIEW_JN VARCHAR2(1) DEFAULT 'N', 
	USERNAME_30 VARCHAR2(30), 
	USERNAME_30_ALT VARCHAR2(30), 
	PERSONALNUMMER VARCHAR2(30), 
	VERTRAUENS_ARB_ZEIT_JN VARCHAR2(1), 
	ORG_EINHEIT_AUS_MAIL VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.DATE_TABLE 
   (	COLUMN1 DATE, 
	COLUMN2 VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.RAUM 
   (	ID NUMBER(28,0) NOT NULL ENABLE, 
	ETAGEID NUMBER(28,0) NOT NULL ENABLE, 
	DC DATE DEFAULT sysdate NOT NULL ENABLE, 
	UC VARCHAR2(30) DEFAULT user NOT NULL ENABLE, 
	RAUM VARCHAR2(10) NOT NULL ENABLE, 
	UNTER VARCHAR2(2) DEFAULT '00' NOT NULL ENABLE, 
	BEZEICHNUNG VARCHAR2(50), 
	FLAECHE NUMBER NOT NULL ENABLE, 
	LOCKED VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	BETRVON DATE, 
	BETRBIS DATE, 
	HOEHE NUMBER(6,2), 
	HOEHELICHT NUMBER(6,2), 
	VOLUMEN NUMBER(9,2), 
	UMFANG NUMBER(6,2), 
	DELDAT DATE, 
	TUER_TEXT VARCHAR2(400), 
	ALTE_RAUM_NR VARCHAR2(20), 
	SEKTOR VARCHAR2(1), 
	HOEHE_LRF NUMBER(6,2), 
	HOEHE_LRR NUMBER(6,2), 
	HOEHE_RG NUMBER(6,2), 
	BEREICH VARCHAR2(1) DEFAULT 'a' NOT NULL ENABLE, 
	CAD_DM DATE DEFAULT sysdate, 
	CAD_UM VARCHAR2(30) DEFAULT user, 
	AP_PRAKTISCH NUMBER(3,0), 
	AP_IST NUMBER(3,0), 
	RAUMLAGE_ID NUMBER(28,0), 
	BEZEICHNUNG_ENGLISCH VARCHAR2(50), 
	STANDO_ID NUMBER(28,0), 
	ZK_ZUTRITTSSICHERUNGS_ART_ID NUMBER(7,0), 
	ZK_SCHUTZSTUFE_ID NUMBER(7,0), 
	ZK_STATUS_ID NUMBER(7,0), 
	AP_THEORETISCH NUMBER(8,1) GENERATED ALWAYS AS (CASE  WHEN (FLAECHE-8)/8+1<0 THEN 0 WHEN (FLAECHE-8)/8+1>=0 THEN ROUND((FLAECHE-8)/8+1,1) ELSE NULL END) VIRTUAL , 
	RAUM_ANF_GXP VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	AP_PRAKTISCH_DM DATE, 
	AP_PRAKTISCH_UM VARCHAR2(30), 
	AP_IST_DM DATE, 
	AP_IST_UM VARCHAR2(30), 
	RAUMKATEGORIE_ID NUMBER, 
	AUDIT_ID NUMBER(28,0), 
	AP_BEMERKUNG VARCHAR2(100), 
	AP_OPTIMIERBAR_JN VARCHAR2(1), 
	RAUM_BEZ_NR_CHANGE_DAT DATE, 
	AP_THEORETISCH_6 NUMBER GENERATED ALWAYS AS (CASE  WHEN FLAECHE<=8 THEN ROUND(FLAECHE/8,1) ELSE ROUND((FLAECHE-8)/6+1,1) END) VIRTUAL 
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.ETAGENNUMMERN 
   (	ETAGENNUMMER VARCHAR2(2) NOT NULL ENABLE, 
	SORTIERFOLGE NUMBER(3,0), 
	BEZEICHNUNG VARCHAR2(30), 
	HOEHENKUERZEL VARCHAR2(1), 
	DC DATE DEFAULT sysdate, 
	STEHT_IM_RAUMBUCH_ZUR_VERF_JN VARCHAR2(1) DEFAULT 'N'
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.CHAR_TABLE 
   (	COLUMN1 CHAR(1), 
	COLUMN2 VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.STUNDEN 
   (	BEGINN DATE, 
	ENDE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.JOBS 
   (	JOB_ID VARCHAR2(10) NOT NULL ENABLE, 
	JOB_TITLE VARCHAR2(35) NOT NULL ENABLE, 
	MIN_SALARY NUMBER(6,0), 
	MAX_SALARY NUMBER(6,0), 
	 CONSTRAINT JOB_ID_PK PRIMARY KEY (JOB_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.JOB_ID_PKX ON ORA_MIGRA.JOBS (JOB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.GEBAEUDE_BEZEICHNUNG 
   (	ID NUMBER NOT NULL ENABLE, 
	GEBAEUDE_ID NUMBER NOT NULL ENABLE, 
	BEZEICHNUNG_ALTERNATIV VARCHAR2(50) NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.MY_TABLE 
   (	CURRENT_DATE VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.UNIQUE_COL_TABLE 
   (	UNIQ_TAB_COL1 FLOAT(126) NOT NULL ENABLE, 
	UNIQ_TAB_COL2 VARCHAR2(10), 
	UNIQ_TAB_COL3 VARCHAR2(10), 
	UNIQ_TAB_COL4 CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.MITARBEITER_STANDORT_HIST 
   (	MITARBEITER_ID NUMBER(7,0) NOT NULL ENABLE, 
	STANDORT_ID_OLD NUMBER(28,0), 
	DC DATE DEFAULT sysdate NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.RAUM_IN_VERANST_RAUM 
   (	VERANST_RAUM_ID NUMBER NOT NULL ENABLE, 
	RAUM_ID NUMBER(28,0) NOT NULL ENABLE, 
	ETAGE_ID NUMBER(28,0) NOT NULL ENABLE, 
	UMZUG_ETAGE_MARK VARCHAR2(1), 
	 CONSTRAINT RAUM_IN_VERANST_RAUM_PK PRIMARY KEY (VERANST_RAUM_ID, RAUM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.VERANSTALTUNG 
   (	ID NUMBER(8,0) NOT NULL ENABLE, 
	BEGINN DATE, 
	ENDE DATE, 
	THEMA VARCHAR2(120), 
	ANZAHL_TEILNEHMER NUMBER(4,0), 
	KST_KOSTENSTELLE VARCHAR2(12), 
	MITARBEITER_ID NUMBER(7,0) NOT NULL ENABLE, 
	PROJEKT_ID VARCHAR2(28), 
	AUFTRAG_ID VARCHAR2(12), 
	VERANST_TYP_ID NUMBER NOT NULL ENABLE, 
	DC DATE NOT NULL ENABLE, 
	UC VARCHAR2(30) NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	STATUS CHAR(1) NOT NULL ENABLE, 
	SERIEN_NR NUMBER, 
	BETREUER VARCHAR2(50), 
	STATUS_DATUM DATE, 
	AUFTRAG_ID_TEMP NUMBER, 
	SAP_DATUM DATE, 
	KST_KOSTENSTELLE_2 VARCHAR2(12), 
	KOSTENSTELLE_AUSLAND VARCHAR2(12), 
	STANDORT_ID NUMBER NOT NULL ENABLE, 
	MARB_ID_UC NUMBER(7,0) NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.TEST_TABLE 
   (	ID NUMBER, 
	VALUE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.BESTELL_POSITION 
   (	ID FLOAT(126), 
	BESTELLUNG_ID FLOAT(126), 
	LEISTUNG_ID FLOAT(126), 
	ANZAHL FLOAT(126), 
	DC DATE, 
	UC CHAR(1), 
	DM DATE, 
	UM CHAR(1), 
	PREIS NUMBER(*,0), 
	SAP_ABRECHNUNGS_DATUM DATE, 
	VIDEO_GEGENSTELLE_ID FLOAT(126), 
	STATUS CHAR(1), 
	ANZAHL_STORNO FLOAT(126), 
	VERANSTALTUNG_ID NUMBER(*,0), 
	DIENST_TYP CHAR(1), 
	ANZAHL_MANUELL FLOAT(126), 
	ANSPRECHPARTNER_GEGENSTELLE CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.RAUM_TYP 
   (	ID NUMBER NOT NULL ENABLE, 
	BEZEICHNUNG VARCHAR2(30) NOT NULL ENABLE, 
	ANZAHL_PLAETZE VARCHAR2(30) NOT NULL ENABLE, 
	BEZEICHNUNG2 VARCHAR2(60), 
	NUTZUNGSPAUSCHALE NUMBER, 
	VERANSTALT_PUFFER NUMBER(4,0) NOT NULL ENABLE, 
	STORNOZEITRAUM NUMBER(4,0), 
	STORNOGEBUEHR NUMBER(4,0), 
	DC DATE NOT NULL ENABLE, 
	UC VARCHAR2(30) NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	TEMP_AZ_PLAETZE NUMBER(4,0), 
	PREIS_NACH_SAP_UEBERTR CHAR(1) NOT NULL ENABLE, 
	INAKTIV CHAR(1) NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.STUNDEN_META 
   (	BEGINN_CHR CHAR(1), 
	ENDE_CHR CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.ETAGE 
   (	ID NUMBER(28,0) NOT NULL ENABLE, 
	GEBAEUDEID NUMBER(28,0) NOT NULL ENABLE, 
	DC DATE DEFAULT sysdate NOT NULL ENABLE, 
	UC VARCHAR2(30) DEFAULT user NOT NULL ENABLE, 
	ETAGE VARCHAR2(2) NOT NULL ENABLE, 
	LOCKED VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	TRAG NUMBER(6,2), 
	VERKEHR NUMBER(6,2), 
	SCHALL NUMBER(2,0), 
	DELDAT DATE, 
	PROJEKTID NUMBER(28,0), 
	HOEHE_GR NUMBER(6,2), 
	BGF NUMBER(9,2), 
	BGF_B NUMBER(9,2), 
	BGF_C NUMBER(9,2), 
	STANDO_ID NUMBER(28,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;
 CREATE TABLE ORA_MIGRA.LOCATIONS 
   (	LOCATION_ID NUMBER(4,0) NOT NULL ENABLE, 
	STREET_ADDRESS VARCHAR2(40), 
	POSTAL_CODE VARCHAR2(12), 
	CITY VARCHAR2(30) NOT NULL ENABLE, 
	STATE_PROVINCE VARCHAR2(25), 
	COUNTRY_ID CHAR(2), 
	 CONSTRAINT LOC_ID_PK PRIMARY KEY (LOCATION_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.LOC_ID_PKX ON ORA_MIGRA.LOCATIONS (LOCATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE, 
	 CONSTRAINT LOC_C_ID_FK FOREIGN KEY (COUNTRY_ID)
	  REFERENCES ORA_MIGRA.COUNTRIES (COUNTRY_ID) ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;
  
  CREATE TABLE ORA_MIGRA.DEPARTMENTS 
   (	DEPARTMENT_ID NUMBER(4,0) NOT NULL ENABLE, 
	DEPARTMENT_NAME VARCHAR2(30) NOT NULL ENABLE, 
	MANAGER_ID NUMBER(6,0), 
	LOCATION_ID NUMBER(4,0), 
	 CONSTRAINT DEPT_ID_PK PRIMARY KEY (DEPARTMENT_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.DEPT_ID_PKX ON ORA_MIGRA.DEPARTMENTS (DEPARTMENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE, 
	 CONSTRAINT DEPT_LOC_FK FOREIGN KEY (LOCATION_ID)
	  REFERENCES ORA_MIGRA.LOCATIONS (LOCATION_ID) ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;
  
  CREATE TABLE ORA_MIGRA.EMPLOYEES 
   (	EMPLOYEE_ID NUMBER(6,0) NOT NULL ENABLE, 
	FIRST_NAME VARCHAR2(20), 
	LAST_NAME VARCHAR2(25) NOT NULL ENABLE, 
	EMAIL VARCHAR2(25) NOT NULL ENABLE, 
	PHONE_NUMBER VARCHAR2(20), 
	HIRE_DATE DATE NOT NULL ENABLE, 
	JOB_ID VARCHAR2(10) NOT NULL ENABLE, 
	SALARY NUMBER(8,2) NOT NULL ENABLE, 
	COMMISSION_PCT NUMBER(2,2), 
	MANAGER_ID NUMBER(6,0), 
	DEPARTMENT_ID NUMBER(4,0), 
	 CONSTRAINT EMP_EMAIL_UK UNIQUE (EMAIL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS  ENABLE, 
	 CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY (EMPLOYEE_ID)
  USING INDEX (CREATE UNIQUE INDEX ORA_MIGRA.EMP_EMP_ID_PKX ON ORA_MIGRA.EMPLOYEES (EMPLOYEE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS )  ENABLE, 
	 CONSTRAINT CONSTR_FIRST_NOT_NULL UNIQUE (PHONE_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS  ENABLE, 
	 CONSTRAINT EMP_SALARY_MIN CHECK ( salary > 0) ENABLE, 
	 CONSTRAINT EMP_JOB_FK FOREIGN KEY (JOB_ID)
	  REFERENCES ORA_MIGRA.JOBS (JOB_ID) ENABLE, 
	 CONSTRAINT EMP_DEPT_FK FOREIGN KEY (DEPARTMENT_ID)
	  REFERENCES ORA_MIGRA.DEPARTMENTS (DEPARTMENT_ID) ENABLE, 
	 CONSTRAINT EMP_MANAGER_FK FOREIGN KEY (MANAGER_ID)
	  REFERENCES ORA_MIGRA.EMPLOYEES (EMPLOYEE_ID) ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;


  CREATE TABLE ORA_MIGRA.DIENSTLEISTER 
   (	ID NUMBER NOT NULL ENABLE, 
	BEZEICHNUNG VARCHAR2(60) NOT NULL ENABLE, 
	DIENST_TYP CHAR(1) NOT NULL ENABLE, 
	NAME_1 VARCHAR2(30), 
	NAME_2 VARCHAR2(30), 
	STRASSE VARCHAR2(30) NOT NULL ENABLE, 
	PLZ NUMBER(5,0) NOT NULL ENABLE, 
	ORT VARCHAR2(40) NOT NULL ENABLE, 
	FON VARCHAR2(20) NOT NULL ENABLE, 
	FAX VARCHAR2(20) NOT NULL ENABLE, 
	EMAIL VARCHAR2(256) NOT NULL ENABLE, 
	STANDORT_ID NUMBER(28,0) NOT NULL ENABLE, 
	BESTELLUNG_PROG CHAR(1) NOT NULL ENABLE, 
	BESTELLUNG_FON CHAR(1) NOT NULL ENABLE, 
	BESTELLUNG_FAX CHAR(1) NOT NULL ENABLE, 
	BESTELLUNG_EMAIL CHAR(1) NOT NULL ENABLE, 
	BESTAETIGUNG_PROG CHAR(1) NOT NULL ENABLE, 
	BESTAETIGUNG_FON CHAR(1) NOT NULL ENABLE, 
	BESTAETIGUNG_FAX CHAR(1) NOT NULL ENABLE, 
	BESTAETIGUNG_EMAIL CHAR(1) NOT NULL ENABLE, 
	BESTELLZEIT_MINIMAL NUMBER, 
	GESCH_ZEIT_VON DATE, 
	GESCH_ZEIT_BIS DATE, 
	BEMERKUNGEN VARCHAR2(60), 
	ANLIEFERUNG_MOEGLICH CHAR(1), 
	ABTRANSPORT_MOEGLICH CHAR(1), 
	DC DATE NOT NULL ENABLE, 
	UC VARCHAR2(30) NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	BESTELLZEIT_MINUTEN NUMBER(3,0), 
	BESTELLZEIT_TAGE NUMBER(2,0), 
	BESTELLZEIT_VORTAG NUMBER, 
	BESTELLUNGEN_AUSSERHALB CHAR(1), 
	VERRECHNUNGSART VARCHAR2(6), 
	HINWEIS_DIENSTLEISTER VARCHAR2(60), 
	HINWEIS_BESTELLER VARCHAR2(60 CHAR), 
	INFO_PER VARCHAR2(5), 
	EINFUEGEN_POS CHAR(1) NOT NULL ENABLE, 
	STORNOZEIT_MINUTEN NUMBER(3,0), 
	STORNOZEIT_TAGE NUMBER(2,0), 
	STORNOZEIT_VORTAG NUMBER, 
	INFO_AN_BESTELLER VARCHAR2(100), 
	HINWEIS_BESTELLER_MBZ VARCHAR2(100), 
	BESTELLUNGEN_AUSSER_MBZ CHAR(1) NOT NULL ENABLE, 
	MELDUNG_AKTIV CHAR(1) NOT NULL ENABLE, 
	MELDUNGS_ZEITSPANNE NUMBER(4,0), 
	INAKTIV CHAR(1) NOT NULL ENABLE, 
	BESTELLZEIT_AKTUELLER_TAG NUMBER, 
	HTTP_LINK VARCHAR2(200), 
	HINWEISE_BESTELLER_MAX_ANZ_TAG VARCHAR2(100), 
	HINWEIS_BESTELLZEIT_AKT_TAG VARCHAR2(200), 
	RAUM_ERFORDERLICH CHAR(1) NOT NULL ENABLE, 
	LIEFERART_ERFORDERLICH CHAR(1) NOT NULL ENABLE, 
	ZEIT_ERFORDERLICH CHAR(1) NOT NULL ENABLE, 
	BEWIRTUNGSART_ERFORDERLICH CHAR(1) NOT NULL ENABLE, 
	TEILNEHMER_ERFORDERLICH CHAR(1) NOT NULL ENABLE, 
	SORTIERUNG_WEB NUMBER, 
	KONTAKT VARCHAR2(100), 
	GAESTEANMELDUNG_DL_JN CHAR(1) NOT NULL ENABLE, 
	MELDUNG_BEI_FEHLER_ANMELDUNG VARCHAR2(2000), 
	EMAIL_FEHLER_ANMELDUNG VARCHAR2(100), 
	RAUMBUCHUNGSDAUER_MINIMAL NUMBER(4,0), 
	RAUMBUCHUNGSDAUER_MIN_MELDUNG VARCHAR2(100), 
	EXTERNE_TEILN_ERF_JN CHAR(1), 
	EXTERNE_TEILN_ERF_JN_MLD VARCHAR2(100), 
	FREITEXT_BEI_VERANSTR_MOEGL_JN CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.STUHL_TYP 
   (	ID NUMBER NOT NULL ENABLE, 
	BEZEICHNUNG1 VARCHAR2(30) NOT NULL ENABLE, 
	BEZEICHNUNG2 VARCHAR2(60), 
	DC DATE NOT NULL ENABLE, 
	UC VARCHAR2(30) NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;



  CREATE TABLE ORA_MIGRA.TBL_DBLNK 
   (	COL_INT FLOAT(126), 
	COL_NBR NUMBER(6,2), 
	COL_CHAR CHAR(4), 
	COL_VC2 VARCHAR2(50), 
	COL_DT DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.COMP_KEY_TABLE 
   (	PK1 FLOAT(126) NOT NULL ENABLE, 
	PK2 FLOAT(126) NOT NULL ENABLE, 
	COL1 FLOAT(126)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.BESTELLUNG 
   (	VERANST_RAUM_SAP_GEB_EURO FLOAT(126), 
	STORNO_DATUM DATE, 
	VERANST_RAUM_STORNO_GEB_EURO FLOAT(126), 
	SAP_POTENZIELL_ZU_VERR_JN CHAR(1), 
	THEMA CHAR(1), 
	ID FLOAT(126), 
	LFD_NR FLOAT(126), 
	VERANSTALTUNG_ID NUMBER(*,0), 
	DIENST_TYP CHAR(1), 
	DIENSTLEISTER_ID FLOAT(126), 
	BESTAET_FAX CHAR(1), 
	BESTAET_FON CHAR(1), 
	BESTAET_EMAIL CHAR(1), 
	BESTAET_STATUS CHAR(1), 
	BEMERKUNG1 CHAR(1), 
	BEMERKUNG2 CHAR(1), 
	BEGINN_TERMIN DATE, 
	ENDE_TERMIN DATE, 
	ANZAHL_GAESTE NUMBER(*,0), 
	ANZAHL_GASTGEBER NUMBER(*,0), 
	VERANST_RAUM_ID FLOAT(126), 
	BESTUHL_VARIANTE_ID FLOAT(126), 
	BEGINN_VERANTWORTLICH CHAR(1), 
	ENDE_VERANTWORTLICH CHAR(1), 
	BEGINN_ORT CHAR(1), 
	ENDE_ORT CHAR(1), 
	WIEDERVORLAGE_DATUM DATE, 
	ANLIEFERART CHAR(1), 
	ABHOLART CHAR(1), 
	BEWIRTUNGSART CHAR(1), 
	BEFOERDERUNGSART CHAR(1), 
	FAHRAUFTRAG_ID FLOAT(126), 
	DC DATE, 
	UC CHAR(1), 
	DM DATE, 
	UM CHAR(1), 
	WARTELISTE_DATUM DATE, 
	BEGINN_PUFFER DATE, 
	AUSGABE_MA_ID NUMBER(*,0), 
	RUECKGABE_MA_ID NUMBER(*,0), 
	AUSGABE_GAST_ID FLOAT(126), 
	RUECKGABE_GAST_ID FLOAT(126), 
	AUSGABE_TERMIN DATE, 
	RUECKGABE_TERMIN DATE, 
	VERBINDUNGSAUFBAU_DL CHAR(1), 
	SAP_ABRECHNUNGS_DATUM DATE, 
	ANZAHL_SITZPLAETZE NUMBER(*,0), 
	BESTELLUNG_ID FLOAT(126), 
	VIDEO_BESTELLUNG_ID FLOAT(126), 
	AUFTRAGSART_ID FLOAT(126), 
	DIENSTLEISTER_RAUM_ID FLOAT(126), 
	SAP_ABRECHNUNG_SPERREN CHAR(1), 
	BEMERKUNG_INTERN CHAR(1), 
	VIDEO_KONFERENZ_ID FLOAT(126), 
	OLD_ID FLOAT(126), 
	VIDEO_MASTER_ORDER CHAR(1), 
	BETREUER_MITARBEITER_ID FLOAT(126), 
	BETREUER_TELEFON_NR CHAR(1), 
	BETREUER_AUSWEISNUMMER CHAR(1), 
	ANGELEGT_DURCH_OUTLOOK CHAR(1), 
	OUTLOOK_TEILNEHMER CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.DATAMIGTESTING 
   (	ID NUMBER, 
	COLUMN1 VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.STANDORT 
   (	ID NUMBER(28,0) NOT NULL ENABLE, 
	STANDORT VARCHAR2(100) NOT NULL ENABLE, 
	BEZEICHNUNG VARCHAR2(2000), 
	UC VARCHAR2(30) NOT NULL ENABLE, 
	DC DATE NOT NULL ENABLE, 
	UM VARCHAR2(30), 
	DM DATE, 
	DEFAULT_DATENSERVER VARCHAR2(80), 
	DEFAULT_DATENSERVER_HOST VARCHAR2(80), 
	KUERZEL VARCHAR2(3) NOT NULL ENABLE, 
	KUERZEL_BIDS VARCHAR2(10) NOT NULL ENABLE, 
	BER_ROLLE VARCHAR2(30), 
	SAP_WELT_ID NUMBER(7,0), 
	LAND_ID NUMBER(7,0) NOT NULL ENABLE, 
	ZEITZONE_ID NUMBER(7,0) NOT NULL ENABLE, 
	ZEITZONE_ORACLE_NAME_ID NUMBER(7,0) NOT NULL ENABLE, 
	CAD_WELT_ID NUMBER(7,0) DEFAULT 1 NOT NULL ENABLE, 
	DEFAULT_SPRACHE_ID NUMBER(7,0) NOT NULL ENABLE, 
	DIN_277_AUS_FLAE_BEZ_JN CHAR(1) DEFAULT 'N' NOT NULL ENABLE, 
	DELDAT DATE, 
	DEL_BEMERKUNG VARCHAR2(200), 
	DEFAULT_DOMAENE_ID NUMBER(7,0) NOT NULL ENABLE, 
	TYP_KURZ CHAR(1) DEFAULT 'B' NOT NULL ENABLE, 
	RAUMBUCH_GEPFLEGT_JN VARCHAR2(1) DEFAULT 'N', 
	FLAECHE_EINH_ID NUMBER, 
	WAEHRUNG_ID NUMBER, 
	BEMERKUNG VARCHAR2(400), 
	STANDORT_RAUM_NR_CHECK_ID NUMBER(7,0) DEFAULT 2 NOT NULL ENABLE, 
	LATITUDE NUMBER(9,6), 
	LONGITUDE NUMBER(9,6)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.CNV_DISC_SYSDAT 
   (	SECU_CUS_ID CHAR(9), 
	MSG_EXPT_DT DATE, 
	LOAD_DT DATE DEFAULT CURRENT_TIMESTAMP
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.SOLIDS 
   (	LENGTH FLOAT(126), 
	WIDTH FLOAT(126), 
	HEIGHT FLOAT(126), 
	VOLUME FLOAT(126)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.WEB_STANDORT 
   (	ID NUMBER NOT NULL ENABLE, 
	STANDORT_ID NUMBER NOT NULL ENABLE, 
	SICHTBAR_IM_WEB CHAR(1) NOT NULL ENABLE, 
	BESCHREIBUNG VARCHAR2(100) NOT NULL ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.JOB_HISTORY 
   (	EMPLOYEE_ID FLOAT(126) NOT NULL ENABLE, 
	START_DATE DATE NOT NULL ENABLE, 
	END_DATE DATE NOT NULL ENABLE, 
	JOB_ID VARCHAR2(10) NOT NULL ENABLE, 
	DEPARTMENT_ID FLOAT(126)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.CLIENTS 
   (	CLIENT_ID FLOAT(126) NOT NULL ENABLE, 
	FIRST_NAME VARCHAR2(50) NOT NULL ENABLE, 
	LAST_NAME VARCHAR2(50) NOT NULL ENABLE, 
	COMPANY_NAME VARCHAR2(255) NOT NULL ENABLE, 
	EMAIL VARCHAR2(255) NOT NULL ENABLE, 
	PHONE VARCHAR2(25)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;

  CREATE TABLE ORA_MIGRA.GEBAEUDE 
   (	ID NUMBER(28,0) NOT NULL ENABLE, 
	KOSTENSTELLENID VARCHAR2(12), 
	DC DATE DEFAULT sysdate NOT NULL ENABLE, 
	UC VARCHAR2(30) DEFAULT user NOT NULL ENABLE, 
	GEBAEUDE VARCHAR2(5) NOT NULL ENABLE, 
	LOCKED VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	DM DATE, 
	UM VARCHAR2(30), 
	LAENGE NUMBER(6,2), 
	BREITE NUMBER(6,2), 
	HOEHE NUMBER(6,2), 
	RASTERX NUMBER(6,2), 
	RASTERY NUMBER(6,2), 
	HNG NUMBER(6,2), 
	BGF NUMBER(9,2), 
	NUTZARTID NUMBER(28,0), 
	GENEHMIGUNGID NUMBER(28,0), 
	BRILTG NUMBER(9,2), 
	BRI NUMBER(9,2), 
	NRI NUMBER(9,2), 
	BAUJAHR DATE, 
	NUTZBEGINN DATE, 
	WERT NUMBER(11,2), 
	HERSTELLUNGSKOST NUMBER(11,2), 
	MAFEM NUMBER(4,0), 
	MAMALE NUMBER(4,0), 
	DELDAT DATE, 
	BAUGRUND VARCHAR2(2000), 
	GRUNDWASSER NUMBER(6,1), 
	GRUENDUNGSARTID NUMBER(28,0), 
	TRAGKONST VARCHAR2(2000), 
	DACHKONST VARCHAR2(2000), 
	TEILKLIMA VARCHAR2(1), 
	VOLLKLIMA VARCHAR2(1), 
	FENSTERLUEFT VARCHAR2(1), 
	ZWANGSLUEFT VARCHAR2(1), 
	FASSADENART VARCHAR2(2000), 
	KWERT NUMBER(6,2), 
	FASSADENFL NUMBER(10,1), 
	FENSTERFL NUMBER(10,1), 
	BEZEICHNUNG VARCHAR2(60), 
	STANDORTID NUMBER(28,0) NOT NULL ENABLE, 
	SEKTOR VARCHAR2(1), 
	STATUS VARCHAR2(1) DEFAULT 'V' NOT NULL ENABLE, 
	EVA_ZAEHLER_FOLGE_NR NUMBER(5,0), 
	KLIMATISIERUNG CHAR(1), 
	BUCHUNGSKREIS NUMBER(4,0), 
	BGF_B NUMBER(9,2), 
	BGF_C NUMBER(9,2), 
	BRI_B NUMBER(9,2), 
	BRI_C NUMBER(9,2), 
	BETREUENDE_EINHEIT_ID NUMBER(28,0), 
	GEBAEUDETYP_ID NUMBER(28,0), 
	BAUFELD_ID NUMBER(28,0), 
	LETZTER_UMBAU DATE, 
	GRF NUMBER(9,2), 
	HAUPTGEBAEUDE_JN VARCHAR2(1) DEFAULT 'J' NOT NULL ENABLE, 
	KURZ_BEZEICHNUNG VARCHAR2(10), 
	MARA_GS_KLEINSTES_BUERO_QM NUMBER(5,2), 
	MARA_GS_KLEINSTER_ARBPLATZ_QM NUMBER(5,2), 
	MARA_GS_KOMMUNIKATIONS_ANT_QM NUMBER(5,2), 
	ZK_GEBAEUDEEINSTUFUNG_ID NUMBER(7,0), 
	ZK_ZUTRITTSSICHERUNGS_ART_ID NUMBER(7,0), 
	ZK_SCHUTZSTUFE_ID NUMBER(7,0), 
	ZK_STATUS_ID NUMBER(7,0), 
	OWNER_TYP_KURZ CHAR(1) DEFAULT 'O' NOT NULL ENABLE, 
	BEMERKUNG VARCHAR2(400), 
	IT_REF VARCHAR2(3), 
	REAL_ESTATE_SITE_ID NUMBER, 
	CORA_NR VARCHAR2(15), 
	FLAE_VERR_KST VARCHAR2(12), 
	LATITUDE NUMBER(9,6), 
	LONGITUDE NUMBER(9,6), 
	BILD BLOB DEFAULT NULL, 
	BILD_NAME VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (BILD) STORE AS SECUREFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;

  CREATE TABLE ORA_MIGRA.DATEI_AUSGABE 
   (	ID NUMBER NOT NULL ENABLE, 
	DATEI_NAME VARCHAR2(255) NOT NULL ENABLE, 
	DATEI_INHALT CLOB NOT NULL ENABLE, 
	DATEI_TYP VARCHAR2(10) NOT NULL ENABLE, 
	REFERENZ_ID NUMBER, 
	BEMERKUNG VARCHAR2(256), 
	TERMIN_FREIGABE DATE NOT NULL ENABLE, 
	TERMIN_GESCHRIEBEN DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (DATEI_INHALT) STORE AS SECUREFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;

/* DROPPING TABLES....

DROP TABLE ORA_MIGRA.SAP_ABRECHNUNGS_TERMINE ;
DROP TABLE ORA_MIGRA.MITARBEITER_BI_ALLE ;
DROP TABLE ORA_MIGRA.DATE_TABLE ;
DROP TABLE ORA_MIGRA.RAUM ;
DROP TABLE ORA_MIGRA.ETAGENNUMMERN ;
DROP TABLE ORA_MIGRA.CHAR_TABLE ;
DROP TABLE ORA_MIGRA.STUNDEN ;
DROP TABLE ORA_MIGRA.GEBAEUDE_BEZEICHNUNG ;
DROP TABLE ORA_MIGRA.MY_TABLE ;
DROP TABLE ORA_MIGRA.UNIQUE_COL_TABLE ;
DROP TABLE ORA_MIGRA.MITARBEITER_STANDORT_HIST ;
DROP TABLE ORA_MIGRA.RAUM_IN_VERANST_RAUM ;
DROP TABLE ORA_MIGRA.VERANSTALTUNG ;
DROP TABLE ORA_MIGRA.TEST_TABLE ;
DROP TABLE ORA_MIGRA.BESTELL_POSITION ;
DROP TABLE ORA_MIGRA.RAUM_TYP ;
DROP TABLE ORA_MIGRA.STUNDEN_META ;
DROP TABLE ORA_MIGRA.ETAGE ;
DROP TABLE ORA_MIGRA.EMPLOYEES ;
DROP TABLE ORA_MIGRA.DEPARTMENTS ;
DROP TABLE ORA_MIGRA.LOCATIONS ;
DROP TABLE ORA_MIGRA.JOBS ;
DROP TABLE ORA_MIGRA.DIENSTLEISTER ;
DROP TABLE ORA_MIGRA.STUHL_TYP ;
DROP TABLE ORA_MIGRA.TBL_DBLNK ;
DROP TABLE ORA_MIGRA.COMP_KEY_TABLE ;
DROP TABLE ORA_MIGRA.BESTELLUNG ;
DROP TABLE ORA_MIGRA.DATAMIGTESTING ;
DROP TABLE ORA_MIGRA.STANDORT ;
DROP TABLE ORA_MIGRA.CNV_DISC_SYSDAT ;
DROP TABLE ORA_MIGRA.SOLIDS ;
DROP TABLE ORA_MIGRA.WEB_STANDORT ;
DROP TABLE ORA_MIGRA.JOB_HISTORY ;
DROP TABLE ORA_MIGRA.CLIENTS ;
DROP TABLE ORA_MIGRA.GEBAEUDE ;
DROP TABLE ORA_MIGRA.DATEI_AUSGABE ;
DROP TABLE ORA_MIGRA.COUNTRIES ;
DROP TABLE ORA_MIGRA.REGIONS ;
DROP TABLE ORA_MIGRA.BESTELLUNG_CHANGED_MAIL_AN_AN ;
DROP TABLE ORA_MIGRA.LEISTUNG ;
DROP TABLE ORA_MIGRA.BPELEMPLOYEES ;
DROP TABLE ORA_MIGRA.VERANST_RAUM ;
DROP TABLE ORA_MIGRA.BESTELLUNG_CHANGED_MAIL_AN_DL ;

*/