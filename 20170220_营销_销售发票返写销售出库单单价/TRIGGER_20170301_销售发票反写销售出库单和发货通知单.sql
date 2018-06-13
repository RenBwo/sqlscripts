--
--	Description:	to UPDATE both the UNIT_PRICE and AMOUNT contained in ICSTOCKBILLENTRY and in SEOUTSTOCKENTRY
--					after  updating icsale
--	Writer:			RenBwo
--	Date:			2017/02/21
--
alter trigger trig_icsale_renbwo_20170220 on dbo.icsale for UPDATE
as 
begin	
if exists(select 1 from  inserted  where ftrantype = 86)
begin
SET NOCOUNT ON	
update d	set		d.fentryselfb0160 = b.fauxprice 
				,	d.fentryselfb0161 = b.famount
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid = b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid = d.finterid			and d.fentryid = b.fsourceentryid

update f set		f.fauxprice = b.fauxprice 
				,	f.famount	= b.famount		
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid = b.fsourceentryid
join SEOutStock			e	on	e.ftrantype = d.fsourcetrantype and e.finterid = d.fsourceinterid
join SEOutStockEntry	f	on	e.finterid	= f.finterid		and f.fentryid = d.fsourceentryid

end
end