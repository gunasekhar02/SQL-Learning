
-- Insert Statements to add the data/ copy the data from one table to another

create table customer(cid int primary key, cname varchar (30) not null, city varchar(30) not null);

-- 1. insert data to a table with specifying columns
insert into customer values(1,'guna','hyd');
insert into customer values(2,'sekhar','knl');
insert into customer values(6,'reddy','ptp');
insert into customer values(7,'tharu','viz');

select * from customer3

-- 2. insert large data in sigle command by specifying columns
insert into customer(cid,cname,city) values ( 3,'diwakar','atp'),( 4,'shaka','bngl'),( 5,'bhanu','goa');


--insert into requires a table that already present or else it will throw error
create table customer3(cid int primary key, cname varchar (30) not null, city varchar(30) not null);

insert into customer3
select * from customer 

-- only sepecify rows then add condition
insert into customer3
select * from customer where cname='tharu' OR cname='reddy';


-- copy only specific columns
create table customer7(cid int identity(1,1) primary key, cname varchar (30) , city varchar(30));

insert into customer7(cname)
select cname from customer;

select * from customer4;

-- with condition
insert into customer7(city)
select city from customer where cname='guna' or  city='bngl';


--- SELECT INTO

-- 1. just copy the structure of one table to another with out data

select * into customer2
from customer where 1>2; -- need to pass the false condition in order to neglect data

-- to add all the data
select * into customer4
from customer;

-- only sepecify rows then add condition
select * into customer5
from customer where city='knl';


-- DELETE STATEMENT

-- delete specific rows
Delete from customer7 where city='hyd' or city='bngl'

-- delete entire table data 
delete from customer5;

--delete a specific data from a row
delete from customer4 where cname='shaka';



