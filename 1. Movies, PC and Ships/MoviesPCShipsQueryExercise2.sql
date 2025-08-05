-- 4
-- ������ ����� �� ����� ������ � ���������� �� ������ �����, ����� � �����������. 
-- ��� ����� ������ ���� �����, �� �� ������ NULL �� ����������.
SELECT s.NAME, m.TITLE
FROM STUDIO s
LEFT JOIN MOVIE m ON m.STUDIONAME = s.NAME

-- ������ ������� �� ������ ����������, ����� �� �� ����������� ���� ���� ����.
SELECT me.NAME
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#
WHERE m.TITLE IS NULL

-- �� ����� ������ �� �� ������� ������� �� ������ �����, � ����� � ��������, � ����� �� ��������, ����� � ����������� �����. 
-- ��� �������� ���� �����, �� �� ������ NULL �� ���� � ������.
SELECT ms.NAME, si.MOVIETITLE, m.STUDIONAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR

-- ������ ������� �� ������ ����� � ������� �� ������������ ��. 
-- ��� �� ����� ���� ���� ���������, �� �� ������ NULL.
SELECT m.TITLE, me.NAME
FROM MOVIE m
LEFT JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#

-- ������ ������� �� ������ ���������� � ������� �� �������, ����� �� �����������. 
-- ��� ����������� ���� �����, �� �� ������ NULL �� ��������.
SELECT me.NAME, m.TITLE
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#

-- ������ ������� �� ������ �������, ����� �� ������ ��� ����� �� MGM, 
-- ������ ��� ���������� �� ���� �����. 
-- ��� �������� ���� ����� ����, �� �� ������ NULL �� ��������.
SELECT ms.NAME, 
	   CASE WHEN m.STUDIONAME = 'MGM' THEN m.TITLE
			ELSE NULL END AS TITLE
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
LEFT JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR

-- �� ����� ���� ������ ����������, ����� �� ���������� � ����� �� ��������. 
-- ��� ������ ��������� ��� ������, �� �� ������ NULL.
SELECT m.TITLE, me.NAME, m.STUDIONAME
FROM MOVIE m
LEFT JOIN MOVIEEXEC me ON me.CERT# = m.PRODUCERC#

-- ������ ������� �� ���������, ����� �� �� ��������� � ���� ���� ����.
SELECT ms.NAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
WHERE si.MOVIETITLE IS NULL

-- 5
-- �� ����� ������ ������ �� ������� ����� �� ���� ��� ��� �������� ����������:
-- ��� �� �������� � ������� ������� �� ������ ������ �����
SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME

-- �� ����� ������ �� �� ������ ����� ������� � ����� ������� ���� �� ������
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

-- �� ����� ������ ������ �������� ������� �� �������, ����� � �����������.
SELECT STUDIONAME, AVG(LENGTH) AS AVGMOVIELENGTH
FROM MOVIE
GROUP BY STUDIONAME

-- ������ ���� �� ���������, ������ ���� 1970 �..
SELECT COUNT(*)
FROM MOVIESTAR
WHERE BIRTHDATE > '1970-12-31'

-- �� ����� ������ ������ ���� �� �������, � ����� � �������� ���� 2000 �..
SELECT ms.NAME, COUNT(si.MOVIETITLE)
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME AND si.MOVIEYEAR > 2000
GROUP BY ms.NAME

-- ������ ����� �� �������, �������� � ���-����� �����.
SELECT STARNAME
FROM STARSIN 
GROUP BY STARNAME
HAVING COUNT(*) = (
	SELECT MAX(FILMCOUNT)
	FROM (
		SELECT COUNT(*) AS FILMCOUNT
		FROM STARSIN
		GROUP BY STARNAME) AS T)

-- ������ ���� �� ���������� ������, � ����� � ������� ����� ������.
SELECT si.STARNAME, COUNT(DISTINCT m.STUDIONAME)
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME

-- ������ ���� �� �������, ����� �� ����������� �� ����� ������ ���� 1995 �.
SELECT STUDIONAME, COUNT(*)
FROM MOVIE
WHERE YEAR > 1995
GROUP BY STUDIONAME

-- ������ �������� ������� �� ������ ����������, ����� �� ����������� ����.
SELECT AVG(NETWORTH)
FROM MOVIEEXEC me
WHERE me.CERT# IN (SELECT PRODUCERC# FROM MOVIE) 

-- ������ ��������, ����� ��� ���-����� ����� � ������� ��� 120 ������.
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

-- �� ����� ������ ������ �������� ������� �� �������, � ����� � ��������.
SELECT si.STARNAME, AVG(m.LENGTH)
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME

-- ������ ���������, ��������� � ���� 3 �������� ������
SELECT ms.NAME
FROM MOVIESTAR ms
JOIN STARSIN si ON si.STARNAME = ms.NAME
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR	
WHERE GENDER = 'f'
GROUP BY ms.NAME
HAVING COUNT(DISTINCT m.STUDIONAME) >= 3

-- 1. ������ ���� �� �������, � ����� � �������� ����� ������, ���������� �� ��������.
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE)
FROM STARSIN 
GROUP BY STARNAME

-- 2. ������ ���������, ��������� � ���� 5 �����.
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE) AS DISTINCTMOVIES
FROM STARSIN
GROUP BY STARNAME
HAVING COUNT(DISTINCT MOVIETITLE) >= 5

-- 3. ������ �������� ������� �� ������� �� ����� ������.
SELECT  YEAR, AVG(LENGTH)
FROM MOVIE
GROUP BY YEAR

-- 4. ������ �� ����� ������ ������������ � ����������� ������� �� ������� ��.
SELECT STUDIONAME, MIN(LENGTH), MAX(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME

-- 5. ������ ���� �� ������� �� ����� ������, �� ����� ��������� � �������� (LENGTH �� � NULL).
SELECT STUDIONAME, COUNT(DISTINCT TITLE)
FROM MOVIE
WHERE LENGTH IS NOT NULL
GROUP BY STUDIONAME

-- 6. ������ ���������, ����� �� ������� ����� � �������� ������ � ���� ��� ��������.
SELECT STARNAME
FROM STARSIN
GROUP BY STARNAME
HAVING COUNT(DISTINCT MOVIEYEAR) >= 2

-- ������ ������� �� ��������� � ���� �� �������, � ����� �� ���������, 
-- ��������� �� ���� ����� (�� ���-����� ��� ���-�����).
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE)
FROM STARSIN
GROUP BY STARNAME
ORDER BY COUNT(MOVIETITLE) DESC

-- �� ����� ������ ������ ���� �� �������, ����� ������� � ��� 100 ������.
SELECT STUDIONAME, COUNT(TITLE)
FROM MOVIE
WHERE LENGTH > 100
GROUP BY STUDIONAME

-- ������ �������� � ���-����� ������� ����� � ����� �� ��.
SELECT TOP 1 YEAR, COUNT(TITLE)
FROM MOVIE
GROUP BY YEAR
ORDER BY COUNT(TITLE) DESC

-- �� ����� ��������� ������ �������� ������� �� �������, ����� � ����������.
SELECT me.NAME, AVG(LENGTH)
FROM MOVIEEXEC me
LEFT JOIN MOVIE m ON m.PRODUCERC# = me.CERT#
GROUP BY me.NAME

-- ������ ����� �� �������, �������� � ���-������ ����.
SELECT si.STARNAME
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
WHERE m.LENGTH = (
	SELECT MAX(LENGTH)
	FROM MOVIE)

-- ������ �� ����� ������ ���� �� ���������� ������, ����� �� ����������� �����.
SELECT YEAR, COUNT(DISTINCT STUDIONAME)
FROM MOVIE
GROUP BY YEAR

-- ������ �������� � ���-����� �����, ����������� ���� 2005 ������.
SELECT TOP 1 STUDIONAME, COUNT(*)
FROM MOVIE
WHERE YEAR > 2005
GROUP BY STUDIONAME 
ORDER BY COUNT(*) DESC

-- �� ����� ������ ������ �������� ������� �� �������, � ����� � ��������, 
-- �� ���� ��� � �������� � ���� 3 �����.
SELECT si.STARNAME, AVG(m.LENGTH) AS AvgMovieLength
FROM STARSIN si
JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
GROUP BY si.STARNAME
HAVING COUNT(DISTINCT TITLE) >= 3

-- ������ ���� �� ���������, ����� �� ��������� � ���� 3 �������� ������.
SELECT COUNT(*)
FROM (
	SELECT si.STARNAME
	FROM STARSIN si
	JOIN MOVIE m ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
	GROUP BY si.STARNAME
	HAVING COUNT(DISTINCT STUDIONAME) >= 3) AS ACTORS

-- ������ ����� �� �������� � ������ ���� �� ��������� �� ������� ��, 
-- �� ���� �� ������, ����� ���� ������ �� 5 �����
SELECT STUDIONAME, SUM(LENGTH)
FROM MOVIE
GROUP BY STUDIONAME
HAVING COUNT(DISTINCT TITLE) >= 5