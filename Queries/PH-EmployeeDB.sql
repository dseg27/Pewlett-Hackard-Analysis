-- Creating tables for PH-EmployeeDB
CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE(dept_name)
);


CREATE TABLE employees(
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);


CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL PRIMARY KEY,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp(
    emp_no INT NOT NULL,
    dept_no VARCHAR NOT NULL, 
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no), 
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles(
    emp_no INT NOT NULL,
    title VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Retirement eligibility 
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' and '1988-12-31');

SELECT* FROM retirement_info;
DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables 
SELECT d.dept_name,
	 dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Left join to add dept_no to retirement_info
-- Current emp has employees born bewteen 1952-1955 and 
-- hired between '85-'88

SELECT ri.emp_no,
	ri.first_name, 
	ri.last_name, 
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')

-- SELECT * FROM retirement_info LIMIT(5)
	
-- Using additional functions 
SELECT COUNT(ce.emp_no), de.dept_no 
INTO retirement_dept_counts
FROM current_emp as ce
LEFT JOIN dept_emp as de 
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no; 

-- CREATING NEW LISTS (MODULE 7.3.5)

-- Viewing to_date in salaries table 
SELECT * FROM salaries
ORDER BY to_date DESC;

-- LIST 1 -- 
-- Reuse code showing retirees with a join

SELECT e.emp_no,
	e.first_name,
	e.last_name, 
	e.gender, 
	s.salary, 
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- LIST 2: MANAGEMENT 
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);
		
-- LIST 3 add dept name to current_emp 
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name, 
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);

-- Tailored Lists 
-- SELECT * FROM retirement_info LIMIT(5);
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
-- INTO tailored_list_1
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON(de.dept_no = d.dept_no)
WHERE (d.dept_name= 'Sales'); 
		
-- TAILORED LIST 2
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO tailored_list_2
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON(de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');

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
	



