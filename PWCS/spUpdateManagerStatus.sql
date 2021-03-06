SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 16 May 2013
-- Description:	Used to update the status of a manager by setting their
--				active state to either true or false
--
-- GRANT EXECUTE ON [dbo].[spUpdateManagerStatus] to [PWCS_app]
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateManagerStatus] 
	-- Add the parameters for the stored procedure here
	@Status bit,
	@ManagerID int,
	@modified_by nvarchar(50),
	@modified_date date
AS
BEGIN
	-- For UPDATE/DELETE statements, NOCOUNT needs to be turned off so that the 
	-- number of records affected is returned.  If NOCOUNT is set to ON, the database
	-- will always return a -1. 
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	UPDATE managers 
	SET active = @Status, 
		modified_by = @modified_by, 
		modified_date = @modified_date 
	WHERE ID = @ManagerID; 
END
GO