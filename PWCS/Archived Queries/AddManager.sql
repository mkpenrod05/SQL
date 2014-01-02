DECLARE 

@ACCOUNT_CODE nvarchar(50), 
@POSITION nvarchar(50), 
@RANK nvarchar(50),
@FNAME nvarchar(50),
@LNAME nvarchar(50),
@ORG nvarchar(50),
@PHONE nvarchar(50),
@EMAIL nvarchar(50),
@TRAINED date

SET @ACCOUNT_CODE = '67WC'
SET @POSITION = 'Alternate' -- Primary / Alternate
SET @RANK = 'TSGT'
SET @FNAME = 'Thomas'
SET @LNAME = 'Coomes'
SET @ORG = '388 EMS/CCR'
SET @PHONE = '775-5795'
SET @EMAIL = 'Thomas.Coomes@hill.af.mil'
SET @TRAINED = '19JUN2012' -- yyyy-mm-dd OR ddMMyy (12Jan2012)

INSERT INTO dbo.[managers](
account_code,position,rank,fname,lname,org,phone,email,trained
)
VALUES (
UPPER(@ACCOUNT_CODE),@POSITION,UPPER(@RANK),@FNAME,@LNAME,UPPER(@ORG),@PHONE,@EMAIL,@TRAINED
)
;
SELECT * FROM dbo.managers WHERE account_code = @ACCOUNT_CODE
;