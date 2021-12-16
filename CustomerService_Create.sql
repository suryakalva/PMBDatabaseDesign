-- Created by Vertabelo (http://vertabelo.com)

--database creation

CREATE DATABASE CutomerService;

-- tables
-- Table: Pmb_Category
CREATE TABLE Pmb_Category (
    CategoryID int NOT NULL AUTO_INCREMENT,
    CategoryName varchar(50) NOT NULL,
    CategoryActive bool NOT NULL,
    CONSTRAINT PK_CategoryID PRIMARY KEY (CategoryID)
) ENGINE InnoDB;

-- Table: Pmb_CategoryTally
CREATE TABLE Pmb_CategoryTally (
    CategoryTallyID int NOT NULL AUTO_INCREMENT,
    Hitcount int  NULL,
    InsertDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CategoryID int NOT NULL,
    CONSTRAINT PK_CategoryTallyID PRIMARY KEY (CategoryTallyID)
);

-- Table: Pmb_CategoryandQuestion
CREATE TABLE Pmb_CategoryandQuestion (
    CategoryandQuestionID int NOT NULL AUTO_INCREMENT,
    QuestionID int NOT NULL,
    CategoryID int NOT NULL,
    CONSTRAINT PK_CategoryandQuestionID PRIMARY KEY (CategoryandQuestionID)
);

-- Table: Pmb_QuestionTally
CREATE TABLE Pmb_QuestionTally (
    QuestionTallyID int NOT NULL AUTO_INCREMENT,
    HitCount int  NULL,
    Insertdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    QuestionID int NOT NULL,
    CONSTRAINT PK_QuestionTallyID PRIMARY KEY (QuestionTallyID)
);

-- Table: Pmb_Questions
CREATE TABLE Pmb_Questions (
    QuestionID int NOT NULL AUTO_INCREMENT,
    QuestionName text NOT NULL,
    Description text NOT NULL,
    Answer text NOT NULL,
    QuestionActive bool NOT NULL,
    PartnerCode int NOT NULL,
    CONSTRAINT PK_QuestionID PRIMARY KEY (QuestionID)
);


-- foreign keys
-- Reference: Pmb_CategoryTally_Pmb_Category (table: Pmb_CategoryTally)
ALTER TABLE Pmb_CategoryTally ADD CONSTRAINT Pmb_CategoryTally_Pmb_Category FOREIGN KEY Pmb_CategoryTally_Pmb_Category (CategoryID)
    REFERENCES Pmb_Category (CategoryID);

-- Reference: Pmb_CategoryandQuestion_Pmb_Category (table: Pmb_CategoryandQuestion)
ALTER TABLE Pmb_CategoryandQuestion ADD CONSTRAINT Pmb_CategoryandQuestion_Pmb_Category FOREIGN KEY Pmb_CategoryandQuestion_Pmb_Category (CategoryID)
    REFERENCES Pmb_Category (CategoryID);

-- Reference: Pmb_CategoryandQuestion_Pmb_Questions (table: Pmb_CategoryandQuestion)
ALTER TABLE Pmb_CategoryandQuestion ADD CONSTRAINT Pmb_CategoryandQuestion_Pmb_Questions FOREIGN KEY Pmb_CategoryandQuestion_Pmb_Questions (Pmb_Questions_QuestionID)
    REFERENCES Pmb_Questions (QuestionID);

-- Reference: Pmb_QuestionTally_Pmb_Questions (table: Pmb_QuestionTally)
ALTER TABLE Pmb_QuestionTally ADD CONSTRAINT Pmb_QuestionTally_Pmb_Questions FOREIGN KEY Pmb_QuestionTally_Pmb_Questions (QuestionID)
    REFERENCES Pmb_Questions (QuestionID);



-- End of file.

