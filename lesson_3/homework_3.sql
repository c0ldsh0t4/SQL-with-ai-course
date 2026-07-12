USE master;
GO

CREATE DATABASE OnlineStore;
GO

USE OnlineStore;
GO


-- ==========================
-- CREATE TABLES
-- ==========================


CREATE TABLE Customers(
    Id INT NOT NULL
    CONSTRAINT PK_Customers PRIMARY KEY,
    FirstName NVARCHAR(20) NOT NULL, 
    LastName NVARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL CONSTRAINT UQ_Customers_Email UNIQUE,
    RegistrationDate DATE DEFAULT GETDATE()
);
GO

CREATE TABLE Products(
    Id INT NOT NULL
        CONSTRAINT PK_Products PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2)
    CONSTRAINT CK_Products_Price CHECK (Price > 0),
    StockQuantity INT,
    CategoryID INT

);
GO

CREATE TABLE Categories(
    Id INT NOT NULL
        CONSTRAINT PK_Categories PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);
GO

CREATE TABLE Orders (
    Id INT NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL

);
GO

CREATE TABLE OrderDetails (
    Id INT NOT NULL
        CONSTRAINT PK_OrderDetails PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL 
    CONSTRAINT CK_OrderDetails_Quantity CHECK(Quantity > 0),
    UnitPrice DECIMAL(10, 2) NOT NULL
);
GO


-- ============
-- FOREIGN KEYS
-- ============


ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories 
FOREIGN KEY (CategoryID) 
REFERENCES Categories(Id);
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(Id);
GO

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrdersDetails_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders(Id);
GO

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Products
FOREIGN KEY (ProductID)
REFERENCES Products(Id);
GO

ALTER TABLE Products
ADD Description NVARCHAR(255);
GO

ALTER TABLE Products
DROP COLUMN Description;
GO

-- ==========
-- TEST DATA
-- ==========

INSERT INTO Customers(
    Id,
    FirstName,
    LastName,
    Email,
    RegistrationDate
)
VALUES (
    1,
    'Oleksii',
    'Baranovskyi',
    'oleksii.baranovskyi@example.com',
    GETDATE()
),
(
    2,
    'Ivan',
    'Ivanov',
    'ivan@example.com',
    GETDATE()
),

(
    3,
    'Anna',
    'Petrenko',
    'anna@example.com',
    GETDATE()
);
GO


INSERT INTO Categories(
    Id,
    CategoryName,
    Description
)
VALUES
(
    1,
    'Electronics',
    'Electronic devices'
),
(
    2,
    'Books',
    'Books and magazines'
),
(
    3,
    'Clothes',
    'Clothing and accessories'
);
GO

INSERT INTO Products(
    Id,
    ProductName,
    Price,
    StockQuantity,
    CategoryID
)
VALUES (
    1,
    'Laptop',
    1005.00,
    45,
    1
),
( 
    2,
    'Rich Dad Poor Dad',
    15.40,
    30,
    2
),

(
    3,
    'T-shirt',
    10.50,
    200,
    3
);
GO


INSERT INTO Orders(
    Id,
    CustomerID,
    OrderDate,
    TotalAmount
)
VALUES
(
    1,
    1,
    GETDATE(),
    1005.00
),
(
    2,
    2,
    GETDATE(),
    15.40
),
(
    3,
    3,
    GETDATE(),
    10.50
);
GO

INSERT INTO OrderDetails(
    Id,
    OrderID,
    ProductID,
    Quantity,
    UnitPrice
)
VALUES
(
    1,
    1,
    1,
    1,
    1005.00
),
(
    2,
    2,
    2,
    1,
    15.40
),
(
    3,
    3,
    3,
    1,
    10.50
);
GO

SELECT * FROM Customers;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
GO
