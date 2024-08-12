use Kaznacheystvo;

/*Task D*/
ALTER TABLE Budget_institution
ADD CONSTRAINT FK_Institution_To_Pidrozdil FOREIGN KEY (Pidrozdil_ID) REFERENCES Pidrozdil_kaznacheystva (ID) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Koshtorys
ADD CONSTRAINT FK_Koshtorys_To_Institution FOREIGN KEY (Institution_ID) REFERENCES Budget_institution (ID);

ALTER TABLE Koshtorys
ADD CONSTRAINT FK_Koshtorys_To_KEKW FOREIGN KEY (KEKW_Code) REFERENCES KEKW (Code);

ALTER TABLE Koshtorys_Change
ADD CONSTRAINT FK_Change_To_Koshtorys FOREIGN KEY (Koshtorys_ID) REFERENCES Koshtorys (ID);

ALTER TABLE Platizhne_doruchennia
ADD CONSTRAINT FK_Doruchennia_To_Institution FOREIGN KEY (Institution_ID) REFERENCES Budget_institution (ID);

ALTER TABLE Platizhne_doruchennia
ADD CONSTRAINT FK_Doruchennia_To_KEKW FOREIGN KEY (KEKW_Code) REFERENCES KEKW (Code);

ALTER TABLE Platizhne_doruchennia
ADD CONSTRAINT FK_Doruchennia_To_Bank FOREIGN KEY (Bank_Code) REFERENCES Commercial_bank (Code);

ALTER TABLE Platizhne_doruchennia
ADD CONSTRAINT FK_Doruchennia_To_Pidrozdil FOREIGN KEY (Pidrozdil_ID) REFERENCES Pidrozdil_kaznacheystva (ID);
