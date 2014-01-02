USE PWCS 
go

select assets.account, assets.trunkID, assets.trunkIDRange, assets.serialNum, assets.modelNum, assets.modelDesc,
		max(TrunkingSystemLog.TransmitDate) as 'LastTransmitDate'  

from dbo.assets
inner join dbo.TrunkingSystemLog on assets.trunkID = TrunkingSystemLog.TrunkID
where (account is null) 
	and (serialNum is not null) 
	and (serialNum <> '0') 
	and (trunkIDRange <> 'SLC GUARD') 
	and (trunkIDRange <> 'GSA')
	and (TrunkingSystemLog.TransmitDate < (GETDATE() - 365))
group by assets.account, assets.trunkID, assets.trunkIDRange, assets.serialNum,
		assets.modelNum, assets.modelDesc, TrunkingSystemLog.TrunkID
order by assets.serialNum		