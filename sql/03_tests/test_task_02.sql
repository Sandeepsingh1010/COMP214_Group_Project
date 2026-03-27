-- Test file for task 02
SET SERVEROUTPUT ON;

PROMPT Task 2 test: n = 5
BEGIN
	DBMS_OUTPUT.PUT_LINE('Factorial of 5 is ' || get_factorial(5));
END;
/

PROMPT Task 2 test: n = 1
BEGIN
	DBMS_OUTPUT.PUT_LINE('Factorial of 1 is ' || get_factorial(1));
END;
/

PROMPT Task 2 test: n = 0 (error path)
BEGIN
	DBMS_OUTPUT.PUT_LINE('Factorial of 0 is ' || get_factorial(0));
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Expected error for n=0: ' || SQLERRM);
END;
/

PROMPT Task 2 test: n = -3 (error path)
BEGIN
	DBMS_OUTPUT.PUT_LINE('Factorial of -3 is ' || get_factorial(-3));
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Expected error for n=-3: ' || SQLERRM);
END;
/
