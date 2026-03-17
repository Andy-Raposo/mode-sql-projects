-- =========================================================
-- Logical Operators
-- Dataset: tutorial.billboard_top_100_year_end
--
-- This dataset contains the Billboard Year-End Top 100 songs
-- for each year up to 2014.
--
-- Column Notes:
-- year_rank  -> Rank of the song at the end of the listed year
-- group_name -> Full credited artist/group (can include collaborations)
-- artist     -> Individual artist name (may also represent a group)
-- =========================================================


-- ---------------------------------------------------------
-- LIKE and ILIKE Operators
-- ---------------------------------------------------------

-- Return all rows where Ludacris was part of the group.
-- ILIKE is used for case-insensitive matching.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE group_name ILIKE '%Ludacris%';


-- Return all rows where the first listed artist name begins with "DJ".

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist LIKE 'DJ%';



-- ---------------------------------------------------------
-- IN Operator
-- ---------------------------------------------------------

-- Retrieve all entries for Elvis Presley and M.C. Hammer.
-- First we identify all possible "Hammer" variations.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE group_name ILIKE '%hammer%';


-- After inspection we discard "Jan Hammer"
-- and keep only the relevant artist names.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist IN ('Elvis Presley', 'Hammer', 'M.C. Hammer');



-- ---------------------------------------------------------
-- BETWEEN Operator
-- ---------------------------------------------------------

-- Return all Top 100 songs between 1985 and 1990.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1985 AND 1990;



-- ---------------------------------------------------------
-- OR Operator
-- ---------------------------------------------------------

-- Return all Top-10 songs that feature either Katy Perry or Bon Jovi.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
AND (group_name ILIKE '%Katy%' OR group_name ILIKE '%Jovi%');



-- ---------------------------------------------------------
-- String Filtering Example
-- ---------------------------------------------------------

-- Return songs with titles containing the word "California"
-- in either the 1970s or the 1990s.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name ILIKE '%California%'
AND (year BETWEEN 1970 AND 1979
     OR year BETWEEN 1990 AND 1999);



-- ---------------------------------------------------------
-- OR vs NOT BETWEEN
-- ---------------------------------------------------------

-- Return Top-100 recordings featuring Dr. Dre
-- before 2000 or after 2009.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE group_name ILIKE '%Dr. Dre%'
AND (year < 2000 OR year > 2009);



-- Equivalent query using NOT BETWEEN

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE group_name ILIKE '%Dr. Dre%'
AND year NOT BETWEEN 2000 AND 2009;



-- ---------------------------------------------------------
-- COUNT operator
-- ---------------------------------------------------------
-- Write a query that determines counts of every single 
-- column. With these counts, can you tell which column has 
-- the most null values?

SELECT COUNT(aapl.date) AS date_count,
       COUNT(aapl.year) AS year_count,
       COUNT(aapl.month) AS month_count,
       COUNT(aapl.open) AS open_count,
       COUNT(aapl.high) AS high_count,
       COUNT(aapl.low) AS low_count,
       COUNT(aapl.close) AS close_count,
       COUNT(aapl.volume) AS volume_count
FROM tutorial.aapl_historical_stock_price as aapl
