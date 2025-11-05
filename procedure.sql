

select * from regions WHERE region_id IN(
SELECT region_id FROM countries WHERE country_id IN (
SELECT country_id FROM locations WHERE city='London'));
------
select * from locations where city='London';

select city from locations where country_id='US';

SELECT locations.city,locations.country_id,country_name,countries.region_id,region_name
FROM locations
INNER JOIN
countries on (locations.country_id=countries.country_id)
INNER JOIN
regions on (countries.region_id=regions.region_id)
where city='London';
-----
select * from countries LEFT JOIN regions ON (countries.region_id=regions.region_id);

---------
SELECT region_id,country_id,count(distinct country_id) no_of_countries,
count(city) nO_of_cities from (
select city,locations.country_id,country_name,countries.region_id,region_name
from locations
inner join
countries on (locations.country_id=countries.country_id)
inner join
regions on (countries.region_id=regions.region_id)
where countries.region_id=3) group by region_id,country_id;
--------
-----------------------------------
-----Sequences for Auto IDs
-- Sequences for tables with NUMBER primary keys
CREATE SEQUENCE seq_region START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_location START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_warehouse START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_employee START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_category START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_product START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_customer START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_contact START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_order START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_order_item START WITH 1 INCREMENT BY 1 NOCACHE;

-------
--Create a view to simplify product + inventory
CREATE OR REPLACE VIEW vw_product_inventory AS
SELECT 
    p.product_id,
    p.product_name,
    p.list_price,
    p.standard_cost,
    p.category_id,
    i.warehouse_id
FROM products p
JOIN inventories i ON p.product_id = i.product_id;

--------------
--Function: compute order total
CREATE OR REPLACE FUNCTION fn_order_total(p_order_id IN NUMBER) 
RETURN NUMBER IS
v_total NUMBER:=0;
BEGIN 
SELECT NVL(SUM(quantity* unit_price),0)
INTO v_total
FROM order_items
WHERE order_id=p_order_id;
RETURN v_total;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 0;
WHEN OTHERS THEN 
RAISE;
END;

----
DECLARE
  v_total NUMBER;
BEGIN
  v_total := fn_order_total(1); -- none yet
  DBMS_OUTPUT.PUT_LINE('Order 1 total = ' || v_total);
END;
/
-------

--
--
--Procedure: create_order_with_items
CREATE OR REPLACE PROCEDURE p_create_order(
p_customer_id IN NUMBER,
p_order_date IN DATE,
p_items IN  SYS.ODCINUMBERLIST 
) IS
v_order_id NUMBER;
v_item_id NUMBER;
 v_product  NUMBER;
v_qty NUMBER;
v_unit_price NUMBER;
BEGIN
v_order_id:=seq_order.NEXTVAL;
 INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date)
  VALUES (v_order_id, p_customer_id, 'NEW', NULL, p_order_date);

FOR i IN 1..P_items.COUNT LOOP
v_product:=TRUNC(p_items(i)/100000);
v_qty:=MOD(p_items(i),100000);
v_item_id:=seq_order_item.NEXTVAL;

SELECT list_price INTO v_unit_price FROM products WHERE product_id = v_product;

    INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price)
    VALUES (v_order_id, v_item_id, v_product, v_qty, v_unit_price);
  END LOOP;
  

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Order Created, ID = ' || v_order_id || '; Total = ' || fn_order_total(v_order_id));
EXCEPTION
  WHEN inventory_management.insufficient_stock THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Order failed: insufficient stock. Rolled back.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Order failed: ' || SQLERRM);
END;

----------

------
--
--Cursor low stock report
CREATE OR REPLACE PROCEDURE p_low_stock_report(p_threshold IN NUMBER) IS
CURSOR c_low IS
 SELECT p.product_id, p.product_name, i.quantity
      FROM products p
      JOIN inventories i ON p.product_id = i.product_id
     WHERE i.quantity <= p_threshold
     ORDER BY i.quantity;

v_id products.product_id%TYPE;
v_name products.product_name%TYPE;
v_qty inventories.quantity%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Low stock report (threshold=' || p_threshold || ')');
  FOR r IN c_low LOOP
    DBMS_OUTPUT.PUT_LINE('Product ID: ' || r.product_id || ', Name: ' || r.product_name || ', Qty: ' || r.quantity);
  END LOOP;
END;
---

------
--bulk insert many sample inventory
DECLARE
TYPE t_restocks IS TABLE OF NUMBER;
v_prod_id t_restocks :=t_restocks(1,2);
v_qty t_restocks :=t_restocks(50,100);
BEGIN
FORALL i IN INDICES OF v_prod_id
    MERGE INTO inventories t
    USING (SELECT v_prod_id(i) pid, 1 wid, v_qty(i) qty FROM dual) src
    ON (t.product_id = src.pid AND t.warehouse_id = src.wid)
    WHEN MATCHED THEN UPDATE SET t.quantity = t.quantity + src.qty
    WHEN NOT MATCHED THEN INSERT (product_id, warehouse_id, quantity) VALUES (src.pid, src.wid, src.qty);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Bulk restock performed.');
END;

--------


-------------------



CREATE OR REPLACE PROCEDURE sp_log(p_level IN VARCHAR2, p_msg IN VARCHAR2) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO app_logs(log_id, log_ts, log_level, message)
  VALUES (seq_log.NEXTVAL, SYSTIMESTAMP, p_level, p_msg);
  COMMIT; -- must commit because autonomous
END;
/















