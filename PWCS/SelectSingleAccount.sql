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
-- Create date:		21 Sep 2013
-- Description:		Retrieves all attributes of a specific account
--
-- ------------EXAMPLE USES---------------------
-- SelectSingleAccount @AccountCode = '74LM'
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[SelectSingleAccount] to [PWCS_app] -- For Production Use Only 
-- =============================================
CREATE PROCEDURE dbo.spSelectSingleAccount 
	@AccountCode nvarchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM accounts WHERE account_code = @AccountCode
END
GO
