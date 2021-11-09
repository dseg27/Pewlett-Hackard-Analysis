-- CHALLENGE CODE--
-- DELIVERABLE 1 -- 

SELECT emp_no, first_name, last_name
FROM employees;

SELECT title, from_date, to_date 
FROM titles;

-- Create retirement_titles table combining data from above
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title, 
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ti
		ON(e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles LIMIT(3);

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) from_date,
to_date,
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC; 

-- Retrieve the number of employees by their most recent job 
-- title who are about to retire. (Total 90,398)

SELECT title, COUNT(title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
	
