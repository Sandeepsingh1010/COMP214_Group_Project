/* Task 9
The task assigned is to prevent rows in employees table from being deleted during business hours.
a.
Write a statement trigger called Remove_employee_trigger on the employees table 
to prevent rows from being deleted during weekday business hours, which are from 9:00 AM through 6:00 PM.
b.
Attempt to delete employees with job_id of SA_REP who are not assigned to a department.
*/

-- Task 8 Code--
CREATE OR REPLACE TRIGGER Remove_employee_trigger
BEFORE DELETE ON employees
BEGIN
    IF TO_NUMBER(TO_CHAR(SYSTIMESTAMP, 'HH24')) BETWEEN 8 AND 17 -- Using 17 because between works inclusively.
    AND TO_NUMBER(TO_CHAR(SYSDATE, 'D')) BETWEEN 1 AND 6 THEN --Weekdays starts from sunday = 1
        RAISE_APPLICATION_ERROR(-20001, 'Delect can be performed only on weekdays from 9:00 AM to 6:00 PM.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER remove_employee_trigger
BEFORE DELETE ON employees
BEGIN
    IF TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') IN ('MON', 'TUE', 'WED', 'THU', 'FRI')
       AND TO_CHAR(SYSDATE, 'HH24MI') BETWEEN '0900' AND '1800' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employees cannot be deleted during weekday business hours (9 AM to 6 PM).');
    END IF;
END;
/

-- Task 8 Test--
SELECT *
FROM employees
WHERE emp_id = 1017;

DELETE FROM employees
WHERE emp_id = 1017;

ROLLBACK;

SELECT SYSTIMESTAMP FROM dual;

-- Get hour/minute/second as text parts
SELECT
    TO_CHAR(SYSTIMESTAMP, 'HH24') AS current_hour,
    TO_CHAR(SYSTIMESTAMP, 'MI')   AS current_minute,
    TO_CHAR(SYSTIMESTAMP, 'SS')   AS current_second
FROM dual;

-- HH24 text format
SELECT TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS') AS current_time
FROM dual;

SELECT TO_CHAR(SYSDATE, 'D') AS weekday_number FROM dual;



SELECT * FROM departments;
SELECT * FROM countries_a;
SELECT * FROM location_a;
SELECT * FROM departments;
SELECT * FROM employees_a;
SELECT * FROM job_grades;
SELECT * FROM job_history;