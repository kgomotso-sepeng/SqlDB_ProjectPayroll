/*

	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Employee Earning and Deduction View

	--TEST QUERY
	select * from dbo.view_EmployeePaySlip
*/

Create Or Alter View view_EmployeePaySlip
As
	Select e.EmployeeID [Emp ID], 
		   e.FirstName [Name] ,
		   e.LastName ,
		   e.Email, 
		   e.PhoneNumber [Contact Number]  ,
		   d.Name [Department]	, 
		   p.Salary ,
		   dt.Name [Deduction] , 
		   dd.Amount, 
		   dbo.fn_DeductEarnings(p.Salary,dd.Amount)	 [After Deductions]
		   ,Concat(format(p.StartDate,'yyyy/MM/dd'),'-',format(p.EndDate,'yyyy/MM/dd')) [Payment Period] 
	from Employee e
	Left Outer Join Department d
		on (d.DepartmentID = e.DepartmentID)
	left Join Deduction dd
		on (dd.EmployeeID = e.EmployeeID)
	inner join DeductionType dt
		on (dt.DeductionTypeID = dd.DeductionTypeID)
	Left Join Payroll p
	on (p.EmployeeID = e.EmployeeID)


