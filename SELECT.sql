SELECT 
    dept_no
FROM
    departments;

SELECT 
    *
FROM
    departments;
    
SELECT 
    *
FROM
    employees
where
	first_name = 'Elvis';

SELECT
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE ('%JACK%');
SELECT
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%'); 

SELECT

    *

FROM

    salaries;

 

SELECT
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
   
SELECT
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

SELECT
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;

SELECT 
    *
FROM
    employees
WHERE
    gender = ('F')
        AND hire_date >= ('2000-01-01'); 

SELECT
    *
FROM
    salaries
WHERE
    salary > 150000;

select distinct
	hire_date
from employees ;

select
	count(*)
from
	salaries
where
	salary >= 100000;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

select
	salary, count('emp_no') as emps_with_same_salary
from
	salaries
where
	salary >= 80000
group by salary
order by salary;

SELECT
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

SELECT 
    emp_no, COUNT(emp_no) AS emp_contract_count
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no desc;

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

SELECT
    *
FROM
    dept_emp
LIMIT 10;

insert into dept_emp
(
	emp_no,
    dept_no,
    from_date,
    to_date
)
values
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);
 
SELECT
    *
FROM
    departments;

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_name = 'Business Analysis';
commit;
DELETE FROM departments 
WHERE
    dept_no = 'd0010';
rollback;

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    MAX(emp_no)
FROM
    employees;
SELECT 
    MIN(emp_no)
FROM
    employees;
    
SELECT 
    ROUND(AVG(salary),2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments
ORDER BY dept_no ASC;
SELECT 
    emp_no, birth_date, COALESCE(first_name, last_name) AS name
FROM
    employees;

DROP TABLE IF EXISTS departments_dup;
CREATE TABLE departments_dup
(
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);
INSERT INTO departments_dup
	(dept_no,dept_name)
SELECT
	*
FROM
	departments;

INSERT INTO departments_dup (dept_name)
VALUES                ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES					(999904, '2017-01-01'),
						(999905, '2017-01-01'),
						(999906, '2017-01-01'), 
                        (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

SELECT 
    e.emp_no, e.first_name, e.last_name, t.title, e.hire_date
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch';
        
SELECT
    dm.*, d.*  
FROM  
    departments d  
        CROSS JOIN  
    dept_manager dm  
WHERE  
    d.dept_no = 'd009'  
ORDER BY d.dept_no;

SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;