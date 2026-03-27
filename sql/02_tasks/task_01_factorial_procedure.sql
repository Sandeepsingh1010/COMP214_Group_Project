/* Task 1
Write a store procedure that gets an integer number n and calculates and displays its factorial.
*/
SET SERVEROUTPUT ON

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
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    DBMS_OUTPUT.PUT_LINE('Task 1: Factorial Procedure:');
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Positive integer: 5');
    pr_factorial(5);
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with integer 0:');
    pr_factorial(0);
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'  >Test with Negative integer : -3');
    pr_factorial(-3);
END;
/
