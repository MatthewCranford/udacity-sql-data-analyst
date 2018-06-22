-- How many of the sales reps have more than 5 accounts that they manage?
SELECT s.name, COUNT(a.sales_rep_id) num_accounts
FROM sales_reps s
    JOIN accounts a
    ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(a.sales_rep_id) > 5
ORDER BY num_accounts DESC;

-- How many accounts have more than 20 orders?
SELECT a.name, COUNT(*) num_orders
FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(*) > 20
ORDER BY num_orders DESC;

-- Which account has the most orders?
SELECT a.name, COUNT(*) num_orders
FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1;

-- How many accounts spent more than 30,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent DESC

-- How many accounts spent less than 1,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent DESC

-- Which account has spent the most with us?
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;

-- Which account has spent the least with us?
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY COUNT;

-- Which account used facebook most as a channel? 
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY COUNT DESC
LIMIT 1;

-- Which channel was most frequently used by most accounts?
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY count DESC
LIMIT 1;



