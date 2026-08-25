/*
----------------------------------------------------------------------Description----------------------------------------------------------------------
Classes With at Least 5 Students

Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 
Write a solution to find all the classes that have at least five students.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation: 
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.





----------------------------------------------------------------------Approach----------------------------------------------------------------------
Here's a step-by-step approach to solving this problem — structured the way a typical solution walkthrough would present it.

---

### Understanding the Problem
We need to find all classes that have **at least 5 students** enrolled. The `Courses` table has one row per student per class, meaning each enrollment gets its own row.

---

### Step 1: Identify the core requirement
The key metric is *how many students are in each class*. Since each student's enrollment is a separate row, counting rows per class gives us the student count.

---

### Step 2: Group the data by class
To count students per class, we group all rows that share the same `class` value together:

```sql
GROUP BY class
```

Now each group represents one class, and the rows within it are that class's enrollments.

---

### Step 3: Filter using the aggregate
We apply the condition **after** grouping, so we use `HAVING` rather than `WHERE`:

```sql
HAVING COUNT(student) >= 5
```

`COUNT(student)` counts the number of student entries per group. The `HAVING` clause keeps only groups where that count is 5 or more.

---

### Step 4: Select only the relevant column
Finally, we return just the class name for each qualifying group:

```sql
SELECT class
```

---

### Completed Query
```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

---

### Why `HAVING` and not `WHERE`?
This is the key insight of the approach. `WHERE` filters rows *before* grouping, but the count of students can only be calculated *after* rows are grouped. Filtering on an aggregate therefore must happen with `HAVING`.

**Result:** A list of all classes with 5 or more students.
*/


-------------------------------------------------------CODE--------------------------------------------


SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;


/*
-------------------------------------------------------Input and output--------------------------------------------

Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
*/
