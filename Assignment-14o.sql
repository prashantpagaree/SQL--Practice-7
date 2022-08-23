Create Database Assign14o;
use assign14o;

Select * from Orders;
Select * from Customers;
Select * from OrderDetails;
Select * from Category;
Select * from Payments;
Select * from Products;
Select * from Shippers;
Select * from Suppliers;

--1. Using the Tables from the ecommerce database, do the following:Schema Docs

--a. Create a stored procedure to filter out information on orders
--above a certain amount.

CREATE PROCEDURE p1 @Total_order_amount INT
AS
BEGIN
Select * from Orders where Total_order_amount > @Total_order_amount;
end;
Exec p1 25000;

--b. Create a stored procedure to find the nth ranked order item
--from all orders based on item value.

Create Procedure p4 @Rank int as begin
Select * from (select *,DENSE_RANK()Over(Order by Total_Order_Amount Desc) As Rank from Orders)C where Rank = @Rank;
End;
Exec p4 3;

--c.Create a procedure to get information of customers who reside in a certain
--city and spent a total of a certain amount throughout recorded history.

Create Procedure p6 @City Varchar(30), @Total_Order_Amount Int As Begin
Select * from Customers A Inner Join Orders B On A.CustomerID = B.CustomerID 
where A.City = @City And B.Total_order_amount > @Total_Order_Amount;
End;

Exec p6 'New York', 10000;

--d. Create a stored procedure to filter products information
--which have a discount of a certain value.

Create Procedure p9 @Discount_Value Int As Begin 
Select * from Products Where (Market_Price - Sale_Price) = @Discount_Value
End;

Exec p9 0;

--e. Create a stored procedure to get details of orders from a particular month and year.

Create Procedure p10 @month INT, @YEAR INT AS BEGIN
Select * from Orders where MONTH(OrderDate)=@Month and Year(OrderDate)=@year;
End;

EXEC p10 3,2020;

--f. Create a stored procedure to get details of products which were ordered
--the highest number of times in a particular month and year.

Create Procedure p12 @Month INT, @Year INT as begin 
Select Top 1 B.ProductID,B.Product,B.Brand,Month(C.OrderDate) As Month,Year(C.OrderDate) As Year, Count(A.OrderID) As Total_Orders 
from OrderDetails A Inner Join Products B ON A.ProductID = B.ProductID 
Inner Join Orders C ON A.OrderID = C.OrderID 
Where Month(OrderDate) = @Month AND Year(C.OrderDate) = @Year
Group by B.ProductID,B.Product,B.Brand,Month(OrderDate),Year(OrderDate) Order by Count(A.OrderID) Desc;
End;

EXEC P12 12 , 2021;

--g. Create a stored procedure to get information on a certain type of payment method,
--the total amount transacted using that payment method, during a particular month and year.
Create Procedure p14 @Month int,@year int,@PaymentID INT as Begin 
Select A.PaymentID,A.PaymentType,Month(B.OrderDate) As Month ,YEAR(B.OrderDate) As YEAR, Sum(B.Total_order_amount) As Total_Amount
from Payments A Inner Join Orders B ON A.PaymentID = B.PaymentID 
where Month(B.OrderDate)=@Month AND YEAR(B.OrderDate)=@year AND A.PaymentID = @PaymentID
GROUP BY A.PaymentID,A.PaymentType, Month(B.OrderDate),YEAR(B.OrderDate);
End;

Exec p14 1,2021,1 ;

--2. Do the following:
--a. Create a table with columns ID, Name, Salary,
--DepartmentName.

Create Table t1(ID INT, Name Varchar(20), Salary INT ,DepartmentName Varchar(15));
Select * from t1;

--b. Create a trigger to create a log when a new record is
--inserted into the above table.

Create Table t1_audit(ID INT, Name Varchar(20), Salary INT ,DepartmentName Varchar(15),Updated_at Datetime, Operation Varchar(3));

Create Trigger trigger2 on t1 after Insert, Delete
as begin 
Insert into t1_audit(ID, Name, Salary, DepartmentName, Updated_at, Operation) Select ID, Name, Salary, DepartmentName, Getdate(),'INS' From Inserted 
Union All 
Select ID,Name,Salary,DepartmentName,Getdate(),'Del' From Deleted;
End;

--c. Now check if the trigger creates logs into the log table if a
--record is deleted from the above table.

Insert Into t1 Values(2,'Prashant',20000,'DA');
Delete From t1 where Salary = 20000;

Select * from t1_audit;
Select * from t1;