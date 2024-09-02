<h1>Database Project for Biblioteca de carti</h1>
The scope of this project is to use all the SQL knowledge gained through the Software Testing course and apply it in practice.

<b>Application under test</b>: Biblioteca de carti <br>
<b>Tools used</b>: MySQL Workbench

<b>Database Description</b>
The purpose of this database is to manage and track information related to a library's book collection and the loans made by its members. The database stores information about carti (books), autori (authors), genuri (genres), cititori (readers), and imprumuturi (loans). This structure allows the library to efficiently manage its inventory, track the availability of books, and keep detailed records about which books have been borrowed and by whom.

<b>Database Schema</b><br>
Below you can find the database schema that was generated through Reverse Engineering, which contains all the tables and the relationships between them. The tables are connected in the following way:
<ul>
<li>autori is connected with carti through a One-to-Many relationship, which was implemented through autori.id as a primary key and carti.id_autor as a foreign key.</li> 
<li>genuri is connected with carti through a One-to-Many relationship, which was implemented through genuri.id as a primary key and carti.id_gen as a foreign key.</li>
<li>carti is connected with imprumuturi through a One-to-Many relationship, which was implemented through carti.id as a primary key and imprumuturi.id_carte as a foreign key.</li>
<li>cititori is connected with imprumuturi through a One-to-Many relationship, which was implemented through cititori.id as a primary key and imprumuturi.id_cititor as a foreign key.</li>
</ul>

<b>Database Queries</b><br>
<b>DDL (Data Definition Language)</b> <br>
The following instructions were written for creating the structure of the database:

CREATE DATABASE biblioteca_carti;

USE biblioteca_carti;

CREATE TABLE autori ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    nume_autor VARCHAR(50) NOT NULL, 
    tara VARCHAR(30) 
);

CREATE TABLE genuri ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    gen_carte VARCHAR(30) 
);

CREATE TABLE carti ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    titlu VARCHAR(100) NOT NULL, 
    id_autor INT, 
    id_gen INT, 
    an_publicare YEAR, 
    pret DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (id_autor) REFERENCES autori(id), 
    FOREIGN KEY (id_gen) REFERENCES genuri(id) 
);

CREATE TABLE cititori ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    nume_prenume VARCHAR(50) NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE, 
    data_inregistrare DATE NOT NULL, 
    gen ENUM('M', 'F') 
);

CREATE TABLE imprumuturi ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    id_carte INT, 
    id_cititor INT, 
    data_imprumut DATE NOT NULL, 
    data_returnare DATE, 
    FOREIGN KEY (id_carte) REFERENCES carti(id), 
    FOREIGN KEY (id_cititor) REFERENCES cititori(id) 
);

After the database and tables were created, a few ALTER instructions were written to update the structure as described below:

ALTER TABLE genuri RENAME COLUMN nume_gen TO gen_carte;

ALTER TABLE carti ADD COLUMN pret DECIMAL(3,2) NOT NULL;

ALTER TABLE cititori ADD COLUMN gen ENUM('M', 'F');

ALTER TABLE carti MODIFY COLUMN pret DECIMAL(10, 2);

<b> DML (Data Manipulation Language)</b><br>
To use the database, I populated the tables with various data necessary to perform queries and manipulate the data. In the testing process, this data is identified during the Test Design phase and created in the Test Implementation phase.

Below are all the insert instructions created for this project:

INSERT INTO genuri VALUES 
(1, 'Fantasy'), 
(2, 'SF'), 
(3, 'Mistery'), 
(4, 'SF/Drama'), 
(5, 'Mystery/thriller')

INSERT INTO autori (nume_autor, tara) VALUES 
('J Rowling', 'United Kingdom'), 
('Geeorge R.R. Martin', 'SUA'), 
('J.R.R. Tolkien', 'United Kingdom'), 
('George Orwell', 'United Kingdom'), 
('Stieg Larsson', 'Suedia');

INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret) VALUES 
('Harry Potter and the Philosophers Stone', 1, 1, 1997, 125.00), 
('Game of Thrones', 2, 2, 1996, 90.00), 
('The Hobbit', 3, 3, 1937, 100.00), 
('1984', 4, 4, 1949, 45.00), 
('The Girl with the Dragon Tattoo', 5, 5, 2005, 65.00);

INSERT INTO cititori (nume_prenume, gen, email, data_inregistrare) VALUES 
('Maria Mirabela', 'F', 'maria_mirabela@yahoo.com', '2001-03-04'), 
('Mihalache Ion', 'M', 'mihalache.ion@yahoo.com', '2004-05-18'), 
('Dobre Alina', 'F', 'dobre_alina@gmail.com', '2005-07-15'), 
('Dumitru Mihai', 'M', 'mihai_dumitru@yahoo.com', '1998-01-30'), 
('Teodorescu Laura', 'F', 'laura.teo@gmail.com', '2020-02-28');

INSERT INTO imprumuturi (id_carte, id_cititor, data_imprumut, data_returnare) VALUES 
(1, 4, '2023-06-01', '2023-06-15'), 
(2, 1, '2020-02-14', '2020-02-28'), 
(5, 2, '2006-05-12', '2020-05-26'), 
(4, 3, '2015-12-10', '2015-12-24'), 
(3, 5, '2018-06-06', '2018-06-20');

After the inserts, to better prepare the data for testing, I updated some data as follows:

UPDATE imprumuturi SET data_returnare = '2020-03-14' WHERE id = 2;

<b>DQL (Data Query Language)</b> <br>
After the testing process, I deleted the data that was no longer relevant to keep the database cleanL

DELETE FROM imprumuturi WHERE data_imprumut < '2020-02-14';

To simulate various real-life scenarios, I created the following queries:
<ul>
<li>Select with WHERE:</li>
SELECT * FROM carti WHERE an_publicare > 1990;
<li>Select with AND:</li>
SELECT * FROM carti WHERE id_gen = 1 AND an_publicare > 1990;
<li>Select with OR:</li>
SELECT * FROM carti WHERE id_gen = 3 OR id_autor = 4;
<li>Select with LIKE:</li>
SELECT * FROM cititori WHERE nume_prenume LIKE 'D%';
<li>Inner Join:</li>
SELECT carti.titlu, autori.nume_autor, genuri.gen_carte 
FROM carti 
INNER JOIN autori ON carti.id_autor = autori.id 
INNER JOIN genuri ON carti.id_gen = genuri.id;




