USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[SearchAllAssets]    Script Date: 10/3/2013 10:24:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		02 May 2013
-- Description:		Retrieves a short list of assets pulled from both the 
--					Assets table and the Archived Assets table  
-- =============================================

-- The following line needs to be executed after this procedure is created
-- GRANT EXECUTE ON [dbo].[SearchAllAssets] to [PWCS_app]  
-- DONE - 14 May 2013 - MCP 

ALTER PROCEDURE [dbo].[SearchAllAssets] (
	-- Add the parameters for the stored procedure here
	@Value AS nvarchar(100)
	) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP(10)
		assets.ID,
		assets.account,
		assets.trunkID,
		assets.trunkIDRange,
		assets.serialNum,
		assets.modelNum,
		assets.modelDesc,
		assets.assetComments,
		'Active' AS 'status'
	FROM assets
	WHERE serialNum LIKE @Value OR trunkID LIKE @Value
	UNION ALL
	SELECT TOP(5)
		[archive-assets].ID,
		[archive-assets].account,
		[archive-assets].trunkID,
		[archive-assets].trunkIDRange,
		[archive-assets].serialNum,
		[archive-assets].modelNum,
		[archive-assets].modelDesc,
		[archive-assets].archiveReason,
		'Archived'
	FROM [archive-assets]
	WHERE serialNum LIKE @Value OR trunkID LIKE @Value
	ORDER BY serialNum
END
