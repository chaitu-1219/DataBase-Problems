--------------------------------------------------Description----------------------------------------------------
/*
Rising Temperature
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

--------------------------------------------Approach----------------------------------------------------------
/*
**Logic:**
- `CROSS JOIN` pairs every row of yesterday with every row of today
- `DATEDIFF(today.recordDate, yesterday.recordDate) = 1` ensures yesterday is exactly one day before today
- `today.temperature > yesterday.temperature` filters for days warmer than the previous day

**Minor notes:**

1. **Order of columns in DATEDIFF** — `DATEDIFF(x, y)` computes `x - y` in days, so `DATEDIFF(today.recordDate, yesterday.recordDate) = 1` correctly means today is one day after yesterday. This is right.

2. **Alternative syntax** — Some prefer a self-join with `ON` instead of `CROSS JOIN` + `WHERE`:
```sql
SELECT today.id
FROM Weather today
JOIN Weather yesterday
  ON DATEDIFF(today.recordDate, yesterday.recordDate) = 1
 AND today.temperature > yesterday.temperature
```
Both are functionally equivalent; the `ON` version is often considered more idiomatic.

3. **Edge case** — The problem guarantees no duplicate dates, so each `today` row matches at most one `yesterday` row. You don't need `DISTINCT`, but adding it wouldn't hurt if you want to be safe.

One small correctness check: make sure your `DATEDIFF` is supported by your SQL dialect (it works in MySQL, the typical LeetCode environment). In Postgres you'd use `(today.recordDate - yesterday.recordDate) = 1` or `today.recordDate = yesterday.recordDate + INTERVAL '1 day'`. But for LeetCode's MySQL, your solution is exactly right.
*/
---------------------------------------------------CODE---------------------------------------------------
/*
SELECT today.id
FROM Weather yesterday 
CROSS JOIN Weather today

WHERE DATEDIFF(today.recordDate,yesterday.recordDate) = 1
    AND today.temperature > yesterday.temperature
;
*/

/*
Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
*/
