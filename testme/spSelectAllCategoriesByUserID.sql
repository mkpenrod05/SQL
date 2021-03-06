USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spSelectAllCategoriesByUserID]    Script Date: 12/31/2013 10:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 31 Dec 2013
-- Description:	Used to select all records from tblCategories for a specific user.
-- =============================================
ALTER PROCEDURE [dbo].[spSelectAllCategoriesByUserID]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select * 
	From dbo.tblCategories 
	Where (UserID = @UserID)
	Order By CategoryName
END
