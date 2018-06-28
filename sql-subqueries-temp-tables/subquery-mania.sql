-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT t3.sales_rep, t3.region_name, t3.total_sales
FROM
  (SELECT region_name, MAX(total_sales) max_sales
  FROM
    (SELECT sr.name sales_rep, r.name region_name, SUM(o.total_amt_usd) total_sales
    FROM accounts a
    JOIN sales_reps sr
    ON a.sales_rep_id = sr.id
    JOIN region r
    ON sr.region_id = r.id
    JOIN orders o 
    ON a.id = o.account_id
    GROUP BY 1, 2) t1
 ) t2
JOIN 
  (SELECT sr.name sales_rep, r.name region_name, SUM(o.total_amt_usd) total_sales
  FROM accounts a
  JOIN sales_reps sr
  ON a.sales_rep_id = sr.id
  JOIN region r
  ON sr.region_id = r.id
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY 1, 2
  ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_sales = t2.max_sales



-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed? 
SELECT r.name, COUNT(o.total) total
FROM accounts a
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1
HAVING  SUM(o.total_amt_usd) =
(SELECT MAX(t1.total_sales)
    FROM
      (SELECT r.name region, SUM(o.total_amt_usd) total_sales
          FROM accounts a
          JOIN sales_reps sr
          ON a.sales_rep_id = sr.id
          JOIN region r
          ON sr.region_id = r.id
          JOIN orders o 
          ON a.id = o.account_id
          GROUP BY 1) t1
     )

-- For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases? 
SELECT COUNT(*)
FROM
  (SELECT a.name
  FROM accounts a
  JOIN orders o 
  ON o.account_id = a.id
  GROUP BY 1
  HAVING SUM(o.total) > 
    (SELECT total
    FROM
      (SELECT a.name, a.id, SUM(o.standard_qty) total_std, SUM(o.total) total
      FROM accounts a
      JOIN orders o 
      ON a.id = o.account_id
      GROUP BY 1,2
      ORDER BY 3 DESC
      LIMIT 1) t1)
  ) t2;

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT a.id, a.name, we.channel, COUNT(*) total
FROM accounts a
JOIN web_events we
ON a.id = we.account_id AND a.name = 
  (SELECT comp
  FROM
    (SELECT a.name comp, SUM(o.total_amt_usd) total_amt
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1) t1)
GROUP BY 1,2,3

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(t1.total) total_avg
FROM
  (SELECT a.name account, SUM(o.total_amt_usd) total
  FROM accounts a 
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY 1 
  ORDER BY 2 DESC
  LIMIT 10) t1

-- What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all orders.
SELECT AVG(t2.avg_tot)
FROM
  (SELECT a.name account ,AVG(o.total_amt_usd) avg_tot
  FROM accounts a 
  JOIN orders o 
  ON a.id = o.account_id
  GROUP BY 1
  HAVING AVG(o.total_amt_usd) >
    (SELECT AVG(o.total_amt_usd) avg_all
    FROM accounts a 
    JOIN orders o 
    ON a.id = o.account_id)
  ) t2


