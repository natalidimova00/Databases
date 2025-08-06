-- 6
-- Изведи броя на актьорите, родени в следните периоди:
-- Преди 1970
-- От 1970 до 1989
-- След 1989
SELECT CASE
	WHEN YEAR(BIRTHDATE) < 1970 THEN 'BEFORE 1970'
	WHEN YEAR(BIRTHDATE) > 1989 THEN 'AFTER 1989'
	ELSE 'BETWEEN 1989 AND 1989'
	END AS PERIOD, COUNT(*) AS COUNTACTORS
FROM MOVIESTAR
GROUP BY CASE
	WHEN YEAR(BIRTHDATE) < 1970 THEN 'BEFORE 1970'
	WHEN YEAR(BIRTHDATE) > 1989 THEN 'AFTER 1989'
	ELSE 'BETWEEN 1989 AND 1989'
	END

-- За всеки филм изведи заглавието му и категорията му по дължина:
-- "Short" ако е под 90 минути
-- "Medium" ако е между 90 и 150 минути
-- "Long" ако е над 150 минути
SELECT CASE
	WHEN LENGTH < 90 THEN 'Short'
	WHEN LENGTH > 150 THEN 'Long'
	ELSE 'Medium' 
	END AS MOVIELENGTH, COUNT(*)
FROM MOVIE
GROUP BY CASE
	WHEN LENGTH < 90 THEN 'Short'
	WHEN LENGTH > 150 THEN 'Long'
	ELSE 'Medium' 
	END

-- Изведи броя на актьорите, които са участвали в:
-- По-малко от 3 филма
-- Между 3 и 5 филма
-- Повече от 5 филма
SELECT CATEGORY, COUNT(*)
FROM(
	SELECT CASE
		WHEN COUNT(DISTINCT MOVIETITLE) < 3 THEN 'LESS THAN 3'
		WHEN COUNT(DISTINCT MOVIETITLE) BETWEEN 3 AND 5 THEN 'BETWEEN 3 AND 5'
		ELSE 'MORE THAN 5'
		END AS CATEGORY
	FROM STARSIN
	GROUP BY STARNAME) AS SUB
GROUP BY CATEGORY

-- Изведи колко студиа имат:
-- по-малко от 5 филма
-- между 5 и 10 филма
-- повече от 10 филма
SELECT CATEGORY, COUNT(*)
FROM (
	SELECT CASE
		WHEN COUNT(DISTINCT TITLE) < 5 THEN 'LESS THAN 5 MOVIES'
		WHEN COUNT(DISTINCT TITLE) BETWEEN 5 AND 10 THEN 'BETWEEN 5 AND 10'
		ELSE 'MORE THAN 10'
		END AS CATEGORY
	FROM MOVIE
	GROUP BY STUDIONAME) AS SUB
GROUP BY CATEGORY

-- Брой на актьорите, които:
-- са играли само преди 1980
-- са играли само след 2000
SELECT CATEGORY, COUNT(*)
FROM(
	SELECT CASE
		WHEN MAX(MOVIEYEAR) < 1980 THEN 'ONLY BEFORE 1980'
		WHEN MIN(MOVIEYEAR) > 2000 THEN 'ONLY AFTER 2000'
		ELSE 'OTHER'
		END AS CATEGORY
	FROM STARSIN
	GROUP BY STARNAME) AS SUB
GROUP BY CATEGORY

--
-- Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл поне един актьор
-- (актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат най-старите филми.
SELECT DISTINCT s1.MOVIETITLE, s1.MOVIEYEAR
FROM STARSIN s1
WHERE s1.MOVIEYEAR < 1982 AND EXISTS (
	SELECT 1
	FROM STARSIN s2
	WHERE s2.MOVIETITLE = s1.MOVIETITLE
	  AND s2.MOVIEYEAR = s1.MOVIEYEAR
	  AND s2.STARNAME NOT LIKE '%K%' 
	  AND s2.STARNAME NOT LIKE '%B%')
ORDER BY MOVIEYEAR ASC

-- Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата година, от която е и 
-- филмът Terms of Endearment, но дължината им е по-малка или неизвестна.
SELECT TITLE, LENGTH/60.0 AS LENGTHINHOURS
FROM MOVIE
WHERE TITLE <> 'Terms of Endearment'
	AND YEAR = (SELECT YEAR FROM MOVIE WHERE TITLE = 'Terms of Endearment')
	AND (LENGTH IS NULL OR LENGTH < (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Terms of Endearment'))

-- Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм 
-- преди 1980 г. и поне един след 1985 г.
SELECT STARNAME
FROM STARSIN
WHERE STARNAME IN (SELECT NAME FROM MOVIEEXEC)
	AND MOVIEYEAR < 1980
	AND MOVIEYEAR > 1985

-- Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм 
-- преди 1980 г. и поне един след 1985 г.
SELECT DISTINCT s1.STARNAME
FROM STARSIN s1
JOIN STARSIN s2 ON s2.STARNAME = s1.STARNAME
WHERE s1.STARNAME IN (SELECT NAME FROM MOVIEEXEC)
	AND s1.MOVIEYEAR < 1980
	AND s2.MOVIEYEAR > 1985

-- 2ри начин
SELECT STARNAME
FROM STARSIN
WHERE STARNAME IN (SELECT NAME FROM MOVIEEXEC)
GROUP BY STARNAME
HAVING MIN(MOVIEYEAR) < 1980
   AND MAX(MOVIEYEAR) > 1985