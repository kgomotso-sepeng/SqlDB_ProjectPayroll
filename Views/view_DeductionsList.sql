/*

	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Company Employees Deduction View

	--TEST QUERY
	select * from dbo.view_DeductionsList
*/

Create or Alter View view_DeductionsList
As
	Select d.EmployeeID [Employee ID] ,CONCAT(e.FirstName ,' ',e.LastName)  [Emp Name] , d.DeductionID [Deduction ID] , dt.Description, d.Amount  
	from Deduction d
	Inner Join DeductionType dt
		on (dt.DeductionTypeID = d.DeductionTypeID)
	inner Join Employee e
	on (e.EmployeeID = d.EmployeeID)