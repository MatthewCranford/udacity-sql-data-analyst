-- Q1
SELECT DATE_TRUNC('day', occurred_at) channel_day, channel, COUNT(id)
FROM web_events 
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Q2
SELECT *
FROM
(SELECT DATE_TRUNC('day', occurred_at) channel_day, channel, COUNT(id)
FROM web_events 
GROUP BY 1, 2
ORDER BY 3 DESC) sub;

-- Q3
SELECT channel,AVG(count)
FROM
(SELECT DATE_TRUNC('day', occurred_at) channel_day, channel, COUNT(id)
FROM web_events 
GROUP BY 1, 2) sub
GROUP BY 1;
