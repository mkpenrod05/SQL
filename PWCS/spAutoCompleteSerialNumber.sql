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
-- Create date: 21 Oct 2013
-- Description:	Provide a list of serial numbers for JavaScript Autocomplete functionality.
--
-- GRANT EXECUTE ON [dbo].[spAutoCompleteSerialNumber] to [PWCS_app] -- For production use only.
-- 
-- EXAMPLE USES:
-- spAutoCompleteSerialNumber @SerialNumber = '320CEG'
-- spAutoCompleteSerialNumber @SerialNumber = '320CEG', @Count = 20
--
-- =============================================
ALTER PROCEDURE dbo.spAutoCompleteSerialNumber 
	@SerialNumber nvarchar(50),
	@Count int = 10
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP(@Count) ID, serialNum 
	FROM dbo.assets 
	WHERE serialNum LIKE '%' + @SerialNumber + '%'
	ORDER BY serialNum
END
GO
