/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Stored Procedure To Maintain Table Deduction
	CRUD MODE 
	- C : Create
	- R : Read
	- U : Update
	- D : Delete

	--Test Data
	-- Create a new deduction
	EXEC proc_Deduction_Maint @Mode = 'C', @DeductionID = 1, @EmployeeID = 1, @DeductionTypeID = 1, @Amount = 200.00;
	-- Read all deductions
	EXEC proc_Deduction_Maint @Mode = 'R', @DeductionID = NULL, @EmployeeID = NULL, @DeductionTypeID = NULL, @Amount = NULL;
	-- Read a specific deduction
	EXEC proc_Deduction_Maint @Mode = 'R', @DeductionID = 1, @EmployeeID = NULL, @DeductionTypeID = NULL, @Amount = NULL;
	-- Update a deduction
	EXEC proc_Deduction_Maint @Mode = 'U', @DeductionID = 1, @EmployeeID = 1, @DeductionTypeID = 1, @Amount = 250.00;
	-- Delete a deduction
	EXEC proc_Deduction_Maint @Mode = 'D', @DeductionID = 1, @EmployeeID = NULL, @DeductionTypeID = NULL, @Amount = NULL;

*/

Create or Alter Proc proc_Deduction_Maint
    @Mode char(1), --CRUD MODE
    @DeductionID int,
    @EmployeeID int,
    @DeductionTypeID int,
    @Amount decimal(10,2)
as
BEGIN
    Set NoCount On;

    if @Mode = 'C' Begin

        if not exists(select * from Deduction where DeductionID = @DeductionID)
            Insert Into [dbo].[Deduction]
                   ([DeductionID], 
				   [EmployeeID], 
				   [DeductionTypeID], 
				   [Amount])
             Values(@DeductionID, 
				   @EmployeeID, 
				   @DeductionTypeID, 
				   @Amount)

    End

    if @Mode = 'R' Begin

        if @DeductionID is null
            select * from Deduction
        else 
            select * from Deduction where DeductionID = @DeductionID

    End

    if @Mode = 'U' Begin

        Update Deduction
        set [EmployeeID] = @EmployeeID,
            [DeductionTypeID] = @DeductionTypeID,
            [Amount] = @Amount
        Where DeductionID = @DeductionID

    End

    if @Mode = 'D' Begin

        Delete From Deduction where DeductionID = @DeductionID

    End
END
