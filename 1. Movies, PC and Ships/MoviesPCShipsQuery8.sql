-- 1.
INSERT INTO MOVIESTAR(NAME, GENDER, BIRTHDATE)
VALUES('Nicole Kidman', 'F', '1967-06-20')

-- 2.
DELETE FROM MOVIEEXEC
WHERE NETWORTH < 10000000

-- 3.
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL

-- 4.
UPDATE MOVIEEXEC
SET name = 'Pres. ' + name
WHERE CERT# IN (SELECT PRESC# FROM STUDIO)

--------------------------------------

-- 1.
INSERT INTO product(model, maker, type)
VALUES('1100', 'C', 'PC')
INSERT INTO pc(code, model, speed, ram, hd, cd, price)
VALUES(12, '1100', 2400, 2048, 500, '52x', 299)

-- 2.
DELETE FROM pc 
WHERE model = '1100'
DELETE FROM product
WHERE model = '1100'

-- 3.
INSERT INTO product (model, maker, type)
SELECT DISTINCT model, 'Z', 'Laptop'
FROM pc

INSERT INTO laptop(code, model, speed, ram, hd, price, screen)
SELECT code + 100, model, speed, ram, hd, price + 500, 15
FROM PC

-- 4.
DELETE FROM laptop
WHERE model IN (SELECT model
				FROM product
				WHERE type = 'Laptop' AND
					  maker NOT IN (SELECT maker
									FROM product
									WHERE type = 'Printer'))

-- 5.
UPDATE product
SET maker = 'A'
WHERE maker = 'B'

-- 6.
UPDATE pc
SET price = price / 2, hd = hd + 20

-- 7.
UPDATE laptop
SET screen = screen + 1
WHERE model IN (SELECT model
				FROM product
				WHERE maker = 'B' AND type = 'Laptop')

--------------------------------------

-- 1.
INSERT INTO CLASSES(CLASS, TYPE, NUMGUNS, COUNTRY, BORE, DISPLACEMENT)
VALUES ('Nelson', 'bb', 9, 'Gt.Britain', 16, 34000)

INSERT INTO SHIPS(NAME, CLASS, LAUNCHED)
VALUES ('Nelson', 'Nelson', 1927),
	   ('Rodney', 'Nelson', 1927)

-- 2.
DELETE FROM SHIPS 
WHERE NAME IN (SELECT SHIP
			   FROM OUTCOMES
			   WHERE RESULT = 'sunk')

-- 3.
UPDATE CLASSES
SET BORE = BORE * 2.54, DISPLACEMENT = DISPLACEMENT / 1.1

-- 4.
DELETE FROM CLASSES
WHERE CLASS IN (
	SELECT CLASSES.CLASS
	FROM CLASSES AS c
	LEFT JOIN SHIPS AS s ON c.CLASS = s.CLASS
	GROUP BY c.CLASS
	HAVING COUNT(NAME) < 3)

-- 5.
UPDATE CLASSES
SET BORE = (SELECT BORE
			FROM CLASSES
			WHERE CLASS = 'Bismarck'),
	DISPLACEMENT = (SELECT DISPLACEMENT
					FROM CLASSES
					WHERE CLASS = 'Bismarck')
WHERE CLASS = 'Iowa'