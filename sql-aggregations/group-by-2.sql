-- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account. 
SELECT a.name, AVG(standard_qty) avg_standard_purchased, AVG(gloss_qty) avg_gloss_purchased, AVG(poster_qty) avg_poster_purchased
FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
GROUP BY a.name;

-- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
SELECT a.name, AVG(standard_amt_usd) avg_standard_spent, AVG(gloss_amt_usd) avg_gloss_spent, AVG(poster_amt_usd) avg_poster_spent
FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
GROUP BY a.name;

-- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT s.name, w.channel, COUNT(s.name) occurrences
FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
GROUP BY w.channel, s.name
ORDER BY occurrences DESC;

-- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.