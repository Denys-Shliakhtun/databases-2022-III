USE Restaurant;

--офіціант
CREATE ROLE waiter
GRANT SELECT ON Menu TO waiter
GRANT SELECT ON New_order TO waiter
GRANT SELECT ON Order_row TO waiter
GRANT INSERT ON New_order TO waiter
GRANT INSERT ON Order_row TO waiter
GRANT EXECUTE TO waiter
GRANT SELECT ON ORDER_INFO TO waiter
GRANT SELECT ON ORDER_ROW_INFO TO waiter

CREATE LOGIN Shevchenko_login WITH PASSWORD = '123', DEFAULT_DATABASE = Restaurant
CREATE USER Shevchenko FOR LOGIN Shevchenko_login

ALTER ROLE waiter ADD MEMBER Shevchenko

/*дії для офіціанта:
* EXEC SelectMenu
* EXEC NewOrder @waiter_id, @table_id
* EXEC AddToOrder @order_id, @food_id, @amount
* вибірка представлень New_order_info і Order_row_info
*/

--працівник
CREATE ROLE worker
GRANT SELECT ON New_order TO worker
GRANT SELECT ON Order_row TO worker
GRANT UPDATE ON Order_row TO worker
GRANT SELECT ON Menu TO worker
GRANT SELECT ON Recipe TO worker
GRANT SELECT ON Ingredient TO worker
GRANT SELECT ON Worker TO worker
GRANT EXECUTE TO worker
GRANT SELECT ON ORDER_INFO TO worker
GRANT SELECT ON ORDER_ROW_INFO TO worker
GRANT SELECT ON CheckRecipe TO worker

CREATE LOGIN Bandera_login WITH PASSWORD = '123', DEFAULT_DATABASE = Restaurant
CREATE USER Bandera FOR LOGIN Bandera_login

ALTER ROLE worker ADD MEMBER Bandera

/*дії для працівника:
* EXEC SelectMenu
* SELECT * FROM CheckRecipe(@food_id)
* EXEC UpdateOrderRowWorker @row_id, @worder_id
* вибірка представлень New_order_info і Order_row_info
*/

--шеф-кухар
CREATE ROLE chef
ALTER ROLE worker ADD MEMBER chef
GRANT SELECT, UPDATE, INSERT ON Menu TO chef
GRANT SELECT, UPDATE, DELETE, INSERT ON Recipe TO chef
GRANT SELECT, UPDATE, INSERT ON Ingredient TO chef

CREATE LOGIN Ivanov_login WITH PASSWORD = '123', DEFAULT_DATABASE = Restaurant
CREATE USER Ivanov FOR LOGIN Ivanov_login

ALTER ROLE chef ADD MEMBER Ivanov

/*дії для шеф-кухаря:
* такі ж, що для працівника
* вставлення даних у таблиці Menu, Recipe, Ingredient
* редагування цих даних
*/

CREATE ROLE administration 
GRANT SELECT, UPDATE, INSERT, DELETE, EXECUTE TO administration
DENY DELETE ON Ingredient TO administration

CREATE LOGIN admin_login WITH PASSWORD = '123', DEFAULT_DATABASE = Restaurant
CREATE USER user_admin FOR LOGIN admin_login

ALTER ROLE administration ADD MEMBER user_admin

/*дії адміністрації
* EXEC UpdateIngredientPrice @ingredient_id, @price
* EXEC UpdateMenuPrice @food_id, @price
* EXEC GetIncomePerDay
* SELECT * FROM GetIncomePerWorker()
* SELECT * FROM GetIngredientSpendPerDay(@date)
* SELECT * FROM GetSpendPerIngredient (2)
* вибірки різного роду
*/
