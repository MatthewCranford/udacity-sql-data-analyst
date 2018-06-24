-- Quiz 1
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders;

-- Quiz 2
SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gloss, AVG(poster_qty)avg_post
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
  (SELECT DATE_TRUNC('month', MIN(occurred_at))
  FROM orders)

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
  (SELECT DATE_TRUNC('month', MIN(occurred_at))
  FROM orders)
