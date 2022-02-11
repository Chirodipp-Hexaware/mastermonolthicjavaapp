
  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ORA_MIGRA.SECURE_DML 
IS  
BEGIN  
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'  
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN  
	RAISE_APPLICATION_ERROR (-20205,   
		'You may only make changes during normal office hours');  
  END IF;  
END secure_dml; 
/

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ORA_MIGRA.SECURE_DML_NEW 
IS  
BEGIN  
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'  
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN  
	RAISE_APPLICATION_ERROR (-20205, 'You may only make changes during normal office hours');  
  END IF;  
END secure_dml_new; 
/

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ORA_MIGRA.SAVE_SOLID (len INTEGER, wid INTEGER, hgt INTEGER)  
IS  
BEGIN  
    DECLARE
      solid solid_typ;
      vol INTEGER;
    BEGIN -- PL/SQL block for selecting a solid and displaying details
      solid:=solid_typ(len,wid,hgt);
      vol:= solid.volume();

      INSERT INTO solids (length, width , height , volume )
        values (solid.len,solid.wth,solid.hgt,vol);
      commit;
    END;
END save_solid; 
/

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ORA_MIGRA.ADD_JOB_HISTORY 
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ORA_MIGRA.SAMPLE_PROC 
IS
BEGIN 
   -- enable the buffer with default size 20000 
   dbms_output.enable; 

   dbms_output.put_line('Hello Reader!'); 
   dbms_output.put_line('Hope you have enjoyed the tutorials!'); 
   dbms_output.put_line('Have a great time exploring pl/sql!');     
END;
/

/*
DROP PROCEDURE ORA_MIGRA.SECURE_DML ;
DROP PROCEDURE ORA_MIGRA.SECURE_DML_NEW ;
DROP PROCEDURE ORA_MIGRA.SAVE_SOLID ;
DROP PROCEDURE ORA_MIGRA.ADD_JOB_HISTORY ;
DROP PROCEDURE ORA_MIGRA.SAMPLE_PROC ;

*/

