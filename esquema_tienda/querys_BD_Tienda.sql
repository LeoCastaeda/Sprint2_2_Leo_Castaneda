-- 1. Lista el nombre de todos los productos de la tabla producto
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto
SELECT * FROM producto;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). (Asumimos un cambio de 1€ = 1.1 USD)
SELECT nombre, precio, precio * 1.1 AS precio_usd FROM producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD) con alias específicos
SELECT nombre AS 'nombre de producto', precio AS 'euros', precio * 1.1 AS 'dólares' FROM producto;

-- 6. Lista los nombres y los precios de todos los productos, convirtiendo los nombres a mayúsculas
SELECT UPPER(nombre), precio FROM producto;

-- 7. Lista los nombres y los precios de todos los productos, convirtiendo los nombres a minúsculas
SELECT LOWER(nombre), precio FROM producto;

-- 8. Lista el nombre de todos los fabricantes y los dos primeros caracteres de sus nombres en mayúsculas
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) FROM fabricante;

-- 9. Lista los nombres y precios de los productos, redondeando el precio
SELECT nombre, ROUND(precio, 0) FROM producto;

-- 10. Lista los nombres y precios de los productos, truncando el precio sin decimales
SELECT nombre, TRUNCATE(precio, 0) FROM producto;

-- 11. Lista los códigos de los fabricantes que tienen productos en la tabla producto
SELECT DISTINCT codigo_fabricante FROM producto;

-- 12. Lista los códigos de los fabricantes que tienen productos en la tabla producto sin duplicados
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. Lista los nombres de los fabricantes en orden ascendente
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. Lista los nombres de los fabricantes en orden descendente
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Lista los nombres de los productos ordenados primero por nombre (ascendente) y luego por precio (descendente)
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Retorna las 5 primeras filas de la tabla fabricante
SELECT * FROM fabricante LIMIT 5;

-- 17. Retorna 2 filas a partir de la cuarta fila de la tabla fabricante (incluyendo la cuarta)
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Lista el nombre y el precio del producto más barato usando ORDER BY y LIMIT
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Lista el nombre y el precio del producto más caro usando ORDER BY y LIMIT
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. Lista el nombre de los productos cuyo fabricante tiene código 2
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. Retorna una lista con el nombre del producto, su precio y el nombre del fabricante
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Retorna una lista con el nombre del producto, su precio y el nombre del fabricante, ordenado por nombre del fabricante
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- 23. Lista el código del producto, el nombre del producto, el código y el nombre del fabricante
SELECT p.codigo, p.nombre, f.codigo, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 24. Retorna el nombre del producto más barato y su fabricante
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio ASC LIMIT 1;

-- 25. Retorna el nombre del producto más caro y su fabricante
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;

-- 26. Retorna todos los productos del fabricante Lenovo
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- 27. Retorna los productos del fabricante Crucial con un precio mayor a 200 €
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- 28. Retorna productos de los fabricantes Asus, Hewlett-Packard y Seagate (sin usar IN)
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- 29. Retorna productos de los fabricantes Asus, Hewlett-Packard y Seagate (usando IN)
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. Lista los productos cuyo nombre de fabricante termina en la vocal 'e'
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';

-- 31. Lista los productos cuyo fabricante contiene la letra 'w'
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%';

-- 32. Retorna productos con precio mayor o igual a 180 €, ordenado por precio desc y nombre asc
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;

-- 33. Retorna fabricantes que tienen productos asociados
SELECT DISTINCT f.codigo, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34. Retorna todos los fabricantes con sus productos (incluso los que no tienen productos)
SELECT f.codigo, f.nombre, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Retorna fabricantes que no tienen productos asociados
SELECT f.codigo, f.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo IS NULL;

-- 36. Retorna todos los productos del fabricante Lenovo (sin usar INNER JOIN)
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37. Retorna productos con el mismo precio que el producto más caro de Lenovo (sin usar INNER JOIN)
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 38. Lista el producto más caro del fabricante Lenovo
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1;

-- 39. Lista el producto más barato del fabricante Hewlett-Packard
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard') ORDER BY precio ASC LIMIT 1;

-- 40. Retorna productos cuyo precio sea mayor o igual que el del producto más caro de Lenovo
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 41. Retorna productos del fabricante Asus con precio superior al promedio de sus productos
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));
