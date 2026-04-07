/*
Final submission file compiled from the task scripts.
*/

SET SERVEROUTPUT ON;
/* Task 1
Write a store procedure that gets an integer number n and calculates and displays its factorial.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 1----');
END;
/

-- Task 1 Code--
CREATE OR REPLACE PROCEDURE pr_factorial (
	lv_n IN NUMBER
)
AS
	lv_product NUMBER := 1;
BEGIN
	IF lv_n < 0 THEN
		RAISE_APPLICATION_ERROR(-20000, 'Input Must be a positive number');
	END IF;
	FOR i IN 1..lv_n LOOP
		lv_product := lv_product * i;
	END LOOP;
		DBMS_OUTPUT.PUT_LINE(lv_n || '! = ' || lv_product);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error calculating factorial. ' || SQLERRM );
END;
/

-- Task 1 Tests--
BEGIN
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Positive integer: 5');
	pr_factorial(5);
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with integer 0:');
	pr_factorial(0);
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Negative integer : -3');
	pr_factorial(-3);
END;
/

/* Task 2
Write a user-defined function that takes an integer n as input and returns its factorial.
The function should raise an exception if the input is 0 or a negative number.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 2----');
END;
/

-- Task 2 Code--
CREATE OR REPLACE FUNCTION fn_factorial (
	lv_n IN NUMBER
) RETURN NUMBER
AS
	lv_product NUMBER := 1;
BEGIN
	IF lv_n < 0 THEN
		RAISE_APPLICATION_ERROR(-20000, 'Input Must be a positive number');
	ELSIF lv_n = 0 THEN
		RAISE_APPLICATION_ERROR(-20000, 'Input can not be 0');
	END IF;
	FOR i IN 1..lv_n LOOP
		lv_product := lv_product * i;
	END LOOP;
--        DBMS_OUTPUT.PUT_LINE(lv_n || '! = ' || lv_product);
	RETURN lv_product;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error calculating factorial; returning NULL. ' || SQLERRM );
		RETURN NULL;
END;
/

-- Task 2 Tests--
BEGIN
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Positive integer:');
	DBMS_OUTPUT.PUT_LINE('5! = ' || fn_factorial(5));
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with integer: 0');
	DBMS_OUTPUT.PUT_LINE('0! = ' || fn_factorial(0));
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Negative integer: -2');
	DBMS_OUTPUT.PUT_LINE('-2! = ' || fn_factorial(-2));
END;
/


/* Task 3
calculate employee salary by years worked.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 3----');
END;
/

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
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Employee ID: 104');
	pr_calc_salary(104);
	DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Employee ID: 300');
	pr_calc_salary(300);
END;
/

/* Task 4
cursor employee filter, anonymous PL/SQL block
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 4----');
END;
/

-- Task 4 Code--
DECLARE
	CURSOR EMP_CUR IS
		SELECT first_name || ' ' || last_name AS name, salary, hire_date
		FROM employees_a;
	lv_salary_bound employees_a.salary%TYPE := 15000;
	lv_hire_date employees_a.hire_date%TYPE := TO_DATE('1988-02-01', 'YYYY-MM-DD');
	lv_match_count PLS_INTEGER := 0;
BEGIN
	FOR row_emp IN EMP_CUR LOOP
		IF row_emp.salary > lv_salary_bound AND
		row_emp.hire_date > lv_hire_date THEN
			lv_match_count := lv_match_count + 1;
			DBMS_OUTPUT.PUT_LINE(row_emp.name || ' Joined on ' ||
			row_emp.hire_date || ' and has salary $' || row_emp.salary);
		END IF;
	END LOOP;
	IF lv_match_count = 0 THEN
		DBMS_OUTPUT.PUT_LINE('No employees found.');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

/* Task 5
pl/sql tables
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 5----');
END;
/

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


/* Task 6
parameterized date cursor
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 6----');
END;
/

-- Task 6 Code--
DECLARE
	lv_hiredate DATE := TO_DATE('01-FEB-1988', 'DD-MON-YYYY');
	lv_match_count PLS_INTEGER := 0;

	CURSOR DATE_CUR (p_hiredate DATE) IS
		SELECT employee_id, first_name, last_name, hire_date
		FROM employees_a
		WHERE hire_date > p_hiredate;
BEGIN
	DBMS_OUTPUT.PUT_LINE('  List of Employees Hired after ' ||
	TO_CHAR(lv_hiredate, 'DD-MON-YYYY') || ':' );
	FOR r_emp IN DATE_CUR(lv_hiredate) LOOP
		lv_match_count := lv_match_count + 1;
		DBMS_OUTPUT.PUT_LINE('Hire Date of Employee ID: ' ||
		r_emp.employee_id || ' , ' || r_emp.first_name || ' ' ||
		r_emp.last_name || ' : ' ||
		TO_CHAR(r_emp.hire_date, 'DD-MON-YYYY'));
	END LOOP;

	IF lv_match_count = 0 THEN
		DBMS_OUTPUT.PUT_LINE('No employees found.');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

/* Task 7
GET_JOB function to return a job title based on an employee ID.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 7----');
END;
/

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


/* Task 8
function to return the annual salary computed from an employee’s monthly salary and commission passed as parameters.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 8----');
END;
/

-- Task 8 Code--
CREATE OR REPLACE FUNCTION GET_ANNUAL_COMP (
	fv_salary_monthly employees_a.salary%TYPE,
	fv_commission_pct employees_a.commission_pct%TYPE
) RETURN employees_a.salary%TYPE
AS
	lv_salary_annual employees_a.salary%TYPE;
BEGIN
	lv_salary_annual :=
		(NVL(fv_salary_monthly, 0) * 12) +
		(NVL(fv_commission_pct, 0) * NVL(fv_salary_monthly, 0) * 12);
	RETURN lv_salary_annual;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- Task 8 Test--
SELECT salary,
	commission_pct,
	department_id,
	GET_ANNUAL_COMP(salary, commission_pct) AS Annual_Salary
FROM employees_a
WHERE department_id = 50;



/* Task 9
prevent rows in employees table from being deleted during business hours.
*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('----TASK 9----');
END;
/

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
