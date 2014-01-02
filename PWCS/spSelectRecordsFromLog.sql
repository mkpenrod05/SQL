-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 26 Sep 2013
-- Description:	Used to retrieve a list of assets that are unaccounted for.  
--
-- ------------EXAMPLE USES---------------------
-- spSelectRecordsFromLog @PageNumber = 1, @PageSize = 5, @ActionType = 'Account Update', @ColumnName = 'account_comments', @AffectedTableID = 10, @UniqueValue = '' 
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spSelectRecordsFromLog] to [PWCS_app] -- For production use
-- =============================================
ALTER PROCEDURE dbo.spSelectRecordsFromLog
	@PageNumber int = 1,
	@PageSize int = 30,
	@ActionType nvarchar(100),
	@ColumnName nvarchar(50),
	@AffectedTableID int = 0,
	@UniqueValue nvarchar(100) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StartRow int, @EndRow int
	SET @StartRow = (@PageNumber - 1) * @PageSize
	SET @EndRow = ((@PageNumber - 1) * @PageSize) + @PageSize
	;
	IF (@AffectedTableID = 0)
		SET @AffectedTableID = null
	;
	IF (@UniqueValue = '')
		SET @UniqueValue = null
	;	
	WITH TempTable AS (
		SELECT ID, Reason, OldValue, NewValue, modified_by, modified_date
			,ROW_NUMBER() OVER(ORDER BY modified_date DESC, ID DESC) AS RowNumber
			,TotalRows = COUNT(*) OVER()
		FROM dbo.Log
		WHERE (ActionType = @ActionType) 
			AND (ColumnName = @ColumnName) 
			AND ((AffectedTableID = @AffectedTableID) OR (UniqueValue = @UniqueValue))
	)
	SELECT ID, Reason, OldValue, NewValue, modified_by, modified_date, RowNumber, TotalRows
	FROM TempTable
	WHERE (RowNumber > @StartRow AND RowNumber <= @EndRow)
END
GO
