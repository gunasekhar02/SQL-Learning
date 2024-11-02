create database sqllearning;


-- create a table employee with primary key has auto increment and with constraints
create table Employee( empid int identity(1,1) primary key,
empname varchar(30) not null,
dept varchar(30) not null,
salary decimal(10,2) check (salary>=0));

--insert some data into Employee table
insert into Employee values('guna','technology',67000);
insert into Employee values('sekhar','Consulting',47000);
insert into Employee values('goutham','Radiology',37000);
insert into Employee values('guna2','corporate',-23);  -- throws error because of check that we put for salary
insert into Employee values('guna3',null,23); -- throws error because of constraint that we put on dept

--insert more data in another by specifing the columns

INSERT into Employee(empname, dept, salary) values ('kiran','IT',56000),
('Sravan','Govt',45000),('Aruna','homeopathy',87000);

-- get the all data in a table

select * from Employee;

--delete any specific row
delete from Employee where empid=4;

--create table from another table

SELECT *
INTO employee_dupe
FROM Employee;

select * from employee_dupe;

