CREATE  TRIGGER [dbo].[ICMO_Update] ON [dbo].[ICMO]
FOR Update
AS
if Update(FStatus)
--增加判断，此触发器只有在修改FStatus字段时才需要触发。Wangdayong  2006/06/20
Begin
Declare @insFStatus int,
	@DelFstatus int
--	@insCancel int,
--	@DelCancel int,
--	@InterID  int,
--	@FtranType int,
--	@PlanOrderInterID int,
--	@FType	int
--select @InsFstatus=FStatus,@insCancel=FCancellation ,@InterID=FInterID,@PlanOrderInterID=FPlanOrderinterID ,@FTranType=FTranTYpe,@FType=FType from  INSERTED
--select @DelFstatus=FStatus,@DelCancel=FCancellation  from  DELETED
select @InsFstatus=FStatus from  INSERTED
select @DelFstatus=FStatus from  DELETED
if @InsFstatus=3 and @DelFstatus<>3
begin
	Delete t1 from t_LockStock  t1  join ppbom p1 on(p1.FInterID=t1.FinterID) join Deleted t2 on (p1.Ficmointerid=t2.FinterID) Where t1.FTranType=88
end
--作废时判断:作废则减少数量,否则反之
--修改生产任务单的触发器,取消反写计划订单及关闭计划订单的功能 wangdayong 2004/11/30
--if (@insCancel<>@DelCancel ) and (@PlanOrderInterID>0 and (@FTrantype=54 or (@FTranType=85 and @FType<11060 and @FType>0)))
--begin
--	UPDATE t1 SET t1.FHaveOrderQty=t1.FHaveOrderQty-(@insCancel-@DelCancel)*cast(t2.FQty as float)
--		,t1.Fstatus=case when t1.FHaveOrderQty-(@insCancel-@DelCancel)*cast(t2.FQty as float)>=t1.FPlanQty then 3 else 1 end
----		FROM ICMrpResult t1 ,icmo t2
--		WHERE	t2.FinterID=@Interid
--		AND 	t1.FPlanOrderInterID=t2.FPlanOrderInterID
--		AND	t1.FItemID=t2.FItemID
--end
update t3 set t3.FHeadSelfJ0191=t3.FQty-t3.FAuxStockQty-t3.FHeadSelfJ0189-t3.FHeadSelfJ0190 
from icmo t3 
inner join inserted t4 on t3.FInterID=t4.FInterID
End