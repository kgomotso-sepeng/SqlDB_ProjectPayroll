/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Stored Procedure To Maintain Table Payroll
	CRUD MODE 
	- C : Create
	- R : Read
	- U : Update
	- D : Delete

	TEST DATA
	-- Create a new payroll record
	EXEC proc_Payroll_Maint @Mode = 'C', @PayrollID = 1, @EmployeeID = 1, @Salary = 5000.00, @StartDate = '2023-01-01', @EndDate = '2023-01-31';
	-- Read all payroll records
	EXEC proc_Payroll_Maint @Mode = 'R', @PayrollID = NULL, @EmployeeID = NULL, @Salary = NULL, @StartDate = NULL, @EndDate = NULL;
	-- Read a specific payroll record
	EXEC proc_Payroll_Maint @Mode = 'R', @PayrollID = 1, @EmployeeID = NULL, @Salary = NULL, @StartDate = NULL, @EndDate = NULL;
	-- Update a payroll record
	EXEC proc_Payroll_Maint @Mode = 'U', @PayrollID = 1, @EmployeeID = 1, @Salary = 5500.00, @StartDate = '2023-01-01', @EndDate = '2023-01-31';
	-- Delete a payroll record
	EXEC proc_Payroll_Maint @Mode = 'D', @PayrollID = 1, @EmployeeID = NULL, @Salary = NULL, @StartDate = NULL, @EndDate = NULL;

*/

Create or Alter Proc proc_Payroll_Maint
    @Mode char(1), --CRUD MODE
    @PayrollID int,
    @EmployeeID int,
    @Salary decimal(10,2),
    @StartDate date,
    @EndDate date
as
BEGIN
    Set NoCount On;

    if @Mode = 'C' Begin

        if not exists(select * from Payroll where PayrollID = @PayrollID)
            Insert Into [dbo].[Payroll]
                   ([PayrollID], 
				   [EmployeeID], 
				   [Salary], 
				   [StartDate], 
				   [EndDate])
             Values(@PayrollID, 
				   @EmployeeID, 
				   @Salary, 
				   @StartDate, 
				   @EndDate)

    End

    if @Mode = 'R' Begin

        if @PayrollID is null
            select * from Payroll
        else 
            select * from Payroll where PayrollID = @PayrollID

    End

    if @Mode = 'U' Begin

        Update Payroll
        set [EmployeeID] = @EmployeeID,
            [Salary] = @Salary,
            [StartDate] = @StartDate,
            [EndDate] = @EndDate
        Where PayrollID = @PayrollID

    End

    if @Mode = 'D' Begin

        Delete From Payroll where PayrollID = @PayrollID

    End
END
