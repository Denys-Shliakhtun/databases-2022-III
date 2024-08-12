/*дії для працівника:
* EXEC SelectMenu
* SELECT * FROM CheckRecipe(@food_id)
* EXEC UpdateOrderRowWorker @row_id, @worder_id
* вибірка представлень New_order_info і Order_row_info
*/

SELECT * FROM Order_row_info
EXEC UpdateOrderRowWorker 168, 4
SELECT * FROM CheckRecipe(3)
SELECT * FROM ORDER_INFO
SELECT * FROM Order_ROW_INFO