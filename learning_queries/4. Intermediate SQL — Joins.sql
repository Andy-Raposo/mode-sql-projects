-- =========================================================
-- Joins
-- Dataset: tutorial.aapl_historical_stock_price
--
-- =========================================================


-- ---------------------------------------------------------
-- Inspect dataset
-- ---------------------------------------------------------
-- Display the contents of the Apple historical stock table.

SELECT *
FROM tutorial.aapl_historical_stock_price;



-- ---------------------------------------------------------
-- Monthly trading volume
-- ---------------------------------------------------------
-- Calculate the total number of shares traded each month.
-- Results are ordered chronologically.

SELECT year,
       month,
       SUM(volume) AS monthly_volume
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month;



-- ---------------------------------------------------------
-- Average daily price change by year
-- ---------------------------------------------------------
-- Calculate the average difference between closing price
-- and opening price for each year.

SELECT year,
       AVG(close - open) AS avg_daily_change
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year;



-- ---------------------------------------------------------
-- Monthly price range
-- ---------------------------------------------------------
-- Determine the lowest and highest prices Apple stock
-- reached each month.

SELECT year,
       month,
       MIN(low)  AS monthly_low_price,
       MAX(high) AS monthly_high_price
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month;



-- ---------------------------------------------------------
-- Which conference has the heaviest average players?
-- ---------------------------------------------------------
-- A simple query to find what are the players with a
-- bigger body weight on average, per conference.

SELECT
    t.conference,
    AVG(p.weight) AS avg_player_weight
FROM benn.college_football_players p
JOIN benn.college_football_teams t
    ON p.school_name = t.school_name
GROUP BY year, month
ORDER BY year, month DESC;

