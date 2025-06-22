-- 1.
CREATE VIEW ActressesView AS
SELECT [NAME], BIRTHDATE 
FROM MOVIESTAR
WHERE GENDER = 'F'

-- 2.
CREATE VIEW StarMovieCountView AS
SELECT ms.NAME, COUNT(si.MOVIETITLE) as MOVIECOUNT
FROM MOVIESTAR AS ms
LEFT JOIN STARSIN AS si ON ms.NAME = si.STARNAME
GROUP BY ms.NAME

--------------------------------------

-- 1.
CREATE VIEW AllDevicesView AS
SELECT code, model, price
FROM pc
UNION ALL
SELECT code, model, price
FROM laptop
UNION ALL
SELECT code, model, price
FROM printer

-- 2.
ALTER VIEW AllDevicesView AS
SELECT code, model, price, 'pc' AS type
FROM pc
UNION ALL
SELECT code, model, price, 'laptop' AS type
FROM laptop
UNION ALL
SELECT code, model, price, 'printer' AS type
FROM printer

-- 3.
ALTER VIEW AllDevicesView AS
SELECT code, model, price, 'pc' AS type, speed
FROM pc
UNION ALL
SELECT code, model, price, 'laptop' AS type, speed
FROM laptop
UNION ALL
SELECT code, model, price, 'printer' AS type, NULL AS speed
FROM printer

--------------------------------------

-- 1. 
CREATE VIEW BritishShips AS
SELECT 
	s.NAME AS Name, s.CLASS AS Class, c.TYPE AS Type, c.NUMGUNS AS NumGuns, 
	c.BORE AS Bore, c.DISPLACEMENT AS Displacement, s.LAUNCHED AS Launched
FROM SHIPS AS s
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE c.COUNTRY = 'Gt.Britain'

-- 2.
SELECT NumGuns, Displacement
FROM BritishShips
WHERE Type = 'bb' AND Launched < 1919

-- 3.
SELECT 
	c.NUMGUNS AS NumGuns, c.DISPLACEMENT AS Displacement
FROM SHIPS AS s
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE c.COUNTRY = 'Gt.Britain' AND c.TYPE = 'bb' AND s.LAUNCHED < 1919

-- 4.
SELECT c.COUNTRY, AVG(DISPLACEMENT) AS AvgMaxDisplacement
FROM CLASSES AS c
JOIN (
	SELECT COUNTRY, MAX(DISPLACEMENT) AS maxDisplacement
	FROM CLASSES
	GROUP BY COUNTRY
) AS maxClasses
ON c.COUNTRY = maxClasses.COUNTRY AND c.DISPLACEMENT = maxClasses.maxDisplacement
GROUP BY c.COUNTRY

-- 5.
CREATE VIEW SunkShips AS
SELECT BATTLE, SHIP
FROM OUTCOMES
WHERE RESULT = 'sunk'

-- 6.
INSERT INTO SunkShips (BATTLE, SHIP)
VALUES('Guadalcanal', 'California')

-- 7.
CREATE VIEW BigGunClasses AS
SELECT *
FROM CLASSES
WHERE NUMGUNS >= 9
WITH CHECK OPTION

SELECT *
FROM BigGunClasses

UPDATE BigGunClasses
SET NUMGUNS = 15
WHERE CLASS = 'Iowa'

UPDATE BigGunClasses
SET NUMGUNS = 5
WHERE CLASS = 'Iowa'

-- 8.
DROP VIEW BigGunClasses

CREATE VIEW BigGunClasses AS
SELECT *
FROM CLASSES
WHERE NUMGUNS >= 9

-- 9.
CREATE VIEW DamagedShipsInBattle AS
SELECT o.BATTLE
FROM OUTCOMES AS o
JOIN SHIPS AS s ON s.NAME = o.SHIP
JOIN CLASSES AS c ON c.CLASS = s.CLASS
WHERE c.NUMGUNS < 9
GROUP BY o.BATTLE
HAVING COUNT(*) >= 3 AND SUM(CASE WHEN o.RESULT = 'damaged' THEN 1 ELSE 0 END) >= 1