create database biblioteca_carti;
use biblioteca_carti;
drop database biblioteca_carti;

-- Instructiuni DDL
-- Crearea tabelelor
create table autori (
id int primary key auto_increment,
nume_autor varchar(50) not null,
tara varchar(30)
);

desc autori;

create table genuri (
id int primary key auto_increment,
nume_gen varchar(30)
);

desc genuri;

-- redenumire coloana in tabelul genuri
ALTER TABLE genuri RENAME COLUMN nume_gen TO gen_carte;


create table carti (
id int primary key auto_increment,
titlu varchar(100) not null,
id_autor int,
id_gen int,
an_publicare year,
foreign key (id_autor) references autori(id),
foreign key (id_gen) references genuri(id)
);

desc carti;

-- adaugare coloana pret in tabelul carti
alter table carti 
add column pret decimal(3,2) not null;

create table cititori (
id int primary key auto_increment,
nume_prenume varchar(50) not null,
email varchar(100) not null unique,
data_inregistrare date not null
);

desc cititori;

-- adaugare coloana gen in tabelul cititori
alter table cititori
add column gen enum ("M", "F");

create table imprumuturi (
 id int primary key auto_increment,
 id_carte int,
 id_cititor int,
 data_imprumut date not null,
 data_returnare date,
 foreign key (id_carte) references carti(id),
 foreign key (id_cititor) references cititori(id)
);

desc imprumuturi;

SET SQL_SAFE_UPDATES=0; 

-- Instructiuni DML - inserarea datelor
-- inserare date in tabelul autori
insert into autori (nume_autor, tara)
values ('J Rowling', 'United Kingdom'),
('Geeorge R.R. mARTIN', 'SUA'),
('J.R.R. Tolkien', 'United Kingdom'),
('Geroge Orwell', 'United Kingdom'),
('Stieg Larsson', 'Suedia');

desc autori;
select * from autori;

-- inserare date in tabelul genuri
insert into genuri (gen_carte)
values ('Fantasy'),
('SF'),
('Mistery'),
('SF/Drama'),
('Mystery/thriller');

desc genuri;
select * from genuri;

-- inserare date in tabelul carti 
insert into carti (titlu, id_autor, id_gen, an_publicare, pret)
values ('Harry Potter and the Philosophers Stone', 1, 1, 1997, 125),
('Game of Thrones', 2, 2, 1996, 90),
('The Hobbit', 3,3, 1937, 100),
('1984', 4, 4, 1949, 45),
('The Girl with the Dragon Tattoo', 5, 5, 2005, 65);

select * from carti;

-- modificare coloana pret in tabelul carti
ALTER TABLE carti MODIFY COLUMN pret DECIMAL(10, 2);

-- inserare in tabelul cititori
insert into cititori (nume_prenume, gen, email, data_inregistrare)
values ('Maria Mirabela', "F", 'maria_mirabela@yahoo.com', '2001-03-04'),
('Mihalache Ion', "M", 'mihalache.ion@yahoo.com', '2004-05-18'),
('Dobre Alina', "F", 'dobre_alina@gmail.com', '2005-07-15'),
('Dumitru Mihai', "M", 'mihai_dumitru@yahoo.com', '1998-01-30'),
('Teodorescu Laura', "F", 'laura.teo@gmail.com', '2020-02-28');

desc cititori;
select * from cititori;

-- inserare in tabelul imprumuturi
insert into imprumuturi (id_carte, id_cititor, data_imprumut, data_returnare)
values (1, 4, '2023-06-01', '2023-06-15'),
(2, 1, '2020-02-14', '2020-02-28'),
(5, 2, '2006-05-12', '2020-05-26'),
(4, 3, '2015-12-10', '2015-12-24'),
(3, 5, '2018-06-06', '2018-06-20');

desc imprumuturi;
select * from imprumuturi;

-- stergere imprumuturi vechi 
delete from imprumuturi where data_imprumut < '2020-02-14';

-- Ștergerea tabelului genuri
drop table genuri;

-- actualizare data de returnare pentru un imprumut
update imprumuturi set data_returnare = '2020-03-14' where id= 2;

-- truncate, stergerea tuturor rândurilor din tabelul imprumuturi, păstrând structura tabelului
truncate table imprumuturi;

-- Instructiuni DQL
-- selectarea titlurilor si anilor de publicare ale cartilor
select titlu, an_publicare from carti;

-- filtrare cu where
-- selectarea cartilor publicate dupa anul 1990
select * from carti where an_publicare > 1990;

-- filtrare cu like
-- selectarea cititorilor al caror nume incepe cu 'D'
select * from cititori where nume_prenume like 'D%';

-- filatrare cu AND si OR 
-- selectarea cartilor de fantasy publicate dupa anul 1990
select * from carti where id_gen = 1 and an_publicare > 1990;
-- selectarea cartilor de mistery sau scrise de George Orwell
select * from carti where id_gen=3 or id_autor=4;

-- Functii agregate 
-- numarul total de carti 
select count(*) as Total_carti from carti;
-- filtrare cu functii agregate, pret maxim al unei carti
select max(pret) as pret_maxim
from carti;
-- numarul de autori din fiecare tara
select tara, count(*) as numar_autori
from autori
group by tara;

-- JOINURI
-- inner join: selectarea cartilor si autorilor lor
select carti.titlu, autori.nume_autor, genuri.gen_carte
from carti 
inner join autori on carti.id_autor = autori.id
inner join genuri on carti.id_gen = genuri.id;

-- Left Join: Selectarea tuturor cititorilor și împrumuturilor lor
select cititori.nume_prenume, imprumuturi.data_imprumut
from cititori
left join imprumuturi on cititori.id = imprumuturi.id;

-- Cross Join: Toate combinațiile posibile de cărți și membri
select carti.titlu, cititori.nume_prenume
from carti
cross join cititori;

-- limit si order by
-- toate cartile ordonate crescator dupa anul de publicare 
 select * from carti
 order by an_publicare asc
 limit 5;
 -- toate cartile ordonate descrescator dupa pret
 select * from carti
 order by pret desc
 limit 5;
 
-- subquery pentru a gasi id-ul cititorului "Dobre Alina"
SELECT id
FROM cititori
WHERE nume_prenume = 'Dobre Alina';
-- interogarea principală pentru a găsi titlurile cărților împrumutate de acest cititor:
select titlu
from carti
where id in (
    select id_carte
    from imprumuturi
    where id_cititor = (
        select id
        from cititori
        where nume_prenume = 'Dobre Alina'
    )
);












