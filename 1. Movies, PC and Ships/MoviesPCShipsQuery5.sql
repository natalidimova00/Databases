-- 1.
SELECT AVG(speed) AS AvgSpeed
FROM pc

-- 2.
SELECT p.maker, AVG(l.screen) AS AvgScreen
FROM laptop AS l
JOIN product AS p ON p.model = l.model
GROUP BY p.maker

-- 3.
SELECT AVG(speed) AS AvgSpeed
FROM laptop
WHERE price > 1000

-- 4.
SELECT AVG(pc.price) AS AvgPrice
FROM pc AS pc
JOIN product AS p ON p.model = pc.model
WHERE p.maker = 'A'

-- 5.
SELECT AVG(price) AS AvgPrice
FROM(
	SELECT pc.price
	FROM pc AS pc
	JOIN product AS p ON pc.model = p.model
	WHERE p.maker = 'B'

	UNION ALL

	SELECT l.price
	FROM laptop AS l
	JOIN product AS p ON l.model = p.model
	WHERE p.maker = 'B') AS all_prices

-- 6.
SELECT speed, AVG(price) AS AvgPrice
FROM pc
GROUP BY speed

-- 7.
SELECT maker
FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(DISTINCT model) >= 3

-- 8.
SELECT DISTINCT p.maker
FROM pc
JOIN product AS p ON pc.model = p.model
WHERE pc.price = (SELECT MAX(price)FROM pc)

-- 9.
SELECT speed, AVG(price) AS AvgPrice
FROM pc
WHERE speed > 800
GROUP BY speed

-- 10.
SELECT AVG(pc.hd) AS AvgDiskSize
FROM pc
JOIN product AS p ON pc.model = p.model
WHERE p.maker IN (
	SELECT DISTINCT p_pr.maker
	FROM printer AS pr
	JOIN product AS p_pr ON pr.model = p_pr.model)

-- 11.
SELECT screen, MAX(price) - MIN(price) AS PriceDiff
FROM laptop
GROUP BY screen

------------------------------------------

-- 1.
SELECT COUNT(DISTINCT CLASS)
FROM SHIPS

-- 2.
SELECT AVG(c.NUMGUNS)
FROM SHIPS AS s
JOIN CLASSES AS c ON s.CLASS = c.CLASS

-- 3.
SELECT CLASS,
	MIN(LAUNCHED) AS FirstYear,
	MAX(LAUNCHED) AS LastYear
FROM SHIPS
GROUP BY CLASS

-- 4.
SELECT s.CLASS, COUNT(*) AS SunkShips
FROM OUTCOMES AS o
JOIN SHIPS AS s ON o.SHIP = s.NAME
WHERE o.RESULT = 'sunk'
GROUP BY s.CLASS

-- 5.
SELECT s.CLASS, COUNT(o.SHIP)
FROM SHIPS AS s
LEFT JOIN OUTCOMES AS o ON s.NAME = o.SHIP AND o.RESULT = 'sunk'
GROUP BY s.CLASS
HAVING COUNT(s.NAME) > 4

-- 6.
SELECT COUNTRY, AVG(DISPLACEMENT)
FROM CLASSES
GROUP BY COUNTRY

------------------------------------------

-- 1.
SELECT si.STARNAME, COUNT(DISTINCT m.STUDIONAME)
FROM STARSIN AS si
JOIN MOVIE AS m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME

-- 2.
SELECT ms.NAME, COUNT(DISTINCT m.STUDIONAME)
FROM MOVIESTAR AS ms
LEFT JOIN STARSIN AS si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE AS m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY ms.NAME

-- 3.
SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR > 1990
GROUP BY STARNAME
HAVING COUNT(DISTINCT MOVIETITLE) >= 3

------------------------------------------

-- 4.
SELECT model, MAX(price) AS MaxPrice
FROM pc
GROUP BY model
ORDER BY MaxPrice DESC