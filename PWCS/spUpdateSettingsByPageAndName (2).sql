USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateSettingsByPageAndName]    Script Date: 09/10/2013 15:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 09 Sep 2013
-- Description:	Update the Settings table for any given value.
--
-- GRANT EXECUTE ON [dbo].[spUpdateSettingsByPageAndName] to [PWCS_app] -- DONE MCP
--
-- spUpdateSettingsByPageAndName 'Test', 'Test', 'Test Value', 'The Incredible Hulk'
-- =============================================
ALTER PROCEDURE [dbo].[spUpdateSettingsByPageAndName] 
	-- Add the parameters for the stored procedure here
	@SettingPage nvarchar(50),
	@SettingName nvarchar(50),
	@SettingValue nvarchar(MAX),
	@modified_by nvarchar(100)
AS
BEGIN
	
	UPDATE dbo.Settings
	SET SettingValue = @SettingValue, modified_by = @modified_by
	WHERE SettingPage = @SettingPage AND SettingName = @SettingName

END
