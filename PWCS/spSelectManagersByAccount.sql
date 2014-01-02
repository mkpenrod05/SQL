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
-- Description:		Retrieves a list of PWCS managers for a specific account.
--
-- ------------EXAMPLE USES---------------------
-- spSelectManagersByAccount @AccountCode = '74LM'
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spSelectManagersByAccount] to [PWCS_app] -- For production use 
-- =============================================
CREATE PROCEDURE dbo.spSelectManagersByAccount 
	@AccountCode nvarchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.managers 
	WHERE account_code = @AccountCode
	ORDER BY active DESC, position DESC
END
GO
