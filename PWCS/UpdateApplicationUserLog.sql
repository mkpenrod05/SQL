USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[UpdateApplicationUserLog]    Script Date: 12/13/2013 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Penrod
-- Create date: 11 Dec 2013
-- Description:	Testing...
-- 
-- =============================================
ALTER PROCEDURE [dbo].[UpdateApplicationUserLog] (
	--@App nvarchar(50),
	@UserSessionID nvarchar(100),
	@UserSessionStatus bit,
	--@AUTH_USER nvarchar(50),
	--@SessionStart datetime,
	@SessionEnd datetime,
	--@IpAddress nvarchar(50),
	--@MachineName nvarchar(50),
	--@DisplayName nvarchar(50),
	--@CN  nvarchar(MAX),
	--@GIGID  nvarchar(50),
	--@ModifiedBy  nvarchar(50),
	@ModifiedDate datetime
	)
AS
BEGIN
	
	UPDATE dbo.ApplicationUsersLog
	SET UserSessionStatus = @UserSessionStatus,
		SessionEnd = @SessionEnd,
		ModifiedDate = @ModifiedDate
	WHERE UserSessionID = @UserSessionID

END
