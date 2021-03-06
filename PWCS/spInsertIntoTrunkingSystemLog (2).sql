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
-- Create date: 03 September 2013
-- Description:	Used to insert data into the TrunkingSystemLog table from the "TrunkLogImport.ps1" file
--				located at "\\fshill\data\CommInfo\75 CS\Hill CFP\PWCS\Trunking System Log Files" 
--
-- GRANT EXECUTE ON [dbo].[SearchAllAssets] to [PWCS_app] -- For Production Use
--
-- EXAMPLE USES:
-- spInsertIntoTrunkingSystemLog '2013-12-01','Testing','700000','700000','123ABC4567','800000','FAKENAME','10000000'
-- =============================================
ALTER PROCEDURE dbo.spInsertIntoTrunkingSystemLog 
	-- Add the parameters for the stored procedure here
	@TransmitDate Date,
	@Action nvarchar(100),
	@Radio nvarchar(50),
	@RadioUser nvarchar(50),
	@SerialNumber nvarchar(50),
	@TargetGroupID nvarchar(50),
	@TargetGroupName nvarchar(50),
	@OLCallNumber nvarchar(50)
AS
BEGIN
	Insert Into dbo.TrunkingSystemLog (
		TransmitDate, Action, Radio, RadioUser, SerialNumber, TargetGroupID, TargetGroupName, OLCallNumber
	)
	Select @TransmitDate, @Action, @Radio, @RadioUser, @SerialNumber, @TargetGroupID, @TargetGroupName, @OLCallNumber
	Where NOT EXISTS (
		Select 1 From dbo.TrunkingSystemLog 
		Where TransmitDate = @TransmitDate
			AND Radio = @Radio
			AND RadioUser = @RadioUser
			AND TargetGroupName = @TargetGroupName
	)
END
GO

