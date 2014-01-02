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
-- Author:		Michael Penrod
-- Create date: 11 Dec 2013
-- Description:	Testing...
-- =============================================
CREATE PROCEDURE dbo.InsertApplicationUserLog (
	@App nvarchar(50),
	@UserSessionID nvarchar(100),
	@UserSessionStatus bit,
	@AUTH_USER nvarchar(50),
	@SessionStart datetime,
	--@SessionEnd datetime,
	@IpAddress nvarchar(50),
	@MachineName nvarchar(50),
	@DisplayName nvarchar(50),
	@CN  nvarchar(MAX),
	@GIGID  nvarchar(50),
	@ModifiedBy  nvarchar(50)
	--@ModifiedDate datetime
	)
	
AS
BEGIN
	
	INSERT INTO dbo.ApplicationUsersLog
	(App, UserSessionID, UserSessionStatus, AUTH_USER, SessionStart, IpAddress, MachineName, DisplayName, CN, GIGID, ModifiedBy)
	VALUES
	(@App, @UserSessionID, @UserSessionStatus, @AUTH_USER, @SessionStart, @IpAddress, @MachineName, @DisplayName, @CN, @GIGID, @ModifiedBy)

END
GO
