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
-- Author:			Michael C. Penrod
-- Create date:		17 July 2013
-- Description:		Retrieves a list of all open trunk ID's regardless
-- of what role that ID plays in the system.  For example, any ID larger
-- than 730000 is analog and cannot be used for digital transmission.
-- Also, many ID's in the 720000 range are console ID's which are used for 
-- a unit's computer console that connects directly to the trunking system.
-- These ID's cannot be assigned to a PWCS device. 
--
-- ------------EXAMPLE USES---------------------
-- spAllOpenTrunkID
-- spAllOpenTrunkID @PageNumber = 2, @PageSize = 50
-- spAllOpenTrunkID @PageNumber = 1, @PageSize = 500
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spActiveManagersList] to [PWCS_app]  
-- =============================================
CREATE PROCEDURE [dbo].[spAllOpenTrunkID] 
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
		SELECT trunkID, trunkIDRange, serialNum, assetComments,
			ROW_NUMBER() OVER(ORDER BY trunkID) AS RowNumber,
			TotalRows = COUNT(*) OVER() 
		FROM dbo.assets
		WHERE ((serialNum LIKE '0%') OR (serialNum = '') or (serialNum is null)) AND (trunkID LIKE '7%')
	)
	SELECT trunkID, trunkIDRange, serialNum, assetComments, RowNumber, TotalRows
	FROM TempTable
	WHERE (RowNumber > @StartRow AND RowNumber <= @EndRow)
END
