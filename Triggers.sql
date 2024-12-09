-- triggers

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Action NVARCHAR(50),
    ActionDate DATETIME DEFAULT GETDATE()
);

select * from Employees

-- create a trigger for insertion to employee

create trigger afterInsert on Employees
after insert
as
begin

insert into EmployeeAudit(EmployeeID,Action)
select EmployeeID,'Inserted' from INSERTED
end

INSERT INTO Employees (EmployeeName, Age, Salary)
VALUES 
('guna sekhar', 21, 5000),
('Reddy', 34, 6000)

select * from EmployeeAudit

-- update trigger

create trigger afterUpdate2 on Employees
after update
as
begin
insert into EmployeeAudit(EmployeeID,Action)
select employeeID,'updated' from INSERTED
end

drop trigger afterUpdate

update employees set salary=10000 where EmployeeName like '%Bob%'

-- delete trigger

create trigger afterDelete on Employees
after Delete
as
begin

insert into EmployeeAudit(EmployeeID,Action)
select EmployeeID,'Deleted' from deleted
end

delete from Employees where age=21;