USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spSelectSingleAccount]    Script Date: 9/21/2013 4:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Michael C. Penrod
-- Create date:		21 Sep 2013
-- Description:		Retrieves all attributes of a specific account
--
-- ------------EXAMPLE USES---------------------
-- spSelectSingleAccount @AccountCode = '74LM'
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spSelectSingleAccount] to [PWCS_app] -- For Production Use Only 
-- =============================================
ALTER PROCEDURE [dbo].[spSelectSingleAccount] 
	@AccountCode nvarchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM accounts WHERE account_code = @AccountCode
END
