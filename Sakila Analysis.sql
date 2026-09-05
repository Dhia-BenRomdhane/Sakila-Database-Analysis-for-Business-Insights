USE sakila;

-- DATA EXPLORATION


-- Which movies are most popular by genre?
-- Listing All Movies and Their Categories

SELECT film.film_id, film.title, film.release_year, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
ORDER BY film.film_id;

-- Most Popular Movies by Rental Count

SELECT f.title, COUNT(r.rental_id) AS nbr_of_rentals
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY nbr_of_rentals DESC ;

-- Top Movies by Category

SELECT c.name AS category, f.title, COUNT(r.rental_id) AS nbr_of_rentals
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY category, f.title
ORDER BY category, nbr_of_rentals DESC;

-- Most Popular Genres by Rental Count

SELECT c.name AS category, COUNT(r.rental_id) AS nbr_of_rentals
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY category
ORDER BY nbr_of_rentals DESC;

-- Which customers rent the most movies?
-- Top Customers by Number of Rentals

SELECT rental.customer_id, customer.first_name, customer.last_name, COUNT(rental_id) AS nbr_of_rentals
FROM rental 
JOIN customer ON customer.customer_id = rental.customer_id
GROUP BY customer_id
ORDER BY nbr_of_rentals DESC
LIMIT 5;

-- Store Performance: Which store generates the most revenue?
--  Sales by Store

SELECT store.store_id, SUM(p.amount) AS total_sales
FROM store 
JOIN inventory AS i ON store.store_id = i.store_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY store.store_id
ORDER BY total_sales DESC;

-- Rental Trends: What are the peak rental periods?
-- Monthly Rental Trends

SELECT MONTH(rental_date) AS month, COUNT(rental_id) AS rentals_by_month
FROM rental
GROUP BY month 
ORDER BY month;

-- Most Rented Movies per Month

SELECT month, title, nbr_of_rentals
FROM (
	SELECT 
		MONTH(r.rental_date) AS month, 
		f.title, 
		COUNT(r.rental_id) AS nbr_of_rentals,
		ROW_NUMBER() OVER (PARTITION BY MONTH(r.rental_date) ORDER BY COUNT(r.rental_id) DESC) AS rank_per_month
	FROM film AS f
	JOIN inventory AS i ON f.film_id = i.film_id
	JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY month, f.title
    ) AS films_ranked_per_month
WHERE rank_per_month <11
ORDER BY month, nbr_of_rentals DESC;


-- CREATING VIEWS

-- View for Most Popular Movies

CREATE VIEW popular_movies AS
SELECT f.title, COUNT(r.rental_id) AS nbr_of_rentals
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY nbr_of_rentals DESC ;

SELECT * FROM popular_movies;
