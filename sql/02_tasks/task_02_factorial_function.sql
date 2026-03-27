/* Task 2
Write a user-defined function that takes an integer n as input and returns its factorial.
The function should raise an exception if the input is 0 or a negative number.
*/
SET SERVEROUTPUT ON
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
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    DBMS_OUTPUT.PUT_LINE('Task 2: Factorial Function:');
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Positive integer:');
    DBMS_OUTPUT.PUT_LINE('5! = ' || fn_factorial(5));
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with integer: 0');
    DBMS_OUTPUT.PUT_LINE('0! = ' || fn_factorial(0));
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Negative integer: -2');
    DBMS_OUTPUT.PUT_LINE('-2! = ' || fn_factorial(-2));
END;
/