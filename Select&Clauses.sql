--Select statement in  SQL

--create table
create table student( rollno int identity(1,1) primary key,
name varchar(30) not null,
age int not null,
subject varchar(30) not null);


--insert data
insert into student(name,age,subject)
values ('guna',23,'maths'),('sekhar',24,'science'),('guna',23,'hindi'),('siraj',25,'accounting'),('sekhar',24,'physics'),('reddy',24,'chemistry');


--select statement
select * from student;
select name, age as studentage from student;
select top 2 * from student




--WHERE Clause


select * from student where rollno=3 OR rollno=5;
select * from student where rollno=3 AND name='guna';




--GROUP BY Clause


-- scenario 1 =>  How many students are there in each age group?

select subject, count(rollno) as noofstudents
from student group by subject;


-- scenario 2 =>  How many subjects each student enrolled?

select name, count(subject) as noofsubjects
from student group by name;


-- scenario 3 => What is the maximum age of students enrolled in each subject?

select subject,max(age) as maxage
from student group by subject;


-- scenario 4 => What is the minimun age of students enrolled in each subject?

select subject,min(age) as maxage
from student group by subject;






-- HAVING Clause



-- having clause is used in order to filter the data from the result of an select or aggregate functions


-- scenario 1  => Count of Students by Subject with Minimum Enrollment =1

select subject,count(rollno) as noofenrollments from
student group by subject having count(rollno)=1;



-- scenario 2  => Count of Students by Subject with  Enrollment >2

SELECT subject, COUNT(*) AS student_count
FROM student
GROUP BY subject
HAVING COUNT(*) >= 2;


-- scenario 3 => What are the names of students whose average age is greater than 23?

select name,avg(age) from student
group by name having avg(age)>23;



-- scenario 4 => Which subjects have students with an age greater than 24?

select subject, max(age) as maxage from student
group by subject having  max(age)>24;




-- ORDER BY Clause

-- order by clause is used to sort the columns it can be applied on single or multiple columns

-- order by column number
select * from student order by 4 desc;


-- scenario 1 => List all students sorted by their age in ascending order.

select * from student order by age;


-- scenario 2 => Show subjects with the number of enrolled students, sorted by the count in descending order.

select subject, count(*)
from student group by subject order by count(*) desc;


-- scenarion 3 => Retrieve students sorted by their names in alphabetical order.

select * from student order by name;



-- scenario to include all the clauses
--What are the subjects with an average age of students greater than 23, and list them in descending order of the average age?

select subject, avg(age) as average_age from  student 
group by subject having avg(age)>23 order by average_age desc;



-- note 
--     we need to follow the order of clauses like below
--     Select statement --> WHERE(optional) --> GROUP BY --> HAVING (will be used for group by only)   --> ORDER BY



