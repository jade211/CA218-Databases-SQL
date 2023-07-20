/* JOIN TYPES INNER, LEFT, RIGHT, OUTER (UNION OF LEFT AND RIGHT) */

-- SELECT * FROM branch;
-- SELECT * FROM propertyforrent;
-- SELECT * FROM branch JOIN propertyforrent; # RETURNS CARTESIAN PRODUCT
-- SELECT * FROM branch JOIN propertyforrent On branch.city = propertyforrent.city; # RETURNS JOIN OF DATA


/* INNER, LEFT AND RIGHT JOIN */
-- SELECT * FROM branch INNER JOIN propertyforrent ON branch.city = propertyforrent.city;
-- SELECT * FROM branch LEFT JOIN propertyforrent ON branch.city = propertyforrent.city;
-- SELECT * FROM branch RIGHT JOIN propertyforrent ON branch.city = propertyforrent.city;

/* FULL OUTER JOIN) */
-- (SELECT * FROM branch LEFT JOIN propertyforrent ON branch.city = propertyforrent.city) UNION (SELECT * FROM branch RIGHT JOIN propertyforrent ON branch.city = propertyforrent.city);

# ----------------------------------------------------------------------



