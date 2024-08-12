USE Restaurant;
GO

-- перегляд меню
CREATE PROCEDURE SelectMenu
AS
SELECT * FROM Menu
GO

-- створення нових замовлень
CREATE PROCEDURE NewOrder 
	@waiter_id INT, @table_id INT
AS
BEGIN 
	INSERT New_order(Waiter_ID, Table_ID) VALUES(@waiter_id, @table_id)
	DECLARE @order_id INT
	SET @order_id = (SELECT MAX(ID) FROM New_order)
	DECLARE @waiter_surname NVARCHAR(50)
	SET @waiter_surname = (SELECT Surname FROM Worker WHERE ID = @waiter_id)
	PRINT N'Замовлення №' + CONVERT(VARCHAR, @order_id) 
		+ N', офіціант ' + @waiter_surname
END
GO

EXEC NewOrder 1, 1
GO

CREATE PROCEDURE AddToOrder
	@order_id INT, @food_id INT, @amount INT
AS
BEGIN
	INSERT Order_row(Order_ID, Food_ID, Amount, Price) VALUES(@order_id, @food_id, @amount, (SELECT Price FROM Menu WHERE @food_id = Menu.ID))
	DECLARE @food NVARCHAR(100)
	SET @food = (SELECT Food FROM Menu WHERE ID = @food_id)
	PRINT N'До замовлення №' + CONVERT(VARCHAR, @order_id) 
		+ N' успішно додано "' +  @food
		+ N'" у кількості: ' + CONVERT(VARCHAR, @amount)
END
GO

EXEC AddToOrder 37, 3, 2
GO

-- перегляд склад страв
CREATE FUNCTION CheckRecipe (@food_id INT)
RETURNS TABLE AS
RETURN (SELECT Ingredient.Ingredient, Recipe.Ingredient_amount, Ingredient.Unit_of_measurement FROM Ingredient JOIN Recipe ON Recipe.Ingredient_ID = Ingredient.ID WHERE Recipe.Food_ID = @food_id)
GO

SELECT * FROM CheckRecipe(3)
GO

-- встановлення відповідального за рядок замовлення
CREATE PROCEDURE UpdateOrderRowWorker
	@row_id INT, @worker_id INT
AS
UPDATE Order_row SET Worker_ID = @worker_id WHERE ID = @row_id
GO

-- встановлення цін на інгредієнти і страви
CREATE PROCEDURE UpdateIngredientPrice 
	@ingredient_id INT, @price MONEY
AS
UPDATE Ingredient SET PRICE = @price WHERE ID = @ingredient_id
GO

EXEC UpdateIngredientPrice 3, 1200
GO

CREATE PROCEDURE UpdateMenuPrice 
	@food_id INT, @price MONEY
AS
UPDATE Menu SET Price = @price WHERE ID = @food_id
GO

EXEC UpdateMenuPrice 3, 10
GO

-- отримання даних за обіг коштів
CREATE PROCEDURE GetIncomePerDay AS
BEGIN
	SELECT Order_date, SUM(Price) AS 'Income' FROM New_order GROUP BY Order_date
END
GO

EXEC GetIncomePerDay
GO

--продуктивність кожного працівника
CREATE FUNCTION GetIncomePerWorker () RETURNS TABLE AS
RETURN
	SELECT New_order.Order_date, Worker.Surname, Worker.Name, SUM(Order_row.Price) AS 'Income', N'Працівник' AS 'Position' FROM Order_row JOIN New_order ON Order_row.Order_ID = New_order.ID JOIN Worker ON Worker.ID = Order_row.Worker_ID GROUP BY New_order.Order_date, Worker.Surname, Worker.Name
	UNION
	SELECT New_order.Order_date, Worker.Surname, Worker.Name, SUM(New_order.Price) AS 'Income', N'Офіціант' AS 'Position' FROM New_order JOIN Worker ON Worker.ID = New_order.Waiter_ID GROUP BY New_order.Order_date, Worker.Surname, Worker.Name
GO

SELECT * FROM GetIncomePerWorker()
GO

-- отримання рівня витрат інгредієнтів
CREATE FUNCTION GetIngredientSpendPerDay (@date DATE)
RETURNS TABLE
AS
RETURN
	(SELECT Ingredient.Ingredient, 
	SUM(Order_Row.Amount * Recipe.Ingredient_amount) AS Amount, Ingredient.Unit_of_measurement
	FROM New_Order JOIN Order_Row ON New_Order.ID = Order_Row.Order_ID
	JOIN Menu ON Menu.ID = Order_Row.Food_ID
	JOIN Recipe ON Menu.ID = Recipe.Food_ID
	JOIN Ingredient ON Ingredient.ID = Recipe.Ingredient_ID WHERE New_order.Order_date = @date
	GROUP BY  New_order.Order_date, Ingredient.Ingredient, Ingredient.Unit_of_measurement)
GO

SELECT * FROM GetIngredientSpendPerDay('2022-12-18')
GO

CREATE FUNCTION GetSpendPerIngredient (@ingredient_id INT)
RETURNS TABLE
AS
RETURN
	(SELECT New_order.Order_date, Ingredient.Ingredient, 
	SUM(Order_Row.Amount * Recipe.Ingredient_amount) AS Amount, Ingredient.Unit_of_measurement
	FROM New_Order JOIN Order_Row ON New_Order.ID = Order_Row.Order_ID
	JOIN Menu ON Menu.ID = Order_Row.Food_ID
	JOIN Recipe ON Menu.ID = Recipe.Food_ID
	JOIN Ingredient ON Ingredient.ID = Recipe.Ingredient_ID WHERE Ingredient.ID = @ingredient_id
	GROUP BY  New_order.Order_date, Ingredient.Ingredient, Ingredient.Unit_of_measurement)
GO

SELECT * FROM GetSpendPerIngredient (1)
GO