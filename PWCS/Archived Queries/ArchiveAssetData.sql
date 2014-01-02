USE PWCS
GO
DECLARE 
@SN nvarchar(50),@ArchiveReason nvarchar(max),@ModifiedBy nvarchar(50),@ModifiedDate date  

SET @SN = ''
SET @ArchiveReason = ''
SET @ModifiedBy = SUSER_NAME()
SET @ModifiedDate = GETDATE()

INSERT INTO dbo.[archive-assets](
trunkID,trunkIDRange,serialNum,account,partNum,modelNum,modelDesc,cost,[9600B],AES,OTAR,OTAP,
assetComments,assetDisabled,assetDisabledDate,assetDisabledComments,archiveReason,modified_by,modified_date
)
SELECT 
trunkID,trunkIDRange,serialNum,account,partNum,modelNum,modelDesc,cost,[9600B],AES,OTAR,OTAP,
assetComments,assetDisabled,assetDisabledDate,assetDisabledComments,@ArchiveReason,@ModifiedBy,@ModifiedDate
FROM    dbo.assets
WHERE   (serialNum = @SN)
;
UPDATE 	dbo.assets
SET		serialNum = NULL,
		account = NULL,
		partNum = NULL,
		modelNum = NULL,
		modelDesc = NULL,
		cost = NULL,
		[9600B] = NULL,
		AES = NULL,
		OTAR = NULL,
		OTAP = NULL,
		assetComments = NULL,
		assetDisabled = NULL,
		assetDisabledDate = NULL,
		assetDisabledComments = NULL,
		modified_by = SUSER_NAME(),
		modified_date = GETDATE()
WHERE   (serialNum = @SN)
;
-- make sure asset's data made it into the archive table
SELECT * FROM dbo.[archive-assets] WHERE serialNum = @SN;

-- should turn up empty meaning the data was successfully archived
SELECT serialNum As 'I should be empty! If you see a value below me, something went wrong!' FROM dbo.assets WHERE serialNum = @SN;