--use [AIS20161026113020]
use [AIS20091217151735]
go
set ansi_nulls on
go
SET QUOTED_IDENTIFIER ON
go
alter trigger trig_salestatus_change_after_uncheck
on dbo.icstockbill
after update
as 
begin
declare @status_before int,
	@status_after int,
	@status_sale int

	select @status_before = a.fstatus,@status_after = b.fstatus
	from deleted a join inserted b on a.finterid = b.finterid and b.ftrantype = 21 and a.ftrantype = 21
	
	if @status_before = 1 and @status_after = 0 
	begin
	update a set a.fheadselfb0157 = null
	from icstockbill a join inserted b on a.finterid = b.finterid
	end
	if @status_before=0 and @status_after=1
	begin
	if not exists (select 1 from inserted where fheadselfb0157 in (select fitemid from t_item where fitemclassid = 3012))
	    BEGIN
              RAISERROR('销售状态不正确，请检查单据!',18,18)
          ROLLBACK transaction
    END
	end
	
end