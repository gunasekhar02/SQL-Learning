-- commands on Databases

-- Create database
CREATE DATABASE exp_db;

-- Show List of dbs in the System
SELECT name FROM Sys.Databases;

-- use the db
USE exp_db;

--create table in a db

create table student(id int , name varchar(20), age int);
insert into student values(1,'nick',23);
select * from student;

--rename the database
ALTER DATABASE [exp_db] SET Single_user WITH Rollback IMMEDIATE;
ALTER DATABASE [exp_db] MODIFY name=[stu_db];
ALTER DATABASE [stu_db] SET Multi_user;

--drop/delete DB when no longer need
drop database stu_db;
-- we will get "Cannot drop database "stu_db" because it is currently in use." because other users might using
--this db because it is multiuser db, so we need to make it single_user db and drop that
-- use MASTER db to drop

USE master;
ALTER DATABASE [stu_db] set Single_user with Rollback Immediate;
DROP database [stu_db];
