/* Task 8
Create a function called GET_ANNUAL_COMP to return the annual salary computed from an employee’s monthly salary and commission passed as parameters.
a)
Create the GET_ANNUAL_COMP function, which accepts parameter values for the monthly
salary and commission. Either or both values passed can be NULL, but the function should
still return a non-NULL annual salary. Use the following basic formula to calculate the annual
salary:
(salary*12) + (commission_pct * salary * 12)
b)
Use the function in a SELECT statement against the EMPLOYEES table for employees in
department 50.
*/

SET SERVEROUTPUT ON
-- Task 8 Code--
CREATE OR REPLACE FUNCTION GET_ANNUAL_COMP (
    fv_salary_monthly employees_a.salary%TYPE,
    fv_commission_pct employees_a.commission_pct%TYPE
) RETURN employees_a.salary%TYPE
AS
    lv_salary_annual employees_a.salary%TYPE;
    lv_commission_pct employees_a.commission_pct%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(fv_salary_monthly);
    IF fv_salary_monthly IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Salary input ! Returning 0');
        RETURN 0;
    ELSIF fv_salary_monthly < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Salary cant be negative ! Returning 0');
        RETURN 0;
    END IF;
    
    IF fv_commission_pct IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Invalid commission ! considering 0');
        lv_commission_pct := 0;
    ELSIF fv_commission_pct < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Commission cant be negative ! considering 0');
        lv_commission_pct := 0;
    ELSE lv_commission_pct := fv_commission_pct;
    END IF;
    
    lv_salary_annual := (fv_salary_monthly*12) + (lv_commission_pct * fv_salary_monthly * 12);
    RETURN lv_salary_annual;
END;
/

-- Task 8 Test--
SELECT salary,
    commission_pct,
    department_id,
    GET_ANNUAL_COMP(salary, commission_pct) AS Annual_Salary
FROM employees_a
WHERE department_id = 50;