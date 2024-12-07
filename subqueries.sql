CREATE TABLE EmployeesCT (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing primary key
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2),
    DepartmentID INT,  -- Foreign key to DepartmentsCT table
    ManagerID INT NULL,  -- Self-referencing column
    JoiningDate DATE,
    Gender NVARCHAR(10),
    FOREIGN KEY (ManagerID) REFERENCES EmployeesCT(EmployeeID) -- Self-referencing relationship
);

--------------------

CREATE TABLE DepartmentsCT (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing primary key
    DepartmentName NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50)
);


--------------------------

CREATE TABLE PayrollCT (
    PayrollID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing primary key
    EmployeeID INT NOT NULL,  -- Foreign key to EmployeesCT table
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES EmployeesCT(EmployeeID) -- Foreign key relationship
);


--- Insertion

INSERT INTO EmployeesCT (FirstName, LastName, Salary, DepartmentID, ManagerID, JoiningDate, Gender)
VALUES
('John', 'Doe', 75000, 1, NULL, '2021-05-15', 'Male'),  -- John has no manager
('Jane', 'Smith', 85000, 1, 1, '2022-03-10', 'Female'), -- Jane reports to John
('Emily', 'Davis', 95000, 2, NULL, '2020-08-20', 'Female'), -- Emily has no manager
('Michael', 'Brown', 65000, 3, 2, '2023-01-05', 'Male'); -- Michael reports to Jane

INSERT INTO EmployeesCT (FirstName, LastName, Salary, DepartmentID, ManagerID, JoiningDate, Gender)
VALUES
('reddy', 'sekhar', 45000, 2, NULL, '2021-05-15', 'Male'),('knl', 'babu', 45000, 2, NULL, '2021-05-15', 'Male');

INSERT INTO DepartmentsCT (DepartmentName, Location)
VALUES
('Finance', 'New York'),
('Engineering', 'San Francisco'),
('Human Resources', 'Chicago');

INSERT INTO DepartmentsCT (DepartmentName, Location)
VALUES
('IT', 'India')

INSERT INTO PayrollCT (EmployeeID, PaymentDate, Amount)
VALUES
(1, '2024-01-01', 75000),  -- EmployeeID 1 exists
(2, '2024-01-01', 85000),  -- EmployeeID 2 exists
(3, '2024-01-01', 95000),  -- EmployeeID 3 exists
(4, '2024-01-01', 65000);  -- EmployeeID 4 exists

-- retreving data
select * from EmployeesCT
select * from DepartmentsCT
select * from PayrollCT

-----------------------------------------------------------------------

-- queries

-- 1. Find employees who earn more than the average salary of their department.

select avg(Salary) from EmployeesCT
group by DepartmentID

--Actual query 
select * from EmployeesCT e1
where salary >(select avg(Salary) from EmployeesCT e2
				where e1.DepartmentID = e2.DepartmentID)




--2. Find the second-highest salary in the company.

select max(Salary) from EmployeesCT

-- Actual Query

select max(salary) from EmployeesCT
where salary < (select max(salary) from  EmployeesCT)




--3. List employees who do not belong to any department.

select * from EmployeesCT
where DepartmentID not in (select DepartmentID from DepartmentsCT)





-- 4. Identify the employee(s) with the highest salary in each department.

select * from EmployeesCT

select * from EmployeesCT e1
where salary = (select max(salary) from EmployeesCT e2
				where e1.DepartmentID=e2.DepartmentID) order by departmentID



--5. Find departments that have more than 2 employees.

select DepartmentName from
DepartmentsCT where DepartMentID in (select DepartmentID from EmployeesCT group by departmentID having count(*)>2)




--6. Retrieve employees whose salaries are greater than the average salary of the entire company.

select * from EmployeesCT
where salary > (select avg(salary) from EmployeesCT)



--7. List employees who work in a department located in a specific city (e.g., 'New York')

select distinct departmentID from DepartmentsCT
where location = 'New York'

-- actual query

select * from EmployeesCT
where departmentId in (select distinct departmentID from DepartmentsCT
where location = 'New York') 



-- 8. Find employees who joined after the most recent hire in another specific department.
--First, you need to find the employee with the latest joining date in the specific department (e.g., 'Engineering').

select max(JoiningDate) from EmployeesCT
where DepartmentID=2;  -- i.e 2021-05-15

--actual Query

select * from EmployeesCT
where joiningdate>(select max(JoiningDate) from EmployeesCT
				where DepartmentID=2)



--9. Identify employees who have the same salary as someone in a different department.

select * from EmployeesCT e1
where salary in (select salary from EmployeesCT e2
				where e1.DepartmentId <> e2.departmentID)



--10. Find departments that have no employees assigned to them.

select DepartmentName from 
departmentsCT where DepartmentId not in (select distinct departmentId from employeesCT)



--11. Count the number of employees who have the same salary as the maximum salary in their department.

select * from employeesCT

select count(*) from EmployeesCT e1
where salary in ( select max(salary) from EmployeesCT e2
				where e1.DepartmentID=e2.DepartmentID)


				

--12. Find employees who do not have a corresponding record in another table, such as Payroll
select * from payrollCT

select * from EmployeesCT
where EmployeeId not in ( select distinct employeeID from PayrollCT)



--13. Identify employees whose salaries are above the 90th percentile of all employees in the company.

select * from EmployeesCT
where salary > (select sum(salary)*0.9 from employeesCT)



--14. Retrieve employees who work in a department with the highest average salary across all departments.


with deptAvgSalary as (  SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM EmployeesCT
    GROUP BY DepartmentID)

select e1.employeeID,e1.FirstName,e1.Salary,e1.DepartmentID
from employeesCT e1
where departmentid=(select top 1 departmentId from deptAvgSalary order by AvgSalary desc )



--15. Find all employees who have the same manager as a specific employee.

SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e1.ManagerID
FROM EmployeesCT e1
JOIN EmployeesCT e2 ON e1.ManagerID = e2.ManagerID