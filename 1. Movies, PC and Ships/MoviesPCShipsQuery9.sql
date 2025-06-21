-- 1.
CREATE DATABASE test
GO
USE test
GO

-- 2.
CREATE TABLE Product (
	maker CHAR(1),
	model CHAR(4),
	type VARCHAR(7)
)

CREATE TABLE Printer (
	code INT,
	model CHAR(4),
	color CHAR(1) DEFAULT 'n',
	price DECIMAL(9, 2)
)
DROP TABLE Printer

CREATE TABLE Classes (
	class CHAR(50),
	type CHAR(2)
)

-- 3.
INSERT INTO Printer(code, model) 
VALUES(1, '1234');
INSERT INTO Printer(code, model, color) 
VALUES(2, '1235', NULL);

-- 4.
ALTER TABLE Classes
ADD bore FLOAT

-- 5.
ALTER TABLE Printer
DROP COLUMN price

-- 6.
DROP TABLE Product
DROP TABLE Printer
DROP TABLE Classes

DROP DATABASE test