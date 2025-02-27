SELECT Maker, Speed
FROM product
JOIN laptop ON product.model = laptop.model
WHERE hd >= 9;

SELECT product.model, COALESCE(laptop.price, pc.price, printer.price) AS Price
FROM product
LEFT JOIN laptop ON product.model = laptop.model
LEFT JOIN pc ON product.model = pc.model
LEFT JOIN printer ON product.model = printer.model
WHERE maker = 'B'
ORDER BY Price DESC;

SELECT HD
FROM pc
GROUP BY hd
HAVING COUNT(*) >= 2;

SELECT pc1.model,pc2.model
FROM pc pc1
JOIN pc pc2 ON pc1.speed = pc2.speed
			AND pc1.ram = pc2.ram
			AND pc1.model < pc2.model;

SELECT Maker
FROM product
JOIN pc ON product.model = pc.model
WHERE pc.speed >= 500
GROUP BY maker
HAVING COUNT(DISTINCT pc.model) >= 2;