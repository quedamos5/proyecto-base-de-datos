-- Usando la base de datos steam
use steam;
go
-- 1. Lista todas las columnas de la tabla.
select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'juegos';
go
-- 2. Lista todos los diferentes géneros, eliminando duplicados.
select distinct CAST(Genre as varchar(1000)) as Genero
from juegos;
go
-- 3. Lista únicamente aquellos juegos que puedan ser jugados únicamente en Linux
select Nombre, PlatformLinux, PlatformMac, PlatformWindows
from juegos
where PlatformLinux like 'True' and PlatformMac like 'False' and PlatformWindows like 'False';
go
-- 4.Lista todos los juegos de rol, ordenador por nota.
select CAST(Nombre as varchar(1000)) as Nombre, Metacritic
from juegos
where Genre like '%RPG%'
order by Metacritic desc;
go
-- 5.Lista todos aquellos juegos que puedan ser jugados en Español pero no en Frances
select Nombre, SupportedLanguages
from juegos
where SupportedLanguages not like '%French%' and SupportedLanguages like '%Spanish%';
go
-- 6.Lista el nombre del juego, su precio inicial, su precio final y la diferencia entre ambos en una nueva columna.
select Nombre, PriceInitial, PriceFinal, (PriceInitial - PriceFinal) as Diferencia
from juegos
order by Diferencia desc;
go
-- 7.¿Cuántos juegos hay del siglo pasado?
select CAST(Nombre as varchar(1000)) as Nombre, ReleaseDate  
from juegos
where ReleaseDate like '[^2]%';
go
-- 8.Devuelve todos los juegos que terminen o en N o en O.
-- 9.Devuelve todos los juegos que empiecen por A y que se puedan jugar con mando.
-- 10.Devuelve todos aquellos juegos que estén entre el 2000 y el 2010.
-- 11.Devuelve todos los juegos que sean de la saga Final Fantasy.
-- 12.Devuelve todos los juegos que sean de deportes y haya trabajado más de 3 desarrolladores.
-- 13.¿Cuántos juegos hay asociados a cada categoría?
-- 14.¿Cuántos juegos se han sacado en cada año?
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
