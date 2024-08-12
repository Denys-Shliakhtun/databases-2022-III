USE Restaurant;
GO

CREATE TRIGGER Ingredient_price_update ON Ingredient 
WITH EXECUTE AS OWNER
AFTER UPDATE
AS
BEGIN
	DECLARE @temptable TABLE (foodPrice MONEY, ingredientPrice Money)
	INSERT INTO @temptable SELECT Menu.Price, SUM (Ingredient.PRICE * Recipe.Ingredient_amount)
	FROM Ingredient JOIN Recipe ON Ingredient_ID = Ingredient.ID JOIN Menu ON Food_ID = Menu.ID GROUP BY Recipe.Food_ID, Menu.Price	
	DECLARE @count1 INT
	SET @count1 = (SELECT COUNT(*) FROM @temptable WHERE foodPrice < ingredientPrice)
	IF (@count1 > 0)
	BEGIN
		PRINT 'WARNING! The price of ingredients exceeds prices of food in menu! ' + CONVERT(VARCHAR, @count1) + ' positions in the menu need corrections' 
	END
END
GO

CREATE TRIGGER Menu_price_update ON Menu 
WITH EXECUTE AS OWNER
AFTER UPDATE
AS
BEGIN
	DECLARE @temptable TABLE (foodPrice MONEY, ingredientPrice Money)
	INSERT INTO @temptable SELECT Menu.Price, SUM (Ingredient.PRICE * Recipe.Ingredient_amount)
	FROM Ingredient JOIN Recipe ON Ingredient_ID = Ingredient.ID JOIN Menu ON Food_ID = Menu.ID  WHERE Food_ID IN (SELECT ID FROM inserted) GROUP BY Recipe.Food_ID, Menu.Price	
	IF ((SELECT COUNT(*) FROM @temptable WHERE foodPrice < ingredientPrice) > 0)
	BEGIN
		PRINT 'WARNING! The price of ingredients exceeds the price of food in menu!'
	END
END
GO

CREATE TRIGGER Order_row_insert ON Order_row 
WITH EXECUTE AS OWNER
AFTER INSERT
AS
BEGIN
	DECLARE curs CURSOR FOR SELECT Order_ID FROM inserted FOR READ ONLY
	DECLARE @id INT
	OPEN curs
	FETCH NEXT FROM curs INTO @id
	UPDATE New_order SET Price = (SELECT Sum(Price*Amount) FROM Order_row WHERE Order_ID = @id) WHERE ID = @id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM curs INTO @id
		UPDATE New_order SET Price = (SELECT Sum(Price*Amount) FROM Order_row WHERE Order_ID = @id) WHERE ID = @id
	END
	CLOSE curs
	DEALLOCATE curs
END