SELECT DISTINCT STARNAME
FROM STARSIN
JOIN MOVIESTAR ON STARSIN.STARNAME = MOVIESTAR.NAME
WHERE MOVIETITLE = 'Terms of Endearment' AND GENDER = 'F';

SELECT DISTINCT STARNAME
FROM STARSIN
JOIN MOVIE ON STARSIN.MOVIETITLE = MOVIE.TITLE AND STARSIN.MOVIEYEAR = MOVIE.YEAR
WHERE STUDIONAME = 'MGM' AND MOVIEYEAR = 1995;