-- D1: CREATE RETIREMENT INFO TABLE
-- BY JOINING EMPLOYEES AND TITLE TABLES
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- DATA FOR MOST RECENT EMPLOYEE TITLE
SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


--RETIRING EMPLOYEES BY TITLE
SELECT COUNT(title) 
	count,
	title
NTO retiring_titles
FROM unique_titles
GROUP BY (title)
ORDER BY count desc;




--D2: EMPLOYEES ELIGIBLE FOR MENTORSHIP
SELECT DISTINCT ON (emp_no)
        e.emp_no, 
        e.first_name,
        e.last_name,
        e.birth_date,
        de.from_date,
        de.to_date,
        ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_employees as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND de.to_date = '9999-01-01'
ORDER BY emp_no, ti.from_date DESC;