-- =========================================================
-- Advanced Joins
-- Datasets:
-- tutorial.crunchbase_companies
-- tutorial.crunchbase_acquisitions
-- tutorial.crunchbase_investments_part1
-- tutorial.crunchbase_investments
--
-- Crunchbase is a crowdsourced database containing
-- information about startups, founders, investors, and
-- acquisitions. The datasets used here allow us to explore
-- relationships between companies, acquisitions, and
-- investments.
--
-- The companies table contains one row per company, while
-- the acquisitions table contains one row per acquisition.
-- By joining these tables we can examine how acquisition
-- activity relates to company data.
-- =========================================================



-- ---------------------------------------------------------
-- Inspect datasets
-- ---------------------------------------------------------

SELECT *
FROM tutorial.crunchbase_companies;

SELECT *
FROM tutorial.crunchbase_acquisitions;



-- ---------------------------------------------------------
-- Basic INNER JOIN
-- ---------------------------------------------------------
-- Join companies with acquisitions using the acquirer
-- permalink. This returns companies that have acquired
-- other companies.

SELECT *
FROM tutorial.crunchbase_companies AS comps
INNER JOIN tutorial.crunchbase_acquisitions AS acqs
        ON comps.permalink = acqs.acquirer_permalink;



-- ---------------------------------------------------------
-- Counting joined rows
-- ---------------------------------------------------------
-- Instead of listing rows, count the number of matched
-- records between companies and acquisitions.

SELECT
       COUNT(companies.permalink)              AS companies_rowcount,
       COUNT(acquisitions.company_permalink)   AS acquisitions_rowcount
FROM tutorial.crunchbase_companies AS companies
LEFT JOIN tutorial.crunchbase_acquisitions AS acquisitions
       ON companies.permalink = acquisitions.company_permalink;

-- This demonstrates how a LEFT JOIN retains all rows from
-- the left table while including matching rows from the
-- right table where available.



-- ---------------------------------------------------------
-- Company counts by state
-- ---------------------------------------------------------
-- Count the number of unique companies and the number of
-- acquired companies by state. Exclude rows where the
-- state is unknown.

SELECT
       comps.state_code,
       COUNT(DISTINCT comps.permalink)           AS unique_company_count,
       COUNT(DISTINCT acqs.company_permalink)    AS unique_acquired_company_count
FROM tutorial.crunchbase_companies AS comps
LEFT JOIN tutorial.crunchbase_acquisitions AS acqs
       ON comps.permalink = acqs.company_permalink
WHERE comps.state_code IS NOT NULL
GROUP BY comps.state_code
ORDER BY unique_acquired_company_count DESC;



-- ---------------------------------------------------------
-- RIGHT JOIN version
-- ---------------------------------------------------------
-- Rewriting the previous query using a RIGHT JOIN while
-- producing the same results.

SELECT
       comps.state_code,
       COUNT(DISTINCT comps.permalink)           AS unique_company_count,
       COUNT(DISTINCT acqs.company_permalink)    AS unique_acquired_company_count
FROM tutorial.crunchbase_acquisitions AS acqs
RIGHT JOIN tutorial.crunchbase_companies AS comps
        ON acqs.company_permalink = comps.permalink
WHERE comps.state_code IS NOT NULL
GROUP BY comps.state_code
ORDER BY unique_acquired_company_count DESC;



-- ---------------------------------------------------------
-- FULL JOIN example
-- ---------------------------------------------------------
-- Join companies and investments and count how many rows
-- appear only in one table versus both tables.

SELECT
  COUNT(CASE
        WHEN company.permalink IS NOT NULL
         AND investment.company_permalink IS NULL
        THEN company.permalink
       END) AS company_only,

  COUNT(CASE
        WHEN company.permalink IS NOT NULL
         AND investment.company_permalink IS NOT NULL
        THEN company.permalink
       END) AS both_tables,

  COUNT(CASE
        WHEN company.permalink IS NULL
         AND investment.company_permalink IS NOT NULL
        THEN investment.company_permalink
       END) AS investment_only

FROM tutorial.crunchbase_companies AS company
FULL JOIN tutorial.crunchbase_investments_part1 AS investment
       ON company.permalink = investment.company_permalink;




-- ---------------------------------------------------------
-- Additional testing
-- ---------------------------------------------------------
-- Write a query that shows a company's name, "status" 
-- (found in the Companies table), and the number of unique 
-- investors in that company. Order by the number of 
-- investors from most to fewest. Limit to only companies in 
-- the state of New York.
--
-- NOTE: company_permalink in this investment database 
-- relates to permalink on the companies database. Also, 
-- this table, unlike the previous one, has rows for ALL 
-- investments made, even if repeated in the same company.

SELECT c.name,
       c.status,
       COUNT(DISTINCT i.company_name) AS unique_investors
FROM tutorial.crunchbase_companies AS c
JOIN tutorial.crunchbase_investments AS i
ON c.permalink = i.company_permalink
WHERE c.state_code = 'NY'
GROUP BY c.status, c.name
ORDER BY unique_investors DESC;


-- ---------------------------------------------------------
-- Write a query that lists investors based on the number of 
-- companies in which they are invested. Include a row for 
-- companies with no investor, and order from most companies 
-- to least.







-- ---------------------------------------------------------
-- NOTES
-- ---------------------------------------------------------
--
-- 1. WHERE and ON clauses both can manipulate and filter
-- data, but doing it within the ON clause filters data
-- before the JOIN, while doing it within the WHERE clause
-- filters it after the JOIN.