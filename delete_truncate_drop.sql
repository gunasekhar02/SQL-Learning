
--Truncate/ drop / Delete

create database temp;

use  temp;

create table products(pid int identity (1,1) primary key, pname varchar(30) not null, price int);

insert into products(pname,price) values('laptop',45000),('mobile',20000),('charger',1200),('keyboard',2000);

select * from products2;

--1 DELETE 

-- it is used to just delete the rows in a table not the entire sturcture of the table

DELETE From products where pid=3;

--create another table
select * Into products2
from products;

-- to delete entire data from table dont specify conditon

DELETE FROM products3;



--2 TRUNACTE
-- Truncate is similar to DELETE statemnt with out condition, this only clear the data, no the table structure

--create another table
 Insert Into products3(pname,price)
select pname,price from products;

-- to delete entire data from table dont specify conditon
select * from products3;

TRUNCATE table products3;


--3 DROP

-- DRop state will clear the entire data from tables/ database including structures too

drop table products;
select * from products;
-- we will get Invalid object name 'products'.

drop database temp;
-- getting "Cannot drop database "temp" because it is currently in use."

-- so we need to use master and the drop this db

use master
alter database[temp] set single_user with rollback immediate;
drop database temp;