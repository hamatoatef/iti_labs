--1-Create it programmatically
--2-Create a new user data type named loc with the following Criteria:
--•	nchar(2)
--•	default:NY 
--•	create a rule for this Datatype :values in (NY,DS,KW)) and associate it to the 
create rule r1 as @x in ('NY','DS','KW')
create default def1 as 'ny'
sp_addtype loc,'nchar(2)'
sp_bindrule r1, loc
sp_bindefault def1,loc
 --1.	Create the following tables with all the required information and load the required data as specified in each table 
   --using insert statements[at least two rows]
 
create table department
(
DeptNo char(3) primary key ,
DeptName varchar(20),
Location loc
)
insert into department
values('d1','Research','NY')
insert into department
values
('d2','Accounting','DS'),('d3','Markiting','KW')

create table employee 
(
empno int primary key,
empfname varchar(20) not null,
emplname varchar(20) not null,
deptno char(3),
salary int ,
constraint c1 foreign key(deptno) references department(deptno) ,
constraint c2 unique(salary) ,
constraint c3 check (salary<6000)

)


insert into employee
values(25348,'Mathew','Smith','d3',2500),(10102,'Ann','Jones','d3',3000),(18316,'John','Barrimore','d1',2400)
insert into employee values(29346,'James','James','d2',2800)
/*insert into works_on(empno)
values(11111)
update works_on
set empno =11111 where empno=10102
update employee
set empno=22222 where empno=10102
delete from employee where empno=10102*/

--1-Add  TelephoneNumber column to the employee table[programmatically]
alter table employee add telephone int

--2-drop this column[programmatically]
alter table employee drop column telephone 


--3-Bulid A diagram to show Relations between tables

------------------------------------------------------------------------------------




--2.	Create the following schema and transfer the following tables to it 
--a.	Company Schema 
--i.	Department table (Programmatically)
--ii.	Project table (visually)

create schema company
alter schema company transfer department
--b.	Human Resource Schema-
--i.	  Employee table (Programmatically)

create schema humanresource
alter schema humanresource transfer Employee 

--3.	 Write query to display the constraints for the Employee table.

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Employee'

--4.	Create Synonym for table Employee as Emp and then run the following queries and describe the results
  create synonym emp for HumanResource.employee

--a.	Select * from Employee
Select * from Employee

--b.	Select * from [Human Resource].Employee
Select * from HumanResource.Employee

--c.	Select * from Emp
Select * from Emp

--d.	Select * from [Human Resource].Emp
Select * from HumanResource.Emp

Select * from dbo.Emp

--5.	Increase the budget of the project where the manager number is 10102 by 10%.

update company.project
set budget+=(.1*budget)
from company.project p inner join works_on w
on p.projectno=w.projectno
where empno=10102

--6.	Change the name of the department for which the employee named James works.The new department name is Sales.

update company.department
set DeptName='sales'
from company.department d inner join humanresource.employee e
on d.DeptNo=e.deptno
where empfname='james'

--7.	Change the enter date for the projects for those employees
-- who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
update works_on
set enter_date='12/12/2007'
from company.department d,humanresource.employee e,works_on w
where d.DeptNo=e.deptno and e.empno=w.empno and d.DeptName='sales' and projectno='p1'

--8.Delete the information in the works_on table for all employees who work for the department located in KW.

delete from works_on
where empno in (select empno from humanresource.employee e,company.department d where d.DeptNo=e.deptno and d.Location='kw') 



