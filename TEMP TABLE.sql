#1:

CREATE TEMPORARY TABLE male_max_salaries as
SELECT
    s.emp_no, MAX(s.salary)
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no;



#2:

SELECT 
    *
FROM
    male_max_salaries;
    
DROP TEMPORARY TABLE IF exists male_max_salaries;

 #1:

CREATE TEMPORARY TABLE dates
SELECT
    NOW(),
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;

 #2:
SELECT
    *
FROM
    dates dates;

 #3:
WITH cte AS (SELECT
    NOW(),
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS cte_a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS cte_a_year_later)
SELECT * FROM dates d1 JOIN cte c;

 #4:
WITH cte AS (SELECT
    NOW(),
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS cte_a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS cte_a_year_later)
SELECT * FROM dates UNION SELECT * FROM cte;

 #5:
DROP TABLE IF EXISTS male_max_salaries;

DROP TABLE IF EXISTS dates;