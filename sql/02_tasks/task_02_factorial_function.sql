/* Task 2
Write a user-defined function that takes an integer n as input and returns its factorial.
Raise an exception if input is 0 or negative.
*/

CREATE OR REPLACE FUNCTION get_factorial(p_num IN NUMBER)
RETURN NUMBER
IS
	lv_factorial NUMBER := 1;
BEGIN
	IF p_num IS NULL THEN
		RAISE_APPLICATION_ERROR(-20011, 'Input cannot be NULL.');
	ELSIF p_num <= 0 THEN
		RAISE_APPLICATION_ERROR(-20012, 'Input cannot be negative.');
	END IF;

	FOR i IN 1 .. p_num LOOP
		lv_factorial := lv_factorial * i;
	END LOOP;

	RETURN lv_factorial;
END;
/
