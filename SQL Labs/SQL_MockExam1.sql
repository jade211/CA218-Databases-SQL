-- Q1 ---------------------------------------
USE world;
-- A)
# Q:List the full information for all cities that start with the letter ‘A’.


-- SELECT 
--     *
-- FROM
--     city
-- WHERE
--     Name LIKE 'A%'



-- B)
# Q: List the name of each continent, together with the number of countries, average population and average life expectancy of the continent. 
# Order by Country Count, from highest number of countries to lowest.

-- SELECT 
--     Continent,
--     COUNT(Name) AS CountryNumber,
--     AVG(Population) AS AVG_Population,
--     AVG(LifeExpectancy) AS AVG_LifeExpectancy
-- FROM
--     country
-- GROUP BY Continent
-- ORDER BY CountryNumber DESC;





-- C)
# Q: Using a nested query and join expression:
# List the name, population and the number of languages spoken in each country where the life expectancy 
# is greater than the average life expectancy for all countries. Order the result from highest number of languages to lowest.


-- SELECT 
--     country.Name,
--     country.Population,
--     COUNT(countrylanguage.Language) AS Languages_Spoken
-- FROM
--     country
--         INNER JOIN
--     countrylanguage ON country.Code = countrylanguage.CountryCode
-- WHERE
--     country.LifeExpectancy > (SELECT 
--             AVG(country.LifeExpectancy)
--         FROM
--             country)
-- GROUP BY country.Name , country.Population
-- ORDER BY Languages_Spoken DESC;





-- Q2 ------------------------------------------
--  A)
#Q: List each customer’s first and last name and the total amount the customer paid to rent films. 
# Order the result by amount from lowest to highest.
USE Sakila;

-- SELECT 
--     customer.first_name,
--     customer.last_name,
--     SUM(payment.amount) AS TotalRental
-- FROM
--     customer
--         INNER JOIN
--     payment ON customer.customer_id = payment.customer_id
-- GROUP BY customer.first_name , customer.last_name
-- ORDER BY TotalRental ASC;



# SOLUTION PROVIDED
-- SELECT first_name, last_name, sum(amount) 
-- FROM payment join customer using (customer_id)
-- group by customer_id
-- order by sum(amount) asc;









-- B)
# Q: Show the name of the most popular film category based on the number of individual films rented. 
# Display also the number of times individual films in this category were rented.

# How I did it (WRONG)
-- SELECT category.name, Count(film_category.film_id) AS Rented_Per_Category FROM film_category 
-- INNER JOIN category ON category.category_id = film_category.category_id 
-- GROUP BY category.Name;


# Answer (CORRECT)
-- SELECT category.name, Count(film_category.film_id) AS Rented_Per_Category FROM film_category 
-- INNER JOIN category ON category.category_id = film_category.category_id 
-- INNER JOIN film ON film_category.film_id = film.film_id
-- INNER JOIN inventory ON film.film_id = inventory.film_id
-- INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
-- GROUP BY film_category.category_id
-- ORDER BY Rented_Per_Category desc
-- LIMIT 1;


-- Q3
-- A)
# Q: Find out which products have a total quantity ordered greater than product S18_3685. 
# From this, list the names of each of these products, how many different customers have ordered this product and the total profit it has made. 
# (Hint: profit for each unit is MSRP-buyPrice)
USE classicmodels;

# MY SOLUTION
-- SELECT 
--     products.productName,
--     SUM(quantityOrdered) AS TotalQuantity,
--     COUNT(DISTINCT customerNumber) AS TotalCustomers,
--     (MSRP - buyPrice) * SUM(orderdetails.quantityOrdered) AS Profit
-- FROM
--     orders
--         INNER JOIN
--     orderdetails USING (OrderNumber)
--         INNER JOIN
--     products USING (productCode)
-- GROUP BY productCode
-- HAVING SUM(orderdetails.quantityOrdered) > (SELECT 
--         SUM(quantityOrdered)
--     FROM
--         orderdetails
--     WHERE
--         productCode = 'S18_3685')
-- ORDER BY SUM(MSRP - buyPrice) * SUM(orderdetails.quantityOrdered);






# GIVEN SOLUTIONS
-- SELECT products.productName, sum(quantityOrdered) AS TotalQuantity, COUNT(DISTINCT customerNumber) AS TotalCustomers, (MSRP - buyPrice)*sum(orderdetails.quantityOrdered) AS Profit FROM orderdetails JOIN products USING (productCode) JOIN orders using (ordernumber) GROUP BY productCode HAVING sum(quantityOrdered) > (SELECT SUM(quantityOrdered) FROM orderdetails WHERE productCode = "S18_3685") ORDER BY SUM(MSRP - buyPrice)*sum(orderdetails.quantityOrdered);

-- select productName, sum(quantityOrdered) tot, count(distinct customerNumber), (MSRP-buyPrice)*sum(quantityOrdered) totprofit
-- from orderdetails join products using (ProductCode)
-- join orders using (ordernumber)
-- group by productCode
-- having sum(quantityOrdered) > (select sum(quantityOrdered) s18tot from orderdetails where productCode='S18_3685')
-- order by totprofit









-- B)
# Q: How many products in a) have a total quantityOrdered greater than 200 and were ordered by more than 20 customers?

-- SELECT COUNT(*) FROM (SELECT 
--     products.productName,
--     SUM(quantityOrdered) totquantity,
--     COUNT(DISTINCT customerNumber) totcustomers,
--     (MSRP - buyPrice) * SUM(orderdetails.quantityOrdered) totprofit
-- FROM
--     orders
--         INNER JOIN
--     orderdetails USING (OrderNumber)
--         INNER JOIN
--     products USING (productCode)
-- GROUP BY productCode
-- HAVING SUM(orderdetails.quantityOrdered) > (SELECT 
--         SUM(quantityOrdered) s18tot
--     FROM
--         orderdetails
--     WHERE
--         productCode = 'S18_3685')
-- ORDER BY totprofit)t 
-- WHERE totquantity > 1000 AND totcustomers > 20;
