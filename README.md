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

