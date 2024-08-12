use Kaznacheystvo;

/*Task C*/

ALTER TABLE Commercial_bank
DROP CONSTRAINT CK_Code;

ALTER TABLE Budget_institution
DROP CONSTRAINT UQ_Pidrozdil_ID;

ALTER TABLE Pidrozdil_kaznacheystva
DROP CONSTRAINT DF_Building_address;

ALTER TABLE Pidrozdil_kaznacheystva
DROP COLUMN Building_address;

ALTER TABLE Platizhne_doruchennia
DROP COLUMN Bank_name;

DROP TABLE Platizhne_doruchennia, Koshtorys_Change, Koshtorys, Budget_institution, Pidrozdil_kaznacheystva,  Commercial_bank,  KEKW;