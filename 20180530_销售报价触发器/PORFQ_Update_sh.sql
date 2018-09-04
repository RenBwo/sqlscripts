/* 
 * DATA:		2018/09/04
 * AUTHOR:		RENBO
 * DESCRIPTION:	表头增加“上海有色金属网铝锭期货价格”，
 * 				取核算项目.上海有色金属网铝锭期货价格的数据
 * 
 * DATA:		2018/08/18
 * AUTHOR:		RENBO
 * DESCRIPTION:	单据子体的价格类型数据来源，从“价格类型”变更为“核算项目.运费标准.价格类型”，
 * 				本程序的 “porfqentry.FPriceType” 变更为“t_item_3029.f_107”
 * 
 * AUTHOR:		YangYuan
 * DATE: 		2014-12-29
 * Description:	销售报价单相当于调价申请单 审核时 
 * 				1. 自动将客户对应物料代码、客户对应名称关联到物料对应表中
 * 					A. 存在物料对应表，则判断数据是否是’-‘ 若是，则更新
 * 					B. 不存在 则新增
 * 				2. 实际含税单价 等信息自动关联到客户价格体系中
 * 					A. 对应价格类型 若存在 则删除   
 * 					一个客户一种物料可以对应不同价格类型的数据 因发货地址不同  盛红春要求2015年8月份
 * 					B. 新增
 */
alter TRIGGER [dbo].[PORFQ_Update_sh] 	ON [dbo].[PORFQ]   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE		@FInterID				INT,
				@FDetailID				INT,
				@FCustID				INT,
				@FCurrencyID			INT,
				@FItemID				INT,
				@FUnitID				INT,
				@FAuxTaxPriceDiscount   DECIMAL(28,10), 
				@FPriceType				INT,
				@FBegDate				Datetime,
				@FEndDate				Datetime,
				@FNote					VARCHAR(1000),
				@FStatus				INT,
				@FCusItemID				VARCHAR(50),
				@FCusItemName			VARCHAR(50),
				@FMapNumber				VARCHAR(80),
				@FMapName				VARCHAR(255),
				@M_MESSAGE				VARCHAR(1000),
				@X_ADD					INT
	
	SET		@X_ADD=0
    SET		@M_MESSAGE=''      
    select @FStatus=FStatus  from inserted	
    if @fstatus = 0 
    begin
	    update porfq set FAiFurPriceShanghai=(
					select isnull(f_101,0) from t_item_3032 
					where f_102 <= getdate() and f_103 >= getdate()
					)
		from porfq a join inserted b on a.finterid = b.finterid 
		--上海有色金属网铝锭期货价格
	end
    
    IF @FStatus =1   ---审核状态
    BEGIN
	    DECLARE cur_xs CURSOR
		FOR
			SELECT A.FInterID ,B.FDetailID
				 , A.FCustID				-- 客户代码
				 , A.FCurrencyID		    -- 货币
				 , B.FItemID				-- 物料
				 , B.FUnitID				-- 单位
				 , B.FAuxTaxPriceDiscount   -- 实绩含税单价
				 , c.f_107			    	-- 价格类型 B.FPriceType
				 , B.FBegDate				-- 生效日期
				 , B.FEndDate				-- 失效日期
				 , B.FNote					-- 备注
				 , B.FCusItemID				-- 客户对应物料代码
				 , B.FCusItemName			-- 客户对应物料名称
			  FROM INSERTED a
			 INNER JOIN PORFQEntry b on a.FInterID = b.FInterID
		 	JOIN t_item_3029 c on c.fitemid = b.fpricetype		 
			  	    
		OPEN cur_xs	    
		FETCH NEXT FROM cur_xs into @FInterID ,@FDetailID, @FCustID, @FCurrencyID
					  , @FItemID, @FUnitID, @FAuxTaxPriceDiscount, @FPriceType, @FBegDate, @FEndDate
					  , @FNote, @FCusItemID, @FCusItemName					  
		WHILE @@FETCH_STATUS=0 
		
		BEGIN								---- 客户物料对应代码 检查
			
			IF (SELECT COUNT(*) from ICItemMapping where FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustID)=0
			BEGIN   						---客户对应物料代码不存在
											----新增客户对应物料表
				insert into ICItemMapping (FID,FItemID ,FPropertyID ,FCompanyID ,FMapNumber, FMapName)
				VALUES(4,@FITEMID ,1,@FCustID , ISNULL(@FCusItemID,'-'), ISNULL(@FCusItemName,'-'))
			END
			ELSE     						----客户物料对应代码存在
			BEGIN
											----若客户对应物料代码为'-'或客户对应物料名称为'-'，则 更新 客户对应物料代码
				SELECT @FMapNumber=FMapNumber, @FMapName=FMapName 
				  from ICItemMapping 
				 where FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustID
				
				IF (@FMapNumber='-' OR @FMapNumber ='' ) AND ISNULL(@FCusItemID,'-')<>'-' 
				BEGIN 
					UPDATE ICItemMapping
					SET FMapNumber=@FCusItemID
					WHERE FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustID
				END
				IF (@FMapName='-' OR @FMapName ='' ) AND ISNULL(@FCusItemName,'-')<>'-' 
				BEGIN 
					UPDATE ICItemMapping
					SET FMapName=@FCusItemName
					WHERE FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustID
				END
			END
			
								-------客户价格体系检查
			IF (SELECT COUNT(*) FROM IcPrcPlyEntry WHERE FInterID=4 AND FItemID =@FITEMID AND FRelatedID=@FCustID
					 AND FPriceType=@FPriceType AND FCuryID =@FCurrencyID )>0
				BEGIN			-----客户价格体系存在(对应的价格类型)，先删除对应 价格类型和币别的客户价格体系
					DELETE  FROM IcPrcPlyEntry WHERE FInterID=4 AND FItemID =@FITEMID AND FRelatedID=@FCustID AND FPriceType=@FPriceType AND FCuryID =@FCurrencyID	
			  	END
			---客户价格体系新增，插入
				INSERT INTO IcPrcPlyEntry(FIndex,FItemID,FRelatedID,FAuxPropID,FInterID,FUnitID,FBegQty,FEndQty
					, FCuryID, FPriceType
					, FPrice
					, FBegDate,FEndDate
					, FLeadTime, FNote,FMainterID,FMaintDate,FCheckerID,FCheckDate,Fchecked,FFlagSave
					)	  	 
				VALUES(0,@FITEMID , @FCustID, 0, 4, @FUnitID, 0, 0
					 , @FCurrencyID ,@FPriceType
					 , (CASE WHEN @FCurrencyID=1000 THEN ROUND(@FAuxTaxPriceDiscount,5) ELSE ROUND(@FAuxTaxPriceDiscount,4) END)
					 , @FBegDate, @FEndDate
					 , 0, ISNULL(@FNote,'') ,16591, GETDATE(),16535,GETDATE(),1,NEWID())
						
			---更新价控资料
			UPDATE ICPrcPlyEntrySpec 
			   SET FLowPrice  =(CASE WHEN @FCurrencyID=1000 THEN ROUND(@FAuxTaxPriceDiscount,5) ELSE ROUND(@FAuxTaxPriceDiscount,4) END)
				 , FLPriceCuryID=@FCurrencyID , FLPriceCtrl =1
			 WHERE FInterID =4 and FItemID =@FITEMID and FRelatedID =@FCustID 
				
		FETCH NEXT FROM cur_xs into @FInterID ,@FDetailID, @FCustID, @FCurrencyID
					  , @FItemID, @FUnitID, @FAuxTaxPriceDiscount, @FPriceType, @FBegDate, @FEndDate
					  , @FNote, @FCusItemID, @FCusItemName
		END
		CLOSE cur_xs
		DEALLOCATE cur_xs 
	END
	
END