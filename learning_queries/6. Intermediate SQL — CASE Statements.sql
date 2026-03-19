-- ---------------------------------------------------------
-- CASE statements — the basics
-- ---------------------------------------------------------
-- To showcase how CASE statements work, the following query
-- must include a column that is flagged "yes" when a player 
-- is from California, and sort the results with those
-- players first.

SELECT player_name,
       hometown,
       CASE WHEN state = 'CA' THEN 'yes'
       ELSE NULL
       END AS is_from_california
FROM benn.college_football_players
ORDER BY 3;


-- ---------------------------------------------------------
-- But there are also cases where we may want to filter
-- information by sections (like height or weight), or we
-- have more than one condition to fulfill. CASE statements
-- allow to chain cases. To showcase such, then:
-- ---------------------------------------------------------
-- Write a query that includes players' names and a column 
-- that classifies them into four or five categories based 
-- on weight. Since the database is in pounds, an additional
-- kgs column must be done.

SELECT player_name,
       weight AS weight_in_lbs,
       weight * 0.45359237 AS weight_in_kgs,
       CASE WHEN weight * 0.45359237 < 70 THEN 'under_70_kgs'
            WHEN weight * 0.45359237 >= 70 AND weight * 0.45359237 < 100 THEN 'between_70_and_100'
            WHEN weight * 0.45359237 >= 100 AND weight * 0.45359237 < 130 THEN 'between_100_and_130'
            WHEN weight * 0.45359237 >= 130 THEN 'over_130_kgs'
       ELSE NULL END AS weight_range
FROM benn.college_football_players

-- Now from here on we could do the most logical operation:
-- To count the number of appearances of each category. 
-- However, that would make necessary the use of CTEs which
-- will be seen later on.


-- ---------------------------------------------------------
-- CASE statements — aggregate functions
-- ---------------------------------------------------------
-- Write a query that counts the number of 300lb+ players 
-- for each of the following regions: A, OR, WA or Other 
-- (everywhere else).

SELECT CASE WHEN state = 'CA' THEN 'CA'
            WHEN state = 'OR' THEN 'OR'
            WHEN state = 'WA' THEN 'WA'
            ELSE 'OTHER' END AS state,
            COUNT(1) AS count
FROM benn.college_football_players 
GROUP BY 1


-- Query that returns all rows for which someone named John 
-- was a member of the group.

SELECT full_school_name,
       SUM(CASE WHEN player_name ILIKE '%John%' THEN 1 ELSE 0 END) AS john_count
FROM benn.college_football_players
GROUP BY 1
ORDER BY 2 DESC;