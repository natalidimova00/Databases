-- 1.
SELECT ADDRESS
FROM STUDIO
WHERE STUDIO.NAME = 'MGM'

-- 2.
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE MOVIESTAR.NAME = 'Sandra Bullock'

-- 3.
SELECT DISTINCT s.STARNAME
FROM STARSIN AS s
JOIN MOVIE AS m ON m.TITLE = s.MOVIETITLE AND m.YEAR = s.MOVIEYEAR
WHERE m.YEAR = 1980 AND m.TITLE LIKE '%Empire%'

-- 4.
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000

-- 5.
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS LIKE '%Malibu%'

---------------------------------------------

-- 1.
SELECT model, speed AS MHz, ram AS GB
FROM pc
WHERE price < 1200

-- 2.
SELECT model, price / 1.1 AS Price_EUR
FROM laptop
ORDER BY price

-- 3. 
SELECT model, ram, screen
FROM laptop
WHERE price > 1000

-- 4. 
SELECT *
FROM printer
WHERE color = 'y'

-- 5.
SELECT model, speed, ram
FROM pc
WHERE (cd = '12x' OR cd = '16x') AND price < 2000

-- 6.
SELECT code, model, (speed + ram + 10 * screen) AS raiting
FROM laptop
ORDER BY raiting DESC, code

---------------------------------------------

-- 1. 
SELECT CLASS, COUNTRY
FROM CLASSES
WHERE NUMGUNS < 10

-- 2.
SELECT NAME AS shipName
FROM SHIPS
WHERE LAUNCHED < 1918

-- 3.
SELECT SHIP, BATTLE
FROM OUTCOMES
WHERE RESULT = 'sunk';

-- 4.
SELECT NAME
FROM SHIPS
WHERE NAME = CLASS

-- 5.
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%'

-- 6.
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %' AND NAME NOT LIKE '% % %'
