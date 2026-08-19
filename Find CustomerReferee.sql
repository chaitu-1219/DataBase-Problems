/*
------------------------------------------------Description------------------------------------------------
Find Customer Referee
Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 
Find the names of the customer that are either:

referred by any customer with id != 2.
not referred by any customer.
Return the result table in any order.
The result format is in the following example.
Example 1:

Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/





/*
------------------------------------------------Description------------------------------------------------
I'll explain this MySQL solution for the customer referee problem.

## The Problem
The task is to find the names of customers who are **not referred** by customer `id = 2`. This includes:

1. Customers with **no referee** at all (`referee_id IS NULL`)
2. Customers referred by someone **other than** customer 2 (`referee_id != 2`)

## The Query

```sql
SELECT name 
FROM customer 
WHERE referee_id IS NULL OR referee_id != 2;
```

## Why This Approach Makes Sense

**1. Handling NULL values:** In SQL, `NULL` means "unknown" and requires special handling. The comparison `referee_id != 2` evaluates to `NULL` (not TRUE) when `referee_id` is `NULL`, so those rows would be excluded if we only used that condition. That's why we need the separate `referee_id IS NULL` check using `OR`.

**2. Two logical conditions:**
- `referee_id IS NULL` — customers never referred by anyone
- `referee_id != 2` — customers referred by someone other than customer 2

The `OR` combines both because a customer belongs in the result if **either** condition is true.

**3. Alternative using COALESCE:** An equivalent approach is `COALESCE(referee_id, 0) != 2`, which converts `NULL` to `0` first. However, the explicit `IS NULL OR` version is generally clearer and often performs better (it can more easily use an index on `referee_id`).

## Key Takeaway
The subtlety in this problem is the `NULL` trap. Without the `IS NULL` clause, you'd incorrectly omit customers who have never been referred by anyone — a classic SQL gotcha that this WHERE clause is designed to avoid.
*/


------------------------------------------------CODE------------------------------------------------
select name from customer where referee_id is null or referee_id!=2;

/*
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/
