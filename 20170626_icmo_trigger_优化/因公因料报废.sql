
/*

date:			2017/06/27 
descriptions:	优化ICMO触发器，把whyb_sxh_icmoupdate里与SHPROCRPT相关 update icmo的部分放到这里
DESCRIPTIONS:	免检产品，在工序汇报时输入报废数量；
DESCRIPTIONS：	检验产品，在工序检验单审核后，报废数量反写到工序汇报
author:			RenBwo

date:			<2014-09-12>
Description:	<工序汇报单中增加审核时间24小时的格式，公司需要>
Author:			<YangYuan>
*/
alter TRIGGER [dbo].[SHProcRptMain_Update]
   ON  [dbo].[SHProcRptMain] 
   AFTER UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON 
	
	DECLARE		@FINTERID  INT,
				@FStatus   smallint
				,@ficmointerid int
				,@sum0	decimal(28,10)
				,@sum1  decimal(28,10)
				
	----单据表头增加 审核时间 24小时 (2014-08-01 16:20:33)
	
	DECLARE seu_cur_2 CURSOR
	FOR
		SELECT FinterID, FStatus,ficmointerid  FROM INSERTED 	                           
	OPEN seu_cur_2	    
	FETCH NEXT FROM seu_cur_2 into @FINTERID, @FStatus ,@ficmointerid
	WHILE @@FETCH_STATUS=0
	BEGIN
	    
	select @sum0 =sum(t2.FOperAuxQtyScrap) ,@sum1 = sum(t2.FOperAuxQtyForItem)					--2017/06/27 RenBwo start
	from  shprocrptmain t1 
	join  shprocrpt     t2 on t1.finterid = t2.finterid and  t1.ficmointerid = @ficmointerid
	
	update ICMO set	FHeadSelfJ0189=@sum0,FHeadSelfJ0190=@sum1 where finterid = @ficmointerid	--2017/06/27 RenBwo end

		IF (SELECT FStatus  FROM deleted where FInterID =@FINTERID )=0 AND @FStatus =1    --审核
		BEGIN
			UPDATE SHProcRptMain 
			SET FHeadSelfY5240=GETDATE()
			WHERE FInterID =@FINTERID
			
			UPDATE SHWorkBillEntry
			   SET FEntrySelfz0377=c.FHeadSelfY5240
			FROM SHWorkBill A
			INNER JOIN SHWorkBillEntry B ON A.FInterID =B.FinterID 
			INNER JOIN SHProcRptMain C ON c.FWBInterID=b.FWBInterID
			INNER JOIN ICMO D ON D.FInterID =A.FICMOInterID 
			WHERE c.FInterID =@FInterID 
		
			update t3 set t3.FHeadSelfJ0195=t4.FName											--生产任务单增加工序汇报进度字段	
			from SHProcRptMain t1																			--徐彦武提出
			inner join SHProcRpt t2 on t1.FInterID=t2.FinterID
			inner join ICMO t3 on t1.FICMOInterID=t3.FInterID
			inner join t_SubMessage t4 on t1.FOperID=t4.FInterID
			where t1.FInterID=@FInterID																		-- end
	
			update t3 set t3.FHeadSelfJ0197=GETDATE()														--生产任务单增加下料完成时间字段
			from SHProcRptMain t1																			--李静提出
			inner join SHProcRpt t2 on t1.FInterID=t2.FinterID
			inner join ICMO t3 on t1.FICMOInterID=t3.FInterID
			inner join t_SubMessage t4 on t1.FOperID=t4.FInterID
			inner join SHWorkBill t5 on t3.FInterID=t5.FICMOInterID
			inner join SHWorkBillEntry t6 on t5.FInterID=t6.FinterID
			where t4.FName like '%下料%' and t6.FAuxQtyFinish>=t6.FAuxQtyPlan
			and t1.FInterID=@FInterID																		-- end
	
END
		ELSE IF (SELECT FStatus  FROM deleted where FInterID =@FINTERID)=1 AND @FStatus =0		--反审核
		BEGIN
			UPDATE SHProcRptMain 
			SET FHeadSelfY5240=NULL
			WHERE FInterID =@FINTERID
		END
		
    FETCH NEXT FROM seu_cur_2 into  @FINTERID, @FStatus,@ficmointerid
	END
	CLOSE seu_cur_2
	DEALLOCATE seu_cur_2
	
  -----  审核时间 结束

END

