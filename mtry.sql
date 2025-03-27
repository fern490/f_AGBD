/*SQL Mystery*/

SELECT * FROM crime_scene_report

SELECT * FROM crime_scene_report
WHERE type = "murder"

SELECT * FROM crime_scene_report
WHERE type = 'murder' AND date = 20180115 AND city = 'SQL City' 

SELECT * FROM person

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number ASC /* Resultados en orden ascendente */
LIMIT 10

SELECT * FROM person
WHERE name LIKE '%Annabel%'
AND address_street_name = "Franklin Ave"

SELECT * FROM interview
WHERE person_id IN ("14887", "16371") /* filas donde person_id es igual a 14887 o 16371 */

SELECT * FROM get_fit_now_check_in
WHERE membership_id LIKE '48Z%'
AND check_in_date = "20180109"

SELECT * FROM drivers_license
WHERE gender = "male"
AND plate_number LIKE '%H42W%'

SELECT * FROM person
WHERE license_id IN ("423327", "664760")

SELECT * FROM get_fit_now_member
WHERE person_id IN ("51739", "67318")
