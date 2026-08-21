/*

------------------------------------------------------------Description------------------------------------------------------------
Big Countries
Table: World

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
 
A country is big if:
it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.

Return the result table in any order.

The result format is in the following example.


Example 1:

Input: 
World table:
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
Output: 
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
*/




/*
------------------------------------------------------------Approach------------------------------------------------------------

Your query is correct — that's the straightforward SQL solution for this problem. Let me walk through the approach.

### Approach

The solution is a simple `SELECT` statement with a `WHERE` clause containing an `OR` condition:

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;
```

### How it works

1. **Selection of columns**: We only need three columns — `name`, `population`, and `area` — matching exactly what the problem asks to return.

2. **The `WHERE` filter**: The condition uses the **OR** operator, which means a row qualifies if it meets *either* of the two criteria:
   - `area >= 3000000` — the country's area is at least 3 million km².
   - `population >= 25000000` — the country's population is at least 25 million.

   A country like Russia qualifies on area; a country like Japan qualifies on population; and a country like China, India, or the United States qualifies on both.

### Key considerations

- **Important**: The OR operator means a country only needs to satisfy **one** of the conditions to be included. If you mistakenly used `AND`, you'd only get countries that are both enormous in area *and* huge in population — that would be incorrect.
- **Order**: The output rows can be in any order since the problem doesn't require sorting.
- No `GROUP BY`, `ORDER BY`, or `JOIN` are needed — this is a flat table scan with a filtering condition.

### Alternative (Pandas)

If you're solving in Python instead, the equivalent would be:

```python
big = world[(world['area'] >= 3000000) | (world['population'] >= 25000000)]
result = big[['name', 'population', 'area']]
```

Note the `|` operator for OR (with parentheses around each condition).
*/







------------------------------------------------------------CODE------------------------------------------------------------


select name ,population,area from world where area>=3000000 or population>=25000000;




/*
Input: 
World table:
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
Output: 
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
*/
