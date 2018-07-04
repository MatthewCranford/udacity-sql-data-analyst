-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH t1 AS (
    SELECT r.name region, sr.name rep, SUM(o.total_amt_usd) total_sales
    FROM accounts a 
    JOIN orders o
    ON a.id = o.account_id
    JOIN sales_reps sr 
    ON a.sales_rep_id = sr.id 
    JOIN region r 
    ON r.id = sr.region_id 
    GROUP BY 1,2
    ORDER BY 3 DESC),
t2 AS (
    SELECT region, MAX(total_sales) max_sales
    FROM t1
    GROUP BY 1
)

SELECT t1.rep, t1.region, t1.total_sales
FROM t1
JOIN t2
ON t2.region = t1.region AND t2.max_sales = t1.total_sales;

-- For the region with the largest sales total_amt_usd, how many total orders were placed? 
WITH t1 AS (
    SELECT r.name region, SUM(o.total_amt_usd) sales
    FROM accounts a 
    JOIN orders o
    ON a.id = o.account_id
    JOIN sales_reps sr 
    ON a.sales_rep_id = sr.id 
    JOIN region r 
    ON r.id = sr.region_id 
    GROUP BY 1
    ORDER BY 2 DESC),
t2 AS (
    SELECT MAX(sales)
    FROM t1)   

SELECT r.name region, COUNT(o.total) 
FROM accounts a 
JOIN orders o
ON a.id = o.account_id
JOIN sales_reps sr 
ON a.sales_rep_id = sr.id 
JOIN region r 
ON r.id = sr.region_id 
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (select * FROM t2)


-- For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases? 
WITH t1 AS (
    SELECT a.name account_name, SUM(o.standard_qty) std_purchases
    FROM accounts a 
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1),
t2 AS (
    SELECT a.name
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    GROUP BY 1
    HAVING SUM(o.total) > (SELECT std_purchases FROM t1))

SELECT COUNT(*)
FROM t2


-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
WITH t1 AS (
    SELECT a.name customer, SUM(o.total_amt_usd) total
    FROM accounts a
    JOIN web_events we
    ON a.id = we.account_id
    JOIN orders o 
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1)

SELECT a.name, we.channel, COUNT(we.channel) num_chans
FROM accounts a
JOIN web_events we
ON a.id = we.account_id AND a.name = (SELECT customer FROM t1)
GROUP BY 1, 2
ORDER BY 3

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
WITH t1 AS (
    SELECT a.id, SUM(o.total_amt_usd) total
    FROM accounts a
    JOIN orders o 
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10)

SELECT AVG(total)
FROM T1

-- What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all accounts.
WITH t1 AS (
    SELECT AVG(o.total_amt_usd) all_avg
    FROM accounts a
    JOIN orders o 
    ON a.id = o.account_id),
t2 AS (
    SELECT a.id, AVG(o.total_amt_usd) total_avg
    FROM accounts a
    JOIN orders o 
    ON a.id = o.account_id
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1)
)

SELECT AVG(total_avg)
FROM t2