/**
Author: Diogo Viana
Data Scientist / Data Analyst

Contact:
d.cviana@outlook.com
https://www.linkedin.com/in/diogo-viana/

MySQL practice
MySQL Sakila Practice exercices
**/

SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY';

USE sakila;

-- Overview of each table --

-- actor Table --
DESC actor;
/* As we can see, there are 4 columns in the actor table.*/

SELECT COUNT(*)
FROM actor;
/* There are 200 rows in the actor table.*/

SELECT *
FROM actor
LIMIT 10;

SELECT DISTINCT first_name
FROM actor;
/* Where only 128 first names are unique.*/

-- address Table --
DESC address;
/* There are 9 columns in the address table.*/

SELECT COUNT(*)
FROM address;
/* There are 603 rows in the address table.*/

SELECT *
FROM address
LIMIT 10;

SELECT DISTINCT district
FROM address;

SELECT DISTINCT city_id
FROM address;
/* There are 378 different districts and 599 city_ids.*/

-- category Table --
DESC category;
/* There are 3 columns in the category table.*/

SELECT COUNT(*)
FROM category;
/* There are 16 rows in the category table.*/

SELECT *
FROM category
LIMIT 10;

SELECT DISTINCT name
FROM category;
/* Where only 16 unique categories.*/

-- city Table --
DESC city;
/* There are 4 columns in the city table.*/

SELECT COUNT(*)
FROM city;
/* There are 600 rows in the city table.*/

SELECT *
FROM city
LIMIT 10;

SELECT DISTINCT city
FROM city;
/* Where only 599 unique cities.*/

-- country Table --
DESC country;
/* There are 3 columns in the country table.*/

SELECT COUNT(*)
FROM country;
/* There are 109 rows in the country table.*/

SELECT *
FROM country
LIMIT 10;
/* There are just 3 columns in the country table.*/

SELECT DISTINCT country
FROM country;
/* Where only 109 unique countries.*/

-- customer Table --
DESC customer;
/* There are 9 columns in the customer table.*/

SELECT COUNT(*)
FROM customer;
/* There are 599 rows in the customer table.*/

SELECT *
FROM customer
LIMIT 10;

SELECT DISTINCT first_name
FROM customer;
/* There are 591 unique first names.*/

-- film Table --
DESC film;
/* There are 13 columns in the film table.*/

SELECT COUNT(*)
FROM film;
/* There are 1000 rows in the film table.*/

SELECT *
FROM film
LIMIT 10;

SELECT DISTINCT title
FROM film;

SELECT DISTINCT rating
FROM film;
/* There are 1000 unique titles and 5 rating categories.*/

-- film_actor Table --
DESC film_actor;
/* As we can see, there are 3 columns in the film_actor table.*/

SELECT COUNT(*)
FROM film_actor;
/* There are 5462 rows in the film_actor table.*/

SELECT *
FROM film_actor
LIMIT 10;

SELECT DISTINCT film_id
FROM film_actor;
/* Where only 997 film_ids are unique.*/

-- film_category Table --
DESC film_category;
/* There are 3 columns in the film_category table.*/

SELECT COUNT(*)
FROM film_category;
/* There are 1000 rows in the film_category table.*/

SELECT *
FROM film_category
LIMIT 10;

SELECT DISTINCT category_id
FROM film_category;
/* Where only 16 category_ids are unique.*/

-- film_text Table --
DESC film_text;
/* As we can see, there are 3 columns in the film_text table.*/

SELECT COUNT(*)
FROM film_text;
/* There are 1000 rows in the film_text table.*/

SELECT *
FROM film_text
LIMIT 10;

SELECT DISTINCT title
FROM film_text;
/* Where only 1000 titles are unique.*/

-- inventory Table --
DESC inventory;
/* As we can see, there are 4 columns in the inventory table.*/

SELECT COUNT(*)
FROM inventory;
/* There are 4581 rows in the inventory table.*/

SELECT *
FROM inventory
LIMIT 10;

SELECT DISTINCT film_id
FROM inventory;
/* Where only 958 film_ids are unique.*/

-- language Table --
DESC language;
/* As we can see, there are 3 columns in the language table.*/

SELECT COUNT(*)
FROM language;
/* There are 6 rows in the language table.*/

SELECT *
FROM language
LIMIT 10;

SELECT DISTINCT name
FROM language;
/* Where 6 laanguages are unique.*/

-- payment Table --
DESC payment;
/* As we can observe, there are 7 columns in the payment table.*/

SELECT COUNT(*)
FROM payment;
/* There are 16049 rows in the payment table.*/

SELECT *
FROM payment
LIMIT 10;

SELECT DISTINCT customer_id
FROM payment;
/* Where only 599 customer_ids are unique.*/

-- rental Table --
DESC rental;
/* There are 7 columns in the rental table.*/

SELECT COUNT(*)
FROM rental;
/* There are 16044 rows in the rental table.*/

SELECT *
FROM rental
LIMIT 10;

SELECT DISTINCT inventory_id
FROM rental;
/* Where only 1000 inventory_ids are unique.*/

-- staff Table --
DESC staff;
/* As we can observe, there are 11 columns in the staff table.*/

SELECT COUNT(*)
FROM staff;
/* There are 2 rows in the staff table.*/

SELECT *
FROM staff
LIMIT 10;
/* There only 2 staffs in the staff table.*/

-- store Table --
DESC store;
/* As we can observe, there are 4 columns in the store table.*/

SELECT COUNT(*)
FROM store;
/* There are 2 rows in the store table.*/

SELECT *
FROM store
LIMIT 10;
/* There only 2 stores in the stores table.*/

-- Checking the table film

SELECT *
FROM film
LIMIT 5;

--  Find the shortest, longest and the average length in the film table.
SELECT	MIN(length) AS shortest_film,
		MAX(length) AS longest_film,
		AVG(length) AS avg_lenght_film
FROM film;

-- Checking the titles and description of the movies with the longest duration.
SELECT	title, description, release_year, rating, length
FROM film
WHERE length = (SELECT MAX(length) FROM film)
ORDER BY title ASC;

-- Checking how many films last more than 60 minutes grouped by the length.
SELECT	length,
		COUNT(rating) AS total_by_rating
FROM film
GROUP BY length
HAVING length > 60
ORDER BY length DESC;

-- Checking how many films with more than 60 minutes by category. --
SELECT	c.name AS categoty_name,
		COUNT(f.title) AS total_by_category
FROM	film as f
		INNER JOIN film_category as fc
        ON f.film_id = fc.film_id
			INNER JOIN category as c
            ON fc.category_id = c.category_id
WHERE length > 60            
GROUP BY	c.name
ORDER BY total_by_category DESC;

-- The top 3 categories with movies more than 60 minutes are: Sports, Foreign, and Family.

-- Top 10 categories with the longest film duration
SELECT	c.name AS category,
        f.length
FROM	film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
        INNER JOIN category AS c
			ON fc.category_id = c.category_id
GROUP BY	c.name,
			f.length
ORDER BY	f.length DESC
LIMIT 10;


-- How many films each actor has by category:
SELECT	a.first_name,
		a.last_name,
		c.name,
        COUNT(f.film_id) AS total_actor_film_by_category
FROM	actor AS a
	INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
		INNER JOIN film AS f
        ON fa.film_id = f.film_id
			INNER JOIN filM_category AS fc
            ON f.film_id = fc.film_id
				INNER JOIN category AS c
                ON fc.category_id = c.category_id
GROUP BY	a.first_name,
			a.last_name,
			c.name
ORDER BY total_actor_movie_by_category DESC;

-- List of films and their corresponding categories sorted by film title in ascending alphabetical order with their corresponding length
SELECT	f.title,
		c.name AS category,
        f.length
FROM	film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
        INNER JOIN category AS c
			ON fc.category_id = c.category_id
GROUP BY f.title, c.name, f.length
ORDER BY f.title ASC;


-- Checking the payments for a specific day
SELECT *
FROM payment
WHERE payment_date LIKE '%2005-07-28%';


-- Checking in an average how much each staff received renting during the month of July with the respective names.
SELECT	p.staff_id,
		s.first_name,
        s.last_name,
		ROUND(AVG(p.amount), 2) AS July_avg_per_staff
FROM	payment AS p
			INNER JOIN staff AS s
            ON p.staff_id = s.staff_id
WHERE	payment_date LIKE '2005-07%'
GROUP BY	p.staff_id,
			s.first_name,
            s.last_name
ORDER BY	July_avg_per_staff;
