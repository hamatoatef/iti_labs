
--1.	Display (Using Union Function)
--a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--b.	 And the male dependence that depends on Male Employee.
select d.Dependent_name ,d.Sex
from Employee e inner join Dependent d
on e.ssn=d.ESSN and e.Sex='f' and d.Sex= 'f'
union
select d.Dependent_name ,d.Sex
from Employee e inner join Dependent d
on e.ssn=d.ESSN and e.Sex='m' and d.Sex= 'm'

--2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.
select pname,sum(hours) as total_hours
from Project ,Works_for
where Pnumber=pno
group by pname

--3.	Display the data of the department which has the smallest employee ID over all employees' ID.
select d.*
from Departments d ,Employee e
where d.dnum=e.dno and ssn =( select min(ssn) from Employee e)

--4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select min(salary) as min_val,max(salary) as max_value,avg(salary) as avg_val ,dname
from Employee e,Departments d
where d.Dnum=e.Dno
group by Dname

--5.	List the last name of all managers who have no dependents.
select distinct lname
from Employee inner join Departments
on ssn=MGRSSN
left join Dependent
on ssn=ESSN 
where essn is null

--6.	For each department-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees
select dnum,dname,count(ssn) as count_of_emp
from Employee,Departments
where dnum=dno
group by dnum ,dname
having avg(Salary)<(select AVG(salary) from Employee)

--7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department
    --, ordered alphabetically by last name, first name.
	select fname,lname,pname
	from Employee inner join Departments d
	on dnum=dno
	inner join Project p
	on d.Dnum=p.Dnum
	order by d.dnum,Lname,Fname

	--8.	Try to get the max 2 salaries using subquery
select  top 2(salary)
from employee
order by salary desc

select max(salary)
from Employee
union all
select max(salary)
from Employee
where salary not in (select max(salary)from Employee)




--9.	Get the full name of employees that is similar to any dependent name

select concat (fname,' ',lname)as full_name
from Employee
intersect
select  Dependent_name
from Dependent

--10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 
update Employee 
set Salary+=(.3*Salary)
from Employee,Works_for,Project
where ssn=ESSn and Pnumber=pno and Pname='al rabwah'



--1.	In the department table insert new department called "DEPT IT" ,
--with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'

insert into Departments
values('DEPT IT',100,112233,11/1/2006)

--2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100),
-- and they give you(your SSN =102672) her position (Dept. 20 manager) 

--a.	First try to update her record in the department table
--b.	Update your record to be department 20 manager.
--c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments set MGRSSN =968574 where dnum=100;

update Departments set MGRSSN =102672 where dnum=20;

update Employee set Superssn=102672 where ssn=102660;

--3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that
-- you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).
delete Dependent where ESSN=223344
delete Works_for where ESSN=223344

update Departments set MGRSSN=102672 where MGRSSN=223344;

update Employee set Superssn = 102672  where Superssn=223344;

delete Employee where SSN=223344
