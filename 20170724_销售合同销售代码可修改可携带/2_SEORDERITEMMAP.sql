/*
 * DESCRIPTION:	客户对应编码:来源于销售合同				   营销要求  2017-07-01
 * AUTHOR：		RENBWO
 * DATE:		2017/07/26
 */
-- =============================================
-- Author:		<YangYuan>
-- Create date: <20150510>
-- Description:	<销售订单中客户要求交货日期来源于合同中的客户要求交货日期
-- 客户需要数量若没有录入则自动默认为"数量"字段中的值
-- 纸箱生产数量若没有录入则自动默认为"数量"字段中的值  计划 曲军要求 20150512>
-- 客户对应编码:来源于客户对应物料代码				   计划曲军要求  2015-07-01 
-- =============================================
ALTER TRIGGER [dbo].[SEOrder_InsertUpdate] 
   ON  [dbo].[SEOrder]
   AFTER INSERT,UPDATE
AS 
BEGIN
	DECLARE		@FCNT1			INT,
				@FStatus_old   INT, --变动前原来的状态
				@FStatus_new   INT  --变动后新的状态
				
	SET NOCOUNT ON 
	
	select @FStatus_new=FStatus from inserted    ---保存变更后的数据
    select @FStatus_old=isnull(FStatus,0)  from deleted  ---保存变更前的数据 
	
	--新增(新状态：0, 原来状态：0)、保存(新状态：0, 原来状态：0)、审核状态(新状态：1, 原来状态：0)  FA审核状态(新状态：0, 原来状态：1)  
	IF @FStatus_old=0  --反审核不考虑
	BEGIN
		SELECT @FCNT1=COUNT(*) FROM INSERTED a
		INNER JOIN SEOrderEntry B ON A.FInterID =B.FInterID 
		INNER JOIN t_rpContractEntry C ON B.FContractInterID=C.FContractID AND B.FContractEntryID=C.FEntryID 
		
		---销售合同下推时 客户要求交货日期/客户需要数量/纸箱生产数量  根据销售合同更改
		IF @FCNT1 >0
		BEGIN
			UPDATE SEOrderEntry
			SET FEntrySelfS0161= c.fdate1, FEntrySelfS0162=(case when FEntrySelfS0162=0 then FQty else FEntrySelfS0162 end)
			  , FEntrySelfS0163=FAuxQty-(case when FEntrySelfS0162=0 then FQty else FEntrySelfS0162 end)
			  , FEntrySelfS0181=(case when FEntrySelfS0181=0 then FQty else FEntrySelfS0181 end)
			FROM INSERTED a
			INNER JOIN SEOrderEntry B ON A.FInterID =B.FInterID 
			INNER JOIN t_rpContractEntry C ON B.FContractInterID=C.FContractID AND B.FContractEntryID=C.FEntryID 
			
		END
		/*
		---由销售合同下推或手工录入的销售订单，其中客户对应物料代码都由客户对应物料表中数据关联  曲军提出 2015-07-01
		UPDATE SEOrderEntry
			SET FEntrySelfS0180= ISNULL(D.FMapNumber,''),FEntrySelfS0192=ISNULL(D.FMapName,'')
			FROM INSERTED a
			INNER JOIN SEOrderEntry B ON A.FInterID =B.FInterID 			
			LEFT OUTER JOIN ICItemMapping D on D.FItemID =b.FItemID and D.FCompanyID =a.FCustID AND D.FPropertyID =1
         */																				--20170726	
	END
	
END
GO