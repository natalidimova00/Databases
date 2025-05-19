-- 1.
-- solution 1
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000

INTERSECT

SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'f'

-- solution 2
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'f' AND NAME IN (SELECT NAME
								FROM MOVIEEXEC
								WHERE NETWORTH > 10000000)

-- 2.
-- solution 1
SELECT NAME
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT NAME
				   FROM MOVIEEXEC)

-- solution 2
SELECT NAME
FROM MOVIESTAR EXCEPT (SELECT NAME 
					   FROM MOVIEEXEC)

--------------------------------------

-- 1.
SELECT DISTINCT maker
FROM product
WHERE model IN (SELECT model
				FROM pc
				WHERE speed >= 500)

-- 2.
SELECT *
FROM laptop
WHERE speed < ALL (SELECT speed
				   FROM pc)

-- 3.		
SELECT DISTINCT model
FROM (SELECT model, price
	  FROM pc
	  UNION ALL
	  SELECT model, price
	  FROM laptop
	  UNION ALL
	  SELECT model, price
	  FROM printer) AS AllProducts
WHERE price >= ALL (SELECT price
					FROM pc
					UNION ALL
					SELECT price
					FROM laptop
					UNION ALL
					SELECT price
					FROM printer)

-- 4. 
SELECT DISTINCT maker
FROM product 
WHERE model IN (SELECT model
				FROM printer
				WHERE color = 'y' AND price <= all (SELECT price
													FROM printer
													WHERE color = 'y'))

-- 5.
SELECT DISTINCT maker
FROM product
WHERE model IN (SELECT model
				FROM pc AS p1
				WHERE ram <= all (SELECT ram FROM pc)
				  AND speed >= all (SELECT speed 
									FROM pc AS p2
									WHERE p1.ram = p2.ram))

--------------------------------------

-- 1.
SELECT DISTINCT COUNTRY
FROM CLASSES
WHERE NUMGUNS >= ALL (SELECT NUMGUNS 
					  FROM CLASSES)

-- 2.
SELECT NAME
FROM SHIPS
WHERE CLASS IN (SELECT CLASS
				FROM CLASSES
				WHERE BORE = 16)

-- 3.
SELECT BATTLE
FROM OUTCOMES
WHERE SHIP IN (SELECT NAME
			   FROM SHIPS
			   WHERE CLASS = 'Kongo')

-- 4. 
SELECT CLASS
FROM CLASSES AS c
WHERE NUMGUNS >= ALL (SELECT NUMGUNS
					  FROM CLASSES AS c2
					  WHERE c2.BORE = c.BORE)

-- 5.
SELECT NAME
FROM SHIPS AS s
JOIN CLASSES AS c on s.CLASS = c.CLASS
WHERE NUMGUNS >= ALL (SELECT NUMGUNS
					  FROM CLASSES c2
					  WHERE c2.BORE = c.BORE)