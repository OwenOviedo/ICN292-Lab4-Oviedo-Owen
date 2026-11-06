-- base de datos 
CREATE DATABASE austral;
USE austral;

-- crear tablas
CREATE TABLE coleccion (
id_coleccion INT NOT NULL AUTO_INCREMENT,
titulo VARCHAR(120) NOT NULL,
fecha_publicacion DATE,
PRIMARY KEY (id_coleccion)
);

CREATE TABLE autores (
id_autor INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(80) NOT NULL,
país VARCHAR(60),
género ENUM('Cómic','Ensayo','Infantil','Novela','Poesía') NOT NULL,
PRIMARY KEY (id_autor)
);

CREATE TABLE pagos (
id_pago INT NOT NULL AUTO_INCREMENT,
id_autor INT NOT NULL,
fecha_pago DATE,
monto DECIMAL(10,2),
PRIMARY KEY (id_pago),
FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

CREATE TABLE libro (
id_libro INT NOT NULL AUTO_INCREMENT,
id_autor INT NOT NULL ,
id_coleccion INT,
titulo VARCHAR(60),
páginas INT,
ejemplares_vendidos INT,
año INT NOT NULL,
PRIMARY KEY (id_libro),
FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
FOREIGN KEY (id_coleccion) REFERENCES coleccion(id_coleccion)
);

-- Para visualizar las tablas que ya tengo.
SHOW TABLES;

-- Insertar datos:
INSERT INTO autores (nombre, país, género) VALUES
('Elena Pizarro', 'Chile', 'Novela'),
('Harold Finch', 'Inglaterra', 'Ensayo'),
('Rodrigo Bahamonde', 'Chile', 'Poesía'),
('Valentina Correa', 'Argentina', 'Infantil'),
('Nora Keller', 'Estados Unidos', 'Novela'),
('Kenji Arakawa', NULL, 'Cómic');

-- Para visualizar el contenido
SELECT * FROM autores;
-- Para Borrar el contenido de una tabla
DELETE FROM autores;
-- Reiniciar el contador de la tabla autores
ALTER TABLE autores AUTO_INCREMENT = 1;

INSERT INTO libro
(id_autor, titulo ,páginas, ejemplares_vendidos, año)
VALUES
(1, 'Cielo de Enero', 210, 1500, 2024),
(1, 'Marea Baja', 185, 800, 2023),
(1, 'El Norte', 200, 2200, 2024),
(2, 'Estrellas que Caen', 240, 3000, 2022),
(2, 'Máquinas', 215, 450, 2024),
(3, ' Luz Artificial', 300, 1200, 2024),
(3, 'Ruido Blanco', 280, 600, 2023),
(4, 'El Barrio de Lila', 190, 5000, 2024),
(4, 'Antes del Amanecer', 205, 2700, 2024),
(4, 'La Calle 8', 175, 900, 2023),
(5, 'Flor de Hierro', 195, 4100, 2024),
(5, 'Hora Dorada', 220, 1800, 2022);

SELECT * FROM libro;
DELETE FROM libro;
ALTER TABLE libro AUTO_INCREMENT = 12;

-- Consultas.
-- Consulta 1:
SELECT nombre, género
FROM autores
WHERE país != 'Chile' OR país IS NULL
ORDER BY nombre;

-- Consulta 2:
SELECT titulo, páginas
FROM libro
WHERE páginas BETWEEN 190 AND 220
ORDER BY páginas ASC;

-- Consulta 3:
SELECT COUNT(titulo) AS 'n° de libros' , SUM(ejemplares_vendidos) AS 'Ejemplares vendidos', AVG(páginas) AS 'Promedio de hojas', MIN(año) AS 'Año del libro más antiguo', MAX(ejemplares_vendidos) AS 'Mayor cantidad de ejemplares vendidos'
FROM libro;

-- Consulta 4:
SELECT DISTINCT género
FROM autores
ORDER BY género ASC;

-- Consulta 5:
SELECT COUNT(id_autor) , año
FROM libro
WHERE año = 2024
GROUP BY id_autor
HAVING COUNT(id_autor) >= 2;

SELECT  l.año, a.nombre, COUNT(l.id_libro)
FROM libro AS l
JOIN autores AS a ON a.id_autor = l.id_autor
WHERE año = 2024
GROUP BY a.nombre
HAVING COUNT(l.id_libro) >= 2
ORDER BY a.nombre;

-- Consulta 6:
SELECT año, titulo, ejemplares_vendidos
FROM libro
WHERE año = 2024 AND ejemplares_vendidos > 2000
ORDER BY ejemplares_vendidos DESC
LIMIT 3;

-- Consulta 7:
-- Agregamos el libro
INSERT INTO libro
(id_autor, titulo ,páginas, ejemplares_vendidos, año)
VALUES
(3, 'Papel Mojado', 260, 50, 2024);
-- Visualizamos la tabla 
SELECT * FROM libro;
-- Borramos el nuevo registro
DELETE FROM libro
WHERE titulo = 'Papel Mojado';

-- Consulta 8:
-- Visualizamos la tabla 
SELECT * FROM libro;
-- Actualizamos las ventas 
UPDATE libro
SET ejemplares_vendidos = ejemplares_vendidos + 100
WHERE titulo = 'Cielo de Enero' AND id_libro = 1;

-- Consulta 9:
-- insertar datos a la tabla colecciones:
INSERT INTO coleccion (titulo, fecha_publicacion) VALUES
( 'Baston Arcano', '2017-01-05'),
( 'Baston de Hielo', '2017-02-15'),
( 'Baston Sagrado', '2017-04-21'),
( 'Baston de Fuego', '2017-08-13'),
( 'Baston Maldito', '2017-11-28');
-- Visualizar tabla:
SELECT * FROM coleccion;
-- Actualizar los valores de libros:
UPDATE libro
SET id_coleccion = 3
WHERE id_libro = 1 ;
UPDATE libro
SET id_coleccion = 2
WHERE id_libro = 2;
UPDATE libro
SET id_coleccion = 2
WHERE id_libro = 3;
UPDATE libro
SET id_coleccion = 1
WHERE id_libro = 4;
UPDATE libro
SET id_coleccion = 5
WHERE id_libro = 5;
UPDATE libro
SET id_coleccion = 4
WHERE id_libro = 6;
UPDATE libro
SET id_coleccion = 3
WHERE id_libro = 7;
UPDATE libro
SET id_coleccion = 4
WHERE id_libro = 8;
UPDATE libro
SET id_coleccion = 3
WHERE id_libro = 9;
UPDATE libro
SET id_coleccion = 1
WHERE id_libro = 10;
UPDATE libro
SET id_coleccion = 5
WHERE id_libro = 11;
UPDATE libro
SET id_coleccion = 3
WHERE id_libro = 12 ;
-- Visualizar resultado
SELECT * FROM libro;
-- Visualización de los titulos de los libros más su colección
SELECT c.titulo, l.titulo
FROM libro AS l
JOIN coleccion AS c ON c.id_coleccion = l.id_coleccion;

-- Consulta 10:
-- Insertar datos a la tabla pagos:
INSERT INTO pagos (id_autor, fecha_pago, monto) 
VALUES
( 4 , '2025-01-05', 25000000),
( 4 , '2025-02-15', 17550000),
( 5 , '2025-03-25', 32800000);
-- Visualización de tabla pagos
SELECT a.nombre, p.fecha_pago, p.monto
FROM pagos AS p
JOIN autores AS a ON a.id_autor = p.id_autor;
-- Montos totales 
SELECT SUM(p.monto) AS 'Monto total', a.nombre 
FROM pagos AS p 
JOIN autores AS a ON p.id_autor = a.id_autor
GROUP BY a.nombre


