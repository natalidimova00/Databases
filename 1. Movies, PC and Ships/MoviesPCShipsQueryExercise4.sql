-- Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото студио.
SELECT TITLE, m1.STUDIONAME
FROM MOVIE m1
WHERE m1.INCOLOR = 'n' 
	AND m1.YEAR < (
		SELECT TOP 1 YEAR
		FROM MOVIE m2
		WHERE m2.STUDIONAME = m1.STUDIONAME AND INCOLOR = 'Y'
		ORDER BY YEAR)

-- Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди. 
-- Студиа, за които няма посочени филми или има, но не се знае кои актьори са играли в тях, също да бъдат изведени. 
-- Първо да се изведат студиата, работили с най-много звезди. Напр. ако студиото има два филма, като в първия са играли A, B и C,
-- а във втория - C, D и Е, то студиото е работило с 5 звезди общо
SELECT s.NAME, s.ADDRESS
FROM STUDIO s
LEFT JOIN MOVIE m ON m.STUDIONAME = s.NAME
LEFT JOIN STARSIN si ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
GROUP BY s.NAME, s.ADDRESS
HAVING COUNT(DISTINCT si.STARNAME) < 5
ORDER BY COUNT(DISTINCT si.STARNAME) DESC

-- Изведи имената на всички актьори и имената на филмите, в които са участвали, и името на студиото, което ги е продуцирало. 
-- Ако актьорът няма филми, да се покаже NULL за филм и студио
SELECT ms.NAME, m.TITLE, m.STUDIONAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR

-- Намери броя на филмите, в които е участвал всеки актьор, подредени по брой филми (от най-много към най-малко).
SELECT ms.NAME, COUNT(DISTINCT si.MOVIETITLE) AS MovieCount
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
GROUP BY ms.NAME
ORDER BY MovieCount DESC

-- Намери актьорите, участвали в поне 3 различни студиа.
SELECT si.STARNAME
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME
HAVING COUNT(DISTINCT m.STUDIONAME) >= 3

-- За всяко студио изведи средната дължина на филмите, които е продуцирало, 
-- но само ако е продуцирало поне 5 филма.
SELECT STUDIONAME, AVG(LENGTH) AS AvgLength
FROM MOVIE
GROUP BY STUDIONAME
HAVING COUNT(DISTINCT TITLE) >= 5

-- Класифицирай филмите като:
-- Short – под 90 минути
-- Medium – между 90 и 150
-- Long – над 150
-- и изведи броя филми във всяка категория.
SELECT CASE
	WHEN LENGTH < 90 THEN 'Short'
	WHEN LENGTH > 150 THEN 'Long'
	ELSE 'Medium' 
	END AS MovieLen, COUNT(*) AS MovieCount
FROM MOVIE
GROUP BY
	CASE
	WHEN LENGTH < 90 THEN 'Short'
	WHEN LENGTH > 150 THEN 'Long'
	ELSE 'Medium' END

-- Изведи всички филми, които са от същата година като Terms of Endearment, 
-- но са по-къси или с неизвестна дължина.
SELECT TITLE
FROM MOVIE
WHERE TITLE <> 'Terms of Endearment'
	AND YEAR = (SELECT YEAR FROM MOVIE WHERE TITLE = 'Terms of Endearment')
	AND (LENGTH IS NULL OR LENGTH < (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Terms of Endearment'))

-- Изведи имената на актьорите, които са участвали поне в един филм преди 1980 г. и поне един след 2000 г.
SELECT DISTINCT s1.STARNAME
FROM STARSIN s1
JOIN STARSIN s2 ON s1.STARNAME = s2.STARNAME
WHERE s1.MOVIEYEAR < 1980 AND s2.MOVIEYEAR > 2000

-- Намери студиото с най-много филми, продуцирани след 2010 г.
SELECT TOP 1 STUDIONAME, COUNT(DISTINCT TITLE) AS DistinctTitle
FROM MOVIE
WHERE YEAR > 2010
GROUP BY STUDIONAME
ORDER BY DistinctTitle DESC

-- Изведи имената на продуцентите, които са и филмови звезди, и са играли в поне 2 различни десетилетия.
SELECT si.STARNAME
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#
WHERE me.NAME = si.STARNAME
GROUP BY si.STARNAME
HAVING MAX(si.MOVIEYEAR) - MIN(si.MOVIEYEAR) >= 10

-- Изведи имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди.
-- Студиа, за които няма филми или няма информация за актьори, също да бъдат включени. Първо покажи тези с най-много звезди.
SELECT s.NAME, s.ADDRESS, COUNT(DISTINCT si.STARNAME) AS StarsCount
FROM STUDIO s
LEFT JOIN MOVIE m ON m.STUDIONAME = s.NAME
LEFT JOIN STARSIN si ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
GROUP BY s.NAME, s.ADDRESS
HAVING COUNT(DISTINCT si.STARNAME) < 5
ORDER BY COUNT(DISTINCT si.STARNAME) DESC