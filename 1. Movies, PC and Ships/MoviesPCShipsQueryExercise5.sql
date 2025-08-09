-- Добави нова филмова звезда с име Emma Watson, родена на 15 април 1990 г., без да посочваш адрес.
INSERT INTO MOVIESTAR (NAME, BIRTHDATE)
VALUES ('Emma Watson', '1990-04-15')

-- Изтрий всички филми, които са излезли преди 1970 г.
DELETE FROM MOVIE
WHERE YEAR < 1970

-- Добави в таблицата MovieExec нов продуцент с име John Carter, 
-- сертификат № 999, без известна нетна печалба.
INSERT INTO MOVIEEXEC (NAME, CERT#)
VALUES ('John Carter', 999)

-- Увеличи нетната печалба с 15% на всички продуценти, които имат повече от 50 милиона.
UPDATE MOVIEEXEC
SET NETWORTH = NETWORTH * 1.15
WHERE NETWORTH > 50000000

-- Изтрий всички филмови звезди, които не са участвали в нито един филм (нямат записи в StarsIn
DELETE FROM MOVIESTAR
WHERE NAME NOT IN (
	SELECT STARNAME 
	FROM STARSIN)

--

-- Създай изглед, който показва имената на всички филми и имената на техните продуценти. 
-- Ако за даден филм няма продуцент, да се показва Unknown
CREATE VIEW v_movie_producer
AS
	SELECT m.TITLE, CASE 
		WHEN me.NAME IS NOT NULL THEN me.NAME
		ELSE 'Unknown' END AS PRODUCERNAME
	FROM MOVIE m
	LEFT JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#

-- Създай изглед, който показва всички филмови звезди, 
-- участвали в поне 3 различни филма след 2000 г.
CREATE VIEW v_stars_in_more_than_three_movies 
AS
	SELECT STARNAME
	FROM STARSIN
	WHERE MOVIEYEAR > 2000
	GROUP BY STARNAME
	HAVING COUNT(DISTINCT MOVIETITLE) >= 3