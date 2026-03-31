/* Task 6
Create a PL/SQL block that declares a cursor called DATE_CUR. Pass a parameter of
DATE data type to the cursor and print the details of all the employees who have
joined after that date.

SET SERVEROUTPUT ON
DEFINE P_HIREDATE = 01-FEB-88

*/

-- Task 6 Code--
DECLARE
    lv_hiredate DATE := TO_DATE('01-FEB-1988', 'DD-MON-YYYY');

    CURSOR DATE_CUR (p_hiredate DATE) IS
        SELECT *
        FROM employees_a
        WHERE hire_date > p_hiredate;
BEGIN
    DBMS_OUTPUT.PUT_LINE('  List of Employees Hired after ' ||
    TO_CHAR(lv_hiredate, 'DD-MON-YYYY') || ':' );
    FOR r_emp IN DATE_CUR(lv_hiredate) LOOP
        DBMS_OUTPUT.PUT_LINE('Hire Date of Employee ID: ' ||
        r_emp.employee_id || ' , ' || r_emp.first_name || ' ' ||
        r_emp.last_name || ' : ' ||
        TO_CHAR(r_emp.hire_date, 'DD-MON-YYYY'));
    END LOOP;
END;
/