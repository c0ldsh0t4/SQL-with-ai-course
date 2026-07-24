-- SELECT
-- FROM
-- JOIN      ← если нужны несколько таблиц
-- ON        ← если есть JOIN
-- WHERE     ← если фильтруем строки
-- GROUP BY  ← если используем агрегатные функции (COUNT, SUM, AVG, MIN, MAX)
-- HAVING    ← если фильтруем группы после GROUP BY
-- ORDER BY  ← если нужна сортировка


-- SELECT Artists.Name, COUNT(*) AS TotalSongs
-- FROM Songs
-- JOIN Artists
-- ON Songs.ArtistId = Artists.Id
-- GROUP BY Artists.Name 
-- HAVING COUNT(*)  > 5
-- ORDER BY TotalSongs DESC

-- SELECT ReleaseYear, COUNT(*) AS Totalsongs
-- FROM Songs
-- GROUP BY Songs.ReleaseYear
-- HAVING COUNT(*) >= 3
-- ORDER BY TotalSongs 


-- SELECT Artists.Name , COUNT(*) AS TotalSongs
-- FROM Songs
-- JOIN Artists
-- ON Songs.ArtistId = Artists.Id
-- WHERE ReleaseYear >= 2010
-- GROUP BY Artists.Name
-- ORDER BY TotalSongs DESC


-- SELECT Artists.Name , COUNT(*) AS TotalSongs
-- FROM Songs
-- JOIN Artists
-- ON Songs.ArtistId = Artists.Id
-- GROUP BY Artists.Name 
-- HAVING COUNT(*) >= 2
-- ORDER BY TotalSongs DESC

