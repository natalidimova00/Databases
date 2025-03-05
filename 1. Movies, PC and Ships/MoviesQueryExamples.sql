SELECT studioName, title
FROM Movie;

SELECT title, length / 60.0 as hours
FROM Movie;

SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990;

SELECT *
FROM Movie
WHERE title LIKE 'Star %_';

SELECT *
FROM MovieStar
WHERE birthdate > '1970-06-01';

SELECT name, year(birthdate)
FROM MovieStar
WHERE month(birthdate) = 7;

SELECT title, year, length
FROM Movie
WHERE length > 60
ORDER BY length DESC, title;

SELECT *
FROM MovieStar
ORDER BY month(birthdate);

