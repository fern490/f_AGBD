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

/*6º*/
SELECT count(*), f.rating
FROM film f
GROUP BY rating

/*7º*/
SELECT count(*) AS cant_peliculas, c.name
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name

/*7º*/
SELECT count(*), f.title, a.first_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.title 

/*8º*/
SELECT count(fa.film_id) AS apariciones, a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY apariciones DESC
LIMIT 10

/*9º*/
SELECT count(i.inventory_id) AS total_inventory, s.store_id, a.address, c.city, co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
INNER JOIN inventory i ON s.store_id = i.store_id
GROUP BY s.store_id, a.address, c.city, co.country
ORDER BY total_inventory

/*10º incompleto*/

SELECT count(*), f.title AS peliculas_distintas, s.store_id, a.address, c.city, co.country
FROM film f
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
GROUP BY f.title, s.store_id, a.address, c.city, co.country
ORDER BY peliculas_distintas

/*11*/
SELECT AVG() AS pel_alquiler_prom, 
FROM 
