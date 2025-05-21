-- 1.
SELECT o.BATTLE, COUNT(*) AS SunkAmericanShips
FROM OUTCOMES AS o
JOIN SHIPS AS s ON s.NAME = o.SHIP
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE o.RESULT = 'sunk' AND c.COUNTRY = 'USA'
GROUP BY o.BATTLE
HAVING COUNT(*) >= 1

-- 2.
SELECT o.BATTLE, c.COUNTRY
FROM OUTCOMES AS o
JOIN SHIPS AS s ON s.NAME = o.SHIP
JOIN CLASSES AS c ON c.CLASS = s.CLASS
GROUP BY o.BATTLE, c.COUNTRY
HAVING COUNT(DISTINCT o.SHIP) >= 3

-- 3.
SELECT DISTINCT s.CLASS
FROM SHIPS AS s
WHERE s.CLASS IS NOT NULL
	AND EXISTS (
		SELECT 1
		FROM SHIPS AS s2
		WHERE s2.CLASS = s.CLASS
		  AND s2.LAUNCHED IS NOT NULL)
	AND NOT EXISTS (
		SELECT 1
		FROM SHIPS AS s3
		WHERE s3.CLASS = s.CLASS
		  AND s3.LAUNCHED > 1921)	 

-- 4.
SELECT s.NAME,
		COUNT(CASE WHEN o.RESULT = 'damaged' THEN 1 END) AS DamagedInBattles
FROM SHIPS AS s
LEFT JOIN OUTCOMES AS o ON o.SHIP = s.NAME
GROUP BY s.NAME

-- 5.
SELECT c.COUNTRY, COUNT(s.NAME) AS Ships,
	COUNT(CASE WHEN o.RESULT = 'sunk' THEN 1 END) AS SunkShips
FROM CLASSES AS c
JOIN SHIPS AS s ON s.CLASS = c.CLASS
LEFT JOIN OUTCOMES AS O ON o.SHIP = s.NAME
GROUP BY c.COUNTRY

-- 6.
SELECT c.COUNTRY, 
	COUNT(CASE WHEN o.RESULT = 'damaged' THEN 1 END) AS DamagesShips,
	COUNT(CASE WHEN o.RESULT = 'sunk' THEN 1 END) AS SunkShips
FROM CLASSES AS c
JOIN SHIPS AS s ON s.CLASS = c.CLASS
LEFT JOIN OUTCOMES AS O ON o.SHIP = s.NAME
GROUP BY c.COUNTRY

-- 7.
SELECT c.CLASS,
	COUNT(CASE WHEN o.RESULT = 'ok' THEN 1 END) AS WonShips
FROM CLASSES AS c
JOIN SHIPS AS s ON s.CLASS = c.CLASS
LEFT JOIN OUTCOMES AS o ON o.SHIP = s.NAME
WHERE c.CLASS IN (
	SELECT s.CLASS
	FROM SHIPS AS s
	GROUP BY s.CLASS
	HAVING COUNT(*) >= 3)
GROUP BY c.CLASS

-- 8.
SELECT ms.NAME AS StarName, 
       ms.BIRTHDATE,
       sc.STUDIONAME
FROM MOVIESTAR AS ms
JOIN (
    SELECT starn.SC_STARNAME AS STARNAME, starn.STUDIONAME
    FROM (
        SELECT si.STARNAME AS SC_STARNAME, 
               m.STUDIONAME,
               COUNT(*) AS FilmCount
        FROM STARSIN AS si
        JOIN MOVIE AS m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
        GROUP BY si.STARNAME, m.STUDIONAME
    ) AS starn
    JOIN (
        SELECT st.STARNAME, MAX(st.FilmCount) AS MaxCount
        FROM (
            SELECT si.STARNAME, 
                   m.STUDIONAME,
                   COUNT(*) AS FilmCount
            FROM STARSIN AS si
            JOIN MOVIE AS m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
            GROUP BY si.STARNAME, m.STUDIONAME
        ) AS st
        GROUP BY st.STARNAME
    ) AS maxst ON starn.SC_STARNAME = maxst.STARNAME AND starn.FilmCount = maxst.MaxCount
) AS sc ON sc.STARNAME = ms.NAME;

-- 9.
SELECT p.Maker,
       COUNT(pc.Code) AS PC_Count
FROM Product p
LEFT JOIN Pc pc ON pc.Model = p.Model
WHERE p.Maker IN (
    SELECT Maker
    FROM Product pr
    JOIN Printer prn ON prn.Model = pr.Model
    WHERE prn.Type = 'Laser'
    GROUP BY pr.Maker
    HAVING COUNT(DISTINCT pr.Model) >= 2
)
GROUP BY p.Maker;

-- 10.
SELECT p.Maker
FROM Product p
JOIN Pc pc ON pc.Model = p.Model
JOIN Laptop l ON l.Model = p.Model
GROUP BY p.Maker
HAVING AVG(pc.Price) < AVG(l.Price);

-- 11.
SELECT p.Model
FROM Product p
JOIN Pc pc ON pc.Model = p.Model
WHERE p.Type = 'pc'
GROUP BY p.Model, p.Maker
HAVING AVG(pc.Price) < (
    SELECT MIN(l.Price)
    FROM Laptop l
    JOIN Product p2 ON l.Model = p2.Model
    WHERE p2.Maker = p.Maker
)