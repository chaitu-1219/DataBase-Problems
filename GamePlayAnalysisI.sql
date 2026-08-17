/*
Game Play Analysis I
Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write a solution to find the first login date for each player.
Return the result table in any order.
The result format is in the following example.
Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/

/*
Great — let me break down the SQL solution line by line so you understand exactly what's happening.

The Query
sql
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
Step-by-Step Explanation
1. FROM Activity
Names the source table. All our work operates on the Activity table — every row is one login event with a player_id and a date.

2. GROUP BY player_id
This is the core of the query. It collects all rows that share the same player_id and lumps them into a single group.

Think of it like sorting a pile of cards by player. After this step, you have one group per player:

Group player_id = 1 contains events on 2016-03-01, 2016-05-02, 2017-06-25
Group player_id = 2 contains 2017-06-25
Group player_id = 3 contains 2016-03-02, 2018-07-03
3. MIN(event_date)
Now that we have one group per player, we apply an aggregate function to each group independently. MIN() picks the smallest (chronologically earliest) date within that group.

For player 1: the earliest of the three dates is 2016-03-01
For player 2: only one date, so it's 2017-06-25
For player 3: the earliest is 2016-03-02
4. AS first_login
Renames the computed column in the output so it reads first_login instead of just MIN(event_date).

5. SELECT player_id, ...
Selects the group identifier alongside the aggregate. Note: any non-aggregated column in the SELECT must appear in the GROUP BY (here player_id does).

The Output
Table
player_id	first_login
1	2016-03-01
2	2017-06-25
3	2016-03-02
Each row is one player with their very first login date.

Why It's "Easy"
The composite primary key (player_id, event_date) guarantees no duplicate dates within a player's group, so MIN() always returns a clean, unambiguous value. No ORDER BY is needed because the problem doesn't specify output ordering.

Common Mistakes to Avoid
Forgetting the AS first_login alias — the column name must exactly match the expected output.
Adding ORDER BY event_date inside the query — unnecessary here since the problem doesn't require it, and it can't "order" within groups anyway.
Selecting columns like device_id without putting them in GROUP BY — that would throw a syntax error in most databases. (That's exactly what the harder follow-up "Game Play Analysis II" addresses.)
*/


SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;


/*
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/
