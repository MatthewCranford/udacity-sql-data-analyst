-- Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc. 
SELECT a.primary_poc, LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)) AS first_name, RIGHT(a.primary_poc, LENGTH(a.primary_poc) - POSITION(' ' IN a.primary_poc)) AS last_name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id

-- Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
SELECT name, LEFT(name, POSITION(' ' IN name)) AS first_name, RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) AS last_name
FROM sales_reps
