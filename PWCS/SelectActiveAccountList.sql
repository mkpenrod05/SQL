USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[SelectActiveAccountList]    Script Date: 9/21/2013 3:39:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		02 May 2013
-- Description:		Retrieves a list of active PWCS accounts
-- =============================================

-- The following line needs to be executed after this procedure is created
-- GRANT EXECUTE ON [dbo].[SelectActiveAccountList] to [PWCS_app]  
-- DONE - 02 May 2013 - MCP  

ALTER PROCEDURE [dbo].[SelectActiveAccountList]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT account_code, appt_ltr, inventory, account_validation FROM dbo.accounts
	SELECT * FROM dbo.accounts
	WHERE active = 'True'
	ORDER BY account_code
END
