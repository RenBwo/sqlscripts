/* 
 * Date:			2017/12/26
 * Author:			RenBo
 * Description:		1.	Trigger is actived when checking 
 * Description:		2.	折旧返利 fheadselfl0548(NormalInvoice) fheadselfl0451(specialInvoice) 
 * 
 * Date:			2017/12/14
 * Author:			RenBo
 * Description: 	1. To return-write about the value of fconsignprice and fconsignamount contained in ICSTOCKBILLENTRY 
 * 					2. To add conditions: invoice-normal & RMB ,Invoice-special & RMB,Invoice-special & no RMB 
 * 
 * Date:			2017/06/19
 * Author:			RenBo
 * Description: 	1. Those invoices-normal must be distinguished between including tax and uncluding tax
 *  				2. To make backup of original price and amount of uncludeing tax 
 *  				3. To add conditions: invoice-normal& no RMB 
 * 
 * Date:			2017/02/21
 * Author:			RenBo
 * Description:		1. To return-write  about the UNIT_PRICE and AMOUNT contained both in ICSTOCKBILLENTRY 
 * 					and in SEOUTSTOCKENTRY  after icsale is been checked 
 * Invoice type:	normal ftype = 86 , special ftype = 80
 *  */
Alter trigger [dbo].[trig_icsale_ReturnWrite_OutStock_SaleNotice] on [dbo].[ICSale] for UPDATE
as 
begin
declare @sum0 decimal(20,4),@sum1 decimal(20,4)
declare @s varchar(20),@s2 as varchar(20)
SET NOCOUNT ON	
/*
-- 1. invoice-normal & no RMB & before checked
if  (select fheadselfi0548 from  inserted  where ftrantype = 86 and fcurrencyid >1 and fstatus = 0) = 307022
begin
--make backup of original price and amount
update icstockbillentry	set		 fentryselfb0176 = fentryselfb0160 
								,fentryselfb0177 = fentryselfb0161 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 and isnull(d.fentryselfb0176,0) = 0							-- Once only ,so it can be made sure of be original data 

update icstockbillentry	set		 fconsignprice 		= b.fauxtaxprice*a.fexchangerate
								,fconsignamount 	= b.fstdamount
								,fentryselfb0160 	= b.fauxtaxprice      -- b.fauxprice is been replaced
								,fentryselfb0161 	= b.famount
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86

update SEOutStockEntry set		 fauxprice 	= b.fauxtaxprice
								,fprice 	= b.fauxtaxprice
								,famount	= b.fauxtaxprice*f.FQty	
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
join SEOutStock			e	on	e.ftrantype = d.fsourcetrantype and e.finterid	= d.fsourceinterid --out notice
join SEOutStockEntry	f	on	e.finterid	= f.finterid		and f.fentryid	= d.fsourceentryid
where a.ftrantype = 86
end
-- 2. invoice-normal &  RMB & before checked
if 307022 = (select fheadselfi0548 from  inserted  where ftrantype = 86 and fcurrencyid =1 and fstatus = 0) 
begin
--make backup of original price and amount
update icstockbillentry	set		 fentryselfb0176 = fentryselfb0160 
								,fentryselfb0177 = fentryselfb0161 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 and isnull(d.fentryselfb0176,0) = 0							-- Once only ,so it can be made sure of be original data 

update icstockbillentry	set		 fconsignprice 		= b.fauxtaxprice*a.fexchangerate
								,fconsignamount 	= b.fstdamount
								,fentryselfb0160 	= b.fauxtaxprice      
								,fentryselfb0161 	= b.famount
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86

update SEOutStockEntry set		 fauxprice 	= b.fauxtaxprice
								,fprice 	= b.fauxtaxprice
								,famount	= b.fauxtaxprice*f.FQty	
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
join SEOutStock			e	on	e.ftrantype = d.fsourcetrantype and e.finterid	= d.fsourceinterid --out notice
join SEOutStockEntry	f	on	e.finterid	= f.finterid		and f.fentryid	= d.fsourceentryid
where a.ftrantype = 86
end


-- 3.invoice-special &  RMB & before checked
if 307022 = (select fheadselfi0451 from  inserted  where ftrantype = 80 and fcurrencyid =1 and fstatus = 0) 
begin
--make backup of original price and amount
update icstockbillentry	set		 fentryselfb0176 = fentryselfb0160 
								,fentryselfb0177 = fentryselfb0161 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 80 and isnull(d.fentryselfb0176,0) = 0							-- Once only ,so it can be made sure of be original data 

update icstockbillentry	set		 fconsignprice 		= b.fauxtaxprice
								,fconsignamount 	= b.fstdamountIncludeTax
								,fentryselfb0160 	= b.fauxtaxprice      
								,fentryselfb0161 	= b.fstdamountIncludeTax
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 80

update SEOutStockEntry set		 fauxprice 	= b.fauxtaxprice
								,fprice 	= b.fauxtaxprice
								,famount	= b.fauxtaxprice*f.FQty	
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
join SEOutStock			e	on	e.ftrantype = d.fsourcetrantype and e.finterid	= d.fsourceinterid --out notice
join SEOutStockEntry	f	on	e.finterid	= f.finterid		and f.fentryid	= d.fsourceentryid
where a.ftrantype = 80
end
-- 4. invoice-special &  no RMB
if 307022 = (select fheadselfi0451 from  inserted  where ftrantype = 80 and fcurrencyid >1 and fstatus = 0) 
begin
raiserror('目前,专用发票只能用于人民币业务',18,1) 
rollback tran 
return 
end
*/
-- 5. invoice-normal & no RMB & after checked & no discount
if update(fstatus) 
and exists(select 1 from  inserted  where ftrantype = 86 and fcurrencyid >1 and fstatus = 1 
and isnull(fheadselfi0548,0)<>307022 ) 
begin
--make backup of original price and amount
update icstockbillentry	set		 fentryselfb0176 = fentryselfb0160 
								,fentryselfb0177 = fentryselfb0161 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 and isnull(d.fentryselfb0176,0) = 0							-- Once only ,so it can be made sure of be original data 

select @sum0=0,@sum1=0
select @sum0 = sum(b.famount) 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86

select @sum1 = sum(d.fentryselfb0177) 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86
if abs(@sum0 - @sum1) > 0.5
begin
	select @s = cast(@sum0 as varchar(20)),@s2=cast(@sum1 as varchar(20))
raiserror('销售出库单调整金额 超出 财务规定的范围(-0.5 ~ +0.5),调整后金额%s ,调整前金额%s',18,1,@s,@s2) 
rollback tran 
return 
end

update icstockbillentry	set		 fconsignprice 		= b.fauxtaxprice*a.fexchangerate
								,fconsignamount 	= b.fstdamount
								,fentryselfb0160 	= b.fauxtaxprice      -- b.fauxprice is been replaced 
								,fentryselfb0161 	= b.famount
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill 
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86

update SEOutStockEntry set		 fauxprice 	= b.fauxtaxprice
								,fprice 	= b.fauxtaxprice
								,famount	= b.fauxtaxprice*f.FQty	
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
join SEOutStock			e	on	e.ftrantype = d.fsourcetrantype and e.finterid	= d.fsourceinterid --out notice 
join SEOutStockEntry	f	on	e.finterid	= f.finterid		and f.fentryid	= d.fsourceentryid
where a.ftrantype = 86
end
-- 6. invoice-special &  no discount 
if update(fstatus) 
	and 307022 <> (select (case ftrantype when 80 then isnull(fheadselfi0451,0) 
	when 86 then isnull(fheadselfi0548,0) else 0 end) 
	from  inserted  where ftrantype = 80  or ftrantype = 86)  
begin	
	--make backup of original price and amount 
update icstockbillentry	set		 fentryselfb0176 = fentryselfb0160 
								,fentryselfb0177 = fentryselfb0161 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill 
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where (a.ftrantype = 86 or a.ftrantype = 80) and isnull(d.fentryselfb0176,0) = 0							-- Once only ,so it can be made sure of be original data 

select @sum0=0,@sum1=0
select @sum0 = sum(case a.ftrantype when 86 then b.famount when 80 then b.fstdamountIncludeTax end) 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill 
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 or a.ftrantype = 80

select @sum1 = sum(d.fentryselfb0177) 
from inserted			a 
join icsaleentry		b	on	a.finterid	= b.finterid
join icstockbill		c	on	c.finterid	= b.fsourceinterid	and c.ftrantype = 21 --out bill 
join icstockbillentry	d	on	c.finterid	= d.finterid		and d.fentryid	= b.fsourceentryid
where a.ftrantype = 86 or a.ftrantype = 80

if abs(@sum0 - @sum1) > 0.5
begin
	select @s = cast(@sum0 as varchar(20)),@s2=cast(@sum1 as varchar(20))
	raiserror('没有折扣返利 或者 调整金额超过允许范围,调整后金额%s ,调整前金额%s',18,1,@s,@s2) 
rollback tran 
return 
end
end
end
