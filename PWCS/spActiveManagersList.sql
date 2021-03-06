USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spActiveManagersList]    Script Date: 06/25/2013 11:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		14 June 2013
-- Description:		Retrieves a list of active PWCS managers
--
-- ------------EXAMPLE USES---------------------
-- spActiveManagersList
-- spActiveManagersList @PageNumber = 2, @PageSize = 50
-- spActiveManagersList @PageNumber = 1, @PageSize = 500
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spActiveManagersList] to [PWCS_app]  
-- =============================================
ALTER PROCEDURE [dbo].[spActiveManagersList] 
	-- Add the parameters for the stored procedure here
	-- Here we are also giving these parameters a default value
	@PageNumber INT = 1,
	@PageSize INT = 30
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @StartRow INT, @EndRow INT
	SET @StartRow = (@PageNumber - 1) * @PageSize
	SET @EndRow = ((@PageNumber - 1) * @PageSize) + @PageSize
	;
	-- Insert statements for procedure here
	WITH TempTable As (
		SELECT account_code, position, rank, fname, lname, org, phone, email, trained,
			ROW_NUMBER() OVER(ORDER BY account_code) AS RowNumber,
			TotalRows = COUNT(*) OVER()
		FROM dbo.managers
		WHERE active = 'True'
	)
	SELECT account_code, position, rank, fname, lname, org, phone, email, trained, RowNumber, TotalRows
	FROM TempTable
	WHERE (RowNumber > @StartRow AND RowNumber <= @EndRow)
END
