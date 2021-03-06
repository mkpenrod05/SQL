USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spInsertIntoCategories]    Script Date: 1/1/2014 8:31:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 29 Dec 2013
-- Description:	Used to insert a new record into tblCategories
-- =============================================
ALTER PROCEDURE [dbo].[spInsertIntoCategories] 
	@CategoryName nvarchar(50),
	@UserID int
AS
BEGIN
	IF 
		exists(
			SELECT 1 FROM dbo.tblCategories
			WHERE CategoryName = @CategoryName and UserID = @UserID
		)
		BEGIN
			SELECT 'A category with this name already exists!'
			AS DBErrorMessage
			RETURN
		END
	ELSE
		DECLARE @LastModifiedByID int
		SET @LastModifiedByID = @UserID
		
		INSERT INTO dbo.tblCategories (
			CategoryName,
			UserID,
			LastModifiedByID
		) VALUES (
			@CategoryName,
			@UserID,
			@LastModifiedByID
		)

END
