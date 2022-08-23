Create Database assign13;
use assign13;

Create table Employee(
Name Varchar(20),
Year int,
Sales Int);

Insert Into Employee values 
('Pankaj',2010,72500),
('Rahul',2010,60500),
('Sandeep',2010,52000),
('Pankaj',2011,45000),
('Sandeep',2011,82500),
('Rahul',2011,35600),
('Pankaj',2012,32500),
('Pankaj',2010,20500),
('Rahul',2011,200500),
('Sandeep',2010,32000);

select * from Employee

--Q1. Convert the following given Employee table into the following output tables
--a

Select * from Employee Pivot (Sum(Sales) for Name In (Pankaj,Rahul,Sandeep)) As PivotTable;

--b

Select * from Employee Pivot (Sum(Sales) for Year In ([2010],[2011],[2012])) As PivotTable2;

--Q2. WAQ to do following changes from Original table to PIVOT table.Create table table1(Student varchar(10),Subject Varchar(20),Marks int);Insert into table1 values('Jacob','Mathematics',100),('Jacob','Science',95),('Jacob','Geography',90),('Amilee','Mathematics',90),('Amilee','Science',95),('Amilee','Geography',100);--a.select * from table1 Pivot(Sum(Marks) For Subject In(Mathematics,Science,Geography)) as Pivot2 order by Student Desc;--bselect * from table2 Pivot(Sum(Sales) For Region In(North,South)) as Pivot3;--	Q3create table ip(Team1 varchar(2),Team2 varchar(2),result varchar(2));insert into ip values('A','B','A'),('A','C','C'),('B','D','D'),('A','D','A');select * from ip;SELECT TEAM,SUM(CASE WHEN RESULT = TEAM THEN 1 ELSE 0 END) AS WON,SUM(CASE WHEN RESULT != TEAM THEN 1 ELSE 0 END) AS LOSSFROM(SELECT team1 AS TEAM, RESULT FROM ipUNION ALL SELECT team2 AS TEAM, RESULT FROM ip)CGROUP BY TEAM;
--Q4. Give the Customer_details Table, do the following:CustomerDetails.csv

use assign12oselect * from CustomerDetails;

--4a. Write a query to dynamically filter and get records of cities with a sum of salaries greater than 1.5 Lakhs.Declare @a Varchar(1000),        @b Varchar(50);Set @b = 150000;Set @a = 'Select City, Sum(Salary) as Salary from CustomerDetails Group by City Having Sum(Salary)>'+@b;Exec(@a);--4b. Write a query to dynamically filter on cities from which we have more than 1 customer.Declare @y Varchar(1000),		@d char(50);Set @d = 1;Set @y = 'Select City, Count(CustomerName) as Salary from CustomerDetails Group by City Having  Count(CustomerName)>'+@d;Exec(@y);--Q5. Given the CustomerOrders table, do the following: CustomerOrders.csvuse assign12oselect * from CustomerOrders;--5a. Write a query to dynamically filter the records which have order date 5 June 2021 or greater.

Declare @orderDate as varchar(25);set @orderDate = '2021-06-05'Select * From CustomerOrders where OrderDate > @orderDate;

--5b. Write a query to dynamically filter the records which have employee ID greater than 125.

Declare @d Varchar(1000),
        @sql nvarchar(1000);

Set @d = '125';
Set @Sql = 'Select * from CustomerOrders where CustomerID >'+@d;

Exec(@sql);


--c. Write a query to dynamically filter on customers with total spend of 2500 or aboveDeclare @d Varchar(1000),
        @sql nvarchar(1000);

Set @d = '2500';
Set @Sql = 'Select CustomerID, Sum(OrderAmount) As Total_Spend from CustomerOrders Group by CustomerID Having Sum(OrderAmount) >='+@d;

Exec(@sql);--doubtDECLARE @asdf varchar(20);set @asdf = 'Select * into #a from (SELECT City from CustomerDetails)c';select @asdf,count(CustomerName) from CustomerDetails group by City having count(CustomerName)>1 ;
--doubt declare @tbl varchar(50),		@sql varchar(1000),		@qwe varchar(1000);set @tbl= 'Customerdetails';set @sql='select distinct(city),count(customername) over (partition by city)x from '+ @tblset @qwe='select * from '+@sql+' where count(customername)>1'  exec(@qwe);
