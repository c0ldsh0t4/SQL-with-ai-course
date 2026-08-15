
-- !!! пам'ятайте тут немає правильного чи неправильного запиту, є лише той що ви реалізували

-- Для розігріву :)
--Завдання з циклом і умовами
 -- Створити локальну змінну number, створити цикл, який перевіряє числа від 1 до 20. 
	-- Якщо число кратне 3, виводьте "Fizz", якщо кратне 5 — "Buzz", в іншому випадку просто виводимо число
	-- Пояснення: Кратне число це коли число %(ділеться) на 3 без остатку, 11 % 3 = 1 (не кратне 3), 21 % 3= 0 (кратне 3)
	-- Використовуемо WHILE IF PRINT
DECLARE @number INT;
SET @number = 1;
WHILE @number <= 20
BEGIN
IF @number % 3 = 0
	PRINT 'Fizz';
ELSE IF @number % 5 = 0
	PRINT 'Buzz';
ELSE
	PRINT @number;
SET @number = @number + 1;
END;

-- 1. Змінні та Умови (DECLARE, IF...ELSE)
	--Бізнес-сценарій: "Ціновий радар для маркетологів"
	--Маркетологи просять написати скрипт, який перевіряє середню ціну смартфонів певного бренду (наприклад, 'Apple'). 
	--Якщо середня ціна перевищує $ 1000, скрипт повинен вивести повідомлення "Увага: Преміум сегмент. Запускаємо рекламу для VIP-клієнтів!". 
	--Якщо ціна менша або дорівнює — "Бюджетний/Середній сегмент. Запускаємо масову рекламу".
SELECT AVG(Price) as avgPrice
FROM Products
WHERE Brand = 'Apple';
DECLARE @avgPrice DECIMAL(10, 2);
SET @avgPrice = (
	SELECT AVG(Price)
	FROM Products
	WHERE Brand = 'Apple'
);


-- 2. Цикли та Табличні змінні (WHILE, @Table)
	-- Бізнес-сценарій:"Генератор промокодів". 
	-- Магазин готується до розпродажу.Потрібно згенерувати 5 унікальних купонів на знижку.
	-- Завдання: Створити табличну змінну для зберігання промокодів. 
	-- За допомогою циклу WHILE згенерувати 5 кодів у форматі PROMO-1, PROMO-2 і т.д., записати їх у табличну змінну, а потім вивести на екран.
DECLARE @PromoCodes TABLE (PromoCode NVARCHAR(20));
DECLARE @counter INT = 1;
WHILE @counter <= 5
BEGIN
	INSERT INTO @PromoCodes (PromoCode)
	VALUES ('PROMO-' + CAST(@counter AS NVARCHAR(10)));

	SET @counter = @counter + 1;
END;
SELECT * 
FROM @PromoCodes;


-- 3. Тимчасові таблиці (#Temp Table)
	--Бізнес-сценарій: "Аналітика Чорної П'ятниці"
	--Директор хоче нагородити найкращих клієнтів поточного року.
	--Завдання: Зібрати всіх клієнтів та загальну суму їхніх покупок за цей рік у Тимчасову таблицю.
	--Потім з цієї тимчасової таблиці вибрати ТОП-3 "VIP-клієнтів", чия сума покупок найбільша. 
	--Після цього видалити тимчасову таблицю.
	-- Опціонально- оскільки даних може бути дуже багато, і нам потрібні індекси
CREATE TABLE #VipCustomers (
	CustomerID INT PRIMARY KEY,
	TotalAmount DECIMAL(10, 2)
);
INSERT INTO #VipCustomers (CustomerID, TotalAmount)
SELECT CustomerID, SUM(Amount) AS TotalAmount
FROM Orders
WHERE YEAR(OrderDate) = YEAR(GETDATE())
GROUP BY CustomerID;
SELECT TOP 3 * 
FROM #VipCustomers
ORDER BY TotalAmount DESC;
DROP TABLE #VipCustomers;


-- 4. Табличні змінні (@Table) як "Віртуальний кошик"
	-- Бізнес-сценарій: "Розрахунок кошика до створення замовлення"
	-- Користувач на сайті додав 2 товари в кошик, але ще не натиснув "Купити" (тобто в таблиці Orders цих даних ще немає).
	-- Завдання: Зімітувати цей кошик. Створити табличну змінну, покласти туди ID двох будь-яких товарів та їхню кількість. 
	-- Написати JOIN цієї табличної змінної з реальною таблицею Products, щоб вивести користувачеві чек: Назва товару, Кількість, Ціна за штуку, Загальна вартість рядка.
DECLARE @Cart TABLE (ProductID INT, Quantity INT);
INSERT INTO @Cart (ProductID, Quantity)
VALUES (1, 2), (3, 1); -- Припустимо, що користувач додав 2 одиниці товару з ID=1 і 1 одиницю товару з ID=3
SELECT p.ProductName, c.Quantity, p.Price AS UnitPrice, (c.Quantity * p.Price) AS TotalPrice
FROM @Cart c
JOIN Products p ON c.ProductID = p.ProductID;



-- **** ДОДАТКОВІ СКЛАДНІ ЗАВДАННЯ НА КРЕАТИВНІСТЬ **** --

-- 5. Аналітичний звіт - з таблиці (Orders) вивести загальну кількість продажів з розбиттям по дням тижня (місяц \рік не враховуєм) і відсортувати за назвою тижня.
	-- тобто: Понеділок	53
	--	  Вівторок	43 ...
SELECT  DATENAME(WEEKDAY, OrderDate) AS DayOfWeek, COUNT(*) AS TotalSales
FROM Orders 
GROUP BY DATENAME(WEEKDAY, OrderDate)
ORDER BY DayOfWeek;

-- 6. Завдання з вкладеним циклом
	-- Створіть два вкладені цикли для імітації робочих днів і годин
DECLARE @day INT = 1;
DECLARE @hour INT = 9; -- Початок робочого дня о 9:00
WHILE @day <= 5 -- Припустимо, що робочий тиждень триває 5 днів (з понеділка по п'ятницю)
BEGIN
	WHILE @hour <=17 -- Робочий день триває до 17:00
	BEGIN
	PRINT 'Day' + CAST(@day AS NVARCHAR(10)) + ', Hour:' + CAST(@hour AS NVARCHAR(10));
	SET @hour = @hour + 1;
	END
	SET @hour = 9; -- Скидаємо годину для наступного дня
	SET @day = @day + 1;
END

-- 7. Завдання на CTE і рекурсію
	-- Обчисліть факторіал числа з допомогою рекурсивного CTE.
	WITH FactorialCTE AS (
	    SELECT 1 AS Number, 1 AS Factorial
	    UNION ALL
	    SELECT Number + 1, Factorial * (Number + 1)
	    FROM FactorialCTE
	    WHERE Number < 5 -- Обчислюємо факторіал числа 5
	)
	SELECT * FROM FactorialCTE;



-- 8. Рекурсія
	--Бізнес-сценарій:
	--До вас прийшов HR-директор магазину. Він плутається, хто кому підпорядковується.
	--Завдання: Написати Рекурсивний CTE, який побудує візуальне дерево компанії.
	--Запит має вивести:
		--Ім'я та посаду співробітника.
		--Рівень ієрархії (Генеральний директор — це рівень 1, його заступники — рівень 2, їхні підлеглі — рівень 3 і т.д.).
		--Бонус із зірочкою: Зробити відступи (пробіли або тире) перед іменами залежно від рівня, щоб результат виглядав як справжнє дерево папок на комп'ютері!
	WITH EmployeeHierarchy AS (
	    SELECT 
	        EmployeeID,
	        FullName,
	        JobTitle,
	        ManagerID,
	        1 AS HierarchyLevel,
	        CAST(FullName AS NVARCHAR(MAX)) AS DisplayName
	    FROM #Employees
	    WHERE ManagerID IS NULL -- Починаємо з керівника (CEO)
	    
	    UNION ALL
	    
	    SELECT 
	        e.EmployeeID,
	        e.FullName,
	        e.JobTitle,
	        e.ManagerID,
	        eh.HierarchyLevel + 1 AS HierarchyLevel,
	        CAST(REPLICATE('    ', eh.HierarchyLevel) + e.FullName AS NVARCHAR(MAX)) AS DisplayName
	    FROM #Employees e
	    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
	)
	SELECT *
	FROM EmployeeHierarchy;

	DROP TABLE IF EXISTS #Employees;
	CREATE TABLE #Employees (
	    EmployeeID INT PRIMARY KEY,
	    FullName NVARCHAR(100) NOT NULL,
	    JobTitle NVARCHAR(50) NOT NULL,
	    ManagerID INT NULL -- Посилання на керівника (ID іншого співробітника)
	);

	INSERT INTO #Employees (EmployeeID, FullName, JobTitle, ManagerID)
	VALUES
	    (1, N'Олександр Шеф', N'Генеральний директор (CEO)', NULL),
    
	    (2, N'Ірина Лід', N'Керівник відділу продажів', 1),
	    (3, N'Петро Код', N'IT Директор', 1),
    
	    (4, N'Максим Дзвінок', N'Старший менеджер (B2B)', 2),
	    (5, N'Олена Каса', N'Старший менеджер (B2C)', 2),
	    (6, N'Анна База', N'Адміністратор БД (DBA)', 3),
    
	    (7, N'Іван Стажер', N'Продавець-консультант', 5),
	    (8, N'Марія Стажер', N'Продавець-консультант', 5),
	    (9, N'Сергій Дріт', N'Системний адміністратор', 3);
	GO

