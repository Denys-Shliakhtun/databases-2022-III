USE Restaurant;

--таблиця група страви/напій
CREATE TABLE Food_Type
(
	Food_type NVARCHAR(30) PRIMARY KEY,
);

--таблиця меню
CREATE TABLE Menu
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Food NVARCHAR(100) NOT NULL,
	Food_type NVARCHAR(30) REFERENCES Food_Type(Food_type),
	Price MONEY
);

--таблиця одиниці вимірювання
CREATE TABLE Unit_of_measurement
(
	Unit_of_measurement NVARCHAR(20) PRIMARY KEY
);

--таблиця інгредієнт
CREATE TABLE Ingredient
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Ingredient NVARCHAR(50) NOT NULL,
	Unit_of_measurement NVARCHAR(20) REFERENCES Unit_of_measurement(Unit_of_measurement),
	PRICE Money
);

--таблиця склад страви
CREATE TABLE Recipe
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Food_ID INT REFERENCES Menu(ID) NOT NULL,
	Ingredient_ID INT REFERENCES Ingredient(ID) NOT NULL,
	Ingredient_amount FLOAT DEFAULT 0,
);

--таблиця посада
CREATE TABLE Position
(
	Position NVARCHAR(20) PRIMARY KEY
);

--таблиця співробітник
CREATE TABLE Worker
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Name NVARCHAR(30),
	Surname NVARCHAR(50) NOT NULL,
	Position NVARCHAR(20) REFERENCES Position(Position)
);

--таблиця столик
CREATE TABLE Table_number
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Number INT NOT NULL,
);

--таблиця замовлення
CREATE TABLE New_order
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Waiter_ID INT REFERENCES Worker(ID),
	Table_ID INT REFERENCES Table_number(ID),
	Order_date DATE DEFAULT GETDATE(),
	Order_time TIME DEFAULT CONVERT(TIME, GETDATE()),
	Price MONEY,
);

--таблиця рядок замовлення
CREATE TABLE Order_row
(
	ID INT IDENTITY (1, 1) PRIMARY KEY,
	Order_ID INT REFERENCES New_order(ID),
	Food_ID INT REFERENCES Menu(ID),
	Amount INT DEFAULT 1,
	Price MONEY,
	Worker_ID INT REFERENCES Worker(ID)
);