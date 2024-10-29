use employees_mod;
SELECT
    YEAR(de.from_date) AS calendar_date,
    e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM
    t_employees e
JOIN
    t_dept_emp de ON e.emp_no = de.emp_no
WHERE
    YEAR(de.from_date) >= 1990
GROUP BY
    YEAR(de.from_date), e.gender
ORDER BY
    calendar_date;