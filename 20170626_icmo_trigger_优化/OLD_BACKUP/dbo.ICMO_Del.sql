CREATE TRIGGER ICMO_Del ON dbo.ICMO  
FOR DELETE  
AS  
declare @FromMrp int  
declare @FromMps int  
select @FromMrp = FInterID from t_submessage where ftypeid = 242 and FID = 'LY3'  
select @FromMps = FInterID from t_submessage where ftypeid = 242 and FID = 'LY6'  
if exists(select * from Deleted where FCancellation=1 and FMrp <> @FromMrp and FMrp <> @FromMps)  
  BEGIN  
   ROLLBACK TRAN  
   RAISERROR('不能删除已经作废的单据!',18,18)  
   return  
  END  
if exists(select * from Deleted where  FStatus in(1,2))  
 BEGIN  
  ROLLBACK TRAN  
  RAISERROR('不能删除已经下达的单据!',18,18)  
  return  
 END  
if exists(select * from Deleted where  FStatus =5)  
 BEGIN  
  ROLLBACK TRAN  
  RAISERROR('不能删除已经确认的单据!',18,18)  
  return  
 END   
if exists(select * from Deleted where  FStatus=3)  
 BEGIN  
  ROLLBACK TRAN  
  RAISERROR('不能删除已经结案的单据!',18,18)  
  return  
 END  
 /*销售订单*/  
UPDATE t1 SET t1.FBCommitQty=(CASE WHEN (t1.FBCommitQty-t2.FQty)>0 THEN t1.FBCommitQty-t2.FQty ELSE 0 END)
FROM SEOrderEntry t1 ,Deleted t2  
WHERE t1.FInterID=t2.FOrderInterID  
AND t1.FItemID=t2.FItemID  
AND     t1.FEntryID=t2.FSourceEntryID AND t2.FOrderInterID>0 and t2.FScheduleID=0  
UPDATE t1 SET t1.FAuxBCommitQty=(Case When t2.FCoefficient=0 then t1.FBCommitQty Else t1.FBCommitQty/t2.FCoefficient end)  
FROM SEOrderEntry t1,t_MeasureUnit t2,DELETED t3  
WHERE t1.FInterID=t3.FOrderInterID  
AND t1.FUnitID=t2.FItemID and t3.FOrderInterID>0  
Update t1 set t1.FChildren=(case When t1.FChildren-1 >0 then t1.FChildren-1 else 0 end )
FROM SEOrder t1 ,Deleted t2   Where t1.FInterID=t2.FOrderInterID
update t1 set t1.FUnScheduledAuxQty=t1.FUnScheduledAuxQty+ t2.FAuxQty  
 from icmo t1,deleted t2  
where t1.FInterId=t2.FScheduleID and t1.FTranType=54  
--计划订单号 --修改生产任务单的触发器,取消反写计划订单及关闭计划订单的功能 wangdayong 2004/11/30 
--UPDATE t1 SET t1.FHaveOrderQty=(case when t1.FHaveOrderQty>t2.FQty then t1.FHaveOrderQty - t2.FQty else 0 end)  
--,t1.Fstatus=case when t1.FHaveOrderQty - t2.FQty>=t1.FPlanQty then 3 else 1 end  
--FROM ICMrpResult t1,
--(SELECT FPlanOrderInterID,FItemID,SUM(FQty) AS FQty
--   FROM Deleted 
--  WHERE FTranType=54 or(FTrantype=85 and FType<>11060 and FType>0)
--  GROUP BY FPlanOrderInterID,FItemID
--) t2  
--WHERE t1.FPlanOrderInterID=t2.FPlanOrderInterID  
--AND t1.FItemID=t2.FItemID  
-- AND t2.FPlanOrderInterID>0 
Return