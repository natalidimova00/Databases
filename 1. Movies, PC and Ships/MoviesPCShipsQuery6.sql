SELECT NAME,
	CASE GENDER
		WHEN 'F' THEN 'FEMALE'
		WHEN 'M' THEN 'MALE'
		ELSE 'UNKNOWN'
	END AS GENDER
FROM MOVIESTAR

SELECT model, price, CASE
						WHEN price < 900 THEN 'LOW'
						WHEN price > 1100 THEN 'HIGH'
						ELSE 'AVERAGE'
					 END AS price_rank
FROM laptop

SELECT CASE
			WHEN price < 900 THEN 'LOW'
			WHEN price > 1100 THEN 'HIGH'
			ELSE 'AVERAGE'
	   END AS price_rank, COUNT(*) AS num_laptops
FROM Laptop
GROUP BY CASE
			WHEN price < 900 THEN 'LOW'
			WHEN price > 1100 THEN 'HIGH'
			ELSE 'AVERAGE'		 END
SELECT battle, date,
	SUM(CASE result
			WHEN 'sunk' THEN 1
			ELSE 0
		END) AS num_sunk,
	SUM(CASE result
			WHEN 'damaged' THEN 1
			ELSE 0
		END) AS num_damaged,
	SUM(CASE result
			WHEN 'ok' THEN 1
			ELSE 0
		END) AS num_ok
FROM outcomes
JOIN battles ON battle = name
GROUP by battle, date;

--------------------------------------------------

-- 1.
SELECT 
	CASE
		WHEN BIRTHDATE < '1960-01-01' THEN 'Before 1960'
		WHEN BIRTHDATE >= '1960-01-01' AND BIRTHDATE <= '1970-01-01' THEN '60s'
		WHEN BIRTHDATE >= '1970-01-01' AND BIRTHDATE <= '1980-01-01' THEN '70s'
		ELSE '1980 and later'
	END AS Period,
	COUNT(*) AS NumStars
FROM MOVIESTAR
GROUP BY
	CASE
		WHEN BIRTHDATE < '1960-01-01' THEN 'Before 1960'
		WHEN BIRTHDATE >= '1960-01-01' AND BIRTHDATE <= '1970-01-01' THEN '60s'
		WHEN BIRTHDATE >= '1970-01-01' AND BIRTHDATE <= '1980-01-01' THEN '70s'
		ELSE '1980 and later'
	END

--------------------------------------------------

-- 1.
SELECT o.BATTLE
FROM OUTCOMES AS o
JOIN SHIPS AS s ON s.NAME = o.SHIP
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE c.NUMGUNS < 9
GROUP BY o.BATTLE
HAVING COUNT(*) >= 3 AND
	   SUM(CASE WHEN o.RESULT = 'ok' THEN 1 ELSE 0 END) >= 2