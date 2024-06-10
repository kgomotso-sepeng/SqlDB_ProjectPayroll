/*	
	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Stored Procedure To Maintain Table Department
	CRUD MODE 
	- C : Create
	- R : Read
	- U : Update
	- D : Delete

	TEST DATA
	-- Create a new department
	EXEC proc_Department_Maint @Mode = 'C', @DepartmentID = 1, @Name = 'Human Resources', @Location = 'Building A';
	-- Read all departments
	EXEC proc_Department_Maint @Mode = 'R', @DepartmentID = NULL, @Name = NULL, @Location = NULL;
	-- Read a specific department
	EXEC proc_Department_Maint @Mode = 'R', @DepartmentID = 1, @Name = NULL, @Location = NULL;
	-- Update a department
	EXEC proc_Department_Maint @Mode = 'U', @DepartmentID = 1, @Name = 'HR', @Location = 'Building B';
	-- Delete a department
	EXEC proc_Department_Maint @Mode = 'D', @DepartmentID = 1, @Name = NULL, @Location = NULL;


*/
Create or Alter Proc proc_Department_Maint
    @Mode char(1), --CRUD MODE
    @DepartmentID int,
    @Name nvarchar(100),
    @Location nvarchar(100)
as
BEGIN
    Set NoCount On;

    if @Mode = 'C' Begin

        if not exists(select * from Department where DepartmentID = @DepartmentID)
            Insert Into [dbo].[Department]
                   ([DepartmentID],
				   [Name],
				   [Location])
             Values(@DepartmentID,
				   @Name, 
				   @Location)

    End

    if @Mode = 'R' Begin

        if @DepartmentID is null
            select * from Department
        else 
            select * from Department where DepartmentID = @DepartmentID

    End

    if @Mode = 'U' Begin

        Update Department
        set [Name] = @Name,
            [Location] = @Location
        Where DepartmentID = @DepartmentID

    End

    if @Mode = 'D' Begin
        Delete From Department where DepartmentID = @DepartmentID
    End
END
