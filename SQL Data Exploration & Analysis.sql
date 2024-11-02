use employees;


-- Data Exploration


-- 1. List all employees along with their respective department names. Include employee number, first name, last name, department number, and department name.

select t1.emp_no,t1.first_name,t1.last_name,t2.dept_no,t3.dept_name  from employees.employees as t1
inner join employees.dept_emp as t2
on t1.emp_no=t2.emp_no
inner join employees.departments as t3
on t2.dept_no=t3.dept_no;

-- 2. Find max salary record of a given employee (by employee number). Include employee number, salary.

select emp_no, max(salary) from employees.salaries group by emp_no limit 1 ;

-- 3. Find all employees who have held a specific title (e.g., 'Engineer'). Include employee number, first name, last name, and title.

select t2.emp_no,t2.first_name,t2.last_name,t1.title from employees.titles as t1 
inner join employees.employees as t2
on t1.emp_no=t2.emp_no
where t1.title like'Engineer';

-- 4. List all departments along with their current managers. Include department number, department name, manager's employee number, first name, and last name.

select t1.dept_no,t1.dept_name,t2.emp_no, t3.first_name,t3.last_name from employees.departments as t1
inner join employees.dept_manager   as t2
     on t1.dept_no=t2.dept_no
inner join employees.employees as t3
      on t2.emp_no=t3.emp_no;
      
-- 5. Count the number of employees in each department.Include department number,department name and employee count

select t1.dept_no,t1.dept_name,count(t2.emp_no) as emp_count from  employees.departments as t1
inner join  employees.dept_emp     as t2
   on t1.dept_no = t2.dept_no
group by t1.dept_no,t1.dept_name;

-- 6. Find all employees born in a specific year (e.g., 1960). Include employee number, first name, last name, and birth date.

select emp_no,first_name,last_name,birth_date from  employees.employees
where left(birth_date,4)= '1960';

select emp_no,first_name,last_name,birth_date from  employees.employees
where year(birth_date)= 1960;

-- 7. Write a query to find all employees hired in the last 50 years. Include employee number, first name, last name, and hire date.

select emp_no,first_name,last_name,hire_date from  employees.employees
where hire_date>=date_sub(curdate(),interval 50 year);


-- 8. Calculate the average salary for each department. Include department number, department name, and average salary.
select t1.dept_no,t1.dept_name,avg(t3.salary) as AVG_BY_DEPT from employees.departments as t1
inner join employees.dept_emp as t2
on t1.dept_no= t2.dept_no
inner join employees.salaries as t3
on t2.emp_no=t3.emp_no
group by t1.dept_no,t1.dept_name
order by AVG_BY_DEPT desc;

-- 9. Find the gender distribution (number of males and females) in each department. Include department number, department name, count of males, and count of females.

select t1.dept_no,t1.dept_name,
sum( case when t3.gender='M' then 1 else 0  End ) as Male_count ,
sum(case when t3.gender='F' then 1 else 0  End ) as Female_count 
 from employees.departments as t1
inner join employees.dept_emp as t2
on t1.dept_no= t2.dept_no
inner join employees.employees as t3
on t2.emp_no=t3.emp_no
group by t1.dept_no,t1.dept_name;

-- 10. Find the employees who have served the longest in the company. Include employee number, first name, last name, and number of years served.

select emp_no,first_name,last_name,
timestampdiff(year,hire_date,curdate()) as Year_served
 from employees.employees
 order by Year_served  desc
 limit 10;
 

 

