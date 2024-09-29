-- Base de datos: Universidad
-- Archivo: consultas_universidad.sql
-- Descripción: Este archivo contiene varias consultas SQL realizadas sobre la base de datos Universidad.

-- 1. Listado de primer apellido, segundo apellido y nombre de todos los alumnos, ordenado alfabéticamente.
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

-- 2. Nombre y apellidos de los alumnos que no han registrado su número de teléfono.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Listado de los alumnos que nacieron en 1999.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4. Listado de profesores que no han registrado su número de teléfono y cuyo NIF termina en 'K'.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Listado de las asignaturas que se imparten en el primer cuatrimestre del tercer curso del grado con id 7.
SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Listado de los profesores con el nombre de su departamento, ordenado alfabéticamente.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento
FROM profesor pr
JOIN persona p ON pr.id_profesor = p.id
JOIN departamento d ON pr.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7. Listado de las asignaturas, año de inicio y año de fin del curso escolar del alumno con NIF '26902806M'.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin
FROM alumno_se_matricula_asignatura ama
JOIN asignatura a ON ama.id_asignatura = a.id
JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
JOIN persona p ON ama.id_alumno = p.id
WHERE p.nif = '26902806M';

-- 8. Listado de los departamentos que tienen profesores que imparten asignaturas en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
JOIN asignatura a ON pr.id_profesor = a.id_profesor
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Listado de todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno
JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- Consultas usando LEFT JOIN y RIGHT JOIN:
-- 10. Listado de todos los profesores y los departamentos a los que están vinculados, mostrando también los profesores sin departamento asociado.
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 11. Listado de los profesores que no están asociados a ningún departamento.
SELECT p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
WHERE pr.id_departamento IS NULL AND p.tipo = 'profesor';

-- 12. Listado de los departamentos que no tienen profesores asociados.
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_departamento IS NULL;

-- 13. Listado de los profesores que no imparten ninguna asignatura.
SELECT p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL AND p.tipo = 'profesor';

-- 14. Listado de las asignaturas que no tienen un profesor asignado.
SELECT nombre
FROM asignatura
WHERE id_profesor IS NULL;

-- 15. Listado de los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL;

-- Consultas resumen:

-- 16. Número total de alumnos.
SELECT COUNT(*) AS total_alumnos
FROM persona
WHERE tipo = 'alumno';

-- 17. Número de alumnos que nacieron en 1999.
SELECT COUNT(*) AS alumnos_1999
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 18. Número de profesores por departamento (mostrando solo departamentos con profesores asociados).
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

-- 19. Listado de todos los departamentos y el número de profesores en cada uno (incluyendo los que no tienen profesores).
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.nombre;

-- 20. Listado de todos los grados y el número de asignaturas que tiene cada uno.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY numero_asignaturas DESC;

-- 21. Listado de grados que tienen más de 40 asignaturas asociadas.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING numero_asignaturas > 40;

-- 22. Listado de grados y la suma total de créditos por tipo de asignatura.
SELECT g.nombre AS grado, a.tipo, SUM(a.creditos) AS total_creditos
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo;

-- 23. Listado de cuántos alumnos se han matriculado en alguna asignatura en cada curso escolar.
SELECT ce.anyo_inicio, COUNT(DISTINCT ama.id_alumno) AS alumnos_matriculados
FROM curso_escolar ce
JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar
GROUP BY ce.anyo_inicio;

-- 24. Listado con el número de asignaturas que imparte cada profesor, incluyendo aquellos que no imparten ninguna.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor'
GROUP BY p.id
ORDER BY numero_asignaturas DESC;

-- 25. Datos del alumno más joven.
SELECT *
FROM persona
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- 26. Listado de profesores que tienen un departamento asociado pero no imparten ninguna asignatura.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento
FROM profesor pr
JOIN persona p ON pr.id_profesor = p.id
JOIN departamento d ON pr.id_departamento = d.id
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;
