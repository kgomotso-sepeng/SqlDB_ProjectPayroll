/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Stored Procedure To Maintain Table DeductionType
	CRUD MODE 
	- C : Create
	- R : Read
	- U : Update
	- D : Delete

	TEST DATA
	-- Create a new deduction type
	EXEC proc_DeductionType_Maint @Mode = 'C', @DeductionTypeID = 1, @Name = 'Health Insurance', @Description = 'Monthly health insurance premium';
	-- Read all deduction types
	EXEC proc_DeductionType_Maint @Mode = 'R', @DeductionTypeID = NULL, @Name = NULL, @Description = NULL;
	-- Read a specific deduction type
	EXEC proc_DeductionType_Maint @Mode = 'R', @DeductionTypeID = 1, @Name = NULL, @Description = NULL;
	-- Update a deduction type
	EXEC proc_DeductionType_Maint @Mode = 'U', @DeductionTypeID = 1, @Name = 'Health Ins.', @Description = 'Monthly health insurance premium deduction';
	-- Delete a deduction type
	EXEC proc_DeductionType_Maint @Mode = 'D', @DeductionTypeID = 1, @Name = NULL, @Description = NULL;

*/


Create or Alter Proc proc_DeductionType_Maint
    @Mode char(1), --CRUD MODE
    @DeductionTypeID int,
    @Name nvarchar(100),
    @Description nvarchar(255)
as
BEGIN
    Set NoCount On;

    if @Mode = 'C' Begin

        if not exists(select * from DeductionType where DeductionTypeID = @DeductionTypeID)
            Insert Into [dbo].[DeductionType]
                   ([DeductionTypeID], 
				   [Name], 
				   [Description])
             Values(@DeductionTypeID, 
					@Name, 
					@Description)

    End

    if @Mode = 'R' Begin

        if @DeductionTypeID is null
            select * from DeductionType
        else 
            select * from DeductionType where DeductionTypeID = @DeductionTypeID

    End

    if @Mode = 'U' Begin

        Update DeductionType
        set [Name] = @Name,
            [Description] = @Description
        Where DeductionTypeID = @DeductionTypeID

    End

    if @Mode = 'D' Begin

        Delete From DeductionType where DeductionTypeID = @DeductionTypeID

    End
END
