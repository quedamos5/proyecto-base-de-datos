-- Usando la base de datos steam
USE steam;

go

-- 1. Lista todas las columnas de la tabla.
SELECT column_name
FROM   information_schema.columns
WHERE  table_name = 'juegos';

go

-- 2. Lista todos los diferentes géneros, eliminando duplicados.
SELECT DISTINCT Cast(genre AS VARCHAR(1000)) AS Genero
FROM   juegos;

go

-- 3. Lista únicamente aquellos juegos que puedan ser jugados únicamente en Linux
SELECT nombre,
       platformlinux,
       platformmac,
       platformwindows
FROM   juegos
WHERE  platformlinux LIKE 'True'
       AND platformmac LIKE 'False'
       AND platformwindows LIKE 'False';

go

-- 4.Lista todos los juegos de rol, ordenador por nota.
SELECT Cast(nombre AS VARCHAR(1000)) AS Nombre,
       metacritic
FROM   juegos
WHERE  genre LIKE '%RPG%'
ORDER  BY metacritic DESC;

go

-- 5.Lista todos aquellos juegos que puedan ser jugados en Español pero no en Frances
SELECT nombre,
       supportedlanguages
FROM   juegos
WHERE  supportedlanguages NOT LIKE '%French%'
       AND supportedlanguages LIKE '%Spanish%';

go

-- 6.Lista el nombre del juego, su precio inicial, su precio final y la diferencia entre ambos en una nueva columna.
SELECT nombre,
       priceinitial,
       pricefinal,
       ( priceinitial - pricefinal ) AS Diferencia
FROM   juegos
ORDER  BY diferencia DESC;

go

-- 7.¿Cuántos juegos hay del siglo pasado?
SELECT Cast(nombre AS VARCHAR(1000)) AS Nombre,
       releasedate
FROM   juegos
WHERE  releasedate LIKE '[^2]%';

go

-- 8.Devuelve todos los juegos que terminen o en N o en O.
SELECT nombre
FROM   juegos
WHERE  nombre LIKE '%n'
        OR nombre LIKE '%o';

go

-- 9.Devuelve todos los juegos que empiecen por A y que se puedan jugar con mando.
SELECT nombre
FROM   juegos
WHERE  nombre LIKE 'a%'
       AND controllersupport = 'True';

go

-- 10.Devuelve todos aquellos juegos que estén entre el 2000 y el 2010.
SELECT nombre,
       releasedate
FROM   juegos
WHERE  releasedate BETWEEN 2000 AND 2010;

go

-- 11.Devuelve todos los juegos que sean de la saga Final Fantasy.
SELECT nombre
FROM   juegos
WHERE  nombre LIKE '%Final Fantasy%';

go

-- 12.Devuelve todos los juegos que sean de deportes y haya trabajado más de 3 desarrolladores.
SELECT nombre,
       genre,
       developercount
FROM   juegos
WHERE  genre LIKE '%sport%'
       AND developercount > 3;

go

-- 13.¿Cuántos juegos hay asociados a cada categoría?
SELECT genre,
       Count(nombre) AS CantidadJuegos
FROM   juegos
GROUP  BY genre
ORDER  BY cantidadjuegos DESC;

go

-- 14.¿Cuántos juegos se han sacado en cada año?
SELECT releasedate,
       Count(nombre) AS CantidadJuegos
FROM   juegos
GROUP  BY releasedate
ORDER  BY releasedate;

go
-- 15.En base a la consulta anterior, devuelve aquellos años en los que la media de puntuación esté entre un 6 y un 8,
-- 16.¿Cuál es la máxima, mínima y puntuación mínima por género?
-- 17.Usando LIMIT, devuelve el top 10 de juegos con mayor puntuación del 2012.
-- 18.Usando LIMIT, devuelve el top 10 de juegos más nuevos de género single player.
-- 19.Devuelve la media de nota de todos aquellos juegos que sean para mayores de 18 años.
-- 20.¿Cuántos juegos hay asociados a cada tipo (mayor de 18, de 17…)?
-- 21.Devuelve todos aquellos años en los que haya menos de 300 juegos.
-- 22.Devuelve todos los juegos que estén para Mac pero no para Windows.
-- 23.Devuelve todos los juegos donde su precio final sea mayor a su precio inicial.
-- 24.Devuelve todos los juegos que no estén valorados en dólares.
-- 25.Devuelve todos los juegos que tengan una mayor nota que 0, pero que hayan suspendido.
-- 26.Devuelve el top 15 de juegos con mayor número de DLC.
-- 27.Devuelve la información de los juegos que sólo se puedan jugar en Inglés.
-- 28.Devuelve el nombre(en minúscula) y la web (en mayúscula) de los juegos de acción o casuales.
-- 29.¿Cuál es el juego indie con mayor nota? 
-- 30.¿Y con menor nota?
-- 31.Devuelve toda la información del juego con menor nota, siempre que sea mayor a cero.
-- 32.Devuelve aquellos juegos que tengan mayor nota que la media.
-- 33.Devuelve el juego con mayor nota del año 2008.
-- 34.Devuelve toda la información de los juegos que valgan más que la media.
-- 35.Devuelve toda la información de los juegos de Linux que tengan el mayor número de logros (achivements)