<h1>Database Project for Biblioteca de carti</h1>

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Application under test: Biblioteca de carti <br>
Tools used: MySQL Workbench

Database description: <b>Scopul acestei baze de date este de a gestiona și urmări informațiile legate de colecția de cărți a unei biblioteci și împrumuturile efectuate de membrii acesteia. Baza de date stochează informații despre cărți, autori, genuri, cititori ai bibliotecii și tranzacții de împrumut. Această structură permite bibliotecii să își gestioneze eficient inventarul, să urmărească disponibilitatea cărților și să păstreze evidențe detaliate despre cărțile împrumutate și de către cine.</b>


<ol>
<li>Database Schema</li>
<br>
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

The tables are connected in the following way:

<ul>
  <li> autori is connected with carti through a One-to-Many relationship which was implemented through autori.id as a primary key and carti.id_autor as a foreign key.</li>
  <li> genuri is connected with carti through a One-to-Many relationship which was implemented through genuri.id as a primary key and carti.id_gen as a foreign key.</li>
  <li> carti is connected with imprumuturi through a One-to-Many relationship which was implemented through carti.id as a primary key and imprumuturi.id_carte as a foreign key.</li>
  <li> cititori is connected with imprumuturi through a One-to-Many relationship which was implemented through cititori.id as a primary key and imprumuturi.id_cititor as a foreign key.</li>
</ul> <br> 

<li>Database Queries</li><br>

<ol type="a">
  <li>DDL (Data Definition Language)</li>

  The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)

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


  After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:

  ALTER TABLE genuri RENAME COLUMN nume_gen TO gen_carte;
  
  ALTER TABLE carti 
  ADD COLUMN pret DECIMAL(3,2) NOT NULL;

  ALTER TABLE cititori
  ADD COLUMN gen ENUM('M', 'F');

  ALTER TABLE carti 
  MODIFY COLUMN pret DECIMAL(10, 2);

  <li>DML (Data Manipulation Language)</li>

  In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data. 
  In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase. 

  Below you can find all the insert instructions that were created in the scope of this project:

  INSERT INTO genuri 
  VALUES (1, 'Fantasy'),
       (2, 'SF'),
       (3, 'Mistery'),
       (4, 'SF/Drama'),
       (5, 'Mystery/thriller');

  INSERT INTO autori (nume_autor, tara)
  VALUES ('J Rowling', 'United Kingdom'),
       ('Geeorge R.R. mARTIN', 'SUA'),
       ('J.R.R. Tolkien', 'United Kingdom'),
       ('Geroge Orwell', 'United Kingdom'),
       ('Stieg Larsson', 'Suedia');

  INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret)
  VALUES ('Harry Potter and the Philosophers Stone', 1, 1, 1997, 125.00);

  INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret)
  VALUES ('Game of Thrones', 2, 2, 1996, 90.00);

  INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret)
  VALUES ('The Hobbit', 3, 3, 1937, 100.00);

  INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret)
  VALUES ('1984', 4, 4, 1949, 45.00);

  INSERT INTO carti (titlu, id_autor, id_gen, an_publicare, pret)
  VALUES ('The Girl with the Dragon Tattoo', 5, 5, 2005, 65.00);

  INSERT INTO cititori (nume_prenume, gen, email, data_inregistrare)
  VALUES ('Maria Mirabela', 'F', 'maria_mirabela@yahoo.com', '2001-03-04'),
       ('Mihalache Ion', 'M', 'mihalache.ion@yahoo.com', '2004-05-18'),
       ('Dobre Alina', 'F', 'dobre_alina@gmail.com', '2005-07-15'),
       ('Dumitru Mihai', 'M', 'mihai_dumitru@yahoo.com', '1998-01-30'),
       ('Teodorescu Laura', 'F', 'laura.teo@gmail.com', '2020-02-28');

  INSERT INTO imprumuturi (id_carte, id_cititor, data_imprumut, data_returnare)
  VALUES (1, 4, '2023-06-01', '2023-06-15'),
       (2, 1, '2020-02-14', '2020-02-28'),
       (5, 2, '2006-05-12', '2020-05-26'),
       (4, 3, '2015-12-10', '2015-12-24'),
       (3, 5, '2018-06-06', '2018-06-20');

  After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:

  UPDATE imprumuturi 
  SET data_returnare = '2020-03-14' 
  WHERE id = 2;


  <li>DQL (Data Query Language)</li>

   After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean: 

   DELETE FROM imprumuturi 
   WHERE data_imprumut < '2020-02-14';

   In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

1. Select cu WHERE
SELECT * FROM carti 
WHERE an_publicare > 1990;

2. Select cu AND
SELECT * FROM carti 
WHERE id_gen = 1 AND an_publicare > 1990;

3. Select cu OR
SELECT * FROM carti 
WHERE id_gen = 3 OR id_autor = 4;

4. Select cu LIKE
SELECT * FROM cititori 
WHERE nume_prenume LIKE 'D%';

5. Inner Join
SELECT carti.titlu, autori.nume_autor, genuri.gen_carte
FROM carti 
INNER JOIN autori ON carti.id_autor = autori.id
INNER JOIN genuri ON carti.id_gen = genuri.id;

6. Left Join
SELECT cititori.nume_prenume, imprumuturi.data_imprumut
FROM cititoriLEFT JOIN imprumuturi ON cititori.id = imprumuturi.id;

7. Cross Join 
SELECT carti.titlu, cititori.nume_prenume
FROM carti
CROSS JOIN cititori;

8. Funcții agregate și GROUP BY
Numărul total de cărți:
SELECT COUNT(*) AS Total_carti 
FROM carti;
Prețul maxim al unei cărți:
SELECT MAX(pret) AS pret_maxim
FROM carti;
Numărul de autori din fiecare țară:
SELECT tara, COUNT(*) AS numar_autori
FROM autori
GROUP BY tara;

9. Subquery 
Găsirea ID-ului cititorului "Dobre Alina":
SELECT id
FROM cititori
WHERE nume_prenume = 'Dobre Alina';

Găsirea titlurilor cărților împrumutate de "Dobre Alina" folosind Subquery:
SELECT titlu
FROM carti
WHERE id IN (
    SELECT id_carte
    FROM imprumuturi
    WHERE id_cititor = (
        SELECT id
        FROM cititori
        WHERE nume_prenume = 'Dobre Alina'
    )
);

</ol>

<li>Conclusions</li>

În cadrul acestui proiect, am parcurs un ciclu complet de manipulare a unei baze de date relaționale, acoperind atât aspectele de definire și creare a tabelelor, cât și operațiunile de modificare și manipulare a datelor. Am învățat să folosesc instrucțiuni DDL (Data Definition Language) pentru a crea și modifica structura tabelelor, precum și instrucțiuni DML (Data Manipulation Language) pentru a insera, actualiza și șterge date.
Ce am învățat și realizat:
Crearea și modificarea tabelelor:

Am creat mai multe tabele, cum ar fi autori, genuri, carti, cititori, și imprumuturi, și am definit relațiile între acestea folosind chei primare și chei străine. Am utilizat instrucțiuni ALTER pentru a redenumi coloane, a adăuga noi coloane și a modifica proprietățile coloanelor existente.
Inserarea datelor:

Am folosit diverse metode de inserare a datelor în tabele, inclusiv inserarea mai multor rânduri în același timp și specificarea explicită a coloanelor. Aceasta m-a ajutat să înțeleg importanța corelării între datele din tabele diferite prin intermediul relațiilor definite.
Actualizarea și ștergerea datelor:

Am aplicat filtre cu WHERE pentru a actualiza și șterge doar acele rânduri care corespundeau unor condiții specifice. Aceasta m-a învățat să fiu precis în manipularea datelor pentru a evita modificările accidentale.
Interogarea bazei de date:

Am învățat să folosesc diverse tipuri de interogări SELECT, combinând filtre, funcții agregate, și operațiuni de unire a tabelelor (JOIN-uri). Am utilizat, de asemenea, subinterogări (subqueries) pentru a extrage informații mai complexe, consolidându-mi astfel abilitățile de a lucra cu date relaționale într-un mod eficient.
Relațiile dintre tabele:

Am realizat cât de importantă este definirea corectă a relațiilor dintre tabele pentru a menține integritatea datelor și a facilita interogările complexe. Am aplicat diferite tipuri de JOIN-uri pentru a aduce împreună informații din tabele diferite într-o manieră coerentă.
Concluzie:
Acest proiect mi-a oferit o înțelegere solidă a modului în care funcționează bazele de date relaționale și m-a învățat cum să gestionez eficient structura și datele unei baze de date. Am dobândit o perspectivă practică asupra creării și manipulării tabelelor, inserării și gestionării datelor, precum și utilizării avansate a interogărilor pentru a extrage informațiile dorite. Aceste abilități sunt esențiale pentru orice proiect care implică gestionarea datelor într-o bază de date relațională.

</ol>
