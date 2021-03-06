USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spSelectSingleManagerByID]    Script Date: 9/22/2013 12:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		22 Sep 2013
-- Description:		Retrieves a specific PWCS manager.
--
-- ------------EXAMPLE USES---------------------
-- spSelectSingleManagerByID @ID = 12
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spSelectSingleManagerByID] to [PWCS_app] -- For production use 
-- =============================================
ALTER PROCEDURE [dbo].[spSelectSingleManagerByID] 
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.managers WHERE ID = @ID
END
