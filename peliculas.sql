/* SQL con Base de Datos de Alquiler de Películas(SAKILA) */

SELECT f.title, a.address, c.city, co.country
FROM film f, address a, city c, country co
INNER JOIN film ON f.film_id = f.film_id
INNER JOIN address ON a.address_id = a.address_id
INNER JOIN city ON C.city_id = a.city_id
INNER JOIN country ON co.country = co.country
LIMIT 1



SELECT co.country, c.city, a.address, a.address2, s.first_name, s.last_name
FROM country co, city c, address a, staff s
WHERE co.country_id = c.country_id 
AND a.city_id = c.city_id 
AND s.address_id = a.address_id

