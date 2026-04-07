/* Task 9
The task assigned is to prevent rows in employees table from being deleted during business hours.
a.
Write a statement trigger called Remove_employee_trigger on the employees table 
to prevent rows from being deleted during weekday business hours, which are from 9:00 AM through 6:00 PM.
b.
Attempt to delete employees with job_id of SA_REP who are not assigned to a department.
*/

-- Task 9 Code--
CREATE OR REPLACE TRIGGER Remove_employee_trigger
BEFORE DELETE ON employees_a
BEGIN
    IF TO_NUMBER(TO_CHAR(SYSTIMESTAMP, 'HH24MI')) BETWEEN 0900 AND 1800
    AND TO_NUMBER(TO_CHAR(SYSDATE, 'D')) BETWEEN 1 AND 6 THEN --Weekdays starts from sunday = 1
        RAISE_APPLICATION_ERROR(-20000, 'Can not Delect employee during weekdays from 9:00 AM to 6:00 PM.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error calculating salary. ' || SQLERRM );
END;
/

-- Task 9 Test--
SELECT *
FROM employees_a
WHERE job_id = 'SA_REP'
AND department_id IS NULL;

DELETE FROM employees_a
WHERE job_id = 'SA_REP'
AND department_id IS NULL;

ROLLBACK;