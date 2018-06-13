/*
select * from t_pa_pama
select * from t_pa_department
select * from t_panewdata
delete from t_panewdata
delete from t_pa_pama
select * from t_pa_personal
select * from hm_employees
*/
--计时计件
select b.FProcRptInterID,b.FProcRptEntryID,b.* from icjobpay a join ICJobPayEntry b on a.FInterID = b.FInterID and a.FInterID=10495
--update ICJobPayEntry set FEntrySelfR0133 = 1  from icjobpay a join ICJobPayEntry b on a.FInterID = b.FInterID and a.FInterID=10495

--update SHProcRpt set FEntrySelfY5236 =1 where FinterID  in (select b.FProcRptInterID  from icjobpay a join ICJobPayEntry b on a.FInterID = b.FInterID and a.FInterID=10495
--)
--update t_routingoper set fentryselfz0236 = 1 where FEntrySelfZ0236 = 0