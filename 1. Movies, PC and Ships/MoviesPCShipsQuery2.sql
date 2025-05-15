-- 1.
SELECT DISTINCT NAME
FROM MOVIESTAR AS ms
JOIN STARSIN AS s ON s.STARNAME = ms.NAME
WHERE s.MOVIETITLE = 'Terms of Endearment' AND
	  ms.GENDER = 'f'

-- 2.
SELECT DISTINCT STARNAME
FROM STARSIN AS si
JOIN MOVIE AS m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
WHERE m.STUDIONAME = 'MGM' AND m.YEAR = 1995

---------------------------------------

-- 1.
SELECT p.maker, speed
FROM laptop AS l
JOIN product AS p ON p.model = l.model
WHERE l.hd >= 9

-- 2.
SELECT p.model, COALESCE(l.price, pc.price, pr.price) AS price
FROM product AS p
LEFT JOIN laptop AS l ON l.model = p.model
LEFT JOIN printer AS pr ON pr.model = p.model
LEFT JOIN pc AS pc ON pc.model = p.model
WHERE p.maker = 'B'
ORDER BY price DESC

-- 3.
SELECT DISTINCT p1.hd
FROM pc AS p1
JOIN pc AS p2 ON p2.hd = p1.hd
		AND p1.code <> p2.code	

-- 4.
SELECT DISTINCT p1.model, p2.model
FROM pc AS p1
JOIN pc AS p2 ON p2.speed = p1.speed and p2.ram = p1.ram
WHERE p1.model < p2.model

-- 5.
SELECT pr.maker
FROM pc
JOIN product AS pr ON pc.model = pr.model
WHERE pc.speed >= 500
GROUP BY pr.maker
HAVING COUNT(DISTINCT pc.code) >= 2

---------------------------------------

-- 1.
SELECT s.NAME
FROM SHIPS AS s
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE c.DISPLACEMENT > 35000

-- 2.
SELECT s.NAME AS Name, c.DISPLACEMENT AS Displacement, c.NUMGUNS AS NumGuns
FROM OUTCOMES AS o
JOIN SHIPS AS s ON s.NAME = o.SHIP
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE o.BATTLE = 'Guadalcanal'

-- 3.
SELECT COUNTRY
FROM CLASSES
WHERE TYPE = 'bb'

INTERSECT

SELECT COUNTRY
FROM CLASSES
WHERE TYPE = 'bc'

-- 4.
SELECT DISTINCT o1.SHIP
FROM OUTCOMES AS o1
JOIN BATTLES AS b1 ON o1.BATTLE = b1.NAME
JOIN OUTCOMES AS o2 ON o2.SHIP = o1.SHIP
JOIN BATTLES AS b2 ON b2.NAME = o2.BATTLE
WHERE o1.RESULT = 'damaged' AND b1.DATE < b2.DATE