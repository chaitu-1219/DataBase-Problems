/*Second Highest Salary
Description:

Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee. 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

Example 1:
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

Example 2:
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

MAX() with Subquery (Most Portable)
Intuition:
This approach uses pure logic:
First, find the absolute MAX(salary) in the table.
Then, find the MAX(salary) again, but this time only for salaries that are less than the absolute max.

Approach:
The MAX() aggregate function is perfect here. If the WHERE clause finds no rows (e.g., only one salary exists, so no salary is < MAX), MAX() automatically returns NULL. This elegantly handles the edge case without extra tricks.

Complexity:
Time: O(N) + O(N) = O(N). The DB scans the table (or index) twice.
Space: O(1).

Code:*/
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);


/*
input and output:

Input
Employee =
| id | salary |
| -- | ------ |
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
Output
| SecondHighestSalary |
| ------------------- |
| 200                 |
Expected
| SecondHighestSalary |
| ------------------- |
| 200                 |


Input
Employee =
| id | salary |
| -- | ------ |
| 1  | 100    |
Output
| SecondHighestSalary |
| ------------------- |
| null                |
Expected
| SecondHighestSalary |
| ------------------- |
| null                |*/
