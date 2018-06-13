alter trigger trig_salestatus_change_after_uncheck
on dbo.icstockbill
after update
as 
begin
declare @fstatusIn int,	@fstatusDel int,@ftrantype int

	;select @fstatusIn = fstatus,@ftrantype = ftrantype from inserted
	;select @fstatusDel = fstatus						from deleted  

	if @fstatusIn = 0 and @fstatusDel = 1  and @ftrantype =21 and update(fstatus)
	begin
	update a set a.fheadselfb0157 = null
	from icstockbill a join inserted b on a.finterid = b.finterid
	end
	if @fstatusIn=1 and @fstatusDel=0 and @ftrantype =21 and update(fstatus)
	begin
	if not exists (select 1 from inserted where fheadselfb0157 in (select fitemid from t_item where fitemclassid = 3012))
	    BEGIN
              RAISERROR('销售状态不正确，请检查单据!',18,18)
          ROLLBACK transaction
    END
	end
	
end