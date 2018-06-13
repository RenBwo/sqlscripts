
/* 

date:			2017/06/26			
description:    icmo触发器优化: 
description:    1.if update(fauxqty)与if update(others qty) 分离，update(fauxqty)还触发其它操作
description:    2. 
description:    3.  
description:    4.
author:			RenBwo


date:			2006/06/20
description:	Insert触发器中会更新FAuxQty字段，会触发此触发器，不必增加FOR  INSERT 
author:			Wangdayong 
*/
alter  TRIGGER [dbo].[AuxQty_ICMO] ON [dbo].[ICMO]  
FOR Update																			--  2006/06/20  wangdayong   
AS  
begin
DECLARE     @FBCommitQty Decimal(28,10)
if update(FAuxQty)																	--  2017/06/26 1 RenBwo										
Begin 
update t1 set t1.FQty=cast(t2.FAuxQty as float)*cast((isnull(t3.FCoefficient,1)+isnull(t3.FScale,0)) as float),  
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
 
if exists(select 1 from inserted where ftrantype = 54)								--  未分解数量
 begin 
	UPDATE t1 SET t1.FUnScheduledAuxQty=t1.FAuxQty,t1.FUnScheduledQty=t1.FQty 
			from icmo t1 join inserted t2 on t1.finterid=t2.finterid and t1.FTranType=t2.ftrantype  
 end
SELECT @FBCommitQty=SUM(t2.FQty)											--销售订单  
                FROM SEOrderEntry t1 
				Inner Join ICMO t2  ON t1.FInterID=t2.FOrderInterID AND t1.FEntryID=t2.FSourceEntryID 
							and t2.FScheduleID=0 AND t2.FCancellation=0  AND    t1.FItemID=t2.FItemID    
				left join inserted t3 on  t2.finterid = t3.finterid
                WHERE  t1.FInterID=t3.FOrderInterID    
                AND    t1.FEntryID=t3.FSourceEntryID  and t3.forderinterid > 0   
                Group By t1.FInterID,t1.FEntryID  
         set @FBCommitQty=isnull(@FBCommitQty,0) 
if @FBCommitQty>0  
        BEGIN  		 
                ;UPDATE t1 SET t1.FBCommitQty=@FBCommitQty  
                ,t1.FAuxBCommitQty=(Case When t3.FCoefficient=0 then @FBCommitQty Else @FBCommitQty/cast(t3.FCoefficient as float) end)  
                FROM SEOrderEntry	t1  
				join inserted		t2	on t1.fentryid = t2.fsourceentryid and t1.finterid = t2.forderinterid
				join t_MeasureUnit	t3	on t1.FUnitID=t3.FItemID 
                ;Update t1 set t1.FChildren=t1.FChildren+1  
                FROM SEOrder t1 join inserted t2 on t1.FInterID=t2.fOrderInterID  
         END
END 	 
------------not update fauxqty and update others fqty 2017/06/26-----------------------------------------------------
if not update(FAuxQty) and( update(FAuxQtyFinish) or update(FAuxQtyScrap) or update(FAuxQtyLost)  or update(FAuxQtyPass)  or update(FAuxQtyBack)  
    or update(FAuxInHighLimitQty) or update(FAuxInLowLimitQty) or update(FAuxQtyForItem) or update(FUnScheduledAuxQty) or update(FReleasedAuxQty) ) 
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
H_Error:  
END