select a.fsourceinterid,d.finterid,a.fsourceentryid,d.fentryid,a.fitemid,a.fqty,d.fqty, d.fentryselfb0160 as outprice ,a.fauxprice as invprice,d.fentryselfb0161 as outamount, a.famount
from icstockbill c 
join icstockbillentry d  on c.finterid = d.finterid 
join icsaleentry a on a.fsourceentryid = d.fentryid and a.fsourceinterid = d.finterid 
join icsale b on a.finterid = b.finterid  and b.ftrantype = 86
where b.fbillno like '%18241505%'