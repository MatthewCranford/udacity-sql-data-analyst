-- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT DATE_PART('year', occurred_at) year_date, SUM(total_amt_usd) total
FROM orders o 
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT DATE_PART('month', occurred_at) month_date, SUM(total_amt_usd) total
FROM orders o 
GROUP BY 1
ORDER BY 2 DESC;

-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
SELECT DATE_PART('year', occurred_at) year_date, COUNT(total_amt_usd) total_sales
FROM orders o 
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
SELECT DATE_PART('month', occurred_at) month_date, COUNT(total_amt_usd) total_sales
FROM orders o 
GROUP BY 1
ORDER BY 2 DESC;

-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT DATE_TRUNC('month', occurred_at) year_date, a.name, SUM(gloss_amt_usd) gloss_sales
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;