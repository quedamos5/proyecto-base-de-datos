-- Usando la base de datos steam
USE steam;

go

-- 1. Lista todas las columnas de la tabla.
SELECT column_name
FROM   information_schema.columns
WHERE  table_name = 'juegos';

go

-- 2. Lista todos los diferentes g�neros, eliminando duplicados.
SELECT DISTINCT Cast(genre AS VARCHAR(1000)) AS Genero
FROM   juegos;

go

-- 3. Lista �nicamente aquellos juegos que puedan ser jugados �nicamente en Linux
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

-- 5.Lista todos aquellos juegos que puedan ser jugados en Espa�ol pero no en Frances
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

-- 7.�Cu�ntos juegos hay del siglo pasado?
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

-- 10.Devuelve todos aquellos juegos que est�n entre el 2000 y el 2010.
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

-- 12.Devuelve todos los juegos que sean de deportes y haya trabajado m�s de 3 desarrolladores.
SELECT nombre,
       genre,
       developercount
FROM   juegos
WHERE  genre LIKE '%sport%'
       AND developercount > 3;

go

-- 13.�Cu�ntos juegos hay asociados a cada categor�a?
SELECT genre,
       Count(nombre) AS CantidadJuegos
FROM   juegos
GROUP  BY genre
ORDER  BY cantidadjuegos DESC;

go

-- 14.�Cu�ntos juegos se han sacado en cada a�o?
SELECT releasedate,
       Count(nombre) AS CantidadJuegos
FROM   juegos
GROUP  BY releasedate
ORDER  BY releasedate;

go

-- 15. En base a la consulta anterior, devuelve aquellos años en los que la media de puntuación esté entre un 6 y un 8,
SELECT 'En ' + Cast(releasedate AS NVARCHAR) + ': '
       + Cast(Count(releasedate) AS NVARCHAR) cantidad
FROM   juegos
GROUP  BY releasedate
HAVING Avg(metacritic) >= 6
       AND Avg(metacritic) <= 8
ORDER  BY releasedate

go

-- 16. ¿Cuál es la máxima, media y puntuación mínima por género?
SELECT genre           Género,
       Max(metacritic) 'Puntuación máxima',
       Avg(metacritic) 'Puntuación media',
       Min(metacritic) 'Puntuación mínima'
FROM   juegos
GROUP  BY genre
ORDER  BY genre

go

-- 17. Usando LIMIT, devuelve el top 10 de juegos con mayor puntuación del 2012.
SELECT TOP(10) nombre
FROM   juegos
WHERE  releasedate = 2012
ORDER  BY metacritic DESC

go

-- 18. Usando LIMIT, devuelve el top 10 de juegos más nuevos de category single player.
SELECT TOP(10) nombre
FROM   juegos
WHERE  category LIKE '%single player%'
ORDER  BY releasedate DESC

go

-- 19. Devuelve la media de nota de todos aquellos juegos que sean para mayores de 18 años.
SELECT Avg(metacritic) 'Media de nota'
FROM   juegos
WHERE  requiredage >= 18

go

-- 20. ¿Cuántos juegos hay asociados a cada tipo (mayor de 18, de 17…)?
SELECT requiredage,
       Count(*) 'Juegos'
FROM   juegos
GROUP  BY requiredage
ORDER  BY requiredage DESC

go

-- 21. Devuelve todos aquellos años en los que haya menos de 300 juegos.
SELECT releasedate,
       Count(nombre)
FROM   juegos
GROUP  BY releasedate
HAVING Count(nombre) < 300
ORDER  BY releasedate DESC

go

-- 22.Devuelve todos los juegos que est�n para Mac pero no para Windows.
-- 23.Devuelve todos los juegos donde su precio final sea mayor a su precio inicial.
-- 24.Devuelve todos los juegos que no est�n valorados en d�lares.
-- 25.Devuelve todos los juegos que tengan una mayor nota que 0, pero que hayan suspendido.
-- 26.Devuelve el top 15 de juegos con mayor n�mero de DLC.
-- 27.Devuelve la informaci�n de los juegos que s�lo se puedan jugar en Ingl�s.
-- 28.Devuelve el nombre(en min�scula) y la web (en may�scula) de los juegos de acci�n o casuales.
-- 29.�Cu�l es el juego indie con mayor nota? 
SELECT TOP 1 WITH ties nombre,
                       metacritic
FROM   juegos
WHERE  genre LIKE '%indie%'
ORDER  BY metacritic DESC;

-- 30.�Y con menor nota?
SELECT TOP 1 WITH ties nombre,
                       metacritic
FROM   juegos
WHERE  genre LIKE '%indie%'
       AND metacritic != 0
ORDER  BY metacritic;

-- 31.Devuelve toda la informaci�n del juego con menor nota, siempre que sea mayor a cero.
SELECT *
FROM   juegos
WHERE  metacritic = (SELECT Min(metacritic)
                     FROM   juegos
                     WHERE  metacritic != 0)

go

-- 32.Devuelve aquellos juegos que tengan mayor nota que la media.
SELECT *
FROM   juegos
WHERE  metacritic > (SELECT Avg(metacritic)
                     FROM   juegos
                     WHERE  metacritic > 0);

go

-- 33.Devuelve el juego con mayor nota del a�o 2008.
SELECT nombre,
       metacritic,
       releasedate
FROM   juegos
WHERE  releasedate = 2008
       AND metacritic = (SELECT Max(metacritic)
                         FROM   juegos
                         WHERE  releasedate = 2008);

go

-- 34.Devuelve toda la informaci�n de los juegos que valgan m�s que la media.
SELECT *
FROM   juegos
WHERE  pricefinal > (SELECT Avg(pricefinal)
                     FROM   juegos);

go

-- 35.Devuelve toda la informaci�n de los juegos de Linux que tengan el mayor n�mero de logros (achivements)
SELECT *
FROM   juegos
WHERE  platformlinux = 'True'
       AND achievementcount = (SELECT Max(achievementcount)
                               FROM   juegos
                               WHERE  platformlinux = 'True');

go
-- END