/*
 * 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

CREATE DATABASE human_friends;


/*
 * 8. Создать таблицы с иерархией из диаграммы в БД
 * * * * * * * * * * * * * * * * * * * * * * * * * */
USE human_friends;
CREATE TABLE animal_classes
(
		id int AUTO_INCREMENT PRIMARY KEY,
		class_name varchar(30)
);

INSERT INTO animal_classes (class_name)
VALUES ('домашние'), ('вьючные');

-- --------------------------------------

CREATE TABLE home_animals
(
		id int AUTO_INCREMENT PRIMARY KEY,
		type_name varchar(30),
		class_id int,
		FOREIGN KEY (class_id) REFERENCES animal_classes(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO home_animals  (type_name, class_id)
VALUES	('Собака', 1),('Кошка', 1),('Хомяк', 1);

-- --------------------------------------

CREATE TABLE pack_animals
(
		id int AUTO_INCREMENT PRIMARY KEY,
		type_name varchar(30),
		class_id int,
		FOREIGN KEY (class_id) REFERENCES animal_classes (id) ON DELETE CASCADE ON UPDATE CASCADE 
);

INSERT INTO pack_animals (type_name, class_id)
VALUES	('Лошадь', 2),('Верблюд', 2),('Осел', 2);



/*
 * 9. Заполнить низкоуровневые таблицы именами(животных),
 *    командами которые они выполняют и датами рождения
 * * * * * * * * * * * * * * * * * * * * * * * * * * * */

CREATE TABLE dogs
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES home_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO dogs (name, birthday, commands, type_id)
VALUES ('Шарик', '2019-02-11', 'голос', 1),
('Бим', '2021-03-12', 'сидеть, лежать, дай лапу', 1),  
('Рекс', '2018-06-01', 'лежать', 1), 
('Джесика', '2021-05-09', 'взять', 1);

-- ----------------------------------------

CREATE TABLE cats
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES home_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO cats (name, birthday, commands, type_id)
VALUES ('Килька', '2020-01-10', 'кис-кис', 2),
('Карась', '2022-05-10', 'брысь', 2),  
('Шпрот', '2011-05-09', 'мур-мур', 2);

-- ----------------------------------------

CREATE TABLE hamsters
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES home_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO hamsters (name, birthday, commands, type_id)
VALUES ('Тюлень', '2021-08-11', '', 3),
('Пельмень', '2020-03-12', '', 3),  
('Зайка', '2022-04-01', '', 3), 
('Бэтмэн', '2021-01-09', '', 3);

-- ----------------------------------------

CREATE TABLE horses
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO horses (name, birthday, commands, type_id)
VALUES ('Флешка', '2020-01-12', 'барьер, на тумбу, вольт, пируэт, кругом, вверх, гох', 1),
('Буксир', '2017-03-12', 'но, бррр', 1),  
('Плотва', '2016-07-12', 'но, пошла, стой', 1);

-- ----------------------------------------

CREATE TABLE camels
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO camels (name, birthday, commands, type_id)
VALUES ('Олень', '2016-02-11', 'оп-оп, бррр', 2),
('Зина', '2014-03-11', 'бррр', 2),  
('Пароход', '2015-03-11', '', 2);

-- ----------------------------------------

CREATE TABLE donkeys
(
		id int AUTO_INCREMENT PRIMARY KEY,
		name varchar(30),
		birthday date,
		commands varchar(200),
		type_id int,
		FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO donkeys (name, birthday, commands, type_id)
VALUES ('Дэнди', '2012-02-01', '', 3),
('Джо', '2017-03-12', '', 3),  
('Дональд', '2011-07-10', '', 3);

/*
 * 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
 *     питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


DELETE FROM camels;

CREATE TABLE united_pack
SELECT * FROM horses h 
UNION 
SELECT * FROM donkeys d ;

/*
 * 11.Создать новую таблицу “молодые животные” в которую попадут все
 *    животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
 *    до месяца подсчитать возраст животных в новой таблице
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

CREATE TABLE young_animal (
	id int AUTO_INCREMENT PRIMARY KEY,
	name varchar(30),
    commands varchar(200),
    birthday DATE,
    age text
);

DELIMITER //
CREATE FUNCTION count_age (birthday DATE)
RETURNS text
DETERMINISTIC
BEGIN
    DECLARE res text DEFAULT '';
	SET res = CONCAT(
            TIMESTAMPDIFF(YEAR, birthday, CURDATE()),
            ' years ',
            TIMESTAMPDIFF(MONTH, birthday, CURDATE()) % 12,
            ' month'
        );
	RETURN res;
END//
DELIMITER ;

INSERT INTO young_animal (name, commands, birthday, age)
SELECT name, commands, birthday, count_age(birthday)
FROM cats
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT name, commands, birthday, count_age(birthday)
FROM dogs
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT name, commands, birthday, count_age(birthday)
FROM hamsters
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT name, commands, birthday, count_age(birthday)
FROM united_pack
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) BETWEEN 1 AND 3;




/*
 * 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
 *     прошлую принадлежность к старым таблицам.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

CREATE TABLE united_animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name varchar(30),
    commands TEXT,
    birthday DATE,
    age TEXT,
    animal_type ENUM('cat','dog','hamster', 'pack_animals', 'young_animals') NOT NULL
);

INSERT INTO animals (name, commands, birthday, age, animal_type)
SELECT name, commands, birthday, count_age(birthday), 'cat'
FROM cats;

INSERT INTO animals (name, commands, birthday, age, animal_type)
SELECT name, commands, birthday, count_age(birthday), 'dog'
FROM dogs ;

INSERT INTO animals (name, commands, birthday, age, animal_type)
SELECT name, commands, birthday, count_age(birthday), 'hamster'
FROM hamsters ;

INSERT INTO animals (name, commands, birthday, age, animal_type)
SELECT name, commands, birthday, count_age(birthday), 'pack_animals'
FROM pack_animals ;

INSERT INTO animals (name, commands, birthday, age, animal_type)
SELECT name, commands, birthday, count_age(birthday), 'young_animals'
FROM young_animal;

