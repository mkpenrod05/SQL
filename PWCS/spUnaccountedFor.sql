USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spUnaccountedFor]    Script Date: 06/25/2013 08:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 20 June 2013
-- Description:	Used to retrieve a list of assets that are unaccounted for.  
--
-- ------------EXAMPLE USES---------------------
-- spUnaccountedFor
-- spUnaccountedFor @PageNumber = 2, @PageSize = 50
-- spUnaccountedFor @PageNumber = 1, @PageSize = 500
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spUnaccountedFor] to [PWCS_app]
-- =============================================
ALTER PROCEDURE [dbo].[spUnaccountedFor] 
	-- Add the parameters for the stored procedure here
	-- Here we are also giving these parameters a default value
	@PageNumber INT = 1,
	@PageSize INT = 30
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StartRow INT, @EndRow INT
	SET @StartRow = (@PageNumber - 1) * @PageSize
	SET @EndRow = ((@PageNumber - 1) * @PageSize) + @PageSize
	;
	-- Insert statements for procedure here
	WITH TempTable AS (
		SELECT trunkID, trunkIDRange, serialNum, account, modelNum, modelDesc, 
			assetComments, assetDisabled, assetDisabledDate, assetDisabledComments,
			ROW_NUMBER() OVER(ORDER BY serialNum) AS RowNumber,
			TotalRows = COUNT(*) OVER()
		FROM dbo.assets
		WHERE account = 'NONE'
	)
	SELECT trunkID, trunkIDRange, serialNum, account, modelNum, modelDesc, 
			assetComments, assetDisabled, assetDisabledDate, assetDisabledComments,
			RowNumber, TotalRows
	FROM TempTable
	WHERE (RowNumber > @StartRow AND RowNumber <= @EndRow) 
END
