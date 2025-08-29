CREATE DATABASE OCS_DB;

USE OCS_DB;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create the Salespeople table
CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4,2)
);

INSERT INTO Salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New york', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);

Select * from salespeople;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create the Cust Table 
CREATE TABLE Cust (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT,
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Cust (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);

Select * from Cust;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.	Create orders table 
CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT,
    FOREIGN KEY (cnum) REFERENCES Cust(cnum),
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Orders (onum, amt, odate, cnum, snum) VALUES
(3001,  18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003,  767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007,   75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2001, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);

Select * from Orders;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.	Write a query to match the salespeople to the customers according to the city they are living
SELECT s.sname AS Salesperson, c.cname AS Customer, s.city
FROM Salespeople s
JOIN Cust c ON s.city = c.city;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.	Write a query to select the names of customers and the salespersons who are providing service to them
SELECT c.cname AS Customer, s.sname AS Salesperson
FROM Cust c
JOIN Salespeople s ON c.snum = s.snum;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople
SELECT o.onum, c.cname, s.sname, c.city AS customer_city, s.city AS salesperson_city
FROM Orders o
JOIN Cust c ON o.cnum = c.cnum
JOIN Salespeople s ON o.snum = s.snum
WHERE c.city <> s.city;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.	Write a query that lists each order number followed by name of customer who made that order
SELECT o.onum, c.cname
FROM Orders o
JOIN Cust c ON o.cnum = c.cnum;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 8.	Write a query that finds all pairs of customers having the same rating………………
SELECT c1.cname AS Customer1, c2.cname AS Customer2, c1.rating
FROM Cust c1
JOIN Cust c2 ON c1.rating = c2.rating AND c1.cnum < c2.cnum;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 9.	Write a query to find out all pairs of customers served by a single salesperson………………..
SELECT c1.cname AS Customer1, c2.cname AS Customer2, c1.snum
FROM Cust c1
JOIN Cust c2 ON c1.snum = c2.snum AND c1.cnum < c2.cnum;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 10.	Write a query that produces all pairs of salespeople who are living in same city………………..
SELECT 
    sp1.sname AS salesperson1,
    sp2.sname AS salesperson2,
    sp1.city
FROM 
    salespeople sp1
JOIN 
    salespeople sp2 
    ON sp1.city = sp2.city 
    AND sp1.snum < sp2.snum;
    
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008
SELECT o.*
FROM Orders o
WHERE o.snum = (
    SELECT snum
    FROM Cust
    WHERE cnum = 2008
);

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 12.	Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT * FROM Orders
WHERE amt > (
    SELECT AVG(amt)
    FROM Orders
    WHERE odate = "1994-10-04"
);

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 13.	Write a Query to find all orders attributed to salespeople in London
SELECT o.*
FROM Orders o
JOIN Salespeople s ON o.snum = s.snum
WHERE s.city = 'London';

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres
SELECT *
FROM Cust
WHERE cnum = (
    SELECT snum + 1000
    FROM Salespeople
    WHERE sname = 'Serres'
);

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 15.	Write a query to count customers with ratings above San Jose’s average rating
SELECT COUNT(*) AS Count_Above_Avg_Rating
FROM Cust
WHERE rating > (
    SELECT AVG(rating)
    FROM Cust
    WHERE city = 'San Jose'
);

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 16.	Write a query to show each salesperson with multiple customers
SELECT s.snum, s.sname, COUNT(c.cnum) AS customer_count
FROM Salespeople s
JOIN Cust c ON s.snum = c.snum
GROUP BY s.snum, s.sname
HAVING COUNT(c.cnum) > 1;

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE CompanyDB;

USE CompanyDB;

CREATE TABLE DEPT (
    deptno INT PRIMARY KEY,
    dname VARCHAR(30),
    loc VARCHAR(30));

INSERT INTO DEPT VALUES (10, 'OPERATIONS', 'BOSTON');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'ACCOUNTING', 'NEW YORK');

select * from dept;

CREATE TABLE EMP (
    empno INT PRIMARY KEY,
    ename VARCHAR(30),
    job VARCHAR(20) DEFAULT 'Clerk',
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10,2) CHECK (sal > 0),
    comm DECIMAL(10,2),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES DEPT(deptno));


INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


select * from emp;

-- 3.	List the Names and salary of the employee whose salary is greater than 1000

SELECT ename, sal FROM EMP WHERE sal > 1000;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 4.	List the details of the employees who have joined before end of September 81.

SELECT * FROM EMP WHERE hiredate < '1981-09-30';
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 5.	List Employee Names having I as second character.

SELECT ename FROM EMP WHERE ename LIKE '_I%';
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

SELECT ename AS "Employee Name",
       sal AS "Salary",
       ROUND(sal * 0.40,2) AS "Allowance",
       ROUND(sal * 0.10,2) AS "PF",
       ROUND(sal + (sal * 0.40) - (sal * 0.10),2) AS "Net Salary"
FROM EMP;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 7.	 Employee Names with designations who does not report to anybody

SELECT ename, job FROM EMP WHERE mgr IS NULL;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 8.	List Empno, Ename and Salary in the ascending order of salary.

SELECT empno, ename, sal FROM EMP ORDER BY sal ASC;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 9.	How many jobs are available in the Organization?

SELECT COUNT(DISTINCT job) AS total_jobs FROM EMP;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 10.	Determine total payable salary of salesman category

SELECT SUM(sal + IFNULL(comm, 0)) AS total_payable_salary
FROM EMP
WHERE job = 'SALESMAN';
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 11.	List average monthly salary for each job within each department   

SELECT deptno, job, ROUND(AVG(sal), 2) AS avg_monthly_salary
FROM EMP
GROUP BY deptno, job;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

SELECT e.ename AS empname, e.sal AS salary, d.dname AS deptname
FROM EMP e
JOIN DEPT d ON e.deptno = d.deptno;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 13.	Create the Job Grades Table as below

-- Create JOB_GRADES Table

CREATE TABLE JOB_GRADES (
    grade CHAR(1) PRIMARY KEY,
    lowsal INT,
    hisal INT);

-- Insert Data into JOB_GRADES

INSERT INTO JOB_GRADES VALUES ('A', 0, 999);
INSERT INTO JOB_GRADES VALUES ('B', 1000, 1999);
INSERT INTO JOB_GRADES VALUES ('C', 2000, 2999);
INSERT INTO JOB_GRADES VALUES ('D', 3000, 3999);
INSERT INTO JOB_GRADES VALUES ('E', 4000, 5000);

SELECT * FROM JOB_GRADES;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 14.	Display the last name, salary and  Corresponding Grade.

SELECT e.ename AS "Emp Name", e.sal AS "Salary", g.grade AS "Grade"
FROM EMP e
JOIN JOB_GRADES g
ON e.sal BETWEEN g.lowsal AND g.hisal;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 15.	Display the Emp name and the Manager name under whom the Employee works in the below format.

SELECT e.ename AS "Emp", m.ename AS "Reports_to"
FROM EMP e
LEFT JOIN EMP m ON e.mgr = m.empno;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 16.	Display Empname and Total sal where Total Sal (sal + Comm)

SELECT ename AS "Emp Name",
       sal AS "Salary",
       comm AS "Commission",
       (sal + IFNULL(comm, 0)) AS "Total Salary"
FROM EMP;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 17.	Display Empname and Sal whose empno is a odd number

SELECT ename AS "Emp Name", sal AS "Salary"
FROM EMP
WHERE empno % 2 = 1;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department

SELECT ename, deptno, sal,
       DENSE_RANK() OVER (ORDER BY sal DESC) AS OrgRank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS DeptRank
FROM EMP;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 19.	Display Top 3 Empnames based on their Salary

SELECT ename, deptno, sal
FROM EMP e
WHERE sal = (
    SELECT MAX(sal)
    FROM EMP
    WHERE deptno = e.deptno) ORDER BY sal DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- 20.	Display Empname who has highest Salary in Each Department.

SELECT ename, deptno, sal
FROM EMP e
WHERE sal = (
    SELECT MAX(sal)
    FROM EMP
    WHERE deptno = e.deptno) ORDER BY deptno;