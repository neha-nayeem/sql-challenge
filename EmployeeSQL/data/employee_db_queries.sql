-- EMPLOYEE DATABASE: A MYSTERY IN TWO PARTS
-- DATA ANALYSIS

-- Q1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no
ORDER BY employees.emp_no

-- Q2. List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = '1986'

-- Q3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, 
	   employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no

-- Q4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name
-- creating a view for later use in Q6 & Q7.
CREATE VIEW employees_in_depts AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY dept_emp.emp_no

-- Q5. List first name, last name, and sex for employees 
-- whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'

-- Q6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name
-- using the view created in Q4
SELECT *
FROM employees_in_depts
WHERE dept_name = 'Sales'

-- Q7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name
-- using the view created in Q4
SELECT *
FROM employees_in_depts
WHERE dept_name = 'Sales'
OR dept_name = 'Development'

-- Q8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name, COUNT(last_name) AS "Frequency Count"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count" DESC
