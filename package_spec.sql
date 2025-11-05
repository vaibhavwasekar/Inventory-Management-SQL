--Package: inventory_management
CREATE OR REPLACE PACKAGE inventory_management AS

insufficient_stock EXCEPTION;
out_of_range EXCEPTION;

PROCEDURE check_stock(p_product_id IN NUMBER,p_qty IN NUMBER);
PROCEDURE reserve_stock(p_product_id IN NUMBER, p_warehouse_id IN NUMBER, p_qty IN NUMBER);

  PROCEDURE restock(p_product_id IN NUMBER, p_warehouse_id IN NUMBER, p_qty IN NUMBER);

  FUNCTION get_stock(p_product_id IN NUMBER, p_warehouse_id IN NUMBER) RETURN NUMBER;
END inventory_management;


--------


---
CREATE OR REPLACE PACKAGE BODY inventory_management AS

PROCEDURE check_stock(p_product_id IN NUMBER,p_qty IN NUMBER) IS
v_qty NUMBER;
BEGIN
SELECT quantity INTO v_qty FROM inventories
WHERE product_id=p_product_id
AND warehouse_id=1;
IF v_qty<p_qty THEN
RAISE insufficient_stock;
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE insufficient_stock;
END;

PROCEDURE reserve_stock(p_product_id IN NUMBER,p_warehouse_id IN NUMBER,p_qty IN NUMBER) IS
v_qty NUMBER;
BEGIN
SELECT quantity INTO v_qty FROM inventories
WHERE product_id=p_product_id
AND warehouse_id=p_warehouse_id
FOR UPDATE;

IF v_qty<p_qty THEN
RAISE insufficient_stock;
END IF;

UPDATE inventories
SET quantity=quantity-p_qty
WHERE product_id=p_product_id AND warehouse_id=p_warehouse_id;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE insufficient_stock;
END;

PROCEDURE restock(p_product_id IN NUMBER,p_warehouse_id IN NUMBER,p_qty IN NUMBER) IS
BEGIN
MERGE INTO inventories i
using(SELECT p_product_id AS pid, p_warehouse_id AS wid FROM DUAL) src
ON (i.product_id = src.pid AND i.warehouse_id = src.wid)
WHEN MATCHED THEN
UPDATE SET i.quantity=i.quantity+p_qty
 WHEN NOT MATCHED THEN
      INSERT (product_id, warehouse_id, quantity) VALUES (src.pid, src.wid, p_qty);
  END;
  
 FUNCTION get_stock(p_product_id IN NUMBER, p_warehouse_id IN NUMBER) RETURN NUMBER IS
    v_qty NUMBER := 0;
  BEGIN
    SELECT NVL(quantity, 0) INTO v_qty FROM inventories
     WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;
    RETURN v_qty;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
  END;
  
END inventory_management;
/
------------------------