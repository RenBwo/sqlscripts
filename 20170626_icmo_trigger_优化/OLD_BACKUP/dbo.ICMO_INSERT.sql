CREATE TRIGGER  [dbo].[ICMO_INSERT]  ON [dbo].[ICMO]
FOR INSERT
AS         
DECLARE @InterID  int,
        @SEOrderInterID int,
        @PlanOrderInterID int,
        @Decimal int,
        @FtranType int,
        @FType  int,
        @FSourceEntryID int,
		@fstatus int 
SELECT @InterID=FInterID,@SEOrderInterID =FOrderInterID,@PlanOrderInterID=FPlanOrderinterID ,@FTranType=FTranTYpe,@FType=FType,@FSourceEntryID=FSourceEntryID
,@fstatus = fstatus FROM INSERTED
select @Decimal=FQtyDecimal from t_icitem t1 ,Inserted t2 where t1.FitemID=t2.FitemID
UPDATE ICMO SET FAUXQTY=round(FAuxQty,@Decimal) Where FinterID=@InterID 
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