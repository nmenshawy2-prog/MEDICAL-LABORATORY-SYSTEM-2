CREATE DATABASE MedicalLabDB;
USE MedicalLabDB;
CREATE TABLE Laboratorian (
    LaboratorianID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    BirthDate DATE,
    Job VARCHAR(100)
);
CREATE TABLE Component (
    ComponentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    AvailableQuantity INT NOT NULL,
    MinimumQuantity INT NOT NULL
);
CREATE TABLE MedicalTest (
    TestID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
CREATE TABLE MedicalTest_Component (
    TestID INT,
    ComponentID INT,
    PRIMARY KEY (TestID, ComponentID),
    FOREIGN KEY (TestID) REFERENCES MedicalTest(TestID),
    FOREIGN KEY (ComponentID) REFERENCES Component(ComponentID)
);
CREATE TABLE TestResult (
    ResultID INT PRIMARY KEY,
    TestID INT NOT NULL,
    TestDate DATE NOT NULL,
    PatientID INT NOT NULL,
    LaboratorianID INT NOT NULL,
    Result TEXT,
    FOREIGN KEY (TestID) REFERENCES MedicalTest(TestID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (LaboratorianID) REFERENCES Laboratorian(LaboratorianID)
);
INSERT INTO Laboratorian (LaboratorianID, name, phone, address)
VALUES (01, 'Dr. John Smith', '1234567890', '123 Main St');
INSERT INTO Patient (PatientID, name, phone, address, BirthDate, job)
VALUES (1, 'Alice Johnson', '0987654321', '456 Oak St', '1990-05-10', 'Engineer'),
(12527, 'JOANA SAM', '0736227282', '676 NEW ORLEANS St', '1980-04-10', 'Nurse'),
(12537, 'Brian smith', '0736236237', '490 Oak St', '2000-011-30', 'Acountant');
INSERT INTO Component (Componentid, name, AvailableQuantity, MinimumQuantity)
VALUES 
(1, 'Hemoglobin', 10, 5),
(2, 'WBC Reagent', 3, 5),
(3, 'Platelets Solution', 20, 10);
INSERT INTO MedicalTest (Testid, name, price)
VALUES 
(1, 'CBC', 100.00),
(2, 'Blood Sugar', 50.00);
INSERT INTO MedicalTest_Component (Testid, Componentid)
VALUES 
(1, 1),
(1, 2),
(1, 3);
INSERT INTO MedicalTest_Component (Testid, Componentid)
VALUES 
(2, 1);
INSERT INTO TestResult (ResultID, TestID, TestDate, PatientID, LaboratorianID, Result)
VALUES (1, 1, '2025-08-15', 1, 1, 'Normal CBC levels');

CREATE VIEW CBC_test AS
SELECT Patient.Name
FROM Patient
INNER JOIN TestResult ON Patient.PatientID = TestResult.PatientID
WHERE TestResult.TestID = 1001
AND YEAR(TestResult.Testdate) = 2024;
select * from CBC_Test;

Create View Low_components AS
SELECT  Name 
FROM Component
WHERE MinimumQuantity > AvailableQuantity;
select * from Low_components;


CREATE VIEW Price AS
SELECT PatientID, SUM(Price) AS TotalPrice
FROM MedicalTest
INNER JOIN TestResult
    ON TestResult.TestID = MedicalTest.TestID
WHERE PatientID = 12527
  AND TestDate >= '2022-01-01'
GROUP BY PatientID;

SELECT * FROM Price;
