create database clothingTech
create database clothingTech2

--drop db
use clothingTech2
drop clothingTech2

--Msg 343, Level 15, State 1, Line 6
--Unknown object type 'clothingTech2' used in a CREATE, DROP, or ALTER statement.

use clothingTech
alter database [clothingtech2] set single_user with rollback  immediate
drop database clothingTech2;

-- rename db

alter database[clothingTech] set single_user with rollback immediate;
alter database [clothingTech] modify name=[ctech]
alter database[ctech] set multi_user

----------------------------------------------------------------------
use ctech

create table EmpCT( eid Int identity(1,1),
ename varchar(30) not null,
eage int not null,
esalary decimal(10,2) check (esalary>1000))

insert into Empct(ename,eage,esalary) values ('guna',23,7800),('sekhar',24,54000),('reddy',23,45000);
insert into Empct(ename,eage,esalary,edept) values ('kishor',33,10800,'marketing'),('arjun',30,99800,'it');


select * from EmpCt3;

--------------------------------------------------------------------------
--crud operations including ddl queries

alter table empct add edept varchar(30)
alter table empct add location varchar(30)


update empct set edept = case
                      when esalary>50000 then 'it'
					  when esalary<10000 then 'sales'
					  else 'marketing'
					  end

EXEC sp_rename 'empct.dept', 'edept', 'COLUMN';

alter table empct drop column location

-- insert into and select into

create table EmpCT2( eid Int identity(1,1),
ename varchar(30) not null,
eage int not null,
esalary decimal(10,2) check (esalary>1000)
)
alter table empct2 add edept varchar(30)


insert into Empct2 (ename,eage,esalary,edept)
select ename, eage, esalary, edept from empct


select * into empct3 from empct


-----------------------------------
-- joins

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName VARCHAR(30) NOT NULL,
    Age INT NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 1000)
);

CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    EmployeeID INT NOT NULL,
    CONSTRAINT FK_Departments_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


INSERT INTO Employees (EmployeeName, Age, Salary)
VALUES 
('John Doe', 28, 5000),
('Alice Smith', 35, 6000),
('Bob Johnson', 40, 7000),
('Clara Brown', 30, 5500);

INSERT INTO Departments (DepartmentName, EmployeeID)
VALUES 
('HR', 1),
('Finance', 2),
('IT', 3),
('HR', 4);


-- inner join

select e.EmployeeName,e.Salary,d.departmentName
from employees e
inner join Departments d on e.EmployeeID=d.EmployeeID

-- left join

select e.EmployeeName,e.Salary,d.departmentName
from employees e
left join Departments d on e.EmployeeID=d.EmployeeID

-- right join

select e.EmployeeName,e.Salary,d.departmentName
from employees e
right join Departments d on e.EmployeeID=d.EmployeeID

-- full join

select e.EmployeeName,e.Salary,d.departmentName
from employees e
full join Departments d on e.EmployeeID=d.EmployeeID

----------------------------------
-- clauses

select * from employees order by Salary;

select distinct departmentname from Departments;

select Departmentname, count(*) as counts from Departments group by DepartmentName having count(*) >=2 order by counts

select * from Employees where salary>5000;
select * from employees where salary between 5000 and 7000;

select employeename from employees where  employeename like '%n%'

select top 1 * from departments

----------------------------------------------------------

-- views

create view empview as 
select * from Employees

select * from empctview

select * from empview where age>35

exec sp_rename 'empview','empctview'

drop view empctview

------------------------------------------------------------

-- temporary tables

create table #emp(eid int Identity(1,1) primary key, ename varchar(30))

insert into  #emp(ename) values ('guna'),('sekar')

select * from #emp
-- we can perform all the filters for this temp table


------------------------------------------------------------------

-- stored procedures

create procedure empdetails as
select * from employees
go

exec empdetails

create procedure uniquedepts as
select distinct DepartmentName from Departments
go

exec uniquedepts


-- parametered sps


create procedure getdeptname_by_empid @eid int
as
select Departmentname from Departments
where EmployeeID= @eid
go


exec getdeptname_by_empid 2

----------------------------------------------------------------
----subqueries

--Find the name of the employee who has the highest salary.

select * from employees

select Employeename from employees
where salary = (select max(salary) from employees)

-- find the second highest salary employeee

select max(salary) from employees 
where salary<(select max(salary) from employees)

select * from Employees
where salary =(select max(salary) from employees 
where salary<(select max(salary) from employees))


---find the names of employees who work in departments with the name "HR".

select Employeename from employees 
where EmployeeID in (select EmployeeID from Departments where DepartmentName='hr')


--Find the employees whose salary is above the average salary of all employees in the same department.

select * from Employees e1
where Salary>(SELECT AVG(e2.Salary)
    FROM Employees e2
    INNER JOIN Departments d ON e2.EmployeeID = d.EmployeeID
    WHERE d.DepartmentID = (
        SELECT d2.DepartmentID
        FROM Departments d2
        WHERE d2.EmployeeID = e1.EmployeeID
    ))

select * from Departments
