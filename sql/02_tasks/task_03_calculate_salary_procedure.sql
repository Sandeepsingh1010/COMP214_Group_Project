/* Task 3
Create stored procedure CALCULATE_SALARY.
Input: employee ID.
Use loop logic to calculate salary based on years worked.
Base salary first year = 10000. Increase 5% every following year.
Print first name, last name, salary.
If employee does not exist, display proper message.

The company wants to calculate the employees’ annual salary:
The first year of employment, the amount of salary is the base salary which is $10,000.
Every year after that, the salary increases by 5%.
Write a stored procedure named calculate_salary which gets an employee ID and for that employee calculates the salary based on the number of years the employee has been working in the company. (Use a loop construct to calculate the salary).
The procedure calculates and prints the salary.
Sample output:
First Name: first_name
Last Name: last_name
Salary: $9999,99
If the employee does not exists, the procedure displays a proper message.
*/

-- TODO: implement procedure calculate_salary

SELECT * FROM employees_a;

SET SERVEROUTPUT ON
-- Task 3 Code--
CREATE OR REPLACE PROCEDURE pr_calc_salary (
    lv_emp_id IN employees_a.employee_id%TYPE
)
AS
    lv_salary employees_a.salary%TYPE := 10000;
    lv_first_name employees_a.first_name%TYPE;
    lv_last_name employees_a.last_name%TYPE;
    lv_hire_date DATE;
    lv_experiance NUMBER;
BEGIN
    SELECT first_name, last_name, hire_date INTO lv_first_name, lv_last_name, lv_hire_date
    FROM employees_a
    WHERE employee_id = lv_emp_id;
    
    lv_experiance := TRUNC(MONTHS_BETWEEN(SYSDATE, lv_hire_date) / 12) ;
 --   lv_experiance := 2 ;
    FOR i IN 1..lv_experiance LOOP
        lv_salary := lv_salary +( lv_salary * 0.05);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('First Name: ' || lv_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || lv_last_name);
    DBMS_OUTPUT.PUT_LINE('Salary after working ' || lv_experiance || ' years: $' ||lv_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist. ' || SQLERRM );
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error calculating salary. ' || SQLERRM );
END;
/

-- Task 3 Tests--
BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    DBMS_OUTPUT.PUT_LINE('Task 3: Calculate Salary:');
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Employee ID: 104');
    pr_calc_salary(104);
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Employee ID: 300');
    pr_calc_salary(300);
END;
/