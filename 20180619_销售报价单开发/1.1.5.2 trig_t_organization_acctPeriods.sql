
alter trigger trig_t_organization_acctPeriods 
on t_organization for update
as 
begin
--根据客户收款条件计算客户账期
--ftablename t_paycolcondition,fid 1007737
--客户账期字段：t_organization.f_122
	--必须采用信用收款条件，t_paycolconditionentry.foptmode = 0
	if update(fpaycondition) and exists(select 1 from inserted a join t_paycolconditionentry b on a.fpaycondition = b.fid 
	and b.foptmode >0)
	begin
		ROLLBACK TRAN
        RAISERROR('收款条件错误，请采用信用天数计算的收款条件!',18,18)
	end 
	else if exists (select 1 from inserted where fstatus = 1  )
	begin
	update t_organization set f_122 = (case
 		when b.ffststdate=0 and b.foptmode=0 then isnull(b.fday,0)
  		else isnull(b.fday,0)+15 end)
	from t_organization a join t_paycolconditionentry b on a.fpaycondition = b.fid
	join inserted c on a.fitemid = c.fitemid
	end 
end