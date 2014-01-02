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
-- Create date: 27 Sep 2013
-- Description:	Retrieves a list of events from the Log table.  
--
-- ------------EXAMPLE USES---------------------
-- spSelectRecordFromLogByID @ID = 1659
--
-- ------------FOR PRODUCTION USE---------------
-- GRANT EXECUTE ON [dbo].[spSelectRecordFromLogByID] to [PWCS_app] -- For production use
-- =============================================
CREATE PROCEDURE dbo.spSelectRecordFromLogByID 
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.Log WHERE ID = @ID
END
GO
