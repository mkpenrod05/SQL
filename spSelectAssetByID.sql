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
-- Create date:		22 Sep 2013
-- Description:		Retrieves a specific asset by its ID.
--
-- EXAMPLE USES:
-- spSelectAssetByID @ID = 249	
--
-- GRANT EXECUTE ON [dbo].[spSelectAssetByID] to [PWCS_app] -- For production use  
-- =============================================
ALTER PROCEDURE dbo.spSelectAssetByID 
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.assets 
	WHERE ID = @ID
	ORDER BY serialNum
END
GO
