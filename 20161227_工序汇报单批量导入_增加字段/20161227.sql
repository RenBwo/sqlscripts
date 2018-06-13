Select top 10 * from icshopprocbatch a join icshopprocbatchentry b on a.fid = b.fid;
;select top 10 * FROM SHPROCRPTMAIN A JOIN shprocrpt b on a.finterid = b.Finterid
/*
select @li_qty = fbangdeqty ,@li_wbno = fwbno,@li_item = fitemid  from inserted 

insert into abc(fwbno,fbangdeqty) values(@li_qty ,@li_wbno )
update b set b.fentryselfy5240 = @li_qty
from shprocrptmain a join shprocrpt b on a.finterid = b.finterid 
where a.fwbno = @li_wbno and b.fitemid = @li_item*/
use AIS20161227083209
go
create trigger trig_BD_WorkOrderReport on ICShopProcBatchentry for insert
as
SET NOCOUNT ON
declare @li_qty integer
declare @li_wbno integer
declare @li_item integer
begin
select @li_qty = count(*) from shprocrptmain 
select @li_wbno = count(*) from shprocrpt 
insert into abc(fwbno,fbangdeqty) values(@li_qty ,@li_wbno )
end 
--
create trigger trig_BD_SHprocrpt on shprocrpt for insert
as
SET NOCOUNT ON
declare @li_qty integer
declare @li_wbno integer
declare @li_item integer
begin
select @li_qty = count(*) from shprocrptmain 
select @li_wbno = count(*) from shprocrpt 
insert into abc(fwbno,fbangdeqty) values(@li_qty ,@li_wbno )
end 