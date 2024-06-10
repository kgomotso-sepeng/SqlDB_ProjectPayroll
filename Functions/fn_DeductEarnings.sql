/*

	Author : Kgomotso Sepeng
	Email : www.kdsepeng@gmail.com
	LinkedIn : https://www.linkedin.com/in/kgomotso-sepeng-9b32b24b/
	Function to deduct two decimal values

	--TEST QUERY
	select dbo.fn_DeductEarnings(12.50, 2.25);
*/
Use BasicPayroll
Go
CREATE OR ALTER FUNCTION dbo.fn_DeductEarnings
(
    @Value1 DECIMAL(10, 2),
    @Value2 DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Value1 - @Value2;
END
