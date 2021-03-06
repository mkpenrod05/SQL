USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spGetSettingsByPage]    Script Date: 09/10/2013 15:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 05 Sep 2013
-- Description:	Get the settings for a specific page.
--
-- GRANT EXECUTE ON [dbo].[spGetSettingsByPage] to [PWCS_app] -- For production use
--
-- spGetSettingsByPage
-- spGetSettingsByPage 'ReplacementPlan'
-- =============================================
ALTER PROCEDURE [dbo].[spGetSettingsByPage] 
	-- Add the parameters for the stored procedure here
	@SettingPage nvarchar(50) = 'All'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @SettingPage = 'All'
		SELECT * FROM dbo.Settings
	ELSE
		SELECT * FROM dbo.Settings WHERE SettingPage = @SettingPage
		
    -- Insert statements for procedure here
	
END
