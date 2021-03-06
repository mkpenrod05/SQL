USE [PWCS]
GO
/****** Object:  StoredProcedure [dbo].[spReplacementPlan]    Script Date: 09/06/2013 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 16 May 2013
-- Description:	Used to create a unit's replacement plan 
--
-- GRANT EXECUTE ON [dbo].[spReplacementPlan] to [PWCS_app]
-- =============================================
ALTER PROCEDURE [dbo].[spReplacementPlan] 
	-- Add the parameters for the stored procedure here
	@Account nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--DECLARE @UpgradeCost int;
	--
	--SET @UpgradeCost = (SELECT SettingValue FROM dbo.Settings WHERE SettingName = 'UpgradeCost');
	
    -- Insert statements for procedure here
	SELECT 
		CASE
			WHEN ([9600B] = 'X' or AES = 'X' or OTAR = 'X' or OTAP = 'X')
				THEN '2-replace'
				
			WHEN (([9600B] = 'Y' or [9600B] = 'NA') 
				and (AES = 'Y' or AES = 'NA') 
				and (OTAR = 'Y' or OTAR = 'NA') 
				and (OTAP = 'Y' or OTAP = 'NA'))
				THEN '3-compatible'
				
			WHEN ([9600B] = 'N' or AES = 'N' or OTAR = 'N' or OTAP = 'N')
				THEN '1-upgrade'
				
			WHEN ([9600B] = 'U' or AES = 'U' or OTAR = 'U' or OTAP = 'U')
				THEN '4-unknown'
						
			ELSE '4-unknown' 	
		END AS category,
		serialNum,
		modelNum,
		modelDesc,
		[9600B],
		AES,
		OTAR,
		OTAP,
		cost
		--@UpgradeCost AS 'UpgradeCost'
	FROM dbo.assets 
	WHERE account = @Account
	ORDER BY category, serialNum
END
