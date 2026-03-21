## SQL Learning Walkthrough

This repository documents my progression in SQL, from basic queries to more advanced concepts such as joins, aggregations, and conditional logic.

The queries were written using Mode Analytics’ public SQL training warehouse and executed with PostgreSQL and DBeaver. Each file corresponds to a lesson or case study on the Mode platform that I have adapted, extended, and worked locally with, applying the concepts in real-world datasets.

---

## Repository Structure

- **`databases/`**
  Contains the datasets used throughout the exercises (CSV format).

- **`learning_queries/`**
  Step-by-step SQL queries organized by topic and difficulty level:

  1. Basic SQL Concepts
  2. Aggregate Functions
  3. Logical Operators
  4. Joins
  5. Advanced Joins
  6. Additional Operators
  7. CASE Statements

---

## How to Use This Repository

- Follow the files in `learning_queries/` in numerical order to see a structured learning path.
- Each file builds on previous concepts, using real datasets from the `databases/` folder.
- Queries are written for PostgreSQL syntax and using DBeaver as the GUI. You can replicate them yourself in your machine with the data provided.

---

## Data Sources

These exercises are based on datasets from Mode Analytics' SQL tutorial environment:

- `tutorial.us_housing_units` – US housing data
- `tutorial.billboard_top_100_year_end` – Billboard Top 100
- `tutorial.aapl_historical_stock_price` – Apple stock prices
- `benn.college_football_players` and `benn.college_football_teams` – College football dataset
- `tutorial.crunchbase_*` – Crunchbase company, acquisitions, and investments data

> Note: Table names (e.g., `tutorial.*`) refer to Mode Analytics’ hosted environment and may need adjustment if run locally.

---

## Purpose

The goal of this repository is to:

- Practice and reinforce SQL all the way to CTEs, Windows and advanced SQL.
- Work with real-world datasets to display real, meaningful findings.
- Build a clear, progressive record of my self-learning path.

---

## Future Plans (short-term)

- Add more advanced SQL topics (window functions, CTEs, subqueries)
- Include query explanations and comments on the already existing files
