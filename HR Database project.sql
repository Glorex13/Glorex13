-- Create the tables

CREATE TABLE EMPLOYEES (
                          EMP_ID CHAR(9) NOT NULL,
                          F_NAME VARCHAR(15) NOT NULL,
                          L_NAME VARCHAR(15) NOT NULL,
                          SSN CHAR(9),
                          B_DATE DATE,
                          SEX CHAR,
                          ADDRESS VARCHAR(30),
                          JOB_ID CHAR(9),
                          SALARY DECIMAL(10,2),
                          MANAGER_ID CHAR(9),
                          DEP_ID CHAR(9) NOT NULL,
                          PRIMARY KEY (EMP_ID)
                        );

CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID)
                          );

CREATE TABLE JOBS (
                    JOB_IDENT CHAR(9) NOT NULL,
                    JOB_TITLE VARCHAR(30) ,
                    MIN_SALARY DECIMAL(10,2),
                    MAX_SALARY DECIMAL(10,2),
                    PRIMARY KEY (JOB_IDENT)
                  );

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP)
                          );

CREATE TABLE LOCATIONS (
                          LOCT_ID CHAR(9) NOT NULL,
                          DEP_ID_LOC CHAR(9) NOT NULL,
                          PRIMARY KEY (LOCT_ID,DEP_ID_LOC)
                        );

--- insert values into the tables
INSERT INTO EMPLOYEES VALUES
('E1001','John', 'Thomas', '123456', '1/9/1976', 'M', '5631 Rice, OakPark,IL', '100',100000, '30001','2'),
('E1002', 'Alice', 'James', '123457', '7/31/1972', 'F', '980 Berry ln, Elgin,IL', '200', 80000, '30002', '5'),
('E1003', 'Steve', 'Wells', '123458', '8/10/1980', 'M', '291 Springs, Gary,IL', '300', 50000, '30002', '5'),
('E1004', 'Santosh', 'Kumar', '123459', '7/20/1985', 'M', '511 Aurora Av, Aurora,IL', '400', 60000, '30004', '5'),
('E1005', 'Ahmed', 'Hussain', '123410',	'1/4/1981', 'M', '216 Oak Tree, Geneva,IL', '500', 70000,	'30001', '2'),
('E1006', 'Nancy', 'Allen', '123411', '2/6/1978', 'F', '111 Green Pl, Elgin,IL', '600', 90000, '30001', '2'),
('E1007', 'Mary', 'Thomas',	'123412', '5/5/1975',	'F', '100 Rose Pl, Gary,IL', '650',	65000, '30003', '7'),
('E1008', 'Bharath', 'Gupta', '123413',	'5/6/1985', 'M', '145 Berry Ln, Naperville,IL', '660', 65000,	'30003', '7'),
('E1009', 'Andrea',	'Jones', '123414', '7/9/1990', 'F', '120 Fall Creek, Gary,IL', '234',	70000, '30003',	'7'),
('E1010', 'Ann', 'Jacob', '123415',	'3/30/1982', 'F',	'111 Britany Springs,Elgin,IL',	'220', 70000, '30004', '5')

INSERT INTO JOB_HISTORY VALUES
('E1001', '8/1/2000', '100', '2'),
('E1002', '8/1/2001', '200', '5'),
('E1003', '8/16/2001', '300', '5'),
('E1004', '8/16/2000', '400', '5'),
('E1005', '5/30/2000', '500', '2'),
('E1006', '8/16/2001', '600', '2'),
('E1007', '5/30/2002', '650', '7'),
('E1008', '5/6/2010', '660', '7'),
('E1009', '8/16/2016', '234', '7'),
('E1010', '8/16/2016', '220', '5')

INSERT INTO JOBS VALUES
('100',	'Sr. Architect', 60000, 100000),
('200',	'Sr.Software Developer', 60000, 80000),
('300', 'Jr.Software Developer', 40000,60000),
('400', 'Jr.Software Developer', 40000, 60000),
('500', 'Jr. Architect', 50000, 70000),
('600', 'Lead Architect', 70000, 100000),
('650'	, 'Jr. Designer', 60000, 70000),
('660',	'Jr. Designer',	60000, 70000),
('234',	'Sr. Designer',	70000,90000),
('220',	'Sr. Designer',	70000, 90000)

INSERT INTO DEPARTMENTS VALUES
('2', 'Architect Group', '30001', 'L0001'),
('5', 'Software Group',	'30002', 'L0002'),
('7', 'Design Team', '30003', 'L0003')

INSERT INTO LOCATIONS VALUES
('L0001', '2'),
('L0002','5'),
('L0003', '7')

--Retrieve all employees whose address is in Elgin,IL.
SELECT F_NAME , L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%';

--Retrieve all employees who were born during the 1970's.
SELECT F_NAME , L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';

--Retrieve all employees in department 5 whose salary is between 60000 and 70000.
SELECT *
FROM EMPLOYEES
WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID = 5;

--Retrieve a list of employees ordered by department ID.
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID;

--Retrieve a list of employees ordered in descending order by department ID 
and within each department ordered alphabetically in descending order by last name.

SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

--For each department ID retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(*) AS NO_OF_EMPLOYEES
FROM EMPLOYEES
GROUP BY DEP_ID;

--For each department retrieve the number of employees in the department, and the average employee salary in the department 
ordered by average salary
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

--Limit the result to departments with fewer than 4 employees.
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING count(*) < 4
ORDER BY AVG_SALARY;

--Retrieve all employees records whose salary is lower than the average salary.
SELECT EMP_ID, F_NAME, L_NAME, SALARY 
FROM EMPLOYEES 
WHERE SALARY < (SELECT AVG(SALARY) 
                FROM EMPLOYEES);

--Execute a Column Expression that retrieves all employees records with EMP_ID, SALARY and maximum salary as MAX_SALARY in every row.
SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM employees ) AS MAX_SALARY 
FROM EMPLOYEES;

--Execute a Table Expression for the EMPLOYEES table that excludes columns 
--with sensitive employee data (i.e. does not include columns: SSN, B_DATE, SEX, ADDRESS, SALARY).
SELECT * 
FROM (SELECT EMP_ID, F_NAME, L_NAME, DEP_ID FROM EMPLOYEES) AS EMPLOYEE_TABLE;

--Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table.
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID IN (SELECT JOB_IDENT FROM JOBS);

--Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID IN (SELECT JOB_IDENT 
					FROM JOBS 
					WHERE JOB_TITLE='Jr. Designer');

--Retrieve JOB information and who earn more than $70,000.
SELECT JOB_TITLE, MIN_SALARY,MAX_SALARY,JOB_IDENT 
FROM JOBS WHERE JOB_IDENT IN 
	(SELECT JOB_ID 
	FROM employees 
	WHERE SALARY > 70000 );

--Retrieve JOB information and whose birth year is after 1976.
SELECT JOB_TITLE, MIN_SALARY,MAX_SALARY,JOB_IDENT 
FROM JOBS 
WHERE JOB_IDENT IN 
	(SELECT JOB_ID 
	FROM EMPLOYEES 
	WHERE YEAR(B_DATE)>1976 );

--Retrieve JOB information for female employees whose birth year is after 1976.
SELECT JOB_TITLE, MIN_SALARY,MAX_SALARY,JOB_IDENT 
FROM JOBS 
WHERE JOB_IDENT IN (SELECT JOB_ID 
					FROM EMPLOYEES 
					WHERE YEAR(B_DATE)>1976 and SEX='F' );

--Perform an implicit cartesian/cross join between EMPLOYEES and JOBS tables.
SELECT * 
FROM EMPLOYEES, JOBS;

--Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table.
SELECT * 
FROM EMPLOYEES, JOBS 
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

--Retrieve only the Employee ID, Employee Name and Job Title from the EMPLOYEES and JOBS table.
SELECT EMP_ID,F_NAME,L_NAME, JOB_TITLE 
FROM EMPLOYEES AS E, JOBS AS J 
WHERE E.JOB_ID = J.JOB_IDENT;

