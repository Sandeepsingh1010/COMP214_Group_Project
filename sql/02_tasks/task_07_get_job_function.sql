/* Task 7
Create and invoke the GET_JOB function to return a job title based on an employee ID.

a) Create and compile a function called GET_JOB that accepts an employee ID and returns the job title of that employee.

b) Create a VARCHAR2 host variable called b_title with a length of 35 characters. 
Invoke the function with employee ID 101, store the result in the host variable, and print the host variable to view the result.
*/

SET SERVEROUTPUT ON
-- Task 7 Code--
CREATE OR REPLACE FUNCTION GET_JOB (
    fv_emp_id employees_a.employee_id%TYPE
) RETURN employees_a.job_id%TYPE
AS
    lv_job_id employees_a.job_id%TYPE;
BEGIN
    SELECT job_id INTO lv_job_id
    FROM employees_a
    WHERE employee_id = fv_emp_id;
    RETURN lv_job_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Employee ID not found: ' || fv_emp_id);
END;
/

-- Task 7 Tests--
VARIABLE b_title VARCHAR2(35);
BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Job Id 100');
    :b_title := GET_JOB(100);
    DBMS_OUTPUT.PUT_LINE('The job title with employee ID 100 is ' || :b_title || '.');
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Job Id 500');
    :b_title := GET_JOB(500);
    DBMS_OUTPUT.PUT_LINE('The job title with employee ID 500 is ' || :b_title || '.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/