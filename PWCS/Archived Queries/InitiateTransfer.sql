USE PWCS
GO

DECLARE 
@TRANSFER_NUMBER int,@SN nvarchar(50),@TO_ACCOUNT nvarchar(50),@OriginalAccountComments nvarchar(max)
-- Transfer number 0 is reserved for assets coming to the PWCS account for
-- either DRMO or to be advertised out to the community
-- Next transfer is 17
SET @TRANSFER_NUMBER = 16
SET @SN = '320CLV1705'
SET @TO_ACCOUNT = '99ZZ'

SET @OriginalAccountComments = (SELECT assetComments FROM dbo.assets WHERE serialNum = @SN)

INSERT INTO dbo.transfers(
transfer_number,serial_num,to_account,from_account
)
SELECT @TRANSFER_NUMBER,serialNum,UPPER(@TO_ACCOUNT),account
FROM dbo.assets
WHERE (serialNum = @SN)
;
UPDATE dbo.assets SET 
	modified_by = SUSER_NAME(),
	modified_date = GETDATE(),
	assetComments = ('Transfer number ' + CAST(@TRANSFER_NUMBER AS nvarchar(50)) + ' to account ' + UPPER(@TO_ACCOUNT) + ' has been initiated.' + @OriginalAccountComments)
	WHERE serialNum = @SN;
SELECT * FROM dbo.transfers WHERE transfer_number = @TRANSFER_NUMBER ORDER BY serial_num;
SELECT * FROM dbo.assets WHERE serialNum = @SN;

