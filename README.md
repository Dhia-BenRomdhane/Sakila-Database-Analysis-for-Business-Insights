# Sakila-Database-Analysis-for-Business-Insights
An in-depth SQL analysis of the Sakila database to extract business insights from the DVD rental store dataset containing 16,000+ rental transactions using advanced SQL queries.

## Overview

This project explores customer behavior, movie popularity, and store performance within the Sakila database using SQL. The analysis answers a set of practical business questions using joins, aggregations, window functions, and views.

## Business Questions Answered

- Which movies and genres are most popular by rental count?
- Which customers rent the most movies?
- Which store generates the most revenue?
- What are the peak rental periods, and how do they trend by month?
- What are the most rented movies within each month?

## Techniques Used

- Multi-table joins across `film`, `inventory`, `rental`, `customer`, `category`, `payment`, and `store`
- Aggregate functions (`COUNT`, `SUM`) with `GROUP BY`
- Window functions (`ROW_NUMBER() OVER (PARTITION BY ...)`) to rank results within groups
- Nested/derived-table queries to filter on computed rankings
- SQL views to streamline access to relevant results

## Files

- `sakila_queries.sql` — all analysis queries, organized by business question
- `schema.sql` — Sakila database schema (table definitions)
- `data.sql` — Sakila sample data (to populate the database)
- `sakila.mwb` — for MySQL Workbench

## Tech Stack

`SQL` · `MySQL`

## Author

Dhia Ben Romdhane — Master's in Business Analytics, Tunis Business School
