/*
	YH25 Carlos Johansson Bergqvist
*/

-- Skapar databas
CREATE DATABASE Bokhandel;

USE Bokhandel;

-- Skapar tabell för kunder
CREATE TABLE Kunder (
	KundID INT AUTO_INCREMENT PRIMARY KEY,
	Namn VARCHAR(100) NOT NULL,
	Email VARCHAR(255) UNIQUE NOT NULL,
	Telefon VARCHAR(20),
	Adress VARCHAR(255) NOT NULL
);

CREATE INDEX index_email ON Kunder(Email);

-- Skapar tabell för beställningar
CREATE TABLE Bestallningar (
	OrderID INT AUTO_INCREMENT PRIMARY KEY,
	KundID INT NOT NULL,
	Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp >= 0),
	FOREIGN KEY (KundID) REFERENCES Kunder(KundID) ON DELETE CASCADE -- Foreignkey refererar till kunder.kundID
);

--  Skapar tabell för Böcker
CREATE TABLE Bocker (
	BokID INT AUTO_INCREMENT PRIMARY KEY,
	Titel VARCHAR(100) NOT NULL,
	ISBN CHAR(13) NOT NULL UNIQUE,
	Forfattare VARCHAR(100) NOT NULL,
	Pris DECIMAL (10,2) NOT NULL CHECK(Pris > 0),
	Lagerstatus INT NOT NULL CHECK (Lagerstatus >= 0)
);

-- Skapar tabell för Orderrader
CREATE TABLE Orderrader (
	OrderradID INT AUTO_INCREMENT PRIMARY KEY,
	OrderID INT NOT NULL,
	BokID INT NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0),
	Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
	FOREIGN KEY (OrderID) REFERENCES Bestallningar(OrderID) ON DELETE CASCADE, -- Foreignkey refererar till Order.OrderID
	FOREIGN KEY (BokID) REFERENCES Bocker(BokID) ON DELETE CASCADE-- Foreignkey refererar till Bocker.BokID
);

CREATE TABLE Kundlogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT,
    Handelse VARCHAR(255),
    Loggdatum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) ON DELETE SET NULL
);

-- 5 Index, Constraints & Triggers

DELIMITER $$

CREATE TRIGGER uppdatera_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
   UPDATE Bocker
   SET Lagerstatus = Lagerstatus - NEW.Antal
   WHERE BokID = NEW.BokID;
END $$

CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
   INSERT INTO Kundlogg (KundID, Handelse)
   VALUES (NEW.KundID, CONCAT('Ny kund: ', NEW.Namn));
END $$

DELIMITER ;

-- Lägger till kunder i Kunder
INSERT INTO Kunder (Namn, Email, Telefon, Adress) VALUES
	('Anna Andersson', 'anna@mail.com', '1234567890', 'Adress1'),
	('Erik Svensson', 'erik@mail.com', '1224567890', 'Adress2'),
	('Lisa Berg', 'lisa@mail.com', '1034567800', 'Adress3'),
    ('Clas Ohlson', 'cl@mail.com', '5554567800', 'Adress4');

-- Lägger till böcker i Böcker
INSERT INTO Bocker (Titel, ISBN, Forfattare, Pris, Lagerstatus) VALUES
	('Hobbit', '9780345445605', 'J R R Tolkien', 19.99, 10),
	('1984', '9780141036144', 'George Orwell', 18.99, 5), 
	('Project Hail Mary', '9780593135228', 'Andy Weir', 17.99, 20);

-- Lägger till beställningar i Beställningar
INSERT INTO Bestallningar (KundID, Totalbelopp) VALUES 
	(1, 39.98),  
    (2, 17.99),  
    (4, 56.97),
	(1, 18.99);

-- Lägger till ordrar i Orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Pris) VALUES
	(1, 1, 2, 19.99),
	(2, 3, 1, 17.99),
	(3, 2, 3, 18.99),
    (4, 2, 1, 18.99);

-- 2. Hämta, filtrera och sortera
SELECT * FROM Kunder;
SELECT * FROM Bestallningar;

SELECT * FROM Kunder
WHERE Namn = 'Lisa Berg' AND Email = 'lisa@mail.com';

SELECt * FROM Bocker
ORDER BY Pris ASC;

-- 3. Modifiera data (UPDATE, DELETE, TRANSAKTIONER)
-- Lade till ON DELETE CASCADE, för att ta bort automatiskt från fk constraint
UPDATE Kunder
SET Email = 'nyemail@mail.com'
WHERE KundID = 3;

START TRANSACTION;

DELETE FROM Kunder
WHERE KundID = 4;

SELECT * FROM KUNDER;

ROLLBACK;

SELECT * FROM Kunder;

-- Arbeta med JOINs & GROUP BY
-- punkt 1, 3, 4
SELECT Kunder.KundID, Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar
FROM Kunder
INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.KundID, Kunder.Namn
HAVING AntalBestallningar > 2
ORDER BY AntalBestallningar DESC;

-- punkt 2
SELECT Kunder.Namn, Bestallningar.OrderID
FROM Kunder
LEFT JOIN Bestallningar
ON Kunder.KundID = Bestallningar.KundID
ORDER BY OrderID DESC;
