--1.	Display the Department id, name and id and the name of its manager.
select dname ,dnum,fname,dno 
from Departments d ,Employee e
where ssn=MGRSSN

--2.	Display the name of the departments and the name of the projects under its control.
select dname,pname
from Departments d inner join Project p
on d.Dnum=p.Dnum

--3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select fname,d.*
from Dependent d inner join Employee e
on ssn=ESSN

--4.	Display the Id, name and location of the projects in Cairo or Alex city.
select  pnumber,pname,plocation
from Project where city='cairo' or city='alex'

--5.	Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project
where pname like 'a%'

--6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select E.*
from Employee e inner join Departments d
on dnum=dno and dno=30 and Salary >=1000 and Salary<=2000

--7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select e.*
from Employee e inner join Works_for w
on e.SSN=w.ESSn and e.dno=10
inner join Project
on  Pnumber=Pno and hours>=10 and Pname='Al Rabwah'

--8.	Find the names of the employees who directly supervised with Kamel Mohamed.
select x.fname as emp_name,y.fname+' '+y.Lname as super_name
from Employee x ,Employee y
where y.ssn=x.Superssn and y.Fname='kamel' and y.Lname='mohamed'

--9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select fname,pname
from Employee inner join Departments d
on  Dnum=dno
inner join Project p
on d.Dnum=p.Dnum
order by Pname

--10.For each project located in Cairo City , find the project number
--, the controlling department name ,the department manager last name ,address and birthdate.
select pnumber,dname,lname,address,bdate
from Project p inner join Departments d
on d.Dnum=p.Dnum and city='cairo'
inner join Employee
on ssn=MGRSSN

--11.Display All Data of the mangers
select e.*
from Employee e inner join Departments d
on ssn=MGRSSN

--12.Display All Employees data and the data of their dependents even if they have no dependents
select *
from Employee e left outer join Dependent
on ssn=essn

--1.Insert your personal data to the employee table as a new employee
--in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee
values('mahmoud','elshorbagy',102672,8/14/1995,'133-elshrouk','m',3000,112233,30)

--2.Insert another employee with personal data your friend as new employee
--in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
insert into Employee(Fname,Lname,SSN,Bdate,Address,Sex,Dno)
values('ahmed','refaat',102660,8/20/1995,'zefta','m',30)

--3.Upgrade your salary by 20 % of its last value.

update Employee 
set Salary=(Salary+.2*Salary)
where fname='mahmoud' and Lname='elshorbagy'


