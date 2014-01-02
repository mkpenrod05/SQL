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
-- Author:		Michael C. Penrod
-- Create date: 15 Oct 2013
-- Description:	Select an account's information based on its ID.
--
-- spSelectAccountByID @ID = 5
-- =============================================
CREATE PROCEDURE dbo.spSelectAccountByID
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM dbo.accounts WHERE ID = @ID;
END
GO
