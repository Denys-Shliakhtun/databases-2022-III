USE Kaznacheystvo;

/*Task 1*/

/*a*/
SELECT * FROM KEKW WHERE Code = 2000

/*b*/
SELECT * FROM Platizhne_doruchennia WHERE Sum > 1000
SELECT Name FROM Budget_institution WHERE Pidrozdil_ID = 6;
SELECT * FROM Commercial_bank WHERE Code < 310000

/*c*/
SELECT * FROM KEKW WHERE NOT Code > 3000

/*d*/
SELECT * FROM Budget_institution WHERE Pidrozdil_ID = 10 OR (Pidrozdil_ID > 5 AND NOT Pidrozdil_ID > 7)

/*e*/
SELECT KEKW_Code, SUM(Sum) AS 'KEKW_Sum' FROM Platizhne_doruchennia GROUP BY KEKW_Code HAVING SUM(Sum) > 1000

/*f.i*/
SELECT * FROM Commercial_bank WHERE Commercial_bank.Name IN (N'Ощадбанк', N'Укргазбанк')

/*f.ii*/
SELECT * FROM Budget_institution WHERE Pidrozdil_ID BETWEEN 6 AND 8

/*f.iii*/
SELECT * FROM Pidrozdil_kaznacheystva WHERE Territory LIKE N'%, м._Киї[абв]%';
SELECT * FROM Commercial_bank WHERE Commercial_bank.Name LIKE N'%укр[ес]%'

/*f.iv*/
SELECT * FROM Commercial_bank WHERE Code IS NOT NULL

/*Task 2*/

/*a*/
SELECT Budget_institution.Name AS 'Budget_institution', 
	(SELECT Name FROM Pidrozdil_kaznacheystva WHERE Budget_institution.Pidrozdil_ID = ID) AS 'Pidrozdil_kaznacheystva' 
	FROM Budget_institution
SELECT * FROM Budget_institution WHERE Pidrozdil_ID IN (SELECT ID FROM Pidrozdil_kaznacheystva)

/*b*/
SELECT * FROM Pidrozdil_kaznacheystva WHERE NOT EXISTS (SELECT * FROM Budget_institution WHERE Pidrozdil_ID = Pidrozdil_kaznacheystva.ID)
SELECT * FROM Pidrozdil_kaznacheystva WHERE ID NOT IN (SELECT Pidrozdil_ID FROM Budget_institution)

/*c*/
SELECT Budget_institution.Name AS 'Budget institution', Commercial_bank.Name AS 'Bank' FROM Budget_institution CROSS JOIN Commercial_bank

/*d*/
SELECT Budget_institution.Name, Pidrozdil_kaznacheystva.Territory FROM Budget_institution, Pidrozdil_kaznacheystva WHERE Pidrozdil_ID = Pidrozdil_kaznacheystva.ID

/*e*/
SELECT ID, Date, Sum, Name, EDRPOU FROM Platizhne_doruchennia, Commercial_bank WHERE Bank_Code = Code AND Sum > 5000

/*f*/
SELECT Platizhne_doruchennia.ID, Date, Sum, KEKW_Code, Name FROM Platizhne_doruchennia INNER JOIN Budget_institution ON Institution_ID = Budget_institution.ID

/*g*/
SELECT Pidrozdil_kaznacheystva.Name,  Budget_institution.Name FROM Pidrozdil_kaznacheystva LEFT OUTER JOIN Budget_institution ON Pidrozdil_ID = Pidrozdil_kaznacheystva.ID

/*h*/
SELECT Pidrozdil_kaznacheystva.Name,  Budget_institution.Name FROM Pidrozdil_kaznacheystva RIGHT OUTER JOIN Budget_institution ON Pidrozdil_ID = Pidrozdil_kaznacheystva.ID

/*i*/
SELECT 
	Platizhne_doruchennia.ID, 
	Date, 
	(SELECT Name FROM Budget_institution WHERE Institution_ID = Budget_institution.ID) AS 'Budget institution',
	Recipient,
	Purpose,
	KEKW_Code,
	(SELECT Name FROM Commercial_bank WHERE Code = Platizhne_doruchennia.Bank_Code) AS 'Bank',
	Pidrozdil_kaznacheystva.Name AS 'Kaznacheystvo' 
	FROM Platizhne_doruchennia LEFT OUTER JOIN Pidrozdil_kaznacheystva ON Pidrozdil_ID = Pidrozdil_kaznacheystva.ID