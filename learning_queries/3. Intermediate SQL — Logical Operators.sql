-- =========================================================
-- Aggregate Functions
-- Dataset: tutorial.aapl_historical_stock_price
--
-- These queries are part of the Intermediate SQL section
-- of the Mode Analytics SQL tutorial. The dataset contains
-- historical daily stock price data for Apple Inc.
--
-- The table includes information such as opening price,
-- closing price, trading volume, and daily high/low values.
-- Using aggregate functions allows us to summarize this
-- daily data into meaningful monthly or yearly statistics.
--
-- These queries can be executed using PostgreSQL via the
-- PSQL command line interface or through GUI tools such as
-- DBeaver.
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


-- Write a query to calculate the average opening price
-- without using the AVG formula ()

SELECT COUNT(aapl.open) AS total_count,
       SUM(aapl.open) AS total_price,
       SUM(aapl.open) / COUNT(aapl.open) AS manual_avg_open_price
       AVG(aapl.open) AS formula_avg_open_price
FROM tutorial.aapl_historical_stock_price aapl


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


-- What was the highest single-day increase in Apple's share 
-- value?

SELECT MAX(aapl.close - aapl.open) AS maximum_daily_share_increase
FROM tutorial.aapl_historical_stock_price aapl -- This is the simplest way to do it, but...

-- OR...

SELECT aapl.open AS open_share_price,
       aapl.close AS close_share_price,
       aapl.close - aapl.open AS daily_share_increase
FROM tutorial.aapl_historical_stock_price aapl
WHERE aapl.open IS NOT NULL and aapl.close IS NOT NULL
ORDER BY daily_share_increase DESC
LIMIT 1; -- This is more visual, without writing a subquery
