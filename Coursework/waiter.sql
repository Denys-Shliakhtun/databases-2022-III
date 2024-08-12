/*дії для офіціанта:
* EXEC SelectMenu
* EXEC NewOrder @waiter_id, @table_id
* EXEC AddToOrder @order_id, @food_id, @amount
* вибірка представлень New_order_info і Order_row_info
*/

EXEC SelectMenu
EXEC NewOrder 1, 3
EXEC AddToOrder 37, 5, 3
SELECT * FROM ORDER_INFO
SELECT * FROM Order_ROW_INFO