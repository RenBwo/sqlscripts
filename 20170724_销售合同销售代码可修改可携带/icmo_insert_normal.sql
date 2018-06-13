
/*   
  
date:   2017/06/26     
description:    icmo触发器优化:   
description:    1.Merge lwm_gzlh  
description:    2.Merge lwm_screw2  
description:    3.Merge whyb_sxh_icomupdate1   
author:   RenBwo  
  
date:   2016-05-20    
description: 曲军要求 增加客户代码信息  
author:         xuyaoyao  
  
date:   2014-07-24    
description: 吴总指示,生产任务单上增加   客户库入库数量 和  裸包库入库数量  
author:   YangYuan  
*/  
CREATE TRIGGER  [dbo].[ICMO_INSERT]  ON [dbo].[ICMO]  
FOR INSERT  
AS           
DECLARE @InterID   int  
,  @SEOrderInterID  int    --订单内码  
,  @PlanOrderInterID int  
,  @fparentInterID  int    --拆单  
,  @FSourceEntryID  int    --源单行号  
,  @Decimal   int  
,  @FtranType   int  
,  @FType    int  
,  @fstatus   int  
,  @FHeadSelfJ0192  VARCHAR(50)  
,  @FHeadSelfJ0193  VARCHAR(50)  
,  @FHeadSelfJ0194  VARCHAR(50)  
,  @RowsCount   int    --统计  
  
SELECT @InterID=FInterID,@SEOrderInterID =isnull(FOrderInterID,0),@PlanOrderInterID=FPlanOrderinterID ,  
@FTranType=FTranTYpe,@FType=FType,@FSourceEntryID=isnull(FSourceEntryid,0),@fstatus = fstatus  
,@fparentinterid  = isnull(FParentInterID ,0)  
 FROM INSERTED  
select @Decimal=FQtyDecimal from t_icitem t1 ,Inserted t2 where t1.FitemID=t2.FitemID  
  
------------2017/06/26 RenBwo 1 2 :merge lwm_gzlh and lwm_scrw2--start-----------------------  
  
select @RowsCount=count(*)-1 from  icmo a  join inserted  b on a.FOrderInterid=b.forderinterid   
and a.FSourceEntryid = b.fsourceentryid  and isnull(b.forderinterid,0) <> 0 and isnull(b.fparentinterid,0) = 0  --有销售订单且未拆分的任务单  
  
update a set --a.fbillno =(case   
 -- when @RowsCount=0  then d.FEntrySelfS0160   
 -- when @RowsCount>0  then d.FEntrySelfS0160+'_'+cast (@RowsCount as varchar(3))  
 -- else a.fbillno end)  
-- ,   
  a.FHeadSelfJ0184= d.fentryselfs0160         
  , a.FHeadSelfJ0186= d.FEntrySelfS0162      --  2014-07-24   YANGYUAN  
  , a.FHeadSelfJ0187= d.FEntrySelfS0163          
  , a.FHeadSelfJ0188= e.FNumber        --  2016-05-20   xuyaoyao  
--  , a.FHeadSelfJ0192='1'    
from   icmo   a   
join   inserted  b on a.finterid = b.finterid  
join   SEOrder   c on c.finterid = b.forderinterid   
join   SEOrderEntry d on d.finterid = c.finterid  and  d.fentryid  = b.fsourceentryid  
left outer join t_Organization e ON e.FItemID = c.FCustID  
  
------------2017/06/26 RenBwo 1+2 : merge lwm_gzlh and lwm_scrw2--- ended--------------------  
-------------2017/06/26 RenBwo 3 merge whyb_sxh_icomupdate1 -----start-----------------  
  
select @FHeadSelfJ0192=t4.FMapNumber,@FHeadSelfJ0193=t4.FMapName,@FHeadSelfJ0194=t5.FNote  
from  ICMO   t1  
inner join t_ICItem  t2 on t1.FItemID=t2.FItemID  
inner join T_Organization t3 on t1.FHeadSelfJ0188=t3.FNumber  
inner join  ICItemMapping t4 on t4.FCompanyID=t3.FItemID and t4.FItemID=t2.FItemID  
inner join ICPrcPlyEntry t5 on t5.FRelatedID=t3.FItemID and t5.FItemID=t2.FItemID  
where t2.FNumber like '01.%' and t4.FID=4 and t4.FPropertyID =1  and t5.FInterID=4 and t1.finterid = @interid  
  
/*update ICMO set FHeadSelfJ0192=@FHeadSelfJ0192,FHeadSelfJ0193=@FHeadSelfJ0193,FHeadSelfJ0194=@FHeadSelfJ0194  
  where FInterID=@INTERID */  
--whyb_sxh_icomupdate1 end----------  
  
UPDATE ICMO SET FAUXQTY=round(FAuxQty,@Decimal),FHeadSelfJ0192=@FHeadSelfJ0192,FHeadSelfJ0193=@FHeadSelfJ0193,FHeadSelfJ0194=@FHeadSelfJ0194  
 Where FinterID=@InterID   
-------------2017/06/26 RenBwo 3 merge whyb_sxh_icomupdate1 -----ended-----------------  
--此字段更新会触发AuxQty_ICMO触发器，如去除此语句，需要同步处理AuxQty_ICMO触发器，增加FOR  INSERT 处理 Wangdayong 2006/06/20  
--关于反写全部放到AuxQty_ICMO中处理  
--if @FTranType=54  
--UPDATE ICMO SET FUnScheduledAuxQty=FAuxQty,FUnScheduledQty=FQty Where FinterID=@interid and FTranType=54  
/*销售订单*/  
--if @SEOrderInterID>0  
--        BEGIN  
--                UPDATE t1 SET t1.FBCommitQty=t1.FBCommitQty+t2.FQty  
--                FROM SEOrderEntry t1,ICMO t2  
--                WHERE  t2.FInterID=@InterID  
--                AND    t1.FInterID=@SEOrderInterID  
--                AND    t1.FItemID=t2.FItemID  
--                AND    t1.FEntryID=t2.FSourceEntryID and t2.FScheduleID=0  
--                UPDATE t1 SET t1.FAuxBCommitQty=(Case When t2.FCoefficient=0 then t1.FBCommitQty Else t1.FBCommitQty/cast(t2.FCoefficient as float) end)  
--                FROM SEOrderEntry t1,t_MeasureUnit t2  
--                WHERE t1.FInterID=@SEOrderInterID  
--                AND t1.FUnitID=t2.FItemID  
--                Update t1 set t1.FChildren=t1.FChildren+1  
--               FROM SEOrder t1 Where t1.FInterID=@SEOrderInterID  
--         END  
--H_Error:
GO
