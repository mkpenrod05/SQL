USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[SelectAccountAssets]    Script Date: 9/22/2013 8:07:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		02 May 2013
-- Description:		Retrieves a list of assets for a specific account
--
-- EXAMPLE USES:
-- spSelectAssetsByAccount @Account = '74LM'	
--
-- GRANT EXECUTE ON [dbo].[spSelectAssetsByAccount] to [PWCS_app] -- For production use  
-- =============================================

CREATE PROCEDURE [dbo].[spSelectAssetsByAccount]
	-- Add the parameters for the stored procedure here
	@AccountCode AS nvarchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.assets
	WHERE account = @AccountCode
	ORDER BY serialNum
END
