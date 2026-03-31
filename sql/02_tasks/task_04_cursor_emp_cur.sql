/* Task 4
Create a PL/SQL block to declare a cursor EMP_CUR to select the employee’s name,
salary, and hire date from the employee’s table.
Process each row from the cursor, and
if the salary is greater than 15,000 and the hire date is greater than 01-FEB-1988, display
the employee’s name, salary, and hire date.
*/

-- TODO: implement anonymous PL/SQL block
SET SERVEROUTPUT ON;

-- Task 4 Code--
DECLARE
    CURSOR EMP_CUR IS
        SELECT first_name || ' ' || last_name AS name, salary, hire_date
        FROM employees_a;
BEGIN
    FOR row_emp IN EMP_CUR LOOP
        IF row_emp.salary > 15000 AND
        row_emp.hire_date > TO_DATE('1988-02-01', 'YYYY-MM-DD') THEN
            DBMS_OUTPUT.PUT_LINE(row_emp.name || ' Joined on ' ||
            row_emp.hire_date || ' and has salary $' || row_emp.salary);
        END IF;
    END LOOP;
END;
/

