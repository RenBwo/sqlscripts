select * from ictranstype
select  b.ficmointerid,b.fentryselfa0238,c.fheadselfj0184,* 
from icstockbill a join icstockbillentry b on a.finterid = b.finterid 
join icmo c on c.finterid = b.ficmointerid
where a.ftrantype = 2 and a.fdate > '2017-06-01'
and b.fentryselfa0238 <> c.fheadselfj0184

update icstockbillentry set fentryselfa0238 = c.fheadselfj0184
from icstockbill a join icstockbillentry b on a.finterid = b.finterid 
join icmo c on c.finterid = b.ficmointerid
where a.ftrantype = 2 and a.fdate > '2017-06-01'
and b.fentryselfa0238 <> c.fheadselfj0184