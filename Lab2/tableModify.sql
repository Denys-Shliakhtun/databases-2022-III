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

/*Task B*/

ALTER TABLE Pidrozdil_kaznacheystva
ADD Building_address NVARCHAR(100) CONSTRAINT DF_Building_address DEFAULT 'Не вказано';

ALTER TABLE KEKW
ALTER COLUMN Purpose NVARCHAR(200);

ALTER TABLE Platizhne_doruchennia
ADD CHECK (Sum > 10);

ALTER TABLE Commercial_bank
ADD CONSTRAINT CK_Code CHECK(Code>99999 AND Code<1000000);

ALTER TABLE Koshtorys_Change
ALTER COLUMN Changed_lim INT;

ALTER TABLE Platizhne_doruchennia
ADD Sum_2 AS Sum*0.02;

ALTER TABLE Platizhne_doruchennia
ADD Bank_name NVARCHAR(100);

ALTER TABLE Budget_institution
ADD CONSTRAINT UQ_Pidrozdil_ID UNIQUE (Pidrozdil_ID);