
/*
------------------------------------------------------Description-------------------------------------------------------------------------

Employee Bonus
Easy
Topics
premium lock icon
Companies
Hint
SQL Schema
Pandas Schema
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write a solution to report the name and bonus amount of each employee who satisfies either of the following:

The employee has a bonus less than 1000.
The employee did not get any bonus.
Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
*/



/*
------------------------------------------------------Approach----------------------------------------------------------------------
# Approach for This Query

This query solves a specific pattern: **"find employees who have a bonus under a threshold, including those with no bonus at all."** Here's the thinking behind each design choice.

## 1. The core trick: `LEFT JOIN` instead of `INNER JOIN`

The natural instinct might be to join the two tables directly:

```sql
FROM Employee JOIN Bonus ...
```

But an inner join would **silently discard** employees who don't appear in the `Bonus` table. If you have an employee with no bonus record, the inner join drops them entirely, and they'd never show up in your results. The problem wants those employees included. So you switch to `LEFT JOIN`, which keeps every employee and fills missing bonus data with `NULL`.

This is the central insight — *the join type determines who gets included in the final answer.*

## 2. Handling `NULL` with the `OR` clause

Once you have a `LEFT JOIN`, employees without bonuses have `bonus = NULL`. Now the filtering gets tricky:

- `bonus < 1000` correctly captures employees with a small bonus.
- But `NULL < 1000` evaluates to `NULL` (not `TRUE`) in SQL, so those bonus-less employees would still be filtered out.

Hence the `OR Bonus IS NULL` condition — it explicitly rescues the employees who have no bonus record. Without this, the `LEFT JOIN` would be pointless.

## 3. The `WHERE` clause executes *after* the join

The order of operations matters: the engine first builds the joined result (with NULLs filled in), then applies the `WHERE` filter. So by the time `WHERE` runs, both "small bonus" and "missing bonus" cases are visible as actual rows with `NULL` values.

## The general pattern

This query is a template for a common class of problem:

> **"Find X that satisfy condition C, but also include X that have no related record Y."**

The reusable recipe is:
1. `LEFT JOIN` to preserve all X's.
2. Filter with `OR` and an `IS NULL` check to catch the "no match" cases.

## Potential pitfalls to watch

- **Misplaced NULL check** — putting `bonus IS NULL` inside the join's `ON` clause instead of `WHERE` changes semantics. (`ON` filters *before* joining; `WHERE` filters *after*.)
- **Forgetting `OR`** — using only `WHERE bonus < 1000` quietly excludes all bonus-less employees, defeating the `LEFT JOIN`.
- **Portability** — the version that tests `Bonus IS NULL` on the whole row works in MySQL but may fail on stricter databases; prefer `Bonus.bonus IS NULL` for clarity and compatibility.

In short: the approach hinges on recognizing that you need both a left join (to preserve everyone) and an explicit NULL handling (to include those without bonuses), and the result is a clean, single-pass solution.
*/

------------------------------------------------------Code--------------------------------------------------------------------
SELECT Employee.name,Bonus.bonus FROM Employee 
LEFT JOIN Bonus ON Employee.empID = Bonus.empID
WHERE bonus < 1000 OR Bonus IS NULL ;

/*
Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
*/
