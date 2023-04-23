DROP DATABASE IF EXISTS OperaCompany;
CREATE DATABASE OperaCompany; 
USE OperaCompany;

CREATE TABLE Work(
work_id INT NOT NULL PRIMARY KEY,
title VARCHAR(150) NOT NULL,
language VARCHAR(20) DEFAULT 'Italian', 
premiere_date DATE,
premiere_venue VARCHAR(150),
permiere_country VARCHAR(150));
CREATE TABLE Production(
production_id INT NOT NULL PRIMARY KEY,
title VARCHAR(150), 
director VARCHAR(50) NOT NULL,
premiere_date DATE,
language VARCHAR(20) DEFAULT 'Italian',
movement_director VARCHAR(50),
costume_designer VARCHAR(50),
set_designer VARCHAR(50),
lighting_designer VARCHAR(50),
surtitle_operator VARCHAR(50),
work_id INT NOT NULL,
FOREIGN KEY(work_id) REFERENCES Work(work_id) 
ON UPDATE CASCADE);
CREATE TABLE Dvd(
dvd_id INT NOT NULL PRIMARY KEY,
running_time INT DEFAULT 150, 
release_date DATE,
production_id INT NOT NULL,
FOREIGN KEY(production_id) REFERENCES Production(production_id)
ON UPDATE CASCADE);
CREATE TABLE Composer_of_Work(
work_id INT NOT NULL,
composer_fname VARCHAR(20) NOT NULL,
composer_lname VARCHAR(20) NOT NULL,
PRIMARY KEY(work_id,composer_fname,composer_lname),
FOREIGN KEY(work_id) REFERENCES Work(work_id)
ON UPDATE CASCADE);
CREATE TABLE Librettist_of_Work(
work_id INT NOT NULL,
librettist_fname VARCHAR(20) NOT NULL,
librettist_lname VARCHAR(20) NOT NULL,
PRIMARY KEY(work_id,librettist_fname,librettist_lname),
FOREIGN KEY(work_id) REFERENCES Work(work_id)
ON UPDATE CASCADE);
CREATE TABLE Role(
role_no INT NOT NULL PRIMARY KEY,
name VARCHAR(30) NOT NULL,
description VARCHAR(150),  
voice_type VARCHAR(15) NOT NULL CHECK (voice_type IN ('Soprano','Mezzo-soprano','Contralto',
'Countertenor','Tenor','Baritone','Bass')));
CREATE TABLE Solo_Artist(
artist_id INT NOT NULL PRIMARY KEY,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
phone_no VARCHAR(20) UNIQUE,
email VARCHAR(150) UNIQUE NOT NULL CHECK (email LIKE '%@%.%'),
bdate DATE,
voice_type VARCHAR(15) NOT NULL CHECK (voice_type IN ('Soprano','Mezzo-soprano','Contralto',
'Countertenor','Tenor','Baritone','Bass')));
CREATE TABLE Character_Cast(
role_no INT NOT NULL,
artist_id INT NOT NULL,
performer_type VARCHAR(15) CHECK (performer_type IN ('Principle','Cover')),
PRIMARY KEY(role_no, artist_id),
FOREIGN KEY(role_no) REFERENCES Role(role_no)
ON UPDATE CASCADE,
FOREIGN KEY(artist_id) REFERENCES Solo_Artist(artist_id)
ON UPDATE CASCADE);
CREATE TABLE Production_Roles(
production_id INT NOT NULL,
role_no INT NOT NULL,
PRIMARY KEY(production_id, role_no),
FOREIGN KEY(production_id) REFERENCES Production(production_id)
ON UPDATE CASCADE,
FOREIGN KEY(role_no) REFERENCES Role(role_no)
ON UPDATE CASCADE);
CREATE TABLE Performance(
performance_id INT NOT NULL PRIMARY KEY,
start_time VARCHAR(5) CHECK (start_time LIKE '__:__'),
date DATE,
production_id INT NOT NULL,
FOREIGN KEY(production_id) REFERENCES Production(production_id)
ON UPDATE CASCADE);

INSERT INTO Work VALUES(15353,'Aida','Italian','1871-12-24','Khedivial Opera House','Egypt');
INSERT INTO Work VALUES(15134,'The Elder Tree','English','2019-06-14','Cork Repertory Theater','Ireland');
INSERT INTO Work VALUES(15327,'Cosi fan tutte','Italian','1790-01-26','Burgtheater','Austria');  
INSERT INTO Work VALUES(13441,'Madama Butterfly','Italian','1904-02-17','La Scala','Italy');
INSERT INTO Work VALUES(16830,'Don Giovanni','Italian','1787-10-29','Estates Theatre','Czech Republic');
INSERT INTO Work VALUES(13762,'Lohengrin','German','1850-08-28','Deutsches Nationaltheater Weimar','Germany');

INSERT INTO Production VALUES(14245, 'Aida', 'Christopher Moore','2013-05-27','Italian','Tobias Schmidt','Anna Popescu','Svetlana Kuzmina','Ali Garcias','Conor Gleeson',15353);
INSERT INTO Production VALUES(16332,'The Elder Tree', 'Catherine Finn','2019-06-14','English', 'Maria Holt','Ellen Whittle','Svetlana Kuzmina','Celine Carolan','Franz Herbert',15134);
INSERT INTO Production VALUES(12149, 'Women are like that','Niall Hemming','2008-11-25','Enlgish','Katrin Hertha','Anton Petrov','Martin Corbin','Ella Burke','Conor Gleeson',15327);
INSERT INTO Production VALUES(11634,'Madama Butterfly', 'Christopher Moore', '2008-02-14','Italian','Gordon Jacob','Andre Derain','Jonathan Watkins','Tim Reid', 'Shane Austin',13441);
INSERT INTO Production VALUES(19304, 'Don Giovanni','Catherine Finn','2017-05-09','Italian','Maria Holt','Anna Popescu','Ciaran Bradley','Angela Anca','Judith Flynn',16830);
INSERT INTO Production VALUES(19752, 'Lohengrin','Martin Corbin','2020-01-18', 'German','Amy Santiago', 'Rosa Coffey', 'Svetlana Kuzmina', 'Maximilian Beel','Jane Hart',13762);

INSERT INTO Dvd VALUES(18475,150,'2013-06-15',14245);
INSERT INTO Dvd VALUES(15218,90,'2019-07-10',16332);
INSERT INTO Dvd VALUES(13889,180,'2008-12-20',12149);
INSERT INTO Dvd VALUES(16322,145,'2008-03-05',11634);
INSERT INTO Dvd VALUES(14298,223,'2017-05-22',19304);

INSERT INTO Composer_of_Work VALUES(15353,'Giuseppe','Verdi');
INSERT INTO Composer_of_Work VALUES(15134,'Catherine','Finn');
INSERT INTO Composer_of_Work VALUES(15134,'Andrew','Synett');
INSERT INTO Composer_of_Work VALUES(15327,'Wolfgang A.','Mozart');
INSERT INTO Composer_of_Work VALUES(13441,'Giacomo','Puccini');
INSERT INTO Composer_of_Work VALUES(16830,'Wolfgang A.','Mozart');
INSERT INTO Composer_of_Work VALUES(13762,'Richard','Wagner');

INSERT INTO Librettist_of_Work VALUES(15353,'Antonio','Ghislanzoni');
INSERT INTO Librettist_of_Work VALUES(15134,'Nina','Moran');
INSERT INTO Librettist_of_Work VALUES(15327,'Lorenzo','Da Ponte');
INSERT INTO Librettist_of_Work VALUES(13441,'Luigi','Illica');
INSERT INTO Librettist_of_Work VALUES(13441,'Giuseppe','Giacosa');
INSERT INTO Librettist_of_Work VALUES(16830,'Lorenzo','Da Ponte');
INSERT INTO Librettist_of_Work VALUES(13762,'Richard','Wagner');

INSERT INTO Role VALUES(31225, 'Aida', 'Ethiopian princess', 'Soprano');
INSERT INTO Role VALUES(31228, 'Niamh','Housekeeper','Contralto');
INSERT INTO Role VALUES(25258, 'Ferrando','Soldier','Tenor');
INSERT INTO Role VALUES(11760,'Cio-Cio-san','Former geisha','Soprano');
INSERT INTO Role VALUES(20482,'Don Giovanni','Young nobleman','Baritone');
INSERT INTO Role VALUES(15287,'Ortrud','Telramunds wife','Mezzo-soprano');

INSERT INTO Solo_Artist VALUES(16211,'Martina','Snow',00353879356731,'martinasnow1987@gmail.com','1987-05-20','Soprano');
INSERT INTO Solo_Artist VALUES(12867,'Suzanne','Pucl',003281942774,'puclsuzannemarie90@yahoo.com','1990-01-29','Contralto');
INSERT INTO Solo_Artist VALUES(11280,'Marin','Antonescu',00401864267,'antonescumarin1@gmail.com','1981-07-13','Tenor');
INSERT INTO Solo_Artist VALUES(28664,'Cecilia','Domenico',003519532562,'domenicocecilia82@gmail.com','1982-10-04','Soprano');
INSERT INTO Solo_Artist VALUES(31896,'Samuel','Theda',00469264768,'samuel75theda@yahoo.com','1975-09-21','Baritone');
INSERT INTO Solo_Artist VALUES(10769,'Caitlin','Nolan',003538654270,'nolancaitlin7@gmail.com','1987-08-01','Mezzo-soprano');

INSERT INTO Character_Cast VALUES(31225,16211,'Principle');
INSERT INTO Character_Cast VALUES(31228,12867,'Principle');
INSERT INTO Character_Cast VALUES(25258,11280,'Cover');
INSERT INTO Character_Cast VALUES(11760,28664,'Principle');
INSERT INTO Character_Cast VALUES(20482,31896,'Principle');
INSERT INTO Character_Cast VALUES(15287,10769,'Cover');

INSERT INTO Production_Roles VALUES(14245,31225);
INSERT INTO Production_Roles VALUES(16332,31228);
INSERT INTO Production_Roles VALUES(12149,25258);
INSERT INTO Production_Roles VALUES(11634,11760);
INSERT INTO Production_Roles VALUES(19304,20482);
INSERT INTO Production_Roles VALUES(19752,15287);

INSERT INTO Performance VALUES(10987,'18:30','2013-05-30',14245);
INSERT INTO Performance VALUES(19752,'19:00','2019-06-22',16332);
INSERT INTO Performance VALUES(27152,'18:00','2008-11-25',12149);
INSERT INTO Performance VALUES(19363,'17:30','2008-02-18',11634);
INSERT INTO Performance VALUES(12133,'18:30','2017-05-15',19304);
INSERT INTO Performance VALUES(12135,'19:00','2017-05-18',19304);


-- UPDATE Work
-- SET work_id = 123
-- WHERE work_id = 125;
-- Delete tuple with ... The tuple involved is referenced by tuples from other relations. 
-- Option to address delete/ update operations which violate Referential Integrity 
-- is to cascade/ set null/ set default. 
-- Default action in SQL is to reject the operation.

-- View which shows the titles of all the works that a composer created
CREATE VIEW Composer_Composition(lname, fname, work_title) AS
SELECT composer_lname, composer_fname, title
FROM Composer_of_Work, Work
WHERE Composer_of_Work.work_id = Work.work_id
ORDER BY composer_lname, title;

-- View which shows for each year, the amount of productions presented per year
CREATE VIEW Number_of_Productions_Yearly(year, amount) AS
SELECT Year(premiere_date), COUNT(production_id)
FROM Production
GROUP BY Year(premiere_date)
ORDER BY Year(premiere_date) DESC;

-- for each year, the titles of the productions presented in this year
-- CREATE VIEW Yearly_Productions (year, title) AS
-- SELECT Year(premiere_date), title
-- FROM Production
-- ORDER BY Year(premiere_date) DESC, title;

CREATE VIEW Yearly_Productions (year, title, number_in_year) AS
SELECT Year(premiere_date), title, COUNT(premiere_date) + 1
#(SELECT COUNT(*) + 1 FROM table inner WHERE inner.id < outer.id) AS row_number
FROM Production 
ORDER BY Year(premiere_date) DESC;

trigger when casting to ensure voice types match. If they dont, change the voice type of the role
-- so that they match
DELIMITER //
CREATE TRIGGER Casting_Voice_Types
AFTER INSERT ON Character_Cast
FOR EACH ROW
BEGIN
IF (SELECT voice_type FROM Solo_Artist
WHERE (NEW.artist_id = Solo_Artist.artist_id) != (SELECT voice_type FROM Role
WHERE NEW.role_id = Role.role_id))
THEN UPDATE Role
SET voice_type = (SELECT voice_type FROM Solo_Artist
WHERE NEW.artist_id = Solo_Artist.artist_id);
END IF;
END//
DELIMITER ;


-- trigger when inserting new Production with no title
DELIMITER //
CREATE TRIGGER Production_Title
AFTER INSERT ON Production
FOR EACH ROW
BEGIN
IF NEW.title IS NULL
THEN UPDATE Production
SET title = (SELECT Work.title 
FROM Work
WHERE Production.work_id = Work.work_id);
END IF;
END//
DELIMITER ;

-- trigger when inserting new dvd and its release date is before the premiere date of the production
DELIMITER //
CREATE TRIGGER Dvd_Date
AFTER INSERT ON Dvd
FOR EACH ROW
BEGIN
IF NEW.release_date > (SELECT premiere_date
FROM Production 
WHERE NEW.production_id = Production.production_id)
THEN UPDATE Dvd
SET release_date = NULL;
END IF;
END//
DELIMITER ;


-- trigger when deleting a solo artist with a principle role in a production 
-- DELIMITER //
-- CREATE TRIGGER Character_Cast_Change 
-- AFTER DELETE ON Solo_Artist 
-- FOR EACH ROW
-- BEGIN
-- IF OLD.artist_id = (SELECT artist_id FROM Character_Cast
-- WHERE perfomer_type = 'Principle')
-- THEN UPDATE Character_Cast
-- SET perfomer_type = 'Principle'
-- WHERE perfomer_type = 'Cover' AND role_no = (SELECT role_no FROM Character_Cast
-- WHERE OLD.artist_id = Character_Cast.artist_id);
-- END IF;
-- END //
-- DELIMITER ;

-- Trigger when updating or inserting a tuple in the production relation 
-- and the date of the production premiere and the work premiere are the same 
DELIMITER //
CREATE TRIGGER Premiere_of_Work_after_Update
AFTER UPDATE ON Production
FOR EACH ROW
BEGIN
CALL Premiere_of_Work(NEW.premiere_date, Production.work_id, Production.title);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Premiere_of_Work_after_Insert
AFTER INSERT ON Production
FOR EACH ROW
BEGIN
CALL Premiere_of_Work(NEW.premiere_date, Production.work_id, Production.title);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Premiere_of_Work(new_premiere_date DATE, production_title VARCHAR(255), production_work_id INT)
BEGIN
DECLARE work_premiere_date DATE;
SELECT premiere_date INTO work_premiere_date FROM Work
WHERE production_work_id = WORK.work_id;
IF YEAR(new_premiere_date) = YEAR(work_premiere_date)
THEN UPDATE Production
SET production_title = production_title || ' Premiere';
END IF;
END //
DELIMITER ;

