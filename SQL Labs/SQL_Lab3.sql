-- TASK 1 SAKILA DATABASE
-- SELECT 
--     *
-- FROM
--     actor;

-- Q2
-- SELECT 
--     *
-- FROM
--     actor
-- WHERE
--     first_name = 'John';

-- Q3
-- SELECT 
--     *
-- FROM
--     film
-- WHERE
--     length < '50';

-- Q4
-- SELECT 
--     *
-- FROM
--     film
-- WHERE
--     length < '60' AND release_year = '2006';







-- TASK 1 WORLD DATABSE
-- Q1
-- SELECT 
--     *
-- FROM
--     city;

-- Q2
-- SELECT 
--     *
-- FROM
--     city
-- WHERE
--     population > '1000000';

-- Q3
-- SELECT 
--     *
-- FROM
--     city
-- WHERE
--     CountryCode = 'IRL';

-- Q4
-- SELECT 
--     *
-- FROM
--     city
-- WHERE
--     Population < '200000';

-- Q5
-- SELECT 
--     *
-- FROM
--     country
-- WHERE
--     Continent = 'Africa'
--         OR Continent = 'Antarctica';









-- TASK 2 SAKILA DATABASE
-- Q1
-- SELECT 
--     first_name, last_name
-- FROM
--     actor;

-- Q2
-- SELECT 
--     last_name
-- FROM
--     actor
-- WHERE
--     first_name = 'John';

-- Q3
-- SELECT 
--     title
-- FROM
--     film
-- WHERE
--     length > '50';

-- Q4
-- SELECT 
--     *
-- FROM
--     film
-- WHERE
--     length = '60' AND release_year = '2006';






-- TASK 2 DREAMHOME DATABASE
-- Q1
-- SELECT 
--     fname, lname, email
-- FROM
--     privateowner;


-- Q2
-- SELECT 
--     street, city, postcode
-- FROM
--     propertyforrent
-- WHERE
--     rooms >= 3;

-- Q3
-- SELECT 
--     staffNo
-- FROM
--     staff
-- WHERE
--     salary >= '30000'
--         AND position = 'Supervisor';

-- Q4
-- SELECT 
--     clientNo, fName, lName, telNo
-- FROM
--     client
-- WHERE
--     maxRent = '500';
