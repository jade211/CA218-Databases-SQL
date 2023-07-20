-- Q1 Sakila Database (30 Marks)
-- (A) List the title, release_year and description for all films rated “PG”(15 marks)
USE sakila;
SELECT 
    title, release_year, description
FROM
    film
WHERE
    rating = 'PG';




-- (B) Using joins, list the title and category for all films where the category name begins with “A”. 
-- Order your results alphabetically by film title. (15 marks)

SELECT 
    film.title, category.name
FROM
    film
        INNER JOIN
    category
WHERE
    category.name LIKE 'A%'
ORDER BY film.title;













-- Q2 World Database (35 Marks)
-- (A) List the name of the city, the population of a city, the name of the country the city is in, and 
-- the percentage of the country's population that live in the city, for all countries that have a 
-- life expectancy between 50 and 70 years of age. Order your results by the percentage from highest to lowest(15 marks)
USE world;
-- SELECT city.Name AS CityName, city.Population AS CityPopulation, country.Name AS CountryName, ((city.Population / country.Population)*100) AS CityPercentage FROM city INNER JOIN country ON city.CountryCode = country.Code;
-- SELECT Name FROM country WHERE LifeExpectancy BETWEEN 50 AND 70;

SELECT 
    city.Name AS CityName,
    city.Population AS CityPopulation,
    country.Name AS CountryName,
    ((city.Population / country.Population) * 100) AS CityPercentage
FROM
    city
        INNER JOIN
    country ON city.CountryCode = country.Code
WHERE
    country.Name IN (SELECT 
            Name
        FROM
            country
        WHERE
            LifeExpectancy BETWEEN 50 AND 70)
ORDER BY CityPercentage DESC;



# SAMPLE SOLUTION
-- SELECT ci.Name, ci.Population, co.Name,  (ci.Population/co.Population) * 100 as Percentage 
-- FROM City ci join Country co on ci.CountryCode = co.code
-- WHERE co.LifeExpectancy between 50 and 70
-- order by Percentage desc;





-- (B) Using a subquery, list the name, population and continent for all countries, which have a 
-- greater than average population than the continent the country is in.
-- Order your results alphabetically by the country name.(20 marks)

SELECT
    country.Name, country.Population, country.Continent
FROM
    country
        INNER JOIN
    (SELECT 
        country.Continent, AVG(country.Population) AS AVGPOP
    FROM
        country
    GROUP BY country.Continent) t USING (Continent)
WHERE
    country.Population > AVGPOP
ORDER BY country.Name;



-- Q3 ClassicModels Database (35 Marks)
-- (A) List the name, the textDescription, and the total quantity of products were 
-- ordered in that product line. Order your results from the highest quantities to lowest.(15 marks)
-- USE classicmodels;


SELECT 
    products.productName,
    productlines.textDescription,
    SUM(quantityOrdered) AS Total
FROM
    productlines
        INNER JOIN
    products USING (productLINE)
        INNER JOIN
    orderdetails USING (productCode)
GROUP BY products.productCode
ORDER BY Total DESC;






-- (B) List the name of the employee, the number of customers that employee has, their manager's name and 
-- the total amount of money they have made through orders. For the top 3 most profitable employees(20 marks)
# SELECT employees.firstName, employees.lastName, COUNT(customers.customerNumber) FROM employees INNER JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber INNER JOIN employees WHERE customers.salesRepEmployeeNumber = employees.employeeNumber GROUP BY employees.employeeNumber;

SELECT 
    employees.firstName,
    employees.lastName,
    COUNT(customers.customerNumber),
    manager.firstName,
    manager.lastName,
    SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS TotalAmountOrders
FROM
    employees
        INNER JOIN
    customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
        INNER JOIN
    employees AS manager ON employees.reportsTo = manager.employeeNumber
        INNER JOIN
    orders ON customers.customerNumber = orders.customerNumber
        INNER JOIN
    orderdetails USING (orderNumber)
WHERE
    customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employees.employeeNumber
ORDER BY TotalAmountOrders DESC
LIMIT 3;



