select * from ICTransactionType where  FName like '%¡Ï¡œ%'
update ICTransactionType set FCheckPRO = FCheckPRO+'|redevclientobj:wash.washVerify' where  FID = 24
select * from t_ThirdPartyComponent where FTypedetailID = 24
select * from ICTemplate where FID = 'b04' order by fctlindex
update icstockbill set FHeadSelfB0435='2019-01-01' where FBillNo = 'SOUT302237'
select * from icstockbill where FBillNo = 'SOUT302237'