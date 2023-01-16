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
select 'En ' + CAST(ReleaseDate as nvarchar) + ': ' + CAST(COUNT(ReleaseDate) as nvarchar) cantidad from juegos group by ReleaseDate having AVG(Metacritic) >= 6 and AVG(Metacritic) <= 8 order by ReleaseDate

go
-- 16. ¿Cuál es la máxima, media y puntuación mínima por género?
select genre Género, 
       MAX(Metacritic) 'Puntuación máxima', 
       AVG(Metacritic) 'Puntuación media', 
       MIN(Metacritic) 'Puntuación mínima' 
from juegos 
group by Genre 
order by Genre

go
-- 17. Usando LIMIT, devuelve el top 10 de juegos con mayor puntuación del 2012.
select top(10) Nombre 
from juegos 
where ReleaseDate = 2012 
order by Metacritic desc

go
-- 18. Usando LIMIT, devuelve el top 10 de juegos más nuevos de category single player.
select top(10) nombre 
from juegos 
where Category like '%single player%' 
order by ReleaseDate desc

go
-- 19. Devuelve la media de nota de todos aquellos juegos que sean para mayores de 18 años.
select AVG(Metacritic) 'Media de nota' 
from juegos 
where RequiredAge >= 18

go
-- 20. ¿Cuántos juegos hay asociados a cada tipo (mayor de 18, de 17…)?
select requiredAge, 
       count(*) 'Juegos' 
from juegos 
group by RequiredAge 
order by RequiredAge desc

go
-- 21. Devuelve todos aquellos años en los que haya menos de 300 juegos.
select ReleaseDate, 
       COUNT(nombre) 
from juegos 
group by ReleaseDate 
having COUNT(Nombre) < 300 
order by ReleaseDate desc

go
-- 22.Devuelve todos los juegos que est�n para Mac pero no para Windows.
-- 23.Devuelve todos los juegos donde su precio final sea mayor a su precio inicial.
-- 24.Devuelve todos los juegos que no est�n valorados en d�lares.
-- 25.Devuelve todos los juegos que tengan una mayor nota que 0, pero que hayan suspendido.
-- 26.Devuelve el top 15 de juegos con mayor n�mero de DLC.
-- 27.Devuelve la informaci�n de los juegos que s�lo se puedan jugar en Ingl�s.
-- 28.Devuelve el nombre(en min�scula) y la web (en may�scula) de los juegos de acci�n o casuales.
-- 29.�Cu�l es el juego indie con mayor nota? 
-- 30.�Y con menor nota?
-- 31.Devuelve toda la informaci�n del juego con menor nota, siempre que sea mayor a cero.
-- 32.Devuelve aquellos juegos que tengan mayor nota que la media.
-- 33.Devuelve el juego con mayor nota del a�o 2008.
-- 34.Devuelve toda la informaci�n de los juegos que valgan m�s que la media.
-- 35.Devuelve toda la informaci�n de los juegos de Linux que tengan el mayor n�mero de logros (achivements)