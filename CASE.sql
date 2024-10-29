

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        left JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    (MAX(s.salary) - MIN(s.salary)) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary is high'
        ELSE 'Salary is not high'
    END AS is_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;
