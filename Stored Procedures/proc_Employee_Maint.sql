/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Stored Procedure To Maintain Table Employee
	CRUD MODE 
	- C : Create
	- R : Read
	- U : Update
	- D : Delete

	TEST DATA
	-- Create a new employee
	EXEC proc_Employee_Maint @Mode = 'C', @EmployeeID = 1, @FirstName = 'John', @LastName = 'Langa', @Email = 'john.Langa@myemail.com', @PhoneNumber = '123-456-7890', @DepartmentID = 1;
	-- Read all employees
	EXEC proc_Employee_Maint @Mode = 'R', @EmployeeID = NULL, @FirstName = NULL, @LastName = NULL, @Email = NULL, @PhoneNumber = NULL, @DepartmentID = NULL;
	-- Read a specific employee
	EXEC proc_Employee_Maint @Mode = 'R', @EmployeeID = 1, @FirstName = NULL, @LastName = NULL, @Email = NULL, @PhoneNumber = NULL, @DepartmentID = NULL;
	-- Update an employee
	EXEC proc_Employee_Maint @Mode = 'U', @EmployeeID = 1, @FirstName = 'Jonathan', @LastName = 'Langa', @Email = 'john.Langa@myemail.com', @PhoneNumber = '987-654-3210', @DepartmentID = 1;
	-- Delete an employee
	EXEC proc_Employee_Maint @Mode = 'D', @EmployeeID = 1, @FirstName = NULL, @LastName = NULL, @Email = NULL, @PhoneNumber = NULL, @DepartmentID = NULL;


*/
Create or Alter Proc proc_Employee_Maint
	@Mode char(1), --CRUD MODE
	@EmployeeID int,
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(20),
    @DepartmentID int

as
BEGIN

	Set NoCount On;

	if @Mode = 'C' Begin
	
	if not exists(select * from Employee where EmployeeID = @EmployeeID)

		Insert Into [dbo].[Employee]
			   ([EmployeeID]
			   ,[FirstName]
			   ,[LastName]
			   ,[Email]
			   ,[PhoneNumber]
			   ,[DepartmentID])
		 Values(
			   @EmployeeID,
			   @FirstName,
			   @LastName,
			   @Email,
			   @PhoneNumber,
			   @DepartmentID)

	End

	if @Mode = 'R' Begin

		 if @EmployeeID is null
			select * from Employee
		 else 
			select * from Employee where EmployeeID =  @EmployeeID

	End

	if @Mode = 'U' Begin

		Update Employee
		set [FirstName] = @FirstName
			,[LastName] = @LastName 
			,[Email] = @Email 
			,[PhoneNumber] = @PhoneNumber
			,[DepartmentID] = @DepartmentID
		Where EmployeeID = @EmployeeID

	End

	if @Mode = 'D' Begin

		Delete From Employee where EmployeeID = @EmployeeID

	End


END
