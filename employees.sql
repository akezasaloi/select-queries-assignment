CREATE SCHEMA employment;
CREATE TABLE employment.employees(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male','Female')),
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(8,2) NOT NULL
);
INSERT INTO employment.employees(employee_id, first_name, last_name, gender, department, hire_date, salary) VALUES
(1, 'John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
(2, 'Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
(3, 'Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
(4, 'Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
(5, 'Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
(6, 'David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
(7, 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);

CREATE TABLE employment.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(40) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    stock INT NOT NULL
);
INSERT INTO employment.products (product_id, product_name, category, price, stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Desk', 'Furniture', 300.00, 50),
(3, 'Chair', 'Furniture', 150.00, 200),
(4, 'Smartphone', 'Electronics', 800.00, 75),
(5, 'Monitor', 'Electronics', 250.00, 40),
(6, 'Bookshelf', 'Furniture', 100.00, 60),
(7, 'Printer', 'Electronics', 200.00, 25);

SELECT * FROM employment.products;

CREATE TABLE employment.sales (
    sale_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_product
        FOREIGN KEY (product_id) REFERENCES employment.products(product_id),
    CONSTRAINT fk_employee
        FOREIGN KEY (employee_id) REFERENCES employment.employees(employee_id)
);
INSERT INTO employment.sales (sale_id, product_id, employee_id, sale_date, quantity, total) VALUES
(1,1,1, '2021-01-15', 2, 2400.00),
(2,2,1, '2021-03-22', 1, 300.00),
(3,3,3, '2021-05-10', 4, 600.00),
(4,4,4, '2021-07-18', 3, 2400.00),
(5,5,5, '2021-09-25', 2, 500.00),
(6,6,6, '2021-11-30', 1, 100.00),
(7,7,1, '2022-02-15', 1, 200.00),
(8,1,2, '2022-04-10', 1, 1200.00),
(9,2,3, '2022-06-20', 2, 600.00),
(10,3,4,'2022-08-05', 3, 450.00),
(11,4,5,'2022-10-11', 1, 800.00),
(12,5,6,'2022-12-29', 4, 1000.00);
SELECT * FROM employment.sales;
-- 1. All columns from Employees table
SELECT * FROM employment.employees;
-- 2.First names of all employees
SELECT first_name FROM employment.employees;

-- 3.Distinct departments 

SELECT DISTINCT department FROM employment.employees;

SELECT COUNT(employee_id) AS number_of_employees
FROM  employment.employees;

SELECT SUM(salary) AS total_salary
FROM employment.employees;

 SELECT AVG(salary) AS average_salary
FROM employment.employees;

SELECT MAX(salary) AS highest_salary
 FROM employment.employees;
 
SELECT MIN(salary) AS lowest_salary
 FROM employment.employees;

  SELECT COUNT(employee_id) AS number_of_male_employees
FROM employment.employees
WHERE gender = 'Male';

 SELECT COUNT(employee_id) AS number_of_female_employees
FROM employment.employees
WHERE gender = 'Female';


SELECT   COUNT(employee_id) , EXTRACT (YEAR FROM hire_date ) as employees_hired_in_2020
FROM employment.employees
WHERE EXTRACT (YEAR FROM hire_date) = 2020
GROUP BY(employees_hired_in_2020);

SELECT AVG(salary) AS employees_in_IT
FROM employment.employees
WHERE department LIKE 'IT';

SELECT department,COUNT(employee_id) AS employees_in_each_department
FROM employment.employees
GROUP BY department;

SELECT department, SUM(salary) AS  total_salary
FROM employment.employees
GROUP BY department;

SELECT department,MAX(salary) AS maximum_salary
FROM employment.employees
GROUP BY department;

SELECT department,MIN(salary) AS minimum_salary
FROM employment.employees
GROUP BY department;


SELECT gender,COUNT(employee_id) AS total_number_of_employees
FROM employment.employees
GROUP BY gender;

SELECT gender,AVG(salary) AS average_salary_of_employees
FROM employment.employees
GROUP BY gender;


SELECT * FROM employment.employees
ORDER BY salary DESC
Limit 5;



SELECT COUNT(DISTINCT first_name) AS unique_names
FROM  employment.employees;

SELECT emp.first_name,emp.last_name, sales.total
FROM employment.employees emp
JOIN employment.sales sales
ON sales.employee_id = emp.employee_id;

SELECT *
FROM employment.employees
ORDER BY hire_date
LIMIT 10;

SELECT *
FROM employment.employees
WHERE employee_id NOT IN(SELECT employee_id FROM employment.sales);

SELECT employee_id,COUNT(sale_id) AS sales_made
FROM employment.sales
GROUP BY employee_id;

SELECT emp.employee_id, emp.first_name, emp.last_name, SUM(sale.total) AS total_sales
FROM employment.sales sale
JOIN employment.employees emp ON sale.employee_id = emp.employee_id
GROUP BY emp.employee_id, emp.first_name, emp.last_name
ORDER BY total_sales DESC
LIMIT 1;
