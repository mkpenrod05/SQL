DECLARE 
@SN nvarchar(50), @assetDisabledDate date, @assetDisabledComments nvarchar(max)

SET @SN = ''
SET @assetDisabledDate = GETDATE() -- use getdate() for today's date OR a '20JUN2012' format 
SET @assetDisabledComments = ''

UPDATE dbo.assets
SET assetDisabled = 1, assetDisabledDate = @assetDisabledDate, assetDisabledComments = @assetDisabledComments,
	modified_by = SUSER_NAME(), modified_date = GETDATE()
WHERE aims_sn = @SN OR trunk_sn = @SN
;
SELECT * FROM dbo.assets WHERE aims_sn = @SN OR trunk_sn = @SN; 
SELECT * FROM dbo.assets WHERE assetDisabled = 'True' ORDER BY aims_sn;