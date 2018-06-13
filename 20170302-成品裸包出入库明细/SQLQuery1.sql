		 --select * from ictranstype
		 select  b.fentryselfa0238,* from icstockbill a join icstockbillentry b on a.finterid = b.finterid
		 where  b.fentryselfa0238 like 'z%' and fdate > '2017-02-01' and ftrantype = 21
		 ;select * from ictransactiontype where fname like '%Èë¿â%'
		 select * from ictemplate a join ictemplateentry b on a.fid = b.fid where a.fid = 'a02' and b.fheadcaption like '%¹¤×÷Áî%'
		 ; select * from t_Department  where fnumber like 's6%'