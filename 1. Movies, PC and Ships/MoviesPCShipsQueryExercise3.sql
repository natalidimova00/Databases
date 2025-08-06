-- 6
-- ������ ���� �� ���������, ������ � �������� �������:
-- ����� 1970
-- �� 1970 �� 1989
-- ���� 1989
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

-- �� ����� ���� ������ ���������� �� � ����������� �� �� �������:
-- "Short" ��� � ��� 90 ������
-- "Medium" ��� � ����� 90 � 150 ������
-- "Long" ��� � ��� 150 ������
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

-- ������ ���� �� ���������, ����� �� ��������� �:
-- ��-����� �� 3 �����
-- ����� 3 � 5 �����
-- ������ �� 5 �����
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

-- ������ ����� ������ ����:
-- ��-����� �� 5 �����
-- ����� 5 � 10 �����
-- ������ �� 10 �����
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

-- ���� �� ���������, �����:
-- �� ������ ���� ����� 1980
-- �� ������ ���� ���� 2000
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
-- ��� ���������� ���������� � �������� �� ������ �����, ������� ����� 1982, � ����� � ����� ���� ���� ������
-- (�������), ����� ��� �� ������� ���� ������� 'k', ���� 'b'. ����� �� �� ������� ���-������� �����.
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

-- ���������� � ��������� � ������ (length � � ������) �� ������ �����, ����� �� �� ������ ������, �� ����� � � 
-- ������ Terms of Endearment, �� ��������� �� � ��-����� ��� ����������.
SELECT TITLE, LENGTH/60.0 AS LENGTHINHOURS
FROM MOVIE
WHERE TITLE <> 'Terms of Endearment'
	AND YEAR = (SELECT YEAR FROM MOVIE WHERE TITLE = 'Terms of Endearment')
	AND (LENGTH IS NULL OR LENGTH < (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Terms of Endearment'))

-- ������� �� ������ ����������, ����� �� � ������� ������ � �� ������ � ���� ���� ���� 
-- ����� 1980 �. � ���� ���� ���� 1985 �.
SELECT STARNAME
FROM STARSIN
WHERE STARNAME IN (SELECT NAME FROM MOVIEEXEC)
	AND MOVIEYEAR < 1980
	AND MOVIEYEAR > 1985

-- ������� �� ������ ����������, ����� �� � ������� ������ � �� ������ � ���� ���� ���� 
-- ����� 1980 �. � ���� ���� ���� 1985 �.
SELECT DISTINCT s1.STARNAME
FROM STARSIN s1
JOIN STARSIN s2 ON s2.STARNAME = s1.STARNAME
WHERE s1.STARNAME IN (SELECT NAME FROM MOVIEEXEC)
	AND s1.MOVIEYEAR < 1980
	AND s2.MOVIEYEAR > 1985

-- 2�� �����
SELECT STARNAME
FROM STARSIN
WHERE STARNAME IN (SELECT NAME FROM MOVIEEXEC)
GROUP BY STARNAME
HAVING MIN(MOVIEYEAR) < 1980
   AND MAX(MOVIEYEAR) > 1985