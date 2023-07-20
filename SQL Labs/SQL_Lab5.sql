-- TASK 1 - SAKILA DATABASE
# Q: max amount from payment table
-- Q1
-- SELECT 
--     MAX(amount)
-- FROM
--     payment;

-- Q2
# Q: min amount from payment table
-- SELECT 
--     MIN(amount)
-- FROM
--     payment;



-- Q3
# Q: min max, avg and total collected in October 2006
-- SELECT 
--     MIN(amount) AS myMax, MAX(amount) AS myMin, AVG(amount) AS myAvg, SUM(amount) AS myTotal
-- FROM
--     payment
-- WHERE
--     payment_date LIKE '2006-10%'; # NONE IN OCTOBER - SO NULL

# OR could do
-- SELECT MIN(amount), MAX(amount), AVG(amount), SUM(amount) FROM payment WHERE YEAR(payment_date) = 2006 AND MONTH(payment_date) = 10;
-- SELECT MIN(amount), MAX(amount), AVG(amount), SUM(amount) FROM payment WHERE payment_date BETWEEN '2006-10-01 ' AND '2006-10-31';



-- Q4
# Q: Show the total amount of payment collected each day
-- SELECT 
--     DAY(payment_date) AS Day, MONTH(payment_date) AS Month, YEAR(payment_date) AS Year, SUM(amount) AS Daily_Total
-- FROM
--     payment
-- GROUP BY DAY(payment_date), MONTH(payment_date), YEAR(payment_date);

# SAMPLE ANSWER: SELECT payment_date, SUM(amount) FROM payment GROUP BY payment_date;



-- Q5
# Q: total amount per year ordered by date in DESC
-- SELECT 
--     YEAR(payment_date), SUM(amount) AS yearlyTotal
-- FROM
--     payment
-- GROUP BY YEAR(payment_date)
-- ORDER BY YEAR(payment_date) DESC;






# Q6
# Q: Show the number of films each actor is involved.
-- SELECT 
--     actor.actor_id, actor.first_name, actor.last_name, COUNT(film_id)
-- FROM
--     actor,
--     film_actor
-- WHERE
--     actor.actor_id = film_actor.actor_id
-- GROUP BY actor.actor_id;

# Could also do it this way lmaoo easier
-- SELECT actor_id, COUNT(film_id)
-- FROM film_actor
-- GROUP BY actor_id;






# -----------------------------------------------------------------







-- TASK 1 - WORLD DATABASE
-- Q1
# Q: Select the name and countryCode and the population of the city with the highest population.
-- SELECT 
--     Name, CountryCode, Population
-- FROM
--     city
-- WHERE
--     Population = (SELECT 
--             MAX(Population)
--         FROM
--             city);


-- Q2
# Q: Show the total population of countries by region
-- SELECT 
--     Region, SUM(Population)
-- FROM
--     Country
-- GROUP BY Region;



-- Q3
# Q: Select the country code and population of the country that has a city with the largest population.
-- SELECT 
--     code, Population
-- FROM
--     country
-- WHERE
--     code IN (SELECT 
--             CountryCode
--         FROM
--             city
--         WHERE
--             Population = (SELECT 
--                     MAX(Population)
--                 FROM
--                     city));



# ------------------------------------------------------------








-- TASK 2 - WORLD DATABASE
-- Q1
-- # Q: Identify the region that has the lowest population
-- SELECT DISTINCT
--     Region, Population
-- FROM
--     country
-- WHERE
--     population IN (SELECT 
--             MIN(Population)
--         FROM
--             country);

# Gives Population Number: SELECT DISTINCT population AS Min_Population FROM country WHERE population IN (SELECT min(Population) FROM country);

#OR use his answer
# SELECT Region, MIN(Population) FROM country GROUP BY Region;


# Another way to do it
-- SELECT 
--     MIN(t.pop)
-- FROM
--     (SELECT 
--         region, SUM(population) AS pop
--     FROM
--         country
--     GROUP BY region
--     ORDER BY region) t;




-- Q2
# Q: Select the languages that are widely spoken in a country (see perentage) along with the number of speakers (derived attribute)
  
    
-- CHATGPS Solution - Gives country (and most spoken languages) and figures out speakers from them per country.
SELECT 
    country.Name,
    language.Language,
    (language.Percentage / 100) * country.Population AS num_speakers
FROM
    country
        INNER JOIN
    countrylanguage language ON country.Code = language.CountryCode
-- UNNECESSARY PIECE***
-- WHERE
--     language.IsOfficial = TRUE
--         AND (language.Percentage / 100) >= 0.1
ORDER BY country.Name , num_speakers DESC;




-- This solution is the grosser version of the one below
-- Select cl.Language, sum(co.Population*(cl.Percentage/100)) as speakers
-- From Country as co inner join CountryLanguage as cl on co.Code = cl.CountryCode
-- Group by cl.Language
-- Having speakers > 1000000
-- Order by speakers desc;





-- CORRECT SOLUTION
-- SELECT 
--     countrylanguage.Language,
--     SUM(country.Population * (countrylanguage.Percentage / 100)) AS speakers
-- FROM
--     Country
--         INNER JOIN
--     CountryLanguage ON country.Code = countrylanguage.CountryCode
-- GROUP BY countrylanguage.Language
-- HAVING speakers > 1000000
-- ORDER BY speakers DESC;



# Solution above (but also printing out country name (diff values???)
-- SELECT 
--     countrylanguage.Language,
--     country.Name,
--     SUM(country.Population * (countrylanguage.Percentage / 100)) AS speakers
-- FROM
--     Country
--         INNER JOIN
--     CountryLanguage ON country.Code = countrylanguage.CountryCode
-- GROUP BY countrylanguage.Language, country.Name
-- HAVING speakers > 1000000
-- ORDER BY speakers DESC;
--     




  ## Doesnt work (my way)
-- SELECT 
-- 	Name,
--     CountryCode,
--     Language,
--     Percentage,
--     (SUM(Population) / Percentage) AS Speakers FROM countrylanguage INNER JOIN country GROUP BY Name, CountryCode, Language, Percentage;








-- Q3
# Q: Show the actor detail along with the number of films each actor is involved.
-- SELECT 
--     actor.*, New.Number
-- FROM
--     actor
--         INNER JOIN
--     (SELECT 
--         film_actor.actor_id, COUNT(film_actor.actor_id) AS Number
--     FROM
--         film_actor
--     GROUP BY film_actor.actor_id) 
--     AS New 
-- 		WHERE actor.actor_id = New.actor_id;
--      
     
     # OR  
	-- SELECT actor.*, F.NUM FROM actor INNER JOIN (SELECT actor_id, COUNT(film_id) as NUM FROM film_actor GROUP BY actor_id ) F WHERE actor.actor_id = F.actor_id;
        
        
        
        
# CHATGPT Solution provided.
-- SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS num_films_involved
-- FROM actor
-- INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- GROUP BY actor.actor_id
-- ORDER BY num_films_involved DESC;

    
    
    
    
    
    