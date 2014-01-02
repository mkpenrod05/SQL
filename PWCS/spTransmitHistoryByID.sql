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
-- Create date: 16 May 2013
-- Description:	Used to pull a small transmit history for a specific trunk ID.
--
-- GRANT EXECUTE ON [dbo].[spTransmitHistoryByID] to [PWCS_app]
-- =============================================
CREATE PROCEDURE dbo.spTransmitHistoryByID 
	-- Add the parameters for the stored procedure here
	@TrunkID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT TOP(20) TransmitDate, Radio, SerialNumber, TargetGroupName 
	FROM dbo.TrunkingSystemLog 
	WHERE Radio = @TrunkID 
	ORDER BY TransmitDate DESC
END
GO
