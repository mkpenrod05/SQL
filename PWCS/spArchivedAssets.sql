USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spArchivedAssets]    Script Date: 06/25/2013 11:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		18 June 2013
-- Description:		Retrieves a full list of archived assets
--
-- ------------EXAMPLE USES---------------------
-- spArchivedAssets
-- spArchivedAssets @PageNumber = 2, @PageSize = 50
-- spArchivedAssets @PageNumber = 1, @PageSize = 500
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spArchivedAssets] to [PWCS_app]  
-- =============================================
ALTER PROCEDURE [dbo].[spArchivedAssets] 
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
	WITH TempTable AS (
		SELECT trunkID, trunkIDRange, serialNum, account, modelNum, modelDesc, 
			AIMTransactionNumber, ArchiveReason,
			ROW_NUMBER() OVER(ORDER BY serialNum) AS RowNumber,
			TotalRows = COUNT(*) OVER()
		FROM dbo.[archive-assets]
	)
	SELECT trunkID, trunkIDRange, serialNum, account, modelNum, modelDesc,
			AIMTransactionNumber, ArchiveReason, RowNumber, TotalRows
	FROM TempTable
	WHERE (RowNumber > @StartRow AND RowNumber <= @EndRow)
END
