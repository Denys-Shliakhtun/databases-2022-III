use Kaznacheystvo;

/* tables:
* Pidrozdil_kaznacheystva
* Commercial_bank
* Budget_institution
* KEKW
* Koshtorys
* Koshtorys_Change
* Platizhne_doruchennia
*/

/*Task A*/

IF OBJECT_ID('dbo.Pidrozdil_kaznacheystva', 'U') IS NULL
CREATE TABLE Pidrozdil_kaznacheystva
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	Name NVARCHAR (500) NOT NULL,
	Territory NVARCHAR (50) NOT NULL
);

IF OBJECT_ID('dbo.Commercial_bank', 'U') IS NULL
CREATE TABLE Commercial_bank
(
	EDRPOU NVARCHAR(8) PRIMARY KEY,
	Name NVARCHAR (50) NOT NULL,
	Code INT UNIQUE,
);

IF OBJECT_ID('dbo.Budget_institution', 'U') IS NULL
CREATE TABLE Budget_institution
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	Name NVARCHAR (300) NOT NULL UNIQUE,
	Pidrozdil_ID INT, /*foreign key to Pidrozdil_kaznacheystva*/
	/*CONSTRAINT FK_Pidrozdil_To_Institution FOREIGN KEY (Pidrozdil_ID) REFERENCES Pidrozdil_kaznacheystva (ID) ,*/
);

IF OBJECT_ID('dbo.KEKW', 'U') IS NULL
CREATE TABLE KEKW
(
	Code INT PRIMARY KEY,
	Purpose NVARCHAR (200) NOT NULL UNIQUE,
);

IF OBJECT_ID('dbo.Koshtorys', 'U') IS NULL
CREATE TABLE Koshtorys
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	Year INT NOT NULL,
	Institution_ID INT NOT NULL,	/*foreign key to Budget_institution*/
	KEKW_Code INT NOT NULL,			/*foreign key to KEKW*/
	Limit_costs MONEY NOT NULL,
);

IF OBJECT_ID('dbo.Koshtorys_Change', 'U') IS NULL
CREATE TABLE Koshtorys_Change
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	Koshtorys_ID INT, /*foreign key to Koshtorys*/
	Changed_lim MONEY NOT NULL,
);

IF OBJECT_ID('dbo.Platizhne_doruchennia', 'U') IS NULL
CREATE TABLE Platizhne_doruchennia
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	Date DATE DEFAULT GETDATE(),
	Institution_ID INT NOT NULL,	/*foreign key to Budget_institution*/
	Recipient NVARCHAR (100),
	Purpose NVARCHAR (200),
	Sum MONEY,
	KEKW_Code INT NOT NULL,			/*foreign key to KEKW*/
	Bank_Code INT NOT NULL,			/*foreign key to Commercial_bank*/
	Pidrozdil_ID INT,				/*foreign key to Pidrozdil_kaznacheystva*/
);