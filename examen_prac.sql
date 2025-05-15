/* Examen parte Práctica - 5to "D" */

/* (1) */
SELECT a.title, COUNT(t.TrackId) AS cantCanciones
FROM albums a
INNER JOIN tracks t ON a.AlbumId = t.AlbumId
WHERE a.Title = 'Unplugged'
GROUP BY a.AlbumId

/* (2) */
SELECT ar.name AS Artista, COUNT(t.TrackId) AS cantCanciones
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
INNER JOIN tracks t ON al.AlbumId = t.AlbumId
GROUP BY ar.ArtistId
HAVING cantCanciones >= 30
ORDER BY cantCanciones DESC

/* (3) */
INSERT INTO tracks (Name, MediaTypeId, Composer, Milliseconds, UnitPrice)
VALUES ("newSong1", 1, "Autor 1", 185002, 0.99),
       ("newSong2", 1, "Autor 2", 210000, 0.99),
	   ("newSong3", 1, "Autor 3", 256396, 0.99),
	   ("newSong4", 1, "Autor 4", 309534, 0.99),
	   ("newSong5", 1, "Autor 5", 375478, 0.99),
	   ("newSong6", 1, "Autor 6", 424789, 0.99)

/* (4) */
UPDATE tracks
SET Name = 'Song Modificada 1'
WHERE Name = 'newSong1'

UPDATE tracks
SET Milliseconds = 295782
WHERE Name = 'newSong2'

/* (5) */
DELETE FROM tracks WHERE TrackId BETWEEN 3501 AND 3503
