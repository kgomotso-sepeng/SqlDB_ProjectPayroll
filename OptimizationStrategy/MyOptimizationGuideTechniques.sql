/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/


-- Use #tables/temp tables instead of Real Tables ; this will assist when dealing with Large data and overall perfomance of your database (My Favourite)

	- Temp tables are session specific , meaning that they are only accessible at that specific session of a stored procedure.
	- Helps in avoiding table dead-locks
	- They automatically clean themselves up : They are automatically dropped once a session ends.
	- Easier to debug : You can monitor data change before adding the final results into a real table.
	- Using temporarly tables can help in better resource management : it reduces the DIsk Input/Output. 
*/

use BasicPayroll
Go
--##Temp Table Example For Reporting Purposes
	--Drop temp table if exists
	IF OBJECT_ID('tempdb..#EmpCostToCompany') IS NOT NULL DROP TABLE #EmpCostToCompany	

    -- Insert aggregated salary data into the temporary table
    SELECT EmployeeID, SUM(Salary) [TotalSalary] 
		into #EmpCostToCompany FROM Payroll
	GROUP BY EmployeeID;

    -- Join the temporary table with main tables to get detailed results
    SELECT e.EmployeeID, e.FirstName, e.LastName, ec.TotalSalary
    FROM Employee e
    LEFT JOIN #EmpCostToCompany ec 
	ON e.EmployeeID = ec.EmployeeID;



/*1. Temp Table Used  To Avoid using Loops in Stored Procedures 
	Instead of using Loops then use Joint Update,Delete or Insert or Target-Source Statement 
*/

	--Drop temp table if exists
	IF OBJECT_ID('tempdb..#Emp') IS NOT NULL DROP TABLE #Emp
	select * into #Emp from Employee

	-- Changing data on temp table
	Update #Emp 
	set FirstName = 'JonnyBoy'
	Where EmployeeID = 1

	--Bulk update data instead of looping through all the records
	update a
		set a.FirstName = #Emp.FirstName
	from Employee a
	inner join #Emp
	on (a.EmployeeID = #Emp.EmployeeID)

	--Delete matching records with a joint statement instead of looping through huge amount of data
	Delete a
	from Employee a
	Join #Emp
	on (a.EmployeeID = #Emp.EmployeeID)

--2. Using Merge Technique for better optimization
	
Begin Transaction -- Use For Data Intergrity

	Merge Into Employee as target
	using #Emp as Source
	on (Target.EmployeeID = Source.EmployeeID)
	when Matched then 
		Update 
		set target.FirstName = Source.FirstName
	When not Matched By target Then 
		Insert (target.[EmployeeID],
				target.[FirstName],
				target.[LastName],
				target.[Email],
				target.[PhoneNumber],
				target.[DepartmentID])
		values (Source.[EmployeeID],
				Source.[FirstName],
				Source.[LastName],
				Source.[Email],
				Source.[PhoneNumber],
				Source.[DepartmentID]);

Commit Transaction