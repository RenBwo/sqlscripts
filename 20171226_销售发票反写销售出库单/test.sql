select * from icclasstype where fname_chs like '%发货通知 '
select * from ictemplate where fcaption like '%发票%'
select * from ictemplate where fid = 'S02'
select fheadcaption,ffieldname,fid,* from ictemplateentry where fid in('i05', 'i04') 
and (fheadcaption like '%价%' or fheadcaption like '%额%' )or ffieldname like '%amount%' order by ffieldname
select fprice,fauxprice  from SEOutStockEntry
select * from t_tabledescription where ftablename like 'SEOutStockEntry'

select c.fname,b.fauxprice as 单价,b.fauxtaxprice as 含税单价,b.fauxpricediscount as 实际含税单价
,b.famount as 金额 ,b.fstdamount as 金额本位 
,b.ftaxamount as 税,b.fstdtaxamount as 税本位币
,b.fallamount as 合计金额, b.fstdallamount as 合计本位币
,b.famountincludetax as 含税合计,b.fstdamountincludetax as 含税合计本位币
from icsale a join icsaleentry b on a.finterid = b.finterid and a.fdate > '2017-01-01' 
and a.ftrantype = 86
left join ictransactiontype c on c.fid = a.ftrantype
select b.* from icsale a join icsaleentry b on a.finterid = b.finterid and a.fbillno = 'Z02978679-1'
select b.name,a.* from sys.columns a join  sys.all_objects b on a.object_id = b.object_id where a.name like '%includetax%'

select b.fconsignprice,b.fconsignamount,b.fentryselfb0160, b.fentryselfb0161,b.famount,b.fprice,* from  icstockbill a join icstockbillentry b on a.finterid = b.finterid and a.fbillno like 'xout015038'
select a.fexchangerate,b.fauxtaxprice,b.fstdamount,b.fstdamountincludetax,b.famount,b.famountincludetax,b.* from icsale a join icsaleentry b on a.finterid = b.finterid and a.fbillno like 'zbkp20171201' and b.fentryid = 1
select *  from  icsale  where ftrantype = 86 and fcurrencyid > 1 
--drop trigger tr_icsale_rewriteperiodprice_renbwo
select  fstatus,fheadselfi0548,fheadselfi0451,* from icsale where fdate > '2017-12-12'
select * from t_item where fname like '%返利'

select sum(case a.ftrantype when 86 then isnull(b.famount,0) when 80 then isnull(b.fstdamountIncludeTax,0) end) 
from icsale			a 
join icsaleentry		b	on	a.finterid	= b.finterid and a.finterid = 8781
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 or a.ftrantype = 80
select * from icsale where fdate > '2017-12-24' and (ftrantype  = 80 or ftrantype = 86)

