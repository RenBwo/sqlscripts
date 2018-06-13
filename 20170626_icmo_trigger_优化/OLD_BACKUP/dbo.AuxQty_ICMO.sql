
CREATE  TRIGGER [dbo].[AuxQty_ICMO] ON [dbo].[ICMO]  
--FOR INSERT,Update  
FOR Update --Insert触发器中会更新FAuxQty字段，会触发此触发器，不必增加FOR  INSERT Wangdayong  2006/06/20  
AS  
if update(FAuxQty) or update(FAuxQtyFinish) or update(FAuxQtyScrap) or update(FAuxQtyLost)  or update(FAuxQtyPass)  or update(FAuxQtyBack)  
    or update(FAuxInHighLimitQty) or update(FAuxInLowLimitQty) or update(FAuxQtyForItem) or update(FUnScheduledAuxQty) or update(FReleasedAuxQty)  
Update t1 set t1.FQty=cast(t2.FAuxQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FQtyFinish=cast(t2.FAuxQtyFinish as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FQtyScrap=cast(t2.FAuxQtyScrap as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FQtyLost=cast(t2.FAuxQtyLost as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FQtyPass=cast(t2.FAuxQtyPass as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FQtyBack=cast(t2.FAuxQtyBack as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FInHighLimitQty=cast(t2.FAuxInHighLimitQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FInLowLimitQty=cast(t2.FAuxInLowLimitQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
--t1.FStockQty=t2.FAuxStockQty*(isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)),  
t1.FQtyForItem=cast(t2.FAuxQtyForItem as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FUnScheduledQty=cast(t2.FUnScheduledAuxQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
t1.FReleasedQty=cast(t2.FReleasedAuxQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float)  
from ICMO t1,Inserted t2,t_MeasureUnit t3  
where t1.FInterID=t2.FInterID and t3.FMeasureunitID=t2.FUnitID   
if update(FAuxQty)  
Begin  
DECLARE @InterID  int,  
        @SEOrderInterID int,  
        @PlanOrderInterID int,  
        @Decimal int,  
        @FtranType int,  
        @FType  int,  
        @FSourceEntryID int,  
        @FBCommitQty Decimal(28,10)  
SELECT @InterID=FInterID,@SEOrderInterID =FOrderInterID,@PlanOrderInterID=FPlanOrderinterID ,@FTranType=FTranTYpe,@FType=FType,@FSourceEntryID=FSourceEntryID  
FROM INSERTED  
if @FTranType=54  
UPDATE ICMO SET FUnScheduledAuxQty=FAuxQty,FUnScheduledQty=FQty Where FinterID=@interid and FTranType=54  
/*销售订单*/  
if @SEOrderInterID>0  
        BEGIN  
         SELECT @FBCommitQty=SUM(t2.FQty)   
                FROM SEOrderEntry t1 Inner Join ICMO t2  ON t1.FInterID=t2.FOrderInterID AND t1.FEntryID=t2.FSourceEntryID  
                WHERE  t1.FInterID=@SEOrderInterID    
                AND    t1.FItemID=t2.FItemID    
                AND    t1.FEntryID=@FSourceEntryID and t2.FScheduleID=0 AND t2.FCancellation=0--BT213389 排除作废的任务单   
                Group By t1.FInterID,t1.FEntryID  
                set @FBCommitQty=isnull(@FBCommitQty,0)  
                UPDATE t1 SET t1.FBCommitQty=@FBCommitQty  
                FROM SEOrderEntry t1  
                WHERE  t1.FEntryID=@FSourceEntryID  
                AND    t1.FInterID=@SEOrderInterID  
                UPDATE t1 SET t1.FAuxBCommitQty=(Case When t2.FCoefficient=0 then t1.FBCommitQty Else t1.FBCommitQty/cast(t2.FCoefficient as float) end)  
                FROM SEOrderEntry t1,t_MeasureUnit t2  
                WHERE t1.FInterID=@SEOrderInterID  
                AND t1.FUnitID=t2.FItemID  
                Update t1 set t1.FChildren=t1.FChildren+1  
                FROM SEOrder t1 Where t1.FInterID=@SEOrderInterID  
         END  
H_Error:  
END