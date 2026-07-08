USE master; 
GO

CREATE DATABASE CompanyEmployees;
GO

USE CompanyEmployees;
GO

CREATE TABLE Employees(
    id INT NOT NULL,
    First_Name VARCHAR(50) NOT NULL, 
    Last_Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(1) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Mobile_Number VARCHAR(15) NOT NULL,
    Date_of_Joining DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    id_Department INT NOT NULL,
    Active VARCHAR(5) NOT NULL
);

INSERT INTO Employees (
    id,
    First_Name,
    Last_Name,
    Gender,
    Date_of_Birth,
    Email,
    Mobile_Number,
    Date_of_Joining,
    Salary,
    id_Department,
    Active
)
VALUES (
    1,
    'Oleksii',
    'Baranovskyi',
    'M',
    '1994-01-04',
    'oleksii.baranovskyi@example.com',
    '+380123456789',
    '2020-01-15',
    4000.00,
    1,
    'Yes'
)

SELECT * FROM Employees;
GO


