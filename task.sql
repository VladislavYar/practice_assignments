/*
Задание: 1
Найдите номер модели, скорость
и размер жесткого диска для всех ПК
стоимостью менее 500 дол. Вывести: model, speed и hd
*/
SELECT model, speed, hd FROM PC WHERE price < 500

/*
Задание: 2
Найдите производителей принтеров. Вывести: maker
*/
SELECT DISTINCT maker FROM Product WHERE type = 'Printer'

/*
Задание: 3
Найдите номер модели, объем памяти и размеры
экранов ПК-блокнотов, цена которых превышает 1000 дол.
*/
SELECT model, ram, screen FROM laptop WHERE price > 1000

/*
Задание: 4
Найдите все записи таблицы Printer для цветных принтеров.
*/
SELECT * FROM printer WHERE color = 'y'

/*
Задание: 5
Найдите номер модели, скорость и размер
жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
*/
SELECT model, speed, hd FROM PC WHERE (cd = '12x' OR cd = '24x') AND price < 600

/*
Задание: 6
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска
не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
*/
SELECT DISTINCT Product.maker, Laptop.speed
FROM Product 
INNER JOIN Laptop
   ON Product.model = Laptop.model
WHERE Laptop.hd >= 10

/*
Задание: 7
Найдите номера моделей и цены всех
имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
*/
SELECT DISTINCT Product.model, laptop.price
FROM Product 
INNER JOIN Laptop
   ON Product.model = Laptop.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Product.model, PC.price
FROM Product 
INNER JOIN PC
   ON Product.model = PC.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT Product.model, Printer.price
FROM Product 
INNER JOIN Printer
   ON Product.model = Printer.model
WHERE Product.maker = 'B'

/*
Задание: 8
Найдите производителя, выпускающего ПК, но не ПК-блокноты.
*/
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC'
EXCEPT
SELECT DISTINCT maker
FROM Product
WHERE type = 'Laptop'

/*
Задание: 9
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
*/
SELECT DISTINCT Product.maker
FROM Product
INNER JOIN PC
  ON Product.model = PC.model
WHERE PC.speed >= 450

/*
Задание: 10
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
*/
SELECT DISTINCT model, price
FROM Printer
WHERE price = (SELECT MAX(price) 
 FROM Printer
 )

/*
Задание: 11
Найдите среднюю скорость ПК.
*/
SELECT AVG(speed)
FROM PC

/*
Задание: 12
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
*/
SELECT AVG(speed)
FROM Laptop
WHERE price > 1000

/*
Задание: 13
Найдите среднюю скорость ПК, выпущенных производителем A.
*/
SELECT AVG(PC.speed)
FROM PC
INNER JOIN Product
  ON PC.model = Product.model
WHERE Product.maker = 'A'

/*
Задание: 14
Найдите класс, имя и страну для кораблей 
из таблицы Ships, имеющих не менее 10 орудий.
*/
SELECT Ships.class, Ships.name, Classes.country
FROM Ships
INNER JOIN Classes 
  ON Ships.class = Classes.class
WHERE Classes.numGuns >= 10

/*
Задание: 15
Найдите размеры жестких дисков, 
совпадающих у двух и более PC. Вывести: HD
*/
SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >= 2

/*
Задание: 16
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. 
В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), 
Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
*/
SELECT DISTINCT PC1.model, PC2.model, PC1.speed, PC1.ram
FROM PC AS PC1, PC AS PC2
WHERE PC1.speed = PC2.speed AND PC1.ram = PC2.ram AND PC1.model > PC2.model

/*
Задание: 17
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed
*/
SELECT DISTINCT Product.type, Laptop.model, Laptop.speed
FROM Laptop
INNER JOIN Product
 ON Product.model = Laptop.model
WHERE Laptop.speed < (SELECT MIN(speed) FROM PC)

/*
Задание: 18
Найдите производителей самых дешевых цветных принтеров. 
Вывести: maker, price
*/
SELECT DISTINCT Product.maker, Printer.price
FROM Product
INNER JOIN Printer
  ON Product.model = Printer.model
WHERE Printer.color = 'y' AND Printer.price = (SELECT MIN(price)
                                               FROM Printer
                                               WHERE Printer.color = 'y')

/*
Задание: 19
Для каждого производителя, имеющего модели в 
таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.
*/
SELECT Product.maker, AVG(Laptop.screen) AS avg
FROM Product
INNER JOIN Laptop
  ON Laptop.model = Product.model
GROUP BY Product.maker

/*
Задание: 20
Найдите производителей, выпускающих 
по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
*/
SELECT maker, COUNT(type)
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(type) >= 3

/*
Задание: 21
Найдите максимальную цену ПК, выпускаемых 
каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.
*/
SELECT Product.maker, MAX(PC.price)
FROM Product
INNER JOIN PC
  ON PC.model = Product.model
GROUP BY Product.maker

/*
Задание: 22
Для каждого значения скорости ПК, 
превышающего 600 МГц, определите среднюю цену 
ПК с такой же скоростью. Вывести: speed, средняя цена.
*/
SELECT speed, AVG(price)
FROM PC
WHERE speed > 600
GROUP BY speed

/*
Задание: 23
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты 
со скоростью не менее 750 МГц. Вывести: Maker
*/
SELECT DISTINCT Product.maker
FROM Product  
INNER JOIN PC 
  ON Product.model = PC.model
WHERE PC.speed >= 750 AND maker IN (SELECT Product.maker
FROM Product 
INNER JOIN Laptop 
  ON Product.model = Laptop.model
WHERE Laptop.speed >= 750)

/*
Задание: 24
Перечислите номера моделей любых типов,
имеющих самую высокую цену по всей имеющейся в базе данных продукции.
*/
WITH max_price AS (
SELECT PC.model, PC.price
FROM PC
INNER JOIN Product
  ON PC.model = Product.model

UNION

SELECT Laptop.model, Laptop.price
FROM Laptop
INNER JOIN Product
  ON Laptop.model = Product.model

UNION

SELECT Printer.model, Printer.price
FROM Printer
INNER JOIN Product
  ON Printer.model = Product.model)

SELECT model
FROM max_price
WHERE price = (SELECT MAX(price) FROM max_price)

/*
Задание: 25
Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
*/
SELECT DISTINCT maker
FROM Product
WHERE model IN (SELECT model
                FROM PC
                WHERE ram = (SELECT MIN(ram) FROM PC) AND
                      speed = (SELECT MAX(speed) 
                               FROM PC
                               WHERE ram = (SELECT MIN(ram)
                                            FROM PC)
                               )
                ) AND
      maker IN (SELECT maker
                FROM Product
                WHERE type='Printer'
                )

/*
Задание: 26
Найдите среднюю цену ПК и ПК-блокнотов, 
выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.
*/
WITH avg_price AS (  
  SELECT PC.price
  FROM PC
  INNER JOIN Product
  ON Product.model = PC.model
  WHERE maker = 'A' 

  UNION ALL

  SELECT Laptop.price
  FROM Laptop
  INNER JOIN Product
  ON Product.model = Laptop.model 
  WHERE maker = 'A'
 )

SELECT AVG(price)
FROM avg_price

/*
Задание: 27
Найдите средний размер диска
ПК каждого из тех производителей, 
которые выпускают и принтеры. Вывести: maker, средний размер HD.
*/
SELECT Product.maker, AVG(PC.hd)
FROM PC
INNER JOIN Product
 ON Product.model = PC.model
WHERE Product.maker IN (SELECT maker
                        FROM Product
                        WHERE type = 'Printer')
GROUP BY Product.maker

/*
Задание: 28
Используя таблицу Product, 
определить количество производителей, выпускающих по одной модели.
*/
SELECT COUNT(maker)
FROM Product
WHERE maker IN(SELECT maker 
               FROM Product
               GROUP BY maker
               HAVING COUNT(model) = 1
               )

/*
Задание: 29
В предположении, что приход и расход денег на каждом 
пункте приема фиксируется не чаще одного раза в день 
[т.е. первичный ключ (пункт, дата)], написать запрос 
с выходными данными (пункт, дата, приход, расход). 
Использовать таблицы Income_o и Outcome_o.
*/
SELECT Income_o.point, Income_o.date, Income_o.inc, Outcome_o.out
FROM Income_o
LEFT JOIN Outcome_o 
  ON Income_o.point = Outcome_o.point AND Income_o.date = Outcome_o.date

UNION

SELECT Outcome_o.point, Outcome_o.date, Income_o.inc, Outcome_o.out
FROM Income_o RIGHT JOIN Outcome_o
  ON Income_o.point = Outcome_o.point AND Income_o.date = Outcome_o.date

/*
Задание: 30
В предположении, что приход и расход денег на каждом пункте приема 
фиксируется произвольное число раз (первичным ключом в таблицах 
является столбец code), требуется получить таблицу, в которой 
каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), 
суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).
*/
SELECT point, date, SUM(sum_out) AS sum_out, SUM(sum_inc) AS sum_inc
FROM (SELECT point, date, SUM(inc) AS sum_inc, NULL AS sum_out
      FROM Income 
      GROUP BY point, date

       UNION

       SELECT point, date, NULL AS sum_inc, SUM(out) AS sum_out 
       FROM Outcome 
       GROUP BY point, date ) AS new_inc_out
GROUP BY point, date 
ORDER BY point

/*
Задание: 31
Для классов кораблей, калибр орудий которых 
не менее 16 дюймов, укажите класс и страну.
*/
SELECT class, country
FROM Classes
WHERE bore >= 16

/*
Задание: 32
Одной из характеристик корабля является половина куба калибра его 
главных орудий (mw). С точностью до 2 десятичных знаков определите 
среднее значение mw для кораблей каждой страны, у которой есть корабли в базе данных.
*/
SELECT country, CAST(AVG((POWER(bore,3)/2)) AS NUMERIC(6,2))
FROM (SELECT Classes.country, Classes.class, Classes.bore, Ships.name 
      FROM Classes 
      LEFT JOIN Ships 
      ON Classes.class = Ships.class

      UNION ALL

      SELECT DISTINCT Classes.country, Classes.class, Classes.bore, 
                      Outcomes.ship 
      FROM Classes 
      LEFT JOIN Outcomes
      ON Classes.class = Outcomes.ship
      WHERE Outcomes.ship = Classes.class AND
                            Outcomes.ship NOT IN (SELECT name FROM Ships)) AS 
                                                                    new_table
WHERE name IS NOT NULL 
GROUP BY country

/*
Задание: 33
Укажите корабли, потопленные в сражениях 
в Северной Атлантике (North Atlantic). Вывод: ship.
*/
SELECT ship
FROM Outcomes
WHERE battle = 'North Atlantic' AND result = 'sunk'

/*
Задание: 34
По Вашингтонскому международному договору от начала 1922 г. 
запрещалось строить линейные корабли водоизмещением более 
35 тыс.тонн. Укажите корабли, нарушившие этот договор 
(учитывать только корабли c известным годом спуска на воду). 
Вывести названия кораблей.
*/
SELECT name
FROM Ships
JOIN Classes
  ON Classes.class = Ships.class
WHERE Classes.displacement > 35000 AND Classes.type = 'bb' AND Ships.launched >= 1922

/*
Задание: 35
В таблице Product найти модели, 
которые состоят только из цифр 
или только из латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели.
*/
SELECT model, type
FROM Product
WHERE UPPER(model) NOT LIKE '%[^A-Z]%' OR model NOT LIKE '%[^0-9]%'

/*
Задание: 36
Перечислите названия головных кораблей, 
имеющихся в базе данных (учесть корабли в Outcomes).
*/
SELECT Classes.class
FROM Classes
INNER JOIN Ships
  ON Classes.class = Ships.class
WHERE Classes.class = Ships.name

UNION

SELECT Classes.class
FROM Classes
INNER JOIN Outcomes
  ON Classes.class = Outcomes.ship

/*
Задание: 37
Найдите классы, в которые входит только 
один корабль из базы данных (учесть также корабли в Outcomes).
*/
SELECT class
FROM (SELECT Classes.class, Ships.name
      FROM Classes
      JOIN Ships
        ON Classes.class = Ships.class

      UNION

      SELECT Classes.class, Outcomes.ship
      FROM Classes
      JOIN Outcomes
        ON Classes.class = Outcomes.ship
      ) AS new_table
GROUP BY class
HAVING COUNT(name) = 1

/*
Задание: 38
Найдите страны, имевшие когда-либо классы
обычных боевых кораблей ('bb') 
и имевшие когда-либо классы крейсеров ('bc').
*/
SELECT country
FROM Classes
WHERE type = 'bb'

INTERSECT

SELECT country
FROM Classes
WHERE type = 'bc'

/*
Задание: 39
Найдите корабли, `сохранившиеся для будущих сражений`; т.е. 
выведенные из строя в одной битве (damaged), 
они участвовали в другой, произошедшей позже.
*/
WITH new_table AS (SELECT Outcomes.ship, Battles.date, 
                   Outcomes.result
                   FROM Outcomes
                   LEFT JOIN Battles 
                   ON Outcomes.battle = Battles.name)

SELECT DISTINCT table_1.ship 
FROM new_table AS table_1
WHERE table_1.ship IN (SELECT ship
                       FROM new_table AS table_2
                       WHERE table_2.date < table_1.date AND 
                       table_2.result = 'damaged')

/*
Задание: 40
Найти производителей, которые выпускают 
более одной модели, при этом все выпускаемые 
производителем модели являются продуктами одного типа.
Вывести: maker, type
*/
SELECT maker, MAX(type) AS type
FROM Product
GROUP BY maker
HAVING COUNT(model) > 1 AND COUNT(DISTINCT type) = 1


