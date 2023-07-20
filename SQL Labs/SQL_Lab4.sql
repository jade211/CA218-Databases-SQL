-- TASK 1 CARTESIAN PRODUCT - SAKILA DATABASE
-- Q1
-- SELECT     *
-- FROM    actor,    film_actor;

-- Q2
-- SELECT *
-- FROM actor, film_actor, film;

-- Q3
# Multiply rows values supplied to get answer = Gives 1092400000
-- Describe (SELECT * FROM actor, film_actor, film);

# OR do this and multiply each value returned = Gives 1092400000
-- (SELECT COUNT(actor_id) FROM actor);
-- (SELECT COUNT(film) FROM film_actor);
-- (SELECT COUNT(title) FROM film);

# DEGREE
-- SELECT * FROM sakila.actor, sakila.film_actor, sakila.film;
# Count columns = Gives 20

-- The disadvantage is, it takes a lot of time to 
-- generate the combination in which most of the data 
-- will be useless as it relates records that do not 
-- normally relate.









-- TASK 1 CARTESIAN PRODUCT - WORLD DATABASE
-- Q1
-- SELECT 
--     *
-- FROM
--     city,
--     country;

-- Q2
-- SELECT 
--     *
-- FROM
--     country,
--     countrylanguage;

-- Q3
#Q3. How do you address the problem of large data 
-- resulting from a cartesian product?

-- By specifying condition that checks the 
-- equivalence of common field values from both relations.










-- TASK 2 CARTESIAN PRODUCT (with Projection and Selection) -  SAKILA DATABASE
-- Q1
# DO THIS (NULL AT END)
-- SELECT DISTINCT
--     actor_id, first_name, last_name
-- FROM
--     actor
-- WHERE
--     actor_id IN (SELECT 
--             actor_id
--         FROM
--             film_actor);

# OR DO THIS ** (DUPLICATES - Add DISTINCT infront for no duplicates)
-- SELECT DISTINCT first_name, last_name
-- FROM    actor,    film_actor
-- WHERE    actor.actor_id = film_actor.actor_id;


-- Q2
-- SELECT DISTINCT last_name
-- FROM    actor, film_actor
-- WHERE    actor.actor_id = film_actor.actor_id AND actor.first_name = "John";