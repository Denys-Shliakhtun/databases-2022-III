use Kaznacheystvo;

/*Task E-G*/

CREATE ROLE viewer;
GRANT SELECT TO viewer;

CREATE ROLE add_information;
GRANT SELECT, INSERT, UPDATE TO add_information;

CREATE ROLE change_database;
GRANT CONTROL, ALTER, SELECT, INSERT, UPDATE, DELETE TO change_database;

CREATE LOGIN Bob_login WITH PASSWORD = 'Bob', DEFAULT_DATABASE = Kaznacheystvo, CHECK_POLICY = OFF;
CREATE LOGIN Steve_login WITH PASSWORD = '123', DEFAULT_DATABASE = Kaznacheystvo, CHECK_POLICY = OFF;
CREATE LOGIN Alster_login WITH PASSWORD = '123', DEFAULT_DATABASE = Kaznacheystvo, CHECK_POLICY = OFF;
GO

CREATE USER Bob FOR LOGIN Bob_login; 
CREATE USER Steve FOR LOGIN Steve_login;
CREATE USER Alster FOR LOGIN Alster_login;
GO

ALTER ROLE viewer ADD MEMBER Bob;
ALTER ROLE add_information ADD MEMBER Steve;
ALTER ROLE change_database ADD MEMBER Alster;

DENY SELECT ON Platizhne_doruchennia TO Bob;
DENY UPDATE ON Koshtorys_change TO Steve;

DROP USER Bob
DROP USER Steve
DROP USER Alster
GO

DROP LOGIN Bob_login
DROP LOGIN Steve_login
DROP LOGIN Alster_login
GO

DROP ROLE viewer
DROP ROLE add_information
DROP ROLE change_database