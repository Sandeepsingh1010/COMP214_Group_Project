/* Task 1
Write a stored procedure that gets an integer n and calculates and displays its factorial.
*/

CREATE OR REPLACE PROCEDURE calc_factorial_proc(p_num IN NUMBER)
IS
	lv_factorial NUMBER := 1;
BEGIN
	IF p_num IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001, 'Input cannot be NULL.');
	ELSIF p_num < 0 THEN
		RAISE_APPLICATION_ERROR(-20002, 'Input cannot be negative.');
	END IF;

	FOR i IN 1 .. p_num LOOP
		lv_factorial := lv_factorial * i;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE('Factorial of ' || p_num || ' is ' || lv_factorial);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error in calc_factorial_proc: ' || SQLERRM);
END;
/
