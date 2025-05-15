/* SQL con Base de Datos de Alquiler de Películas(SAKILA) */

/*1º*/
SELECT f.title, a.address, c.city, co.country /*Devuelve el título de la pelicula, dirección donde está disponible(tienda), ciudad(tienda), país(tienda)*/
FROM film f /*Cada 'INNER JOIN' une una tabla con otra*/
INNER JOIN inventory i ON f.film_id = i.film_id /*Une 'f' con 'i' usando 'film_id' porque una pelicula puede estar en varias tiendas*/
INNER JOIN store s ON i.store_id = s.store_id /*Une 'i' con 's' mediante 'store_id' para saber en qué tienda está la pelicula*/
INNER JOIN address a ON s.address_id = a.address_id /*Une 's' con 'a' a través de 'address_id'*/
INNER JOIN city c ON a.city_id = c.city_id /*Une 'a' con 'c' empleando 'city_id'*/
INNER JOIN country co ON c.country_id = co.country_id /*Une 'c' con 'co' por 'country_id'*/
WHERE f.title = 'ACADEMY DINOSAUR'
LIMIT 1

/*2º*/
SELECT f.title, c.name, l.name, f.rating, f.length
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN language l ON f.language_id = l.language_id
WHERE f.length BETWEEN 60 AND 120

/*3º*/
SELECT s.first_name, s.last_name, a.address, c.city, co.country
FROM staff s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id

/*4º*/
SELECT f.title, MIN(r.return_date), MAX(r.return_date)
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id /*Une 'i' con 'r' usando 'inventory_id' para saber qué copia de la película fue alquilada*/
GROUP BY f.title /*Agrupa los datos por título de película('f.title')*/

/*5º*/
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title, f.description, f.release_year, c.name, i.inventory_id, s.store_id,
       ad.address, ci.city, co.country, cu.customer_id, cu.first_name, cu.last_name, r.rental_id, r.rental_date, p.amount, p.payment_date
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
JOIN address ad ON s.address_id = ad.address_id
JOIN city ci ON ad.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, a.actor_id, cu.customer_id

/*6º*/
SELECT COUNT(*), f.rating
FROM film f
GROUP BY rating

/*7º*/
SELECT COUNT(*) AS cant_peliculas, c.name
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name

/*8º*/
SELECT COUNT(fa.film_id) AS apariciones, a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY apariciones DESC
LIMIT 10

/*9º*/
SELECT COUNT(i.inventory_id) AS total_inventory, s.store_id, a.address, c.city, co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
INNER JOIN inventory i ON s.store_id = i.store_id
GROUP BY s.store_id, a.address, c.city, co.country
ORDER BY total_inventory

/*10º*/
SELECT COUNT(i.film_id) as total_movies, s.store_id, a.address, c.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
JOIN inventory i ON s.store_id = i.store_id
GROUP BY s.store_id, a.address, c.city, co.country
ORDER BY total_movies

/*11º*/
SELECT c.name AS categoría, AVG(f.rental_rate) AS renta_costo
FROM category c
INNER JOIN film_category fc ON fc.category_id = c.category_id
INNER JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY renta_costo

/*12º incompleto*/
SELECT r.rental_id, r.rental_date, r.return_date, p.amount AS costo_total
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN payment p ON r.rental_id = p.rental_id
WHERE f.title = 'ALABAMA DEVIL'
ORDER BY r.rental_date DESC

/*13º*/
SELECT f.title, f.length AS duracion, c.name
FROM film f
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category c ON c.category_id = fc.category_id
ORDER BY f.length DESC

/*14º*/
SELECT f.title AS nombre, COUNT(fa.actor_id) >= 5 AS actores
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
WHERE f.title LIKE 'w%'
GROUP BY f.film_id, f.title
ORDER BY f.title

/*15º*/
SELECT c.first_name AS nombre, c.last_name AS apellido, SUM(p.amount) AS total_pagado
FROM customer c
INNER JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_pagado DESC

/*16º*/
SELECT f.title, f.length AS duracion, a.first_name, a.last_name
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE f.length <= 52

/*17º*/
SELECT c.last_name, c.city, co.country, a.address, COUNT(r.rental_id), SUM(p.amount) AS pago
FROM customer c
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city c ON c.city_id = a.city_id
INNER JOIN country co ON co.country_id = c.country_id
INNER JOIN payment p ON p.customer_id = c.customer_id
INNER JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.last_name, c.city, co.country, a.address
ORDER BY pago ASC

/*18º*/
INSERT INTO actor (actor_id, first_name, last_name, last_update)
VALUES (201, "Fernando", "Valle", "2025-04-24 11:37:29")

/*19º*/
INSERT INTO actor (actor_id, first_name, last_name, last_update)
VALUES (202, "Joe", "Smith", "2025-05-08 9:20:11")
VALUES (203, "Tom", "Holland", "2025-05-09 9:24:33")

/*20*/


/*21*/
DELETE FROM actor WHERE nombre = ""