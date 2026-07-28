SELECT
FROM
JOIN      ← если нужны несколько таблиц
ON        ← если есть JOIN
WHERE     ← если фильтруем строки
GROUP BY  ← если используем агрегатные функции (COUNT, SUM, AVG, MIN, MAX)
HAVING    ← если фильтруем группы после GROUP BY
ORDER BY  ← если нужна сортировка


SELECT Artists.Name, COUNT(*) AS TotalSongs
FROM Songs
JOIN Artists
ON Songs.ArtistId = Artists.Id
GROUP BY Artists.Name 
HAVING COUNT(*)  > 5
ORDER BY TotalSongs DESC

SELECT ReleaseYear, COUNT(*) AS Totalsongs
FROM Songs
GROUP BY Songs.ReleaseYear
HAVING COUNT(*) >= 3
ORDER BY TotalSongs 


SELECT Artists.Name , COUNT(*) AS TotalSongs
FROM Songs
JOIN Artists
ON Songs.ArtistId = Artists.Id
WHERE ReleaseYear >= 2010
GROUP BY Artists.Name
ORDER BY TotalSongs DESC


SELECT Artists.Name , COUNT(*) AS TotalSongs
FROM Songs
JOIN Artists
ON Songs.ArtistId = Artists.Id
GROUP BY Artists.Name 
HAVING COUNT(*) >= 2
ORDER BY TotalSongs DESC

SELECT 
    SUM(Price * Quantity) AS TotalPrice, 
    SUM(Quantity) AS TotalQuantity
FROM Products;

SELECT AVG(Price) AS AveragePrice
FROM Products;

SELECT MAX(Price) AS HighestPrice
FROM Products;

SELECT MIN(Price) AS LowestPrice
FROM Products;

SELECT 
    MAX(Price) AS HighestPrice,
    MIN(Price) AS LowestPrice
FROM Products

SELECT 
    Name,
    Price
FROM Products
WHERE Price = (
    SELECT MAX(Price)
    FROM Products
)
OR Price =(
    SELECT MIN(Price)
    FROM Products
);


SELECT 
    Name,
    Price
FROM Products;

SELECT *
FROM Products
WHERE Category ='Laptop';

SELECT *
FROM Products
WHERE Price > 500;

SELECT *
FROM Products
WHERE 
    Category = 'Phone'
AND
    Price > 850;

SELECT *
FROM Products
WHERE 
    Price >= 100 
AND 
    Price <= 1000;

SELECT * 
FROM Products
WHERE Price BETWEEN 100 AND 1000;

SELECT *
FROM Products
WHERE Category != 'Phone';

SELECT *
FROM Products
WHERE 
    Category <> 'Phone'
AND
      Price < 500;


SELECT *
FROM Products
WHERE 
    Category = 'Phone'
OR
    Category = 'Laptop';
    -- ИЛИ
-- WHERE Category IN('Phone','Laptop')

SELECT *
FROM Products
WHERE 
    (Category IN ('Phone', 'Laptop'))
AND
    Price > 1000;


SELECT *
FROM Products
WHERE 
    Price < 100 
OR
    Price > 1000;


SELECT *
FROM Products
WHERE (Category IN ('Mouse', 'Keyboard'))
AND
    Price <= 100;


SELECT
    Name,
    Price
FROM Products
WHERE Price  BETWEEN 100 AND 1000 
AND Category <> 'Phone';

SELECT
    Name,
    Category,
    Price
FROM Products
WHERE (Category IN ('Laptop', 'Monitor'))
AND 
Price BETWEEN 400 AND 2000;

SELECT *
FROM Products
WHERE 
    (Category = 'Phone' AND Price < 900)
OR
    (Category = 'Mouse' AND Price > 100);


SELECT 
    Name,
    Price,
    Quantity
FROM Products
WHERE Price > 100
AND
    (Category IN('Laptop','Monitor','Headphones'))
AND
Quantity >= 5;


SELECT  COUNT(*) AS TotalQuantity, AVG(Price) AS AveragePrice
FROM Products
WHERE Category = 'Phone';

SELECT COUNT(*) AS TotalQuantity,MAX(Price),MIN(Price)
FROM Products
WHERE Category = 'Laptop';

SELECT Category, COUNT(*) AS TotalQuantity
FROM Products
GROUP BY (Category);

SELECT Category, AVG(Price) AS AveragePrice
FROM Products
GROUP BY(Category);

SELECT Category, 
COUNT(*) AS TotalQuantity,
AVG(Price) AS AveragePrice,
MAX(Price) AS MaxPrice,
MIN(Price) AS MinPrice
FROM Products
GROUP BY (Category);


SELECT Category, COUNT(*) AS TotalQuantity
FROM Products
GROUP BY (Category)
HAVING COUNT(*) > 1


SELECT Category,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY (Category)
HAVING AVG(Price) > 500



SELECT Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY (Category)
HAVING 
    COUNT(*) >= 2
AND
    AVG(Price) < 1000



SELECT Category,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Products
GROUP BY (Category)
HAVING 
    MAX(Price) > 800
    AND
    MIN(Price) < 900;



SELECT Customer.Name,
       Orders.OrderId
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId


SELECT Customers.Name,
       Products.ProductName
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId

SELECT 
    Customers.Name,
    Products.ProductName,
    Products.Price,
    Orders.Quantity
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId


SELECT 
    Customers.Name,
    Products.ProductName,
    Products.Price
FROM  Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId
WHERE Products.Price > 1000


SELECT
    Customers.Name,
    COUNT(*) AS OrdersCount
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
GROUP BY (Customers.Name)


SELECT 
    Customers.Name,
    SUM(Products.Price * Orders.Quantity) AS TotalSpent
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId
GROUP BY Customers.Name


SELECT 
    Customers.Name,
    COUNT(Products.ProductId) AS OrdersCount
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId
WHERE Products.Price > 1000
GROUP BY Customers.Name


SELECT 
    Customers.Name,
    SUM(Products.Price * Orders.Quantity) AS TotalSpent
FROM Orders
INNER JOIN Customers
ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Products
ON Products.ProductId = Orders.ProductId
GROUP BY Customers.Name

SELECT 
    Students.Name AS Student,
    Courses.CourseName AS Course
FROM Enrollments
INNER JOIN Students
ON Students.StudentId = Enrollments.StudentId
INNER JOIN Courses
ON Courses.CourseId = Enrollments.CourseId


SELECT 
    Courses.CourseName AS Course,
    COUNT (*) AS StudentsCount
FROM Enrollments
INNER JOIN Courses
ON Courses.CourseId = Enrollments.CourseId
GROUP BY CourseName

SELECT 
    Courses.CourseName AS Course,
    AVG(Enrollments.Grade) AS AverageGrade
FROM Enrollments
INNER JOIN Courses
ON Courses.CourseId = Enrollments.CourseId
GROUP BY Courses.CourseName