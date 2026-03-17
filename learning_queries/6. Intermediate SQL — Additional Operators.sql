-- =========================================================
-- Additional Joins and Functions for them
-- Datasets:
-- tutorial.crunchbase_investments_part1
-- tutorial.crunchbase_investments_part2
-- =========================================================



-- ---------------------------------------------------------
-- UNION operator
-- ---------------------------------------------------------
-- Allows to select and output two databases at the same
-- time. If used with the ALL operator, then it doesn't
-- omit duplicates, which is the most common case.
--
-- Write a query that appends the two crunchbase_investments 
-- datasets above (including duplicate values). Filter the 
-- first dataset to only companies with names that start 
-- with the letter "T", and filter the second to companies 
-- with names starting with "M" (both not case-sensitive). 
-- Only include the company_permalink, company_name, and 
-- investor_name columns.

SELECT company_permalink,
       company_name,
       investor_name
FROM tutorial.crunchbase_investments_part1 i1
WHERE i1.company_name ILIKE 'T%'

UNION ALL

SELECT company_permalink,
       company_name,
       investor_name
FROM tutorial.crunchbase_investments_part2 i2
WHERE i2.company_name ILIKE 'M%'

-- If we do an intersection of the two, we will see nothing
-- will be outputted. That helps us know the two tables are
-- indeed different and now united in what will become
-- "tutorial.crunchbase_investments".



-- ---------------------------------------------------------
-- Write a query that appends the two crunchbase_investments 
-- datasets above (including duplicate values). Filter the 
-- first dataset to only companies with names that start 
-- with the letter "T", and filter the second to companies 
-- with names starting with "M" (both not case-sensitive). 
-- Only include the company_permalink, company_name, and 
-- investor_name columns. Write a query that shows 3 columns. 
-- The first indicates which dataset (part 1 or 2) the data 
-- comes from, the second shows company status, and the third 
-- is a count of the number of investors.
--
-- Hint: you will have to use the 
-- tutorial.crunchbase_companies table as well as the 
-- investments tables.
--
-- And you'll want to group by status and dataset.

SELECT 'Part 1' AS table_origin,
       c.status AS company_status,
       COUNT(DISTINCT i1.investor_permalink) AS number_of_investors
FROM tutorial.crunchbase_investments_part1 i1
LEFT JOIN tutorial.crunchbase_companies c
ON i1.company_permalink = c.permalink
WHERE i1.company_name ILIKE 'T%'
GROUP BY 1, 2

UNION ALL

SELECT 'Part 2' AS table_origin,
       c.status AS company_status,
       COUNT(DISTINCT i2.investor_permalink) AS number_of_investors
FROM tutorial.crunchbase_investments_part2 i2
LEFT JOIN tutorial.crunchbase_companies c
ON i2.company_permalink = c.permalink
WHERE i2.company_name ILIKE 'M%'
GROUP BY 1, 2

-- ---------------------------------------------------------
-- Data Ranges
-- ---------------------------------------------------------
-- In the lessons so far, you've only joined tables by exactly matching values 
-- from both tables. However, you can enter any type of conditional statement 
-- into the ON clause. Here's an example using > to join only investments that 
-- occurred more than 5 years after each company's founding year:

SELECT c.name, c.permalink, c.status, COUNT(i.investor_permalink) AS investors 
FROM tutorial.crunchbase_investments i
FULL JOIN tutorial.crunchbase_companies c
ON i.company_permalink = c.permalink
AND i.funded_year > c.funded_year + 5
GROUP BY 1, 2, 3

-- This would be different though if using a WHERE clause, where the filtering
-- would happen AFTER the join (just change the AND clause with WHERE clause.).



-- ---------------------------------------------------------
-- SELF JOIN
-- ---------------------------------------------------------
-- This JOIN operator is very important in order to separate
-- data within the database itself where some of the data is
-- for example from one region, and the rest from another
-- one. Like in the following, where we seek the companies
-- with an investment from Spain following an investment of
-- Japan

SELECT japan_investments.company_name,
       japan_investments.permalink
FROM tutorial.crunchbase_investments_part1 japan_investments
JOIN tutorial.crunchbase_investments_part1 spain_investments
ON japan_investments.company_name = spain_investments.company_name -- rows that belong to the same company
AND spain_investments.investor_country_code = 'ESP'
AND japan_investments.investor_country_code = 'JPN'
AND spain_investments.funded_at > japan_investments.funded_at
ORDER BY 1