/*
----------------------------------------------------------Description--------------------------------------------------------
Customer Placing the Largest Number of Orders
Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

The result format is in the following example.

 

Example 1:

Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
 

Follow up: What if more than one customer has the largest number of orders, can you find all the customer_number in this case?
*/









------------------------------------------------------Approach------------------------------------------------------------
/*
The document is a LeetCode SQL problem (Problem 586). Here's the approach to solve it.

## The Problem

From the `Orders` table (columns: `order_number` as primary key, `customer_number`), find the `customer_number` of the customer who placed the most orders.

## Approach

**Logic (simple GROUP BY + ORDER + LIMIT):**
1. Group orders by `customer_number`
2. Count orders per customer
3. Sort by count in descending order
4. Return only the top row

**MySQL Solution:**

```sql
SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;
```

**MSSQL Solution** (uses `TOP` instead of `LIMIT`):

```sql
SELECT TOP 1 customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC;
```

## The Follow-Up (Ties)

Since the guarantee of "exactly one" max only applies to the main test, the follow-up asks for *all* customers who share the highest count. A clean approach uses a subquery to find the max count, then filter:

**MySQL:**
```sql
SELECT customer_number
FROM Orders
GROUP BY customer_number
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Orders
    GROUP BY customer_number
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
```

**Alternative with window function** (cleaner, handles ties naturally):

```sql
SELECT customer_number
FROM (
    SELECT customer_number,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM Orders
    GROUP BY customer_number
) t
WHERE rnk = 1;
```

The window function version is the most general—it works regardless of whether there's one winner or many ties, which also elegantly covers the main question if you prefer a single solution.

Would you like me to walk through the reasoning behind the `HAVING` + subquery approach in more detail, or break down how the window function version works step by step?
*/




------------------------------------------------------CODE------------------------------------------------------------

SELECT customer_number
  FROM Orders
 GROUP BY customer_number
 ORDER BY count(*) DESC
 LIMIT 1;

/*
Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+

*/
