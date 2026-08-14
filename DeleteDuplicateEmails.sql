/*
-----------------------------------------Explantion :--------------------------------------------

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+

=> From Person p1, Person p2 : it would look like:
1|john@example.com|1|john@example.com
1|john@example.com|2|bob@example.com 
1|john@example.com|3|john@example.com

2|bob@example.com|1|john@example.com
2|bob@example.com|2|bob@example.com
2|bob@example.com|3|john@example.com

3|john@example.com|1|john@example.com
3|john@example.com|2|bob@example.com
3|john@example.com|3|john@example.com

=> From Person p1, Person p2 where p1.email=p2.email and p1.id>p2.id:
It would look like:
3|john@example.com|1|john@example.com
Now delete this row's matching row in p1 using p1:  delete p1





----------------------------------------- Approach :--------------------------------------------
# Approach Explained
The whole strategy is to **delete duplicates while keeping the earliest (lowest-id) record** of each email.
## The Core Idea

SQL doesn't give you a clean "delete duplicates" command, so the approach is to:

1. **Compare the table against itself** using two aliases (`p1` and `p2`).
2. **Find rows that are duplicates** — same email but different ids.
3. **Delete only the "newer" copies** (higher id), leaving the original.

## Why Two Aliases?

You can't compare a table to itself in a `WHERE` clause without giving it two different names. By writing `FROM Person p1, Person p2`, you create two independent views of the same data — one acts as the "candidate to delete" (`p1`), the other acts as the "reference original" (`p2`).

## The Matching Logic

The filter has two parts, and each does a specific job:

- **`p1.email = p2.email`** — ensures we only match rows that are actually duplicates of each other (same person).
- **`p1.id > p2.id`** — ensures we only flag the *later* copy. This has two important effects:
  - A row never matches itself (ids are equal, not greater).
  - Among any group of duplicates, **every instance except the very first one** gets flagged, and the lowest-id row is never selected for deletion.

## Why This Handles 3+ Duplicates Gracefully

Even if an email appeared 5 times, the logic still works: rows 2, 3, 4, 5 all have at least one *earlier* row (1, 2, 3, 4 respectively) with the same email, so all four get flagged for deletion. Row 1, having no earlier duplicate, is safe.

## The Delete Operation

The `DELETE p1` prefix is essential — it tells SQL *which* table to remove rows from. Without the alias, SQL wouldn't know whether you meant to delete from `p1` or `p2`. Since `p1` holds the higher-id (duplicate) copies, deleting `p1` removes exactly the right rows.

## Summary of the Strategy

| Step | Action | Purpose |
|------|--------|---------|
| 1 | Cross join table with itself | Get all possible row pairings |
| 2 | Match equal emails | Isolate same-person pairs |
| 3 | Require `p1.id > p2.id` | Flag later duplicates, spare the original |
| 4 | `DELETE p1` | Remove duplicates only |

The elegance is that one self-join does all the work — no need for subqueries, `ROW_NUMBER()`, or `GROUP BY`.

*/

/*
----------------------------------------- Description :--------------------------------------------
Delete Duplicate Emails
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The result format is in the following example.

 

Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
*/
---------------    CODE    -----------

delete p1 from person p1,person p2 
where p1.email=p2.email and p1.id>p2.id;

/*
Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
*/

