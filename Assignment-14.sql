Create database assign14;
use assign14;

--Q4. Do the following:
--A. Create a table with columns: Name, Math_marks, English_marks, Physics_marks, Total, Average.

Create table Student(Name Varchar(20),Math_Marks int,English_marks Int, Physics_marks int , Total int, Average Float);

--B. Create a trigger which inserts logs into an audit table when you insert and delete records from the
--above table

Create Table Student_Audit (
Name Varchar(20),
Math_Marks int,
English_marks Int, 
Physics_marks int, 
Total int, 
Average Float,
Updated_at Datetime,
Operation char(3));

Create trigger audit 
on Student 
After Insert, Delete 
as 
Begin
Insert into Student_Audit(
             Name,
			 Math_Marks,
			 English_marks,
			 Physics_marks,
			 Total,
			 Average,
			 Updated_at,
			 Operation)
	   Select 
			 Name,
			 Math_Marks,
			 English_marks,
			 Physics_marks,
			 Total,
			 Average,
			 GETDATE(),
			 'INS'
From Inserted
       Union All
	   Select
	         Name,
			 Math_Marks,
			 English_marks,
			 Physics_marks,
			 Total,
			 Average,
			 GETDATE(),
			 'Del'
      From deleted;
End;

Insert into Student Values('Vaishi',11,12,20,12,12);
select * from Student
select * from Student_Audit
Delete from Student where Name = 'Vaishi';