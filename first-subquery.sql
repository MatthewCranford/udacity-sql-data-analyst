-- Q1
SELECT DATE_PART('day', occurred_at) channel_day, COUNT(id)
FROM web_events 
GROUP BY 1

-- Q2

-- Q3
