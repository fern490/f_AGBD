/* SQL con Chinook */

/*1*/
SELECT FirstName, LastName
FROM employees
ORDER BY LastName, FirstName

/*2*/
SELECT t.Name AS canción, t.Milliseconds / 1000 AS duracion
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Big Ones'
ORDER BY Duracion DESC

/*3*/
SELECT g.Name AS género, COUNT(t.TrackId) AS cantCanciones
FROM genres g
INNER JOIN tracks t ON g.GenreId = t.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY cantCanciones DESC

/*4*/
SELECT a.Title AS disco, COUNT(t.TrackId) AS cantCanciones
FROM albums a
INNER JOIN tracks t ON a.AlbumId = t.AlbumId
GROUP BY a.AlbumId, a.Title
HAVING cantCanciones >= 5
ORDER BY cantCanciones

/*5*/
SELECT a.Title AS disco, SUM(t.UnitPrice) AS precioTotal /* Suma los precios de todas las canciones del disco */
FROM albums a
INNER JOIN tracks t ON a.AlbumId = t.AlbumId
GROUP BY a.AlbumId, a.Title
ORDER BY precioTotal
LIMIT 10

/*6*/
SELECT t.Name AS tema, g.Name AS género, a.Title AS disco
FROM tracks t
INNER JOIN genres g ON t.GenreId = g.GenreId
INNER JOIN albums a ON t.AlbumId = a.AlbumId
WHERE t.UnitPrice = 0.99

/*7*/
SELECT t.Name AS tema, t.Milliseconds / 1000 AS duracionSeg, a.Title AS disco, ar.Name AS artista
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
INNER JOIN artists ar ON a.ArtistId = ar.ArtistId
ORDER BY duracionSeg
LIMIT 20

/*8*/
SELECT e.LastName AS empleado, e.Title AS puesto, jefe.LastName AS jefe, COUNT(c.CustomerId) AS cantClientes
FROM employees e
LEFT JOIN employees jefe ON e.ReportsTo = jefe.EmployeeId
LEFT JOIN customers c ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId, e.LastName, e.Title, jefe.LastName
ORDER BY cantClientes DESC

/*9*/
INSERT INTO tracks (Name, MediaTypeId, Composer, Milliseconds, UnitPrice)
VALUES ("canción1", 1, "Autor1", 185002, 0.99),
       ("canción2", 1, "Autor2", 210000, 0.99),
       ("canción3", 1, "Autor3", 256396, 0.99),
       ("canción4", 1, "Autor4", 309534, 0.99)

/*10*/
SELECT t.name
FROM tracks t
WHERE TrackId BETWEEN 3504 AND 3507

/*11*/
UPDATE tracks
SET Name = 'Song Modificada 1'
WHERE Name = 'canción1'

UPDATE tracks
SET Name = 'Song Modificada 2'
WHERE Name = 'canción2'

/*12*/
SELECT t.name
FROM tracks t
WHERE TrackId BETWEEN 3504 AND 3505

/*13*/
DELETE FROM tracks WHERE TrackId BETWEEN 3504 AND 3505
