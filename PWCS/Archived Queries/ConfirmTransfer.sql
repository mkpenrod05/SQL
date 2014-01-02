USE PWCS
GO

DECLARE @SN nvarchar(50), @OriginalAssetComments nvarchar(max) 
SET @SN = ''
SET @OriginalAssetComments = (SELECT assetComments FROM dbo.assets WHERE serialNum = @SN)

UPDATE dbo.assets
SET account = transfers.to_account
FROM (
	SELECT to_account 
	FROM dbo.transfers
	WHERE (serial_num = @SN) AND (returned <> 'True') 
	) transfers 
WHERE assets.serialNum = @SN
;
UPDATE dbo.transfers
SET returned = 'True',modified_by = SUSER_NAME(),modified_date = GETDATE() 
WHERE serial_num = @SN AND returned <> 'True'
;
UPDATE dbo.assets
SET modified_by = SUSER_NAME(),modified_date = GETDATE(),
	assetComments = (@OriginalAssetComments + ' Transfer has been returned and completed')
WHERE serialNum = @SN
;
SELECT * FROM dbo.assets WHERE serialNum = @SN;
SELECT * FROM dbo.transfers WHERE serial_num = @SN;