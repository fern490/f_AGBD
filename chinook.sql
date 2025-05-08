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
SELECT g.Name AS género, count(t.TrackId) AS cantCanciones
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

