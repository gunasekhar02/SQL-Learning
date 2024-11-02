
-- Operators in SQL
-- these operators are used with the where clause

--Arthimatic operators

Select * from student where age=30;
Select * from student where age<>30;

--logical operators

select * from Student where age=24 OR age=30;
select * from Student where age=24 AND subject='science';
select * from student where age NOT in(24);
select * from student where age IN(24,25);

-- BETWEEN Operator
select * from student
where age between 23 AND 25;

-- LIKE Operator

select * from Student where name like 'g%';
select * from Student where name like '%e%';
select * from Student where name like '%r';
select * from Student where name like '_i%';

-- IS Null and IS Not Null

select * from student where name Is null;
select * from student where name Is not null;





