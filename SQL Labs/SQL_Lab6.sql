# TASK 1 - WORLD DATABASE
-- USE world;
# Q1
# Q List the name of each city that begins with the letter ‘A” and the country that city is in. 
USE world;
SELECT 
    City.Name, Country.Name
FROM
    City
        INNER JOIN
    Country ON City.CountryCode = Country.Code
WHERE
    City.Name LIKE 'A%';


-- Q2
# Q: Print out the names of all spoken languages which have more than 1million speakers. Ordered by the number of people who speak them, from most to least.
-- SELECT SUM(country.population) FROM country;

-- SELECT countrylanguage.Language, SUM(country.Population * (countrylanguage.Percentage / 100)) AS Speakers FROM 
-- countrylanguage INNER JOIN country ON countrylanguage.CountryCode = country.Code GROUP BY countrylanguage.Language HAVING Speakers >= 1000000 ORDER BY Speakers DESC;

SELECT 
    countrylanguage.Language,
    SUM(country.Population * (countrylanguage.Percentage / 100)) AS Spoken
FROM
    countrylanguage
        INNER JOIN
    country ON countrylanguage.CountryCode = country.Code
GROUP BY countrylanguage.Language
HAVING Spoken >= 1000000
ORDER BY Spoken DESC;

# TASK 2 - CLASSICMODELS DATABASE
-- Q3
# Q: Print out the name, description and number of sales for the top three selling productLines (depends on the number of sales). Order your results from highest to lowest.
USE classicmodels;
SELECT 
    productlines.productLine,
    productlines.textDescription,
    COUNT(orderdetails.orderNumber) AS Sales
FROM
    productlines
        INNER JOIN
    products ON productlines.productLine = products.productLine
        INNER JOIN
    orderdetails ON products.productCode = orderdetails.productCode
GROUP BY products.productLine
ORDER BY Sales DESC LIMIT 3;



-- Q3
# Q: Find out which product line is the most profitable, list that product line and the total income made by that product line.
# Hint: the income for each individual product is the buyPrice subtracted from priceEach multiplied by quantityOrdered
SELECT 
    productlines.productLine AS Product_Line,
    SUM((orderdetails.priceEach - products.buyPrice) * orderdetails.quantityOrdered) AS Total_Income
FROM
    productlines
        INNER JOIN
    products ON productlines.productLine = products.productLine
        INNER JOIN
    orderdetails ON products.productCode = orderdetails.productCode
GROUP BY products.productLine
ORDER BY Total_Income DESC
LIMIT 1;


-- Q5
# Q: Find what first names are in common between the customers table in the classicmodel schema and the customer table in the sakila schema.
SELECT 
    DISTINCT contactFirstName
FROM
    customers
WHERE
    contactFirstName IN (SELECT 
            first_name
        FROM
            sakila.customer);


# Another way to do it
-- SELECT DISTINCT 
--    first_name 
-- FROM sakila.customer c1
--    INNER JOIN classicmodels.customers c2 on c1.first_name=c2.contactFirstName;






-- Q6
# Q: List the name of all customers from any country where all the customers in that country 
# have a creditLimit greater than any customers living in Austria

SELECT 
    contactFirstName, contactLastName, creditLimit, country
FROM
    customers
WHERE
    country IN (SELECT 
            country
        FROM
            customers GROUP BY country
        HAVING
            MIN(creditLimit) > (SELECT 
                    MAX(creditLimit)
                FROM
                    customers
                WHERE
                    country = 'Austria'));



-- Q7
# Q: List the last name, location city, phone number and number of orders placed for customers
# who have placed 5 or more orders. List them with the highest number of orders placed first
-- WRONG ATTEMPT: SELECT customers.contactLastName, customers.city, customers.phone, COUNT(orderdetails.orderNumber) AS Orders From orderdetails INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber INNER JOIN customers ON orders.customerNumber = customers.customerNumber GROUP BY orderdetails.orderNumber ORDER BY Orders DESC;

SELECT 
    customers.contactLastName,
    customers.city,
    customers.country,
    customers.phone,
    COUNT(orders.orderNumber) AS Orders
FROM
    Customers
        INNER JOIN
    orders ON customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber
HAVING Orders >= 5
ORDER BY Orders DESC;


-- Q8
# Q: Using a nested select query expression: List the name, vendor and amount of units ordered 
# for all products. List them from highest number ordered to lowest.

SELECT 
    productName, productVendor, orderTable.Ordered
FROM
    products
        INNER JOIN
    (SELECT 
        SUM(quantityOrdered) AS Ordered, productCode
    FROM
        orderdetails
    GROUP BY productCode) AS orderTable ON products.productCode = orderTable.productCode
ORDER BY orderTable.Ordered DESC;




-- Q9
# Q: Return all the countries, the cities in each country and each country’s population for
# countries with an excess of 10 million people. Order the results by population, starting with the highest population.
-- USE World;


# This gives Country Name, City Names and Population of that city (WRONG??)
-- SELECT 
--     Country.Name, city.Name, Country.Population
-- FROM
--     country
--         INNER JOIN
--     city
-- WHERE
--     country.code = city.CountryCode
-- HAVING Country.Population > 10000000
-- ORDER BY Country.Population DESC;




# Gives country name, number of citites in that country and the population (CORRECT)
-- SELECT 
--     Country.Name, COUNT(city.Name) AS Cities, Country.Population
-- FROM
--     country
--         INNER JOIN
--     city
-- WHERE
--     country.code = city.CountryCode
-- GROUP BY Country.Name , Country.Population
-- HAVING Country.Population > 10000000
-- ORDER BY Country.Population DESC;



# Solution provided.
-- SELECT c.Name, count(cty.Name) as NumberOfCities, c.Population
-- FROM Country c 
-- inner join City cty on c.code = cty.CountryCode
-- where c.population > 10000000
-- GROUP BY CountryCode
-- Order by c.Population desc;



-- Q10
# Q: Using a nested select query expression: Find all countries that have a city with over 8million people and out of those countries
# find the number of languages spoken in each and order the results by the number of languages spoken.
-- USE world;
-- SELECT 
--     country.Name,
--     COUNT(countrylanguage.language) AS NumberOfLanguages
-- FROM
--     Country
--         INNER JOIN
--     CountryLanguage ON country.Code = countrylanguage.CountryCode
-- WHERE
--     Country.Name IN (SELECT 
--             Country.Name
--         FROM
--             country
--                 INNER JOIN
--             (SELECT 
--                 CountryCode
--             FROM
--                 city
--             WHERE
--                 population > 8000000) AS city1 ON country.Code = city1.CountryCode)
-- GROUP BY Country.Name
-- ORDER BY NumberOfLanguages;


# Another way to do it - Solution provided
-- Select cc.Name, count(cl.language) as NumberOfLanguages
-- From Country cc 
-- inner join CountryLanguage cl on cc.Code = cl.CountryCode
-- Where cc.Name in 
-- ( Select c.Name 
-- From Country c inner join City cty on c.code = cty.countrycode
-- Where cty.population > 8000000)
-- Group by cc.Name
-- Order by NumberOfLanguages;