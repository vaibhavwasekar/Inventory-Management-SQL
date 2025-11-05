
--Trigger: before inserting an order -> check customer's credit
CREATE OR REPLACE TRIGGER trg_before_order
BEFORE insert ON orders
FOR EACH ROW
DECLARE 
v_credit_limit NUMBER;
v_existing_due NUMBER;
BEGIN
IF :NEW.salesman_id IS NULL THEN
    SELECT employee_id INTO :NEW.salesman_id FROM employees WHERE ROWNUM = 1;
  END IF;
SELECT credit_limit INTO v_credit_limit FROM customers WHERE customer_id = :NEW.customer_id;

IF v_credit_limit IS NULL THEN
    RAISE_APPLICATION_ERROR(-20010, 'Customer has no credit limit set.');
  END IF;
END;
/
---------
--Trigger: after insert order_items
CREATE OR REPLACE TRIGGER trg_after_order_item
AFTER INSERT ON order_items
FOR EACH ROW
DECLARE
BEGIN
  BEGIN
    inventory_management.reserve_stock(:NEW.product_id, 1, :NEW.quantity);
  EXCEPTION
    WHEN inventory_management.insufficient_stock THEN
     RAISE_APPLICATION_ERROR(-20020, 'Insufficient stock for product_id ' || :NEW.product_id);
  END;
END;
------------