-- =========================================================
-- Basic SQL Queries
-- Dataset: tutorial.us_housing_units
--
-- The following queries were written while completing the
-- SQL tutorial from Mode Analytics. The datasets are hosted
-- in a public warehouse provided by Mode and allow users to
-- practice SQL using real-world style data.
--
-- This dataset contains monthly housing construction data
-- in the United States, broken down by four major regions:
-- South, West, Midwest, and Northeast. The data spans
-- several decades, allowing us to perform filtering,
-- comparisons, and basic calculations between columns.
-- =========================================================


-- ---------------------------------------------------------
-- Display housing unit production by region
-- ---------------------------------------------------------
-- This query shows the number of housing units built in each
-- region of the United States for the past ~50 years.

SELECT year AS "Year",
       month AS "Month",
       month_name AS "Month name",
       south AS "South",
       west AS "West",
       midwest AS "Midwest",
       northeast AS "Northeast"
FROM tutorial.us_housing_units
WHERE year >= 1970
AND month_name != 'January'
LIMIT 1000;



-- ---------------------------------------------------------
-- Regional production thresholds
-- ---------------------------------------------------------
-- Did the West region ever produce more than 50,000 housing
-- units in a single month?

SELECT year AS "Year",
       month AS "Month",
       west AS "West"
FROM tutorial.us_housing_units
WHERE west > 50
LIMIT 1000;

-- Result: Yes. This occurred twice in 1978 and once in 2004.



-- Did the South region ever produce 20,000 or fewer units
-- in a single month?

SELECT year AS "Year",
       month AS "Month",
       south AS "South"
FROM tutorial.us_housing_units
WHERE south < 20
LIMIT 1000;

-- Result: Yes. This occurred three times in 2011 and 2012.



-- ---------------------------------------------------------
-- Filtering by text values
-- ---------------------------------------------------------

-- Show only rows where the month name is February.

SELECT *
FROM tutorial.us_housing_units
WHERE month_name = 'February';



-- Show rows where the month name starts with the letter
-- "N" or any earlier letter in the alphabet.

SELECT *
FROM tutorial.us_housing_units
WHERE month_name < 'N';



-- ---------------------------------------------------------
-- Column arithmetic
-- ---------------------------------------------------------
-- SQL allows arithmetic operations between columns to
-- generate derived values.

-- Example: Combine West and South regional totals.

SELECT year,
       month,
       west,
       south,
       west + south AS south_plus_west
FROM tutorial.us_housing_units;



-- Example: Calculate total housing units built across
-- all regions per month.

SELECT year,
       month_name,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest + northeast AS total_sum
FROM tutorial.us_housing_units;



-- ---------------------------------------------------------
-- Regional comparison
-- ---------------------------------------------------------
-- Return rows where the West region produced more housing
-- units than the Midwest and Northeast combined.

SELECT *,
       midwest + northeast AS mw_plus_ne
FROM tutorial.us_housing_units
WHERE west > (midwest + northeast);



-- ---------------------------------------------------------
-- Regional contribution percentages
-- ---------------------------------------------------------
-- Calculate the percentage contribution of each region to
-- the total number of houses built in the United States.
-- Only include results from the year 2000 onwards.

SELECT year,
       month_name,
       south / (south + west + midwest + northeast) AS south_per,
       west / (south + west + midwest + northeast) AS west_per,
       midwest / (south + west + midwest + northeast) AS midwest_per,
       northeast / (south + west + midwest + northeast) AS northeast_per
FROM tutorial.us_housing_units
WHERE year >= 2000;