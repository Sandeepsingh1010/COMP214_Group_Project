-- Test file for task 01
SET SERVEROUTPUT ON;

BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello Test');
END;
/

PROMPT Task 1 test: n = 5
BEGIN
	calc_factorial_proc(5);
END;
/

PROMPT Task 1 test: n = 0
BEGIN
	calc_factorial_proc(0);
END;
/

PROMPT Task 1 test: n = -3 (error path)
BEGIN
	calc_factorial_proc(-3);
END;
/


