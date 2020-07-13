# sql-challenge: Employee Database - A Mystery in Two Parts

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

1. Data Engineering/Data Modeling

2. Data Analysis

All files are inside the folder named for the challenge `EmployeeSQL`. This folder contains:

    * A `data` folder that contains the six CSV files.

    * An `images` folder that contains the Entity-Relationship Diagram, and visualizations from the bonus analysis.

    * An `employee_db_schema.sql` file that contains the table schema for the six tables.

    * An `employee_db_queries.sql` file that contains the eight queries created to answer the questions under *Data Analysis* below.

    * A Jupyter notebook called `bonus-analysis.ipynb` to further analyze the SQL database and create visualizations.

## Data Engineering

There were 6 CSV files which were inspected and the following ERD was created, specifying primary keys, foreign keys and composite keys where applicable:

![ERD.png](/EmployeeSQL/images/employee_db_ERD.png)

The schema for the above information is the `employee_db_schema.sql` file from which tables were created in PostgreSQL and each CSV file was imported into their respective tables to populate the data.

## Data Analysis

Once the database was complete, the following questions were asked. The queries for each question are saved under `employee_db_queries.sql`.

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

```sql
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no
ORDER BY employees.emp_no
```

2. List first name, last name, and hire date for employees who were hired in 1986.

```sql
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = '1986'
```

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

```sql
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, 
	   employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
```

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

```sql
CREATE VIEW employees_in_depts AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY dept_emp.emp_no
```

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

```sql
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'
```

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

```sql
SELECT *
FROM employees_in_depts
WHERE dept_name = 'Sales'
```

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

```sql
SELECT *
FROM employees_in_depts
WHERE dept_name = 'Sales'
OR dept_name = 'Development'
```

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

```sql
SELECT last_name, COUNT(last_name) AS "Frequency Count"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count" DESC
```

## Bonus Analysis

For the bonus section, we had to import our SQL database into Pandas using SQLAlchemy and generate visualizations of the data.

* The script is called `bonus_analysis.ipynb` and was coded using Jupyter notebook. The libraries used were Pandas, Matplotlib, os, sqlalchemy, NumPy and SciPy.
* The database url was created in an environment variable ot protect the database password.
* Only the relevant tables were read into Pandas dataframes using  `read_sql_table()` - salary, employees, and titles, after which these dataframes were used to plot data.

#### Create a histogram to visualize the most common salary ranges for employees

* It appears that the data is positively skewed, indicating a non-normal distribution. 

![salary-ranges.png](/EmployeeSQL/images/histogram.png)

#### Create a bar chart of average salary by title

* Since the salary and title dataframe did not contain the emp_no field to link them, the employees dataframe was also used to merge data in order to get each employee's salary and title.

* Unnecessary columns were removed and a group by object was created on the title, with mean salaries.

![avg-sal-df.png](/EmployeeSQL/images/avg_sal_df.png)
![avg-sal-title.png](/EmployeeSQL/images/avg_sal_title.png)


