USE Restaurant;

--1) вибірка повної інформації про окреме замовлення
SELECT New_order.ID, Worker.Surname AS 'Waiter', Table_number.Number AS 'Table number', 
New_order.Order_date, New_order.Order_time, New_order.Price FROM New_order 
JOIN Worker ON Waiter_ID = Worker.ID JOIN Table_number ON Table_ID = Table_number.ID

--2) вибірка повної інформації про кожен рядок замовлення
SELECT Order_row.ID, Order_info.ID AS 'Order ID', Order_info.Waiter, 
Order_info.[Table number], Order_info.Order_date, Order_info.Order_time, 
Menu.Food, Menu.Food_type, Order_row.Price, Order_row.Amount, Worker.Surname AS 'Worker' 
FROM Order_row JOIN Order_info ON Order_ID = Order_info.ID 
JOIN Menu ON Order_row.Food_ID = Menu.ID JOIN Worker ON Order_row.Worker_ID=Worker.ID

--3) вибірка рецепту до кожної страви
SELECT Menu.Food, Ingredient.Ingredient, Recipe.Ingredient_amount, Ingredient.Unit_of_measurement 
FROM Ingredient JOIN Recipe ON Recipe.Ingredient_ID = Ingredient.ID JOIN Menu ON Food_ID = MENU.ID ORDER BY Recipe.Food_ID

--4) вибірка доходу, який припадає на кожного працівника по датам
SELECT New_order.Order_date, Worker.Surname, Worker.Name, SUM(Order_row.Price*Order_row.Amount) 
	AS 'Income', N'Працівник' AS 'Position' FROM Order_row JOIN New_order ON Order_row.Order_ID = New_order.ID 
	JOIN Worker ON Worker.ID = Order_row.Worker_ID GROUP BY New_order.Order_date, Worker.Surname, Worker.Name
UNION
SELECT New_order.Order_date, Worker.Surname, Worker.Name, SUM(New_order.Price) AS 'Income', 
	N'Офіціант' AS 'Position' FROM New_order JOIN Worker ON Worker.ID = New_order.Waiter_ID 
	GROUP BY New_order.Order_date, Worker.Surname, Worker.Name

--5) вибірка витрат кожного інгредієнту по датам
SELECT New_order.Order_date, Ingredient.Ingredient, SUM(Order_Row.Amount * Recipe.Ingredient_amount) 
AS Amount, Ingredient.Unit_of_measurement FROM New_Order JOIN Order_Row ON New_Order.ID = Order_Row.Order_ID 
JOIN Menu ON Menu.ID = Order_Row.Food_ID JOIN Recipe ON Menu.ID = Recipe.Food_ID JOIN Ingredient 
ON Ingredient.ID = Recipe.Ingredient_ID GROUP BY  New_order.Order_date, Ingredient.Ingredient, Ingredient.Unit_of_measurement

--6) вибірка цін з меню і собівартості страв по їхньому складу
SELECT Menu.Food, Menu.Price AS 'Menu price', SUM (Ingredient.PRICE * Recipe.Ingredient_amount) AS 'Recipe price' 
FROM Ingredient JOIN Recipe ON Ingredient_ID = Ingredient.ID JOIN Menu ON Food_ID = Menu.ID GROUP BY Menu.Food, Menu.Price	

--7) вибірка, скільки яких страв приготував кожен працівник по датам
SELECT NEW_ORDER.Order_date, Worker.Surname, Menu.Food, COUNT(Order_row.Food_ID) AS 'Amount' 
FROM Worker JOIN Order_row ON Worker.ID = Worker_ID JOIN Menu ON Menu.ID = Food_ID 
JOIN New_order ON Order_row.Order_ID=New_order.ID GROUP BY NEW_ORDER.Order_date, Worker.Surname, Menu.Food

--8) вибірка кількості замовлень на кожен столик
SELECT Number AS 'Number of table', COUNT(New_order.ID) AS 'Orders' FROM Table_number 
JOIN New_order ON Table_ID = Table_number.ID GROUP BY Number ORDER BY Orders DESC

--9) вибірка кількості кожної страви, що було замовлено
SELECT Food, SUM(Order_row.Amount) AS 'General amount' FROM Menu JOIN Order_row ON Menu.ID = Food_ID GROUP BY Food

--10) вибірка кількості страв по типам
SELECT Food_Type.Food_type, COUNT(Menu.ID) AS 'Amount in menu' FROM Food_Type 
JOIN Menu ON Food_Type.Food_type = Menu.Food_type GROUP BY Food_Type.Food_type 

--11) вибірка, скільки раз офіціант працював з яким столиком
SELECT Worker.Surname, Table_number.Number AS 'Number of table', COUNT(New_order.Table_ID) AS 'Number of orders' 
FROM Worker JOIN New_order ON Worker.ID = Waiter_ID JOIN Table_number ON Table_number.ID = Table_ID 
GROUP BY Worker.Surname, Table_number.Number ORDER BY [Number of orders] DESC

--12) вибірка кількості страв по датам замовлень
SELECT Menu.Food, New_order.Order_date, SUM(Order_row.Amount) AS 'Amount' FROM Menu 
JOIN Order_row ON Menu.ID = Food_ID JOIN New_order ON Order_ID = New_order.ID GROUP BY Menu.Food, New_order.Order_date

--13) вибірка складності рецептів по кількості інгредієнтів для кожної страви
SELECT Menu.Food, Menu.Food_type, COUNT(Recipe.ID) AS 'Number of different ingredients' FROM Menu 
LEFT JOIN Recipe ON Menu.ID = Recipe.Food_ID GROUP BY Menu.Food, Menu.Food_type

--14) вибірка, скільки раз кожна посада прийняла замовлень по датам
SELECT * FROM (
SELECT Position.Position, New_order.Order_date, COUNT(New_order.ID) AS 'Number of orders' FROM Position 
JOIN Worker ON Position.Position = Worker.Position JOIN New_order ON Worker.ID = New_order.Waiter_ID 
GROUP BY Position.Position, New_order.Order_date
UNION
SELECT Position.Position, New_order.Order_date, COUNT(Order_row.ID) AS 'Number of orders' FROM Position 
JOIN Worker ON Position.Position = Worker.Position JOIN Order_row ON Worker.ID = Order_row.Worker_ID 
JOIN New_order ON Order_row.Order_ID = New_order.ID WHERE Position.Position != N'Офіціант' GROUP BY Position.Position, New_order.Order_date
) AS table1 ORDER BY Order_date

--15) вибірка офіціантів, що працювали між 10 і 30 грудня 2022
SELECT DISTINCT Worker.Surname, New_order.Order_date FROM Worker JOIN New_order ON Waiter_ID = Worker.ID 
WHERE Order_date BETWEEN '12-10-2022' AND '12-30-2022'

--16) вибірка кількості типів замовлених страв по датам
SELECT Food_Type.Food_type, New_order.Order_date, SUM(Order_row.Amount) AS 'Amount' FROM Food_Type 
JOIN Menu ON Food_Type.Food_Type = Menu.Food_Type JOIN Order_row ON Order_row.Food_ID = Menu.ID 
JOIN New_order ON New_order.ID = Order_row.Order_ID GROUP BY Food_Type.Food_type, New_order.Order_date

--17) вибірка кількості страв, зроблених кожним працівником
SELECT Worker.Surname, Menu.Food, COUNT(Order_row.ID) AS 'Count' FROM Worker 
JOIN Order_row ON Worker.ID = Worker_ID JOIN Menu ON Menu.ID = Food_ID GROUP BY Worker.Surname, Menu.Food

--18) вибірка кількості замовлень, що прийняв кожен офіціант по датам
SELECT Worker.Surname, New_order.Order_date, COUNT(New_order.ID) AS 'Order count' FROM Worker 
JOIN New_order ON Worker.ID = Waiter_ID GROUP BY Worker.Surname,New_order.Order_date

--19) вибірка кількості страв на день на кожен столик
SELECT Table_number.Number AS 'Number of table', New_order.Order_date, SUM(Order_row.Amount) 'Number of dishes per day' 
FROM Table_number JOIN New_order ON Table_number.ID = New_order.Table_ID JOIN Order_row 
ON New_order.ID = Order_row.Order_ID GROUP BY Table_number.Number, New_order.Order_date

--20) вибірка кількості страв, які приносить офіціант за замовлення
SELECT New_order.ID, Worker.Surname, New_order.Order_date, New_order.Order_time, 
SUM(Order_row.Amount) AS 'Number of dishes' FROM Worker 
JOIN New_order ON Worker.ID = New_order.Waiter_ID JOIN Order_row ON Order_row.Order_ID = New_order.ID 
GROUP BY New_order.ID, Worker.Surname, New_order.Order_date, New_order.Order_time