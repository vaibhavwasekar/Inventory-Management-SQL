 
SELECT * FROM regions;

SELECT * FROM countries;

SELECT * FROM locations;

SELECT * FROM warehouses;

SELECT * FROM product_categories;

SELECT * FROM products;

SELECT * FROM customers;

SELECT * FROM contacts;

SELECT * FROM employees;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM inventories;
-------
DECLARE
  v_total NUMBER;
BEGIN
  v_total := fn_order_total(1);
  DBMS_OUTPUT.PUT_LINE('Order 1 total = ' || v_total);
END;
/
-------

BEGIN
  DBMS_OUTPUT.PUT_LINE('Current stock before restock: ' || inventory_management.get_stock(1,1));
  inventory_management.restock(1, 1, 25);
  DBMS_OUTPUT.PUT_LINE('Stock after restock: ' || inventory_management.get_stock(1,1));
END;
/

------
DECLARE
  v_items SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
BEGIN
  v_items.EXTEND; v_items(1) := 1*100000 + 2;
  v_items.EXTEND; v_items(2) := 2*100000 + 5;
  p_create_order(1, SYSDATE, v_items);
END;
/
------
BEGIN
  p_low_stock_report(80);
END;
/

BEGIN
  sp_log('INFO', 'All procedures executed successfully.');
  DBMS_OUTPUT.PUT_LINE('Log entry added.');
END;
/
SELECT * FROM app_logs;


BEGIN
    DBMS_OUTPUT.PUT_LINE('Testing inventory management...');
    DBMS_OUTPUT.PUT_LINE('Stock for product 1: ' || inventory_management.get_stock(1, 1));
END;

---------
--archive old orders
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE orders_archive AS
    SELECT * FROM orders WHERE order_date < SYSDATE - 365
  ';
  DBMS_OUTPUT.PUT_LINE('orders_archive created (if older orders existed).');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -955 THEN
      DBMS_OUTPUT.PUT_LINE('orders_archive already exists.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Error creating archive: ' || SQLERRM);
    END IF;
END;
/
--------
DECLARE
  v_items SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
BEGIN
  -- product 1 qty 2 -> encode as 1*100000 + 2 = 100002
  v_items.EXTEND; v_items(1) := 1*100000 + 2;
  -- product 2 qty 5
  v_items.EXTEND; v_items(2) := 2*100000 + 5;

  p_create_order(1, SYSDATE, v_items);
END;
--------

CREATE OR REPLACE TRIGGER trg_update_inventory
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventories
    SET quantity = quantity - :NEW.quantity
    WHERE product_id = :NEW.product_id;

    DBMS_OUTPUT.PUT_LINE('Inventory updated for Product ID: ' || :NEW.product_id);
END;
/

--------

INSERT INTO order_items VALUES (603, 1, 201, 3, 20000);
-----
INSERT INTO orders VALUES (603, 301, 'Pending', 502, SYSDATE);

---

/
