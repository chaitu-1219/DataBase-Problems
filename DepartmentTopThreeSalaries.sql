/*
Department Top Three Salaries
Table: Employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 
Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees
*/







/*
Approach
Lets break down each clause

Select
select d.name as department , e1.name as employee, e1.salary as Salary

Displays the department , the name of the employee and the salary of the employee. simple as that
From
from Employee e1 join Department d on e1.DepartmentId = d.Id

It specifies the tables to be used , employee and department with the alias e and d respectively.
It joins the employee and the department based on the join condition that department id in employee table is same as the department id in department table.
It effectively joins the tables to have access to employee details and the corresponding department name of the employee.
Subquery
select count(distinct (e2.Salary))
from Employee e2
where e2.Salary > e1.Salary
and e1.DepartmentId = e2.DepartmentId

It being a subquery has access to the values in the main query
it creates a copy of the employee table and returns the number of unique salaries in employee table that are higher the salary of the employee being checked in the main query.
Where
Where 3 > (select count(distinct (e2.Salary))

The where clause provides a condition on the employee details that are to be displayed.
since the subquery returns count of the unique salaries in a department higher than current employee in the main query.
the condition is that if this count of unique salary higher than in a department returned by subquery is lower than 3, then the employee is a high earner.
the condition does not make sense yet?.. lets break it down a bit more.
If i have to check if an employee is a top 3 high earners in a department i can do it by checking all the employees in a department and rank them and the one in the top 3 are high earners.

An effective way to do this would be to check if there are people who earn more than the employee.

If a person is rank 3 then there would be only 2 people above.
If a person is rank 2 then there would be only 1 person above.
If a person is rank 1 then there would be no one above him.
so checking for number of people above him to be less than 3 (less than or equal to 2 works too) solves the problem.
But...
the problem states that it needs to be a unique salary so we need the count of people with unique salaries.
if we just return
count(salaries) where e2.salary>e1.salary
it would work if all salaries were already unique

but imagine there were salaries as so

A - 25k
B - 25k
C - 25k
D - 13k
E - 17k
F - 12k
doing count(salaries) where e2.salary>e1.salary would lead to
only a b and c being high earners but top 3 unique salaries would mean 25k 13k and 17k are the top 3 unique salaries and the earners of these salaries do not have to be just 3.
it just means all the earners who earn the top 3 unique salaries.
it is the top 3 salaries that need to be unique which are 25k, 17k and 13k.

The solution essentially is doing this..
lets say an employee e belongs to department A
subquery checks returns the count of unique salaries in department in that is more than salary of e.
if this count is less than 3 it means that e has a salary that is a top 3 unique salary in the department.
if the condition is true it displays the details of the employee
it does this for all the employees in the employee table.
*/






-- CODE:
# Write your MySQL query statement below
Select d.name as department , e1.name as employee, e1.salary as Salary
From Employee e1 join Department d on e1.DepartmentId = d.Id
Where  3 > (select count(distinct (e2.Salary))
            from  Employee e2
            where e2.Salary > e1.Salary
            and e1.DepartmentId = e2.DepartmentId)
/*
Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
*/
