-- =============================================
-- Author:		<YangYuan>
-- Create date: <2015-08-25>
-- Description:	<销售订单自动分解成品到裸包产品； 因MRP运算时不考虑最高存量和最低存量
--  销售订单数据由销售合同下推生成，不需要EXCEL上传
--  1. 成品数量  
--  1-1. 先找共享成品仓库中成品的即时库存 满足或一部分满足则新增一条数据 工作令为D-YYMM-XXX  数量(即时库存)或剩余量  调拨仓库(不用细分到仓位)
--       不同仓库则增加不同行数的数据，工作令顺序递增
--  1-2.  再找裸包产品
--  1-2-1. 裸包产品 (即时库存-已分配) >0 时 增加一条数据 工作令顺序递增 D-YYMM-XXX 数量(即时库存-已分配)或剩余量 领料仓库 裸包产品所在的仓库(不用细分到仓位)
--        不同仓库则增加不同行数的数据，工作令号顺序递增
--  1-2-2. 裸包产品 (即时库存-已分配) <0  且 (即时库存-已分配 + 预计入库量）>0  时 增加一条数据 工作令号顺序递增 D-YYMM-XXX  数量(即时库存-已分配 + 预计入库量)或剩余量  没有仓库
--  1-3. 查找上海邦德品牌仓 (即时库存-存量管理中的最高存量)>0  时增加一条数据 工作令顺序递增 D-YYMM-XXX 数量(即时库存-最高存量)或剩余量  调拨仓库(不用细分到仓位)
--  1-4. 投产 增加一条数据 工作令顺序递增 YYMM-XXX-A 数量(剩余量)
--  1-5. 投产 增加一条数据 工作令顺序递增 YYMM-XXX  裸包产品 数量(剩余量 + 最高存量) 
-->
-- =============================================
CREATE PROCEDURE [dbo].[SEOrderEntry_Computer1] 
	 @FBillNo		varchar(255),
	 @fsgzl			varchar(255),
	 @FMONTH		INT,
	 @FLDate		varchar(8),		--截止计算交货日期	 
	 @M_MESSAGE		VARCHAR(1000) output		--错误信息
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @FInterID					int,
			@FEntryID					int,	
			@FItemid					int,									--物料内码
			@fdate						datetime,								--客户订单 交货日期
			@fqty						int,									--客户订单数量	
			@FEntrySelfS0161			datetime,								--客户订单 客户要求交货日
			@FContractBillNo			VARCHAR(255),							--合同单号
			@FContractEntryID			INT,									--合同分录
			@FContractInterID			INT,									--合同内码
			@FEntrySelfS0175			VARCHAR(255),							--图纸完成时间
			@FEntrySelfS0176			VARCHAR(255),							--BOM清单审核时间
			@FEntrySelfS0177			VARCHAR(255),							--模具完成时间
			@FEntrySelfS0178			VARCHAR(255),							--工装完成时间
			@FEntrySelfS0180			VARCHAR(255),							--客户编码
			@FSourceBillNo				VARCHAR(255),							--源单单号
			@FSourceEntryID				INT,									--源单行号
			@FSourceInterId				INT,									--源单内码
			@FSourceTranType			INT,									--源单类型
			@F_104						DECIMAL(28,10),							--物料包装箱体积
			@FGrossWeight				DECIMAL(28,10),							--物料毛重
			@fqty_center				int									    --中间变动数量
			,@FEntrySelfS0192			VARCHAR(50)								--客户对应物料名称
			
	 Create Table #Ordertemp1(      
		 FInterID					INT,									--销售订单内码
		 FEntryID					INT,									--顺序号
		 FEntrySelfS0160			VARCHAR(255),							--工作令号
		 FItemID					INT,									--物料内码
		 FQty						decimal(28,10) default(0),				--数量
		 FEntrySelfS0179			INT,									--调拨仓库
		 FEntrySelfS0189			INT,									--领料仓库		 
		 FDate						datetime,								--客户订单 交货日期
		 FEntrySelfS0161			datetime,								--客户订单 客户要求交货日
		 FCustQty					decimal(28,10),							--客户需要数量/纸箱生产数量
		 FContractBillNo			VARCHAR(255),							--合同单号
		 FContractEntryID			INT,									--合同分录
		 FContractInterID			INT,									--合同内码
         FEntrySelfS0175			VARCHAR(255),							--图纸完成时间
         FEntrySelfS0176			VARCHAR(255),							--BOM清单审核时间
         FEntrySelfS0177			VARCHAR(255),							--模具完成时间
         FEntrySelfS0178			VARCHAR(255),							--工装完成时间
         FEntrySelfS0180			VARCHAR(255),							--客户编码
         FSourceBillNo				VARCHAR(255),							--源单单号
         FSourceEntryID				INT,									--源单行号
         FSourceInterId				INT,									--源单内码
         FSourceTranType			INT
         ,FEntrySelfS0192			VARCHAR(50)								--客户对应物料名称
)									--源单类型
     
	declare @FStockID		int,				--仓库内码
			@fdb_qty		decimal(28,10),		--仓库即时库存
			@fline_sum		int,
			@fky_qty1		decimal(28,10),		--仓库总即时库存
			@flb_qty2		decimal(28,10),		--裸包产品已分配量
			@flb_qty3		decimal(28,10),		--裸包产品及时库存总量
			@fsp_qty1		decimal(28,10),		--上海邦德品牌仓库即时库存总数
			@FMaxStorage	decimal(28,10),		--上海邦德品牌仓库最高存量
			@FMinStorage    decimal(28,10),		--上海邦德品牌仓库最低存量
			@FHighLimit		decimal(28,10),		--裸包物料最高存量
			@fentry_line	int,				--新表中的行号 顺序增加1
			@fgzl_line		int,				--新表工作令号需要增加的数量
			@fgzlyymm		varchar(4),			--工作令号中的 YYMM
			@fgzlseq		int,				--工作令号中的顺序号 可以是3位，可以是4位
			@gzl_num		char(255),			--计算得到的工作令号
			@f_over2		int,				--跳出循环的状态  1： 跳出  ；0： 继续
			@FItemID_LB		INT,				--成品对应裸包产品的物料内码
			@lbyj_qty		decimal(28,10)		--裸包预计入库量总数

	set @fentry_line=1
	SET @fgzl_line=0
	SELECT  @fgzlseq =CASE WHEN LEN(@fsgzl)=8 THEN cast(substring(@fsgzl ,6,3)  as int)
						   WHEN LEN(@fsgzl)=9 THEN cast(substring(@fsgzl ,6,4)  as int)
						   ELSE 1 END
	set @fgzlyymm =SUBSTRING(@fsgzl,1,4)
	--set @f_over2=0
   
	DECLARE ord_cur1 CURSOR
		FOR
		select A.FInterID ,A.FEntryID, A.FItemID, A.FQty, a.fdate , A.FEntrySelfS0161
		     , A.FContractBillNo ,A.FContractEntryID, A.FContractInterID
             , A.FEntrySelfS0175, A.FEntrySelfS0176, A.FEntrySelfS0177, A.FEntrySelfS0178, A.FEntrySelfS0180
			 , A.FSourceBillNo , A.FSourceEntryID, A.FSourceInterId
			 , A.FSourceTranType,FEntrySelfS0192

		  FROM SEOrderEntry A 
		 INNER JOIN SEOrder B ON A.FInterID = B.FInterID 
		 WHERE B.FBILLNO=@FBillNo and b.FChangeMark=0 and b.FCancellation=0
		 ORDER BY A.FEntryID
		OPEN ord_cur1	    
		FETCH NEXT FROM ord_cur1 into @FInterID, @FEntryID, @FItemId, @fqty, @fdate,@FEntrySelfS0161
		              , @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175
		              , @FEntrySelfS0176, @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
					  , @FSourceBillNo, 	@FSourceEntryID
					  , @FSourceInterId, 	@FSourceTranType
					  ,	@FEntrySelfS0192	--, @F_104, @FGrossWeight
		WHILE @@FETCH_STATUS=0	    
		BEGIN	   
			set @f_over2=0
			set @fqty_center=@fqty
			select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							  THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							  ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 					when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						                else cast(@fgzlseq +@fgzl_line as CHAR) END)
						      END	
						      
			--共享成品仓库 查询成品的及时库存数量
			set @fky_qty1=isnull((select sum(ISNULL(fqty,0)) from ICInventory where FStockID IN(228795,228797,228796) AND FItemID = @FItemID) ,0)			
		    --共享成品仓库有库存时	    
			IF @fky_qty1>0 
			BEGIN
				DECLARE stk_c1 CURSOR
				FOR
					select FStockID ,SUM(FQty) AS FQTY 
					  from ICInventory 
					 where FStockID IN(228795,228797,228796) AND FItemID = @FItemID 
					group by FStockID
				OPEN stk_c1
				FETCH NEXT FROM stk_c1 into @FStockID, @fdb_qty
				WHILE @@FETCH_STATUS=0	    
				BEGIN										
					IF @fdb_qty>=@fqty_center
					BEGIN
						INSERT INTO #Ordertemp1
						VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid, @fqty_center, @FStockID, 0, @fdate, @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType,@FEntrySelfS0192 )
						SET @fqty_center=0
						SET @fentry_line=@fentry_line+1	
						SET @fgzl_line=@fgzl_line+1					
						SET @f_over2 =1 
					END
					ELSE IF @fdb_qty>0 AND @fdb_qty<@fqty_center
					BEGIN
						INSERT INTO #Ordertemp1
						VALUES(@FInterID, @fentry_line, @gzl_num,@FItemid ,@fdb_qty,@FStockID ,0, @fdate, @FEntrySelfS0161
							  , @fdb_qty, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )
						SET @fqty_center=@fqty_center-@fdb_qty
						SET @fentry_line=@fentry_line+1
						SET @fgzl_line=@fgzl_line+1	
						SET @f_over2 =0
					END
					IF @f_over2=1 break  --第一层循环跳出
				FETCH NEXT FROM stk_c1 into @FStockID, @fdb_qty
				END
				CLOSE stk_c1
				DEALLOCATE stk_c1
			END		--IF @fky_qty1>0  END
			
			--@f_over2=1 表示该条销售订单数据已经完成 否则继续				
			
			WHILE  @f_over2=0  
			BEGIN
				--1-2-1. 裸包产品中 (即时库存-已分配) >0 时 增加一条数据 工作令顺序递增 D-YYMM-XXX 数量(即时库存-已分配)或剩余量 领料仓库 裸包产品所在的仓库(不用细分到仓位)
				--        不同仓库则增加不同行数的数据，工作令号顺序递增	
				IF(SELECT COUNT(*) FROM ICBOM A
					INNER JOIN ICBOMChild B ON A.FInterID =B.FInterID 
					INNER JOIN t_ICItemCore C ON C.FItemID =B.FItemID 
					WHERE A.FItemID =@FItemid AND C.FNumber LIKE '13.%' AND A.FStatus =1 AND A.FUseStatus=1072)>0
				BEGIN
					SELECT @FItemID_LB=B.FItemID FROM ICBOM A
					INNER JOIN ICBOMChild B ON A.FInterID =B.FInterID 
					INNER JOIN t_ICItemCore C ON C.FItemID =B.FItemID 
					WHERE A.FItemID =@FItemid AND C.FNumber LIKE '13.%' AND A.FStatus =1 AND A.FUseStatus=1072
				END
				ELSE SET @FItemID_LB=0
				
				IF @FItemID_LB<>0  --有裸包产品
				BEGIN
					SELECT @flb_qty2=dbo.GET_YFQ_QTY1(@FItemID_LB, @FMONTH, @FLDate)  --裸包产品已分配量
					SET @flb_qty3=ISNULL((SELECT sum(ISNULL(fqty,0)) from ICInventory where FStockID =222147 AND FItemID = @FItemID_LB),0) ---裸包产品及时库存总量
					SELECT @lbyj_qty=dbo.GET_YJRK_QTY1(@FItemID_LB, @FMONTH, @FLDate)  ---裸包预计入库量总数
				
					IF(@flb_qty3-@flb_qty2)>0 and (@flb_qty3-@flb_qty2)>=@fqty_center
					BEGIN
						select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END					
							INSERT INTO #Ordertemp1
							VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,@fqty_center,0,222147, @fdate, @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )							
							SET @fqty_center=0
							SET @fentry_line=@fentry_line+1
							SET @fgzl_line=@fgzl_line+1	
							SET @f_over2 =1
					END		
					ELSE IF (@flb_qty3-@flb_qty2)>0 AND (@flb_qty3-@flb_qty2)<@fqty_center
					BEGIN
						select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END
						INSERT INTO #Ordertemp1
						VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,(@flb_qty3-@flb_qty2),0,222147, @fdate, @FEntrySelfS0161
							  , (@flb_qty3-@flb_qty2), @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )
						SET @fqty_center=@fqty_center-(@flb_qty3-@flb_qty2)
						SET @fentry_line=@fentry_line+1
						SET @fgzl_line=@fgzl_line+1	
						SET @f_over2 =0
					END										 
				END --有裸包产品结束	
				
				IF @f_over2=1 BREAK   --跳出循环IF @f_over2=0
				
				--1-2-2. 裸包产品 (即时库存-已分配) <=0  且 (即时库存-已分配 + 预计入库量）>0  时 增加一条数据 工作令号顺序递增 D-YYMM-XXX  数量(即时库存-已分配 + 预计入库量)或剩余量  没有仓库
				--DBO.GET_YFQ_QTY(229090)--,dbo.GET_YJRK_QTY(229090)
				IF (@flb_qty3-@flb_qty2)<=0 AND (@flb_qty3+@lbyj_qty-@flb_qty2)>0 
				BEGIN
					select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END
					IF (@flb_qty3+@lbyj_qty-@flb_qty2)>=@fqty_center
					BEGIN
						INSERT INTO #Ordertemp1
						VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,@fqty_center,0,0 , @fdate, @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )								
						SET @fqty_center=0
						SET @fentry_line=@fentry_line+1
						SET @fgzl_line=@fgzl_line+1	
						SET @f_over2 =1
					END
					ELSE IF (@flb_qty3+@lbyj_qty-@flb_qty2)<@fqty_center
					BEGIN
						select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END
						INSERT INTO #Ordertemp1
						VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,(@flb_qty3+@lbyj_qty-@flb_qty2),0,0, @fdate, @FEntrySelfS0161
							  , (@flb_qty3+@lbyj_qty-@flb_qty2), @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )	
						SET @fqty_center=@fqty_center-(@flb_qty3+@lbyj_qty-@flb_qty2)
						SET @fentry_line=@fentry_line+1
						SET @fgzl_line=@fgzl_line+1	
						SET @f_over2 =0
					END					
				END
				
				IF @f_over2=1 BREAK   --跳出循环IF @f_over2=0
				
				--1-3. 查找上海邦德品牌仓 (即时库存-存量管理中的最高存量)>0  时增加一条数据 工作令顺序递增 D-YYMM-XXX 数量(即时库存-最高存量)或剩余量  调拨仓库(不用细分到仓位)
				select @FMaxStorage=FMaxStorage ,@FMinStorage=FMinStorage from icstorageset WHERE FStockID=245107  and fitemid=@fitemid  --上海品牌仓库最高存量 最低存量
				set @FMaxStorage= ISNULL(@FMaxStorage,0)
				set @FMinStorage=ISNULL(@FMinStorage,0)				
				set	@fsp_qty1=ISNULL((select sum(ISNULL(fqty,0)) from ICInventory where FStockID =245107 AND FItemID = @FItemID ),0)	--上海品牌仓库即时库存总量
				
				IF @fsp_qty1-@FMaxStorage>0 AND (@fsp_qty1-@FMaxStorage)>=@fqty_center
				BEGIN
					select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END
					INSERT INTO #Ordertemp1
					VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,@fqty_center,245107,0, @fdate, @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )								
					SET @fqty_center=0
					SET @fentry_line=@fentry_line+1
					SET @fgzl_line=@fgzl_line+1	
					SET @f_over2 =1
				END
				ELSE IF @fsp_qty1-@FMaxStorage>0 AND (@fsp_qty1-@FMaxStorage)<@fqty_center
				BEGIN
					select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN 'D-'+@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR)	--@fentry_line
							ELSE 'D-'+@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END)
						    END
					INSERT INTO #Ordertemp1
					VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,(@fsp_qty1-@FMaxStorage),245107,0, @fdate, @FEntrySelfS0161
							  , (@fsp_qty1-@FMaxStorage), @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )
					SET @fqty_center=@fqty_center-(@fsp_qty1-@FMaxStorage)
					SET @fentry_line=@fentry_line+1
					SET @fgzl_line=@fgzl_line+1	
					SET @f_over2 =0
				END
				IF @f_over2=1 BREAK   --跳出循环IF @f_over2=0
				
				--1-4. 投产 增加一条数据 工作令顺序递增 YYMM-XXX-A 数量(剩余量)
				IF @fqty_center>0
				BEGIN
					select  @gzl_num=CASE WHEN LEN(@fgzlseq + @fgzl_line)=4 
							THEN CAST(@fgzlyymm + '-' + cast(@fgzlseq + @fgzl_line as CHAR) AS CHAR(9))+'-A'
							ELSE CAST(@fgzlyymm + '-' + (case when LEN(@fgzlseq + @fgzl_line )=2  then '0'+cast(@fgzlseq +@fgzl_line as CHAR) 
					 				when LEN(@fgzlseq + @fgzl_line)=1  then '00'+cast(@fgzlseq +@fgzl_line as CHAR)
						            else cast(@fgzlseq +@fgzl_line as CHAR) END) AS CHAR(8))+'-A'
						    END
					INSERT INTO #Ordertemp1
					VALUES(@FInterID, @fentry_line, @gzl_num, @FItemid ,@fqty_center,0,0, @fdate , @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 )					
					SET @fentry_line=@fentry_line+1
					--1-5 增加裸包投产数量
					select  @gzl_num=CASE WHEN LEN(@gzl_num)=11 THEN SUBSTRING(@gzl_num,1,9)
					                      ELSE SUBSTRING(@gzl_num,1,8) END
					SET @FHighLimit=ISNULL((SELECT FHighLimit FROM t_ICItem WHERE FItemID =@FItemID_LB),0)
					
					INSERT INTO #Ordertemp1
					VALUES(@FInterID, @fentry_line, @gzl_num, @FItemID_LB ,@fqty_center+@FHighLimit,0,0, @fdate, @FEntrySelfS0161
							  , @fqty_center, @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175, @FEntrySelfS0176
							  , @FEntrySelfS0177, @FEntrySelfS0178, ''
							  , @FSourceBillNo, @FSourceEntryID, @FSourceInterId, @FSourceTranType ,@FEntrySelfS0192 ) 
					SET @fqty_center=0
					SET @fentry_line=@fentry_line+1
					SET @fgzl_line=@fgzl_line+1	
					SET @f_over2 =1
				END
				IF @f_over2=1 BREAK   --跳出循环IF @f_over2=0
				
			END			---IF @f_over2=0
						
		FETCH NEXT FROM ord_cur1 into @FInterID, @FEntryID, @FItemId, @fqty, @fdate,@FEntrySelfS0161
		              , @FContractBillNo, @FContractEntryID, @FContractInterID, @FEntrySelfS0175
		              , @FEntrySelfS0176, @FEntrySelfS0177, @FEntrySelfS0178, @FEntrySelfS0180
					  , @FSourceBillNo, @FSourceEntryID
					  , @FSourceInterId, @FSourceTranType
					  ,	@FEntrySelfS0192
		END			--第一层循环
		CLOSE ord_cur1
		DEALLOCATE ord_cur1
				
		/*	
		SELECT A.FInterID ,A.FEntryID ,A.FItemID ,B.FNumber ,B.FName ,B.FModel ,A.FEntrySelfS0160
		     ,A.FEntrySelfS0179, C1.FNumber ,C1.FName ,A.FEntrySelfS0189,C2.FNumber ,C2.FName 
		     , A.*
		FROM #Ordertemp1 A
		INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
		LEFT OUTER JOIN t_Stock C1 ON C1.FItemID =A.FEntrySelfS0179
		LEFT OUTER JOIN t_Stock c2 on C2.FItemID =A.FEntrySelfS0189
		
		*/
	delete from SEOrderEntry 
     where FInterID =(select FInterID from SEOrder where FBillNo =@FBillNo and FChangeMark=0 and FCancellation=0)
	
	INSERT INTO SEOrderEntry (FInterID,FEntryID,FBrNo,FEntrySelfS0160,FMapNumber,FMapName   
			,FItemID,FAuxPropID,FQty,FUnitID,Fauxqty,FSecCoefficient,FSecQty,Fauxprice,FAuxTaxPrice  
			,Famount,FCess,FTaxRate,FUniDiscount,FTaxAmount,FAuxPriceDiscount,FTaxAmt,FAllAmount    
			,FTranLeadTime,FInForecast,FDate,Fnote,FPlanMode,FMTONo,FBomInterID,FCostObjectID,FAdviceConsignDate    
			,FATPDeduct,FLockFlag,FSourceBillNo,FSourceTranType,FSourceInterId,FSourceEntryID,FContractBillNo			
			,FContractInterID,FContractEntryID,FAuxQtyInvoice,FQtyInvoice,FSecInvoiceQty,FSecCommitInstall				
			,FCommitInstall,FAuxCommitInstall,FAllStdAmount,FMrpLockFlag,FOrderBillNo,FOrderEntryID,FHaveMrp			
			,FReceiveAmountFor_Commit, FEntrySelfS0161
			,FEntrySelfS0162,FEntrySelfS0163, FEntrySelfS0174, FEntrySelfS0181
			,FEntrySelfS0175,FEntrySelfS0176,FEntrySelfS0177,FEntrySelfS0178,FEntrySelfS0179,FEntrySelfS0180
			,FEntrySelfS0189,FEntrySelfS0187,FEntrySelfS0188 ,FEntrySelfS0192 
		)	
	select A.FInterID,A.FEntryID,'0',A.FEntrySelfS0160,'',''
		, A.FItemID ,0, A.FQty, b.FORDERUNITID,A.FQty, 0,0,0,0
		,0,0,0,0,0,0,0,0
		,'',0,a.fdate,'',14036,'',0,'0',a.fdate
		,0,0,A.FSourceBillNo,A.FSourceTranType, A.FSourceInterId, A.FSourceEntryID, A.FContractBillNo
		,A.FContractInterID,A.FContractEntryID,0,0,0,0
		,0,0,0,0,'','',0
		,0,a.FEntrySelfS0161
		,A.FCustQty, A.FQty -A.FCustQty,  0, (case when b.FNumber like '13.%' then 0 else A.FCustQty end)
		,A.FEntrySelfS0175, A.FEntrySelfS0176, A.FEntrySelfS0177, A.FEntrySelfS0178,a.FEntrySelfS0179,A.FEntrySelfS0180
		,A.FEntrySelfS0189, round(isnull(b.FGrossWeight,0)*a.FQty,4) ,ROUND(isnull(b.FSize,0)*a.FQty,4)
		,FEntrySelfS0192 
	from #Ordertemp1 A
	INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
			
	DROP TABLE #Ordertemp1
END
