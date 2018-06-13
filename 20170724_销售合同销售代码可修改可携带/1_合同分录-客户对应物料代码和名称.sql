
-- =============================================
/*
 * 	DESCRIPTION:	客户对应物料代码和名称要求可以手动修改
 *	AUTHOR：			RENBWO
 *	DATE：  			20170726
 */
-- Author:		<By YangYuan>
-- Create date: <2015-03-26>
-- Description:	<合同(应付)  新增、修改、审核时 取价格体系中的价格，不存在则报错
--               客户对应物料代码和名称取自 客户对应物料表，不存在报错
-- 内贸客户制作销售合同时检查 客户对应仓库的即时库存+合同数量是否大于 客户对应仓库的存量表中最高存量数量，若大于则不允许保存。吴总要求 2015-09-06>
-- =============================================
alter TRIGGER [dbo].[t_rpContractEntry_change1]
            ON [dbo].[t_rpContractEntry]
   AFTER INSERT,UPDATE
AS 
BEGIN
	DECLARE		@FContractID						INT,				--合同表头内码
				@FDetailID							INT,				--合同表体分录内码
				@FCustomer							INT,				--客户/供应商内码
				@FCurrencyID						INT,				--货币内码
				@FItemID							INT,				--物料内码
				@FItemClassID						INT,				--核算项目类别内码 (1：客户；8：供应商)
				@FExchangeRate						FLOAT,				--汇率
				@FIndex								INT,				--合同表体行号
				@FCusItemNo1						VARCHAR(50),		--客户对应物料代码
				@FCusItemName1						VARCHAR(50),		--客户对应物料名称
				@FCusItemNo0						VARCHAR(50),		--手动修改的客户对应物料代码
				@FCusItemName0						VARCHAR(50),		--手动修改的客户对应物料名称
				@FTJSumY1							DECIMAL(28,10),		--体积(包装箱体积*数量)
				@FPrice								DECIMAL(28,10),		--客户/公司 价格体系中的报价
				@FPriceFor							DECIMAL(28,10),		--不含税单价(原币)
				@FAmountFor							DECIMAL(28,10),	    --金额(原币)
				@FTaxFor							DECIMAL(28,10),     --税额(原币) 
				@FAmountForSum						DECIMAL(28,10),		--合同付款除去最后一行的总计(原币)
				@FAmountSum							DECIMAL(28,10),		--合同付款除去最后一行的总计
				@FAmountIncludeTaxForSum			DECIMAL(28,10),		-- 合同表体价税合计总金额(原币)
				@FLineCount							INT,				--合同付款中的行数@FHeadSelfS0156						INT,				---是否门店销售	Y: 40360  N: 40361  
				@FHeadSelfS0156						INT,				---是否门店销售	Y: 40360  N: 40361  
				@FHeadSelfS0155						INT,				---是否样品     Y: 40363  N: 40364
				@FDate								datetime,
				@FQuantity							DECIMAL(28,10),		---合同数量
				@FQty_js							DECIMAL(28,10),		---客户对应仓库及时库存总数
				@FQty_hight							DECIMAL(28,10),		---客户对应仓库存量表中最高存量总数
				@M_MESSAGE							VARCHAR(1000),
				@FQF								VARCHAR(1),			-- 区分样品 价格设定为零 后步做
				@X_ADD								INT,
				@FINTERID	INT,			
			@fcheckdate  datetime
			
			SELECT  @FINTERID =FContractID from inserted
	select  @fcheckdate=FCheckDate from t_RPContract where FContractID=@FINTERID


		
	SET NOCOUNT ON
	
	SET		@X_ADD=0
    SET		@M_MESSAGE=' '   
  
	DECLARE rpc_xs CURSOR
	FOR
		select a.FContractID, a.FDetailID, d.FItemClassID , d.FCustomer, d.FCurrencyID
		     , d.FExchangeRate, a.FProductID,a.FIndex, isnull(a.FTJSumY1,0), d.FHeadSelfS0155
		     , d.FHeadSelfS0156, D.FDATE, A.FQuantity, FCusItemNo1,FCusItemName1
		 from INSERTED  a
		 inner join t_RPContract d on d.FContractID=a.FContractID
		 where d.FClassTypeID=1000019
		 ORDER BY a.FIndex 
	OPEN rpc_xs	    
	FETCH NEXT FROM rpc_xs into @FContractID,@FDetailID,@FItemClassID,@FCustomer,@FCurrencyID
	,@FExchangeRate,	@FItemID, @FIndex, @FTJSumY1, @FHeadSelfS0155
	,@FHeadSelfS0156, @FDate, @FQuantity,@FCusItemNo0,@FCusItemName0
	
	
	WHILE @@FETCH_STATUS=0 
	
	BEGIN
		IF @FItemClassID=1   ---1. 核算项目为客户的
		BEGIN
					--从客户物料对应表中取客户对应物料代码和对应名称
			IF (SELECT COUNT(*) from ICItemMapping where FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustomer)=0
			BEGIN   ---客户对应物料代码不存在
				SET @X_ADD=1
				SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FIndex,0) as char(3))+'行' 
			END
			ELSE     ----客户物料对应代码存在
			BEGIN
				SELECT @FCusItemNo1=FMapNumber,@FCusItemName1=FMapName  
				  from ICItemMapping 
				 where FID=4 and FPropertyID =1 and FItemID =@FITEMID and FCompanyID =@FCustomer
				
				UPDATE t_rpContractEntry
				SET FCusItemNo1=(case  when  fenableedit=1  then @FCusItemNo0 else @FCusItemNo1 end) 		/*if fenableedit is true ,don't modify*/
				   ,FCusItemName1=(case when  fenableedit=1   then @FCusItemName0 else @FCusItemName1 end)	/*if fenableedit is true ,don't modify*/
				WHERE FDetailID=@FDetailID
			UPDATE t_rpContractEntry
				SET FDate3=FDate1-FInteger
				WHERE FDetailID=@FDetailID	
			END
			
			--内贸时 根据即时库存+投单数<=存量最高上限则允许保存，否则不允许保存 
			-- 即时库存 客户对应仓库的即时库存
			-- 存量最高：客户对应仓库的存量管理中最高存量
			-- 存量管理表中有数据存在时且大于0
			IF( (SELECT COUNT(*) FROM ICstorageSET WHERE FItemID=@FItemID 
			       AND FStockID=(SELECT F_103 FROM t_Organization where FItemID=@FCustomer)
			       AND FMaxStorage>0 AND FCheck =1
			       )>0 AND SUBSTRING((SELECT FNumber FROM t_Organization where FItemID=@FCustomer),1,3)='0A.' )
			BEGIN
				SELECT @FQty_js=SUM(FQty) FROM ICInventory 
				 WHERE FItemID =@FItemID 
				  AND FStockID =(SELECT F_103 FROM t_Organization where FItemID=@FCustomer) 
				  AND FQty >0
				SELECT @FQty_hight=SUM(FMaxStorage) FROM ICstorageSET 
				 WHERE FItemID=@FItemID 
			       AND FStockID=(SELECT F_103 FROM t_Organization where FItemID=@FCustomer)
			       AND FMaxStorage>0 AND FCheck =1
			    IF @FQty_js+@FQuantity>@FQty_hight
			    BEGIN
					SET @X_ADD=4
					SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FIndex,0) as char(3))+'行 '
			    END			    
			END
			
			----若体积(体积=数量*包装箱体积)=0 则不允许保存
			if @FTJSumY1=0
			BEGIN
				SET @X_ADD=3
				SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FIndex,0) as char(3))+'行 '
			END
			
			if @FHeadSelfS0155	=40363  ---是样品  将价格和金额全部清为零
			BEGIN
				SET @FQF ='A'
				SET @FPrice =0.00001
			END
			ELSE					----不是样品的先判断是否是门店销售
			BEGIN 
				if @FHeadSelfS0156=40361 ---不是门店销售的则取客户价格体系  40361:N  40360: Y
				BEGIN								
					---------------------从客户价格体系中取价格			
					--客户价格体系  价格类型  物料代码   相符的报价
					--客户价格体系 存在时
					IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FInterID=4 and FRelatedID  =@FCustomer and FItemID =@FItemID and @FDate between  FBegDate And FEndDate)
					BEGIN
						SELECT @FPrice=isnull(FPrice,0)--,@FPriceSystemID=FInterID 
						  from ICPrcPlyEntry 
						 WHERE FInterID=4 and FRelatedID =@FCustomer and FItemID =@FItemID and @FDate between  FBegDate And FEndDate --AND FPriceType=@FPriceType
					END 
					ELSE ----客户价格体系 不存在时
						/* 客户价格体系不存在时，不允许从公司价格体系中取价格  2015-06-09 问过吴总 确认的 从2015-06-09 12:10：00开始执行
						BEGIN
							-- 公司价格体系  币别  物料  相符的报价	  一种物料的公司价格体系中人民币和美元只能有一条报价数据
							---公司价格体系 存在 
							IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 AND FCuryID=@FCurrencyID)
							BEGIN
								SELECT @FPrice=isnull(FPrice,0)--,@FPriceSystemID=FInterID
								  FROM ICPrcPlyEntry 
								  WHERE FItemID =@FItemID AND FInterID=3 AND FCuryID=@FCurrencyID
							END 
							ELSE		-- 公司价格体系 不存在 
							BEGIN
								SET @FPrice=0
							END
						END
						*/
					BEGIN 
						SET @FPrice =0
					END
				END			---不是门店销售的则取客户价格体系
				ELSE						--是门店销售的取门店价格体系 门店客户内码@FCustID=221312    
				BEGIN
					IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FInterID=4 and FRelatedID=221312 and FItemID =@FItemID and @FDate between  FBegDate And FEndDate)
					BEGIN
						SELECT @FPrice=isnull(FPrice,0) from ICPrcPlyEntry WHERE  FInterID=4 and FRelatedID=221312 and FItemID =@FItemID and @FDate between  FBegDate And FEndDate
					END 
					ELSE 
					  SET @FPrice=0
				END							--是门店销售的取门店价格体系 门店客户内码@FCustID=221312   
			END
			
			IF @FPrice=0 
			BEGIN
				SET @X_ADD=2
				SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FIndex,0) as char(3))+'行' 
			END	
			ELSE
			BEGIN
				IF @FQF ='A'  SET @FPrice =0   ---样品 时 自动将价格设置为零   2015-05-14
				
				--都没有问题了，则把价格改为价格体系中的价格				
				UPDATE t_rpContractEntry
				SET FTaxPriceFor=round(@FPrice,8)															---含税单价(原币)  从价格体系中过来
				  , FTaxPrice = round(@FPrice * B.FExchangeRate,8)											-- 含税单价(本位币 根据汇率换算的) 
				  ---参考金蝶帮助说明
				  , @FPriceFor=round(round(round(@FPrice * A.FQuantity*(1-a.FBusinessDiscountRate/100),4)- @FPrice * A.FQuantity*(1-a.FBusinessDiscountRate/100)/(1+A.FTaxRate/100)*A.FTaxRate/100,4)/(1-a.FBusinessDiscountRate/100)/A.FQuantity,8)
				  , FPriceFor = @FPriceFor
				  , FPrice = ROUND(@FPriceFor * B.FExchangeRate,8)							--不含税单价(本位币)  =A.FPriceFor * B.FExchangeRate  不含税单价(原币) * 汇率
				  , @FAmountFor = round(round(@FPrice * A.FQuantity*(1-a.FBusinessDiscountRate/100),4)- @FPrice * A.FQuantity*(1-a.FBusinessDiscountRate/100)/(1+A.FTaxRate/100)*A.FTaxRate/100,4)
				  , FAmountFor=@FAmountFor
				  , FAmount =round(@FAmountFor* B.FExchangeRate ,2)			--金额(本位币) A.FPrice *A.FQuantity  取小数点后2位
				  , @FTaxFor = @FPrice/(1+A.FTaxRate/100)* A.FTaxRate/100 * A.FQuantity * (1-a.FBusinessDiscountRate/100)			-- 税额(原币) A.FTaxPriceFor/(1+A.FTaxRate/100)*A.FTaxRate/100*A.FQuantity*（1-折扣率/100）
				  , FTaxFor=ROUND(@FTaxFor,4)
				  , FTax = ROUND(@FTaxFor * B.FExchangeRate,2)		-- 税额(本位币) a.FTaxFor * B.FExchangeRate 
				  , FAmountIncludeTaxFor = round(@FPrice * A.FQuantity*(1-a.FBusinessDiscountRate/100),4)			-- 价税合计(原币)  A.FTaxPriceFor*A.FQuantity *(1-折扣率)
				  , FAmountIncludeTax= round(@FPrice * A.FQuantity *(1-a.FBusinessDiscountRate/100) * B.FExchangeRate,2)					--价税合计(本位币) A.FTaxPriceFor*A.FQuantity*B.FExchangeRate 
				  , FFactPriceFor=@FPrice*(1-a.FBusinessDiscountRate/100)							--实际含税单价 FTaxPriceFor*(1-a.FBusinessDiscountRate/100)  含税单价*（1-折扣率/100）
				  , FBusinessDiscountFor= ROUND(A.FQuantity * round(@FPrice,8)*a.FBusinessDiscountRate/100,4) --折扣额(原币)
				  , FBusinessDiscount = ROUND(A.FQuantity * @FPrice*a.FBusinessDiscountRate/100*B.FExchangeRate,2)
				from t_rpContractEntry  A
				INNER JOIN t_RPContract B ON A.FContractID= B.FContractID
				where A.FDetailID =@FDetailID and   @fcheckdate is NULL
			END	
		END
		----2. 核算项目为供应商的处理方法
		---
		
		---
	FETCH NEXT FROM rpc_xs into @FContractID,@FDetailID,@FItemClassID,  @FCustomer, @FCurrencyID
	         , @FExchangeRate, @FItemID, @FIndex, @FTJSumY1, @FHeadSelfS0155,@FHeadSelfS0156, @FDate, @FQuantity,@FCusItemNo0,@FCusItemName0
	END
	CLOSE rpc_xs
	DEALLOCATE rpc_xs 
	
	---更新合同分次付款金额	
	DECLARE rpc_cnid CURSOR
	FOR
		SELECT DISTINCT FContractID  FROM inserted
	OPEN rpc_cnid	    
	FETCH NEXT FROM rpc_cnid into @FContractID
	WHILE @@FETCH_STATUS=0    
	BEGIN
	
		--SET @FContractID = (SELECT DISTINCT FContractID  FROM inserted )
		---合同表体总金额	
		SELECT @FAmountIncludeTaxForSum=SUM(isnull(A.FAmountIncludeTaxFor,0)) FROM t_rpContractEntry A
		WHERE A.FContractID =@FContractID	
		--合同收款行数统计
		SELECT @FLineCount=COUNT(*) FROM t_RPContractScheme A
		WHERE A.FContractID =@FContractID 
		
		IF @FLineCount >1   --多行数据存在
		BEGIN	
			---合同付款 除去最后一行的金额
			SELECT @FAmountForSum=SUM(isnull(a.FAmountFor,0)) from t_RPContractScheme a
			WHERE A.FContractID =@FContractID 
			  AND A.FID <(SELECT MAX(FID) from t_RPContractScheme where FContractID =@FContractID)
			-- 判断 合同付款除去最后一行的金额 与 合同表体总金额 对比	
			IF @FAmountForSum<@FAmountIncludeTaxForSum
			BEGIN
				UPDATE t_RPContractScheme
				SET FAmountFor=ROUND(@FAmountIncludeTaxForSum-@FAmountForSum,4), FAmount =ROUND((@FAmountIncludeTaxForSum-@FAmountForSum)*FExchangeRate ,2)
				WHERE FContractID =@FContractID 
				  AND FID= (SELECT MAX(FID) FROM t_RPContractScheme WHERE FContractID =@FContractID )
			END
			ELSE IF @FAmountForSum=@FAmountIncludeTaxForSum
			BEGIN
				DELETE FROM t_RPContractScheme 
				 WHERE FContractID =@FContractID 
				   AND FID= (SELECT MAX(FID) FROM t_RPContractScheme WHERE FContractID =@FContractID )
			END
			ELSE IF @FAmountForSum>@FAmountIncludeTaxForSum
			BEGIN
				-- 除了第一行外，其余行都删除
				DELETE FROM t_RPContractScheme 
				 WHERE FContractID =@FContractID 
				   AND FID > (SELECT MIN(FID) FROM t_RPContractScheme WHERE FContractID =@FContractID )
				--更新第一行的金额
				UPDATE t_RPContractScheme
				SET FAmountFor=ROUND(@FAmountIncludeTaxForSum,4), FAmount =ROUND(@FAmountIncludeTaxForSum*FExchangeRate ,2)
				WHERE FContractID =@FContractID 
							  
			END
			
		END
		ELSE			-- 只有一行数据时
		BEGIN 
			UPDATE t_RPContractScheme
			SET FAmountFor=ROUND(@FAmountIncludeTaxForSum,4), FAmount =ROUND(@FAmountIncludeTaxForSum*FExchangeRate ,2)
			WHERE FContractID =@FContractID 
		END
		
		--更新合同表头 总金额和总金额(本位币)	--BY YangYuan 2016-01-26  张云峰提出
		--批量处理原来错误的
		UPDATE t_RPContract 
		SET FTotalAmountFor=A.FAmountIncludeTaxFor,FTotalAmount=A.FAmountIncludeTax
		FROM (
			SELECT A.FContractID,SUM(isnull(A.FAmountIncludeTaxFor,0)) AS FAmountIncludeTaxFor
				 , SUM(isnull(A.FAmountIncludeTax,0)) AS FAmountIncludeTax 
			  FROM t_rpContractEntry A
			  WHERE FContractID=@FContractID
			  GROUP BY A.FContractID
			) A
		INNER JOIN t_RPContract B ON A.FContractID=B.FContractID	
	---更新合同表头 总金额和总金额(本位币)  结束
		
	FETCH NEXT FROM rpc_cnid into @FContractID
	END
	CLOSE rpc_cnid
	DEALLOCATE rpc_cnid 
	----更新合同收款表  结束
	
	---错误处理
	if @fcheckdate is null
	IF @X_ADD=1 
	BEGIN
		SET @M_MESSAGE='销售合同'+@M_MESSAGE+ ' 客户对应物料代码不存在!'
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
	END
	ELSE IF @X_ADD=2 
	BEGIN
	
		SET @M_MESSAGE='销售合同'+@M_MESSAGE+ ' 客户/公司价格体系不存在!'
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
	END
	ELSE IF @X_ADD=3
	BEGIN
		SET @M_MESSAGE='销售合同'+@M_MESSAGE+ ' 体积不允许为零！'
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
	END	
	ELSE IF @X_ADD=4
	BEGIN
		SET @M_MESSAGE='销售合同'+@M_MESSAGE+ ' (内贸客户对应仓库即时库存+合同数量)不能超过存量管理中最高存量！'
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
	END
END
GO


