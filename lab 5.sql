
-- 1.	Retrieve number of students who have a value in their age. 
select COUNT(*)
from Student s
where s.St_Age is not null

--2.	Get all instructors Names without repetition
select distinct i.Ins_Name
from Instructor i

--3.	Display student with the following Format (use isNull function)
select isnull(s.St_Id,'no data') as 'Student ID',isnull(s.St_Fname+' '+s.St_Lname,'no data') as 'full name', isnull(d.Dept_Name,'no data') as 'Department name'
from Student s, Department d
where s.Dept_Id = d.Dept_Id

--4.	Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not
select i.Ins_Name, p.Dept_Name
from Instructor i  left outer join Department p 
on i.Dept_Id = p.Dept_Id

-- 5.	Display student full name and the name of the course he is taking
--For only courses which have a grade  

select s.St_Fname+' '+s.St_Lname as 'full name', c.Crs_Name
from Student s inner join Stud_Course sc 
on s.St_Id = sc.St_Id
inner join Course c
on sc.Crs_Id = c.Crs_Id and sc.Grade is not null

--6.	Display number of courses for each topic name
select t.Top_Name, COUNT(c.Crs_Id) as n_courses
from Topic t
inner join Course c
on t.Top_Id =c.Top_Id
group by t.Top_Name

--7.	Display max and min salary for instructors
select MIN(salary), max(salary)
from Instructor 

--8.Display instructors who have salaries less than the average salary of all instructors.
select Ins_Name
from Instructor 
where Salary < (select avg(salary) from Instructor)

--9.Display the Department name that contains the instructor who receives the minimum salary
select d.Dept_Name
from Department d inner join Instructor i
on d.Dept_Id = i.Dept_Id 
where Salary = (select min(Salary) from Instructor) 

select top 1 dept_name
from Instructor i inner join Department d
on d.Dept_Id=i.Dept_Id 
order by Salary 

-- 10.Select max two salaries in instructor table. 
select top 2 i.Ins_Name 
from Instructor i
order by i.salary desc

--11.Select instructor name and his salary but if there is no salary display instructor bonus.
--“use one of coalesce Function”
select ins_name ,coalesce(convert( varchar(20),salary),'bounas')
from Instructor

--12.Select Average Salary for instructors 
select AVG(salary) avg_salary
from Instructor

--13.Select Student first name and the data of his supervisor
select x.st_fname,y.*
from Student x,Student y
where y.St_id=x.St_super

--14.Write a query to select the highest two salaries in Each Department 
--for instructors who have salaries. “using one of Ranking Functions”
select *
from (
select *, ROW_NUMBER()over(partition by Dept_Id order by salary desc) as max_salary
from Instructor i) as new
where max_salary<=2

--15.	Write a query to select a random  student from each department.
--“using one of Ranking Functions”
select * from(
select  *,ROW_NUMBER() over(partition by dept_id order by newid()) as random
from Student)as new
where random=1

