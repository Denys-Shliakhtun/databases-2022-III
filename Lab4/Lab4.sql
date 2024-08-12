USE Kaznacheystvo;

/*Task 1*/

/*a*/
SELECT Code, (SELECT COUNT(*) FROM Platizhne_doruchennia WHERE KEKW_Code = Code) AS 'Count' FROM KEKW

/*b*/
SELECT (SELECT Name FROM Budget_institution WHERE ID = Institution_ID) AS 'Budget institution', SUM(Sum) AS 'Sum' FROM Platizhne_doruchennia GROUP BY Institution_ID

/*c*/
SELECT LOWER(Budget_institution.Name), UPPER(Pidrozdil_kaznacheystva.NAME) FROM Budget_institution, Pidrozdil_kaznacheystva WHERE Pidrozdil_ID = Pidrozdil_kaznacheystva.ID

/*d*/
SELECT DAY(Date) AS 'Day', MONTH(Date) AS 'Month', DATEPART(yyyy, DATE) AS 'Year', DATEADD(q, 3, Date) AS 'Date after 3 quartals', DATEDIFF(dd, Date, GETDATE()) AS 'Days passed' FROM Platizhne_doruchennia

/*e*/
SELECT Institution_ID, Bank_Code, SUM(Sum) 'Sum paid with specific bank' FROM Platizhne_doruchennia GROUP BY Institution_ID, Bank_Code

/*f*/
SELECT Bank_Code, SUM(Sum) AS 'Sum' FROM Platizhne_doruchennia GROUP BY Bank_Code HAVING SUM(Sum) > 15000

/*g*/
SELECT AVG(Sum) FROM Platizhne_doruchennia HAVING COUNT(Sum) > 20

/*h*/
SELECT  ROW_NUMBER() OVER (ORDER BY Bank_Code) AS 'Counter', Sum, (SELECT Name FROM Commercial_bank WHERE Code = Bank_Code) AS 'Bank', ID FROM Platizhne_doruchennia

/*i*/
SELECT Sum, Bank_Code AS 'Bank', ID FROM Platizhne_doruchennia ORDER BY Bank_Code, ID DESC



/*Task 2*/

/*a*/
GO
CREATE VIEW Institution_kaznacheystvo AS 
SELECT Budget_institution.ID, Budget_institution.Name AS 'Budget_institution', Pidrozdil_kaznacheystva.Name AS 'Pidrozdil_kaznacheystva', Territory FROM Budget_institution, Pidrozdil_kaznacheystva WHERE Pidrozdil_ID = Pidrozdil_kaznacheystva.ID;
GO

SELECT * FROM Institution_kaznacheystvo

DROP VIEW Institution_kaznacheystvo

/*b*/
GO
CREATE VIEW Doruchennya AS 
SELECT ID, (SELECT Institution_kaznacheystvo.Budget_institution FROM Institution_kaznacheystvo WHERE Platizhne_doruchennia.Institution_ID = Institution_kaznacheystvo.ID) AS 'Budget_institution', (SELECT Name FROM Commercial_bank WHERE Bank_Code = Code) AS 'Bank' FROM Platizhne_doruchennia
GO

SELECT * FROM Doruchennya

DROP VIEW Doruchennya

/*c*/
GO
ALTER VIEW Doruchennya AS (SELECT ID, (SELECT Name FROM Commercial_bank WHERE Bank_Code = Code) AS 'Bank' FROM Platizhne_doruchennia)
GO

/*d*/
GO
sp_help Institution_kaznacheystvo
GO
sp_helptext Institution_kaznacheystvo
GO
sp_depends Doruchennya