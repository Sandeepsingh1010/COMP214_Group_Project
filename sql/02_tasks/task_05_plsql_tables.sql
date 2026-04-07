/* Task 5
Create a PL/SQL block to retrieve the last name and department ID of each employee
from the EMPLOYEES table for those employees whose EMPLOYEE_ID is less than 114.

From the values retrieved from the employees table, populate two PL/SQL tables, one
to store the records of the employee last names and the other to store the records of
their department IDs.

Using a loop, retrieve the employee’s name information and the
salary information from the PL/SQL tables and display it in the window, using
DBMS_OUTPUT.PUT_LINE. Display these details for the first 15 employees in the PL/SQL
tables.
*/

-->> Question for Proffessor:
--      Display the Salary information ? or Department ID?
--      Do we need to make Records here ?

SET SERVEROUTPUT ON;

-- Task 5 Code--
DECLARE
    TYPE t_last_name IS TABLE OF employees_a.last_name%TYPE INDEX BY PLS_INTEGER;
    TYPE t_dep_id IS TABLE OF employees_a.department_id%TYPE INDEX BY PLS_INTEGER;
    lt_last_name t_last_name;
    lt_dep_id t_dep_id;
BEGIN
    SELECT last_name, department_id
    BULK COLLECT INTO lt_last_name, lt_dep_id
    FROM employees_a
    WHERE employee_id < 114
    ORDER BY employee_id
    FETCH FIRST 15 ROWS ONLY;

    IF lt_last_name.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found.');
    END IF;
    
    FOR i IN 1..lt_last_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Last name: ' || lt_last_name(i) || ' Department ID: ' || lt_dep_id(i));
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
