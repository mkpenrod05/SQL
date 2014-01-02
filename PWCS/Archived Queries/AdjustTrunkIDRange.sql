DECLARE @BOR nvarchar(50),@EOR nvarchar(50),@RangeName nvarchar(50)

SET @BOR = '714000'
SET @EOR = '714046'
SET @RangeName = '299th'

UPDATE dbo.assets SET trunkIDRange = UPPER(@RangeName)
WHERE trunk_id >= @BOR AND trunk_id <= @EOR
;
SELECT * FROM dbo.assets WHERE trunk_id >= @BOR AND trunk_id <= @EOR ORDER BY trunk_id;
SELECT * FROM dbo.assets WHERE trunkIDRange IS NULL;