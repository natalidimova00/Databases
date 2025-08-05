-- 4
-- Изведи името на всяко студио и заглавията на всички филми, които е продуцирало. 
-- Ако някое студио няма филми, да се изведе NULL за заглавието.
SELECT s.NAME, m.TITLE
FROM STUDIO s
LEFT JOIN MOVIE m ON m.STUDIONAME = s.NAME

-- Намери имената на всички продуценти, които не са продуцирали нито един филм.
SELECT me.NAME
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#
WHERE m.TITLE IS NULL

-- За всеки актьор да се изведат имената на всички филми, в които е участвал, и името на студиото, което е продуцирало филма. 
-- Ако актьорът няма филми, да се изведе NULL за филм и студио.
SELECT ms.NAME, si.MOVIETITLE, m.STUDIONAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR

-- Изведи имената на всички филми и имената на продуцентите им. 
-- Ако за даден филм няма продуцент, да се изведе NULL.
SELECT m.TITLE, me.NAME
FROM MOVIE m
LEFT JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#

-- Изведи имената на всички продуценти и имената на филмите, които са продуцирали. 
-- Ако продуцентът няма филми, да се изведе NULL за заглавие.
SELECT me.NAME, m.TITLE
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#

-- Намери имената на всички актьори, които са играли във филми на MGM, 
-- заедно със заглавията на тези филми. 
-- Ако актьорът няма такъв филм, да се изведе NULL за заглавие.
SELECT ms.NAME, 
	   CASE WHEN m.STUDIONAME = 'MGM' THEN m.TITLE
			ELSE NULL END AS TITLE
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR

-- За всеки филм изведи заглавието, името на продуцента и името на студиото. 
-- Ако липсва продуцент или студио, да се изведе NULL.
SELECT m.TITLE, me.NAME, m.STUDIONAME
FROM MOVIE m
LEFT JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#

-- Намери имената на актьорите, които не са участвали в нито един филм.
SELECT ms.NAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
WHERE si.MOVIETITLE IS NULL

-- 5
-- За всяко студио искаме да изведем точно по един ред със следната информация:
-- Име на студиото и сумарна дължина на всички негови филми
SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME

-- За всяка година да се изведе колко актриси и колко актьори мъже са родени
SELECT YEAR(BIRTHDATE), GENDER, COUNT(*)
FROM MOVIESTAR
GROUP BY YEAR(BIRTHDATE), GENDER

SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME
HAVING COUNT(*) >= 2

SELECT *
FROM MOVIE
WHERE LENGTH = (SELECT MAX(LENGTH)
				FROM MOVIE)

SELECT AVG(MOVIESCOUNT)
FROM (SELECT COUNT(MOVIETITLE) AS MOVIESCOUNT
	  FROM MOVIESTAR ms
	  LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
	  GROUP BY NAME) STAT

-- За всяко студио изведи средната дължина на филмите, които е продуцирало.
SELECT STUDIONAME, AVG(LENGTH) AS AVGMOVIELENGTH
FROM MOVIE
GROUP BY STUDIONAME

-- Намери броя на актьорите, родени след 1970 г..
SELECT COUNT(*)
FROM MOVIESTAR
WHERE BIRTHDATE > '1970-12-31'

-- За всеки актьор изведи броя на филмите, в които е участвал след 2000 г..
SELECT ms.NAME, COUNT(si.MOVIETITLE)
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME AND si.MOVIEYEAR > 2000
GROUP BY ms.NAME

-- Намери името на актьора, участвал в най-много филми.
SELECT STARNAME
FROM STARSIN 
GROUP BY STARNAME
HAVING COUNT(*) = (
	SELECT MAX(FILMCOUNT)
	FROM (
		SELECT COUNT(*) AS FILMCOUNT
		FROM STARSIN
		GROUP BY STARNAME) AS T)

-- Намери броя на различните студиа, с които е работил всеки актьор.
SELECT si.STARNAME, COUNT(DISTINCT m.STUDIONAME)
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME

-- Намери броя на филмите, които са продуцирани от всяко студио след 1995 г.
SELECT STUDIONAME, COUNT(*)
FROM MOVIE
WHERE YEAR > 1995
GROUP BY STUDIONAME

-- Намери средната заплата на всички продуценти, които са продуцирали филм.
SELECT AVG(NETWORTH)
FROM MOVIEEXEC me
WHERE me.CERT# IN (SELECT PRODUCERC# FROM MOVIE) 

-- Намери студиото, което има най-много филми с дължина над 120 минути.
SELECT STUDIONAME
FROM MOVIE
WHERE LENGTH > 120
GROUP BY STUDIONAME
HAVING COUNT(*) = (
	SELECT MAX(FILMCOUNT)
	FROM (
		SELECT COUNT(*) AS FILMCOUNT
		FROM MOVIE
		WHERE LENGTH > 120
		GROUP BY STUDIONAME) AS T)

-- За всеки актьор изведи средната дължина на филмите, в които е участвал.
SELECT si.STARNAME, AVG(m.LENGTH)
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME

-- Намери актрисите, участвали в поне 3 различни студиа
SELECT ms.NAME
FROM MOVIESTAR ms
JOIN STARSIN si ON si.STARNAME = ms.NAME
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR	
WHERE GENDER = 'f'
GROUP BY ms.NAME
HAVING COUNT(DISTINCT m.STUDIONAME) >= 3

-- 1. Намери броя на филмите, в които е участвал всеки актьор, независимо от годината.
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE)
FROM STARSIN 
GROUP BY STARNAME

-- 2. Намери актьорите, участвали в поне 5 филма.
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE) AS DISTINCTMOVIES
FROM STARSIN
GROUP BY STARNAME
HAVING COUNT(DISTINCT MOVIETITLE) >= 5

-- 3. Намери средната дължина на филмите за всяка година.
SELECT  YEAR, AVG(LENGTH)
FROM MOVIE
GROUP BY YEAR

-- 4. Намери за всяко студио максималната и минималната дължина на филмите му.
SELECT STUDIONAME, MIN(LENGTH), MAX(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME

-- 5. Намери броя на филмите за всяко студио, за които дължината е известна (LENGTH не е NULL).
SELECT STUDIONAME, COUNT(DISTINCT TITLE)
FROM MOVIE
WHERE LENGTH IS NOT NULL
GROUP BY STUDIONAME

-- 6. Намери актьорите, които са снимали филми в различни години — поне две различни.
SELECT STARNAME
FROM STARSIN
GROUP BY STARNAME
HAVING COUNT(DISTINCT MOVIEYEAR) >= 2

-- Изведи имената на актьорите и броя на филмите, в които са участвали, 
-- подредени по брой филми (от най-много към най-малко).
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE)
FROM STARSIN
GROUP BY STARNAME
ORDER BY COUNT(MOVIETITLE) DESC

-- За всяко студио изведи броя на филмите, чиито дължина е над 100 минути.
SELECT STUDIONAME, COUNT(TITLE)
FROM MOVIE
WHERE LENGTH > 100
GROUP BY STUDIONAME

-- Намери годината с най-много излезли филми и колко са те.
SELECT TOP 1 YEAR, COUNT(TITLE)
FROM MOVIE
GROUP BY YEAR
ORDER BY COUNT(TITLE) DESC

-- За всеки продуцент намери средната дължина на филмите, които е продуцирал.
SELECT me.NAME, AVG(LENGTH)
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#
GROUP BY me.NAME

-- Намери името на актьора, участвал в най-дългия филм.
SELECT si.STARNAME
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
WHERE m.LENGTH = (
	SELECT MAX(LENGTH)
	FROM MOVIE)

-- Изведи за всяка година броя на различните студиа, които са продуцирали филми.
SELECT YEAR, COUNT(DISTINCT STUDIONAME)
FROM MOVIE
GROUP BY YEAR

-- Намери студиото с най-много филми, продуцирани след 2005 година.
SELECT TOP 1 STUDIONAME, COUNT(*)
FROM MOVIE
WHERE YEAR > 2005
GROUP BY STUDIONAME 
ORDER BY COUNT(*) DESC

-- За всеки актьор изведи средната дължина на филмите, в които е участвал, 
-- но само ако е участвал в поне 3 филма.
SELECT si.STARNAME, AVG(m.LENGTH) AS AvgMovieLength
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME
HAVING COUNT(DISTINCT TITLE) >= 3

-- Намери броя на актьорите, които са участвали в поне 3 различни студиа.
SELECT COUNT(*)
FROM (
	SELECT si.STARNAME
	FROM STARSIN si
	JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
	GROUP BY si.STARNAME
	HAVING COUNT(DISTINCT STUDIONAME) >= 3) AS ACTORS

-- Изведи името на студиото и общата сума на дължините на филмите му, 
-- но само за студия, които имат повече от 5 филма
SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME
HAVING COUNT(DISTINCT TITLE) >= 5