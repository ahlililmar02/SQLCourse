SELECT
    emp_no,
    dept_no,
    ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM
dept_manager;

SELECT
emp_no,
first_name,
last_name,
ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num
FROM
employees;

SELECT
dm.emp_no,
    s.salary,
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num2
FROM
dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;

SELECT
dm.emp_no,
    s.salary,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   
FROM
dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no;
    
SELECT
    ROW_NUMBER() OVER () AS row_num1,
    t.emp_no,
    t.title,
    s.salary,
    ROW_NUMBER() OVER (PARTITION BY t.emp_no ORDER BY salary DESC) AS row_num2   
FROM
titles t
    JOIN 
    salaries s ON t.emp_no = s.emp_no
Order By t.emp_no, salary, row_num1 asc;

SELECT
	emp_no,
	first_name,
	ROW_NUMBER() OVER w AS row_num
FROM
	employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);                                                                                                                                                                                                                                                       
SELECT a.emp_no,
       MIN(salary) AS min_salary FROM (
SELECT
emp_no, salary, ROW_NUMBER() OVER w AS row_num
FROM
salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
GROUP BY emp_no;

SELECT a.emp_no,
a.salary as min_salary FROM (
SELECT
emp_no, salary, ROW_NUMBER() OVER w AS row_num
FROM
salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=1;

SELECT
emp_no,
salary,
RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);



SELECT
emp_no,
salary,
DENSE_RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);