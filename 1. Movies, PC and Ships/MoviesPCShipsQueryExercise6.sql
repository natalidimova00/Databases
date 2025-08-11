-- Създай изглед, който показва всички филми, излезли през последните 5 години 
-- (спрямо текущата година).
CREATE VIEW v_latest_movies AS
SELECT *
FROM MOVIE
WHERE YEAR >= YEAR(GETDATE()) - 5

-- За всеки филм покажи заглавието и броя на уникалните актьори, 
-- участвали в него. Ако няма актьори, броят да е 0.
CREATE VIEW v_unique_actors AS
SELECT m.TITLE, COUNT(DISTINCT si.STARNAME)
FROM MOVIE m
LEFT JOIN STARSIN si ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
GROUP BY m.TITLE

-- Създай изглед, който показва имената на продуцентите и броя на филмите им, 
-- като включваш само тези с поне 3 филма.
CREATE VIEW v_producers_movies AS
SELECT me.NAME, COUNT(DISTINCT m.TITLE) AS DistinctMovies
FROM MOVIEEXEC me
JOIN MOVIE m ON m.PRODUCERC# = me.CERT#
GROUP BY me.NAME
HAVING COUNT(DISTINCT m.TITLE) >= 3

-- Създай изглед, който показва всички филми на студио MGM, 
-- които са с дължина под 100 минути.
CREATE VIEW v_mgm_under_hundred_minutes AS
SELECT TITLE
FROM MOVIE
WHERE STUDIONAME = 'MGM' AND LENGTH < 100

-- Създай изглед с актьори, които са участвали в повече от 1 филм в същата година
-- Покажи само имената на тези звезди.
CREATE VIEW v_actors_with_multiple_movies AS
SELECT DISTINCT si1.STARNAME
FROM STARSIN si1
JOIN STARSIN si2 ON si2.STARNAME = si1.STARNAME
WHERE si1.MOVIETITLE <> si2.MOVIETITLE AND si1.MOVIEYEAR = si2.MOVIEYEAR

-- Създай изглед, който извежда името на студиото и средната дължина на филмите му.
CREATE VIEW v_studio_average_length AS
SELECT STUDIONAME, AVG(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME

-- Създай изглед, който показва само филмите, за които липсва информация за продуцент.
CREATE VIEW v_movies_with_no_producers AS
SELECT TITLE
FROM MOVIE
WHERE PRODUCERC# IS NULL

-- За всяка звезда намери заглавието и годината на най-новия филм, в който е участвала.
CREATE VIEW v_moviestar_newest_movie AS
SELECT s.STARNAME, s.MOVIETITLE, s.MOVIEYEAR
FROM STARSIN s
WHERE s.MOVIEYEAR = (
	SELECT MAX(MOVIEYEAR)
	FROM STARSIN
	WHERE STARNAME = s.STARNAME)
