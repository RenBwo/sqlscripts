-- =============================================
--	author :		renbwo
--	date:			20170713
--	description:	EXCEL导入时，自动填写运输在途天数

-- Author:		<BY YangYuan>
-- Create date: <20150523>
-- Description:	<销售合同表体 EXCEL上传功能开发 >

-- =============================================
alter PROCEDURE [dbo].[t_RPContractEntry_EXCEL_UPLOAD]
	@FContractNO	VARCHAR(255),
	@M_MESSAGE		VARCHAR(1000) output		--错误信息	
AS
BEGIN
	
	DECLARE		@FContractID				INT, 
				@FIndex						INT,
				@FCusItemNo1				VARCHAR(255),
				@FCusItemName1				VARCHAR(255),		
				@FProductID					INT,			
				@FUnitID					INT,
				@FQuantity					DECIMAL(28,10),	
				@FPrice1					DECIMAL(28,10), --从客户价格体系中过来的价格
				@FTaxPriceFor				DECIMAL(28,10),
				@FPriceFor					DECIMAL(28,10),
				@FBusinessDiscountRate		DECIMAL(28,10),
				@FFactPriceFor				DECIMAL(28,10),
				@FBusinessDiscountFor		DECIMAL(28,10),
				@FBusinessDiscount			DECIMAL(28,10),
				@FAmountIncludeTaxFor		DECIMAL(28,10),
				@FAmountIncludeTax			DECIMAL(28,10),
				@FTaxRate					DECIMAL(28,10),
				@FTaxFor					DECIMAL(28,10),
				@FTax						DECIMAL(28,10),
				@FPrice						DECIMAL(28,10),
				@FTaxPrice					DECIMAL(28,10),
				@FAmountFor					DECIMAL(28,10),
				@FAmount					DECIMAL(28,10),
				@FDate1						VARCHAR(8),
				@FTJSumY1					DECIMAL(28,10),
				@FExplanation				VARCHAR(255),
				@FExchangeRate				DECIMAL(28,10),	
				@FNumber					VARCHAR(255),
				@FHeadSelfS0156						INT,				---是否门店销售	Y: 40360  N: 40361  
				@FHeadSelfS0155						INT,				---是否样品     Y: 40363  N: 40364	
				@FAmountIncludeTaxForSum			DECIMAL(28,10),		-- 合同表体价税合计总金额(原币)
				@FLineCount							INT,				--合同付款中的行数@FHeadSelfS0156	
				@FAmountForSum						DECIMAL(28,10),		--合同付款除去最后一行的总计(原币)
				@FAmountSum							DECIMAL(28,10),		--合同付款除去最后一行的总计
				@ADD_CN						INT,
				@finteger					int;						--在途运输天数
				
	
	SET NOCOUNT ON;	
	
	SET @ADD_CN=0;
	

		---1. 销售合同号是否存在且状态未进行一级及以上审核
		IF(SELECT COUNT(*) FROM t_RPContract WHERE FContractNo=@FContractNO)=0 --销售合同编号不存在
		 OR (SELECT COUNT(*) FROM ICClassCheckRecords1000019 a
			  inner join (select FBillID, MAX(FID) FID FROM ICClassCheckRecords1000019 GROUP BY FBillID) B ON A.FBillID=B.FBillID AND A.FID =B.FID 
			  WHERE FCheckLevelTo>=1 AND A.FBillNo=@FContractNO)>0   ---审核路线已经进行一审及以上
	     BEGIN  
			SET @ADD_CN=1
		 END
		---2. 物料长代码是否存在
		IF (SELECT COUNT(*) FROM t_y_contractEntry_excel_upload a
		 LEFT OUTER JOIN t_ICItem b on a.FNumber =b.FNumber 
	     WHERE B.FNumber IS NULL) >0
	    BEGIN	----- 物料长代码不存在
			SET @ADD_CN=2
	    END
		---3. 客户对应物料代码及客户对应物料名称是否存在
		IF(SELECT COUNT(*) from t_y_contractEntry_excel_upload A
			INNER JOIN t_RPContract B ON B.FContractNo=@FContractNO --'XSHT000069'
			INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
			LEFT OUTER JOIN ICItemMapping e on e.FID=4 and e.FPropertyID =1 and e.FCompanyID =b.FCustomer and e.FItemID=c.FItemID 
			WHERE (isnull(e.FMapNumber,'')='' or ISNULL(e.FMapName,'')=''))>0
		BEGIN
			SET @ADD_CN=3
		END
		
		SELECT @FHeadSelfS0155=FHeadSelfS0155,@FHeadSelfS0156=FHeadSelfS0156 FROM t_RPContract WHERE FContractNo=@FContractNO
		
		IF @FHeadSelfS0155	=40364 and @FHeadSelfS0156=40361  ---不是样品 且不是门店销售的
		BEGIN
			---4. 客户对应价格体系是否存在/公司价格体系是否存在(样品的不检查)
			IF(SELECT COUNT(*) FROM t_y_contractEntry_excel_upload A
				 INNER JOIN t_RPContract B ON B.FContractNo=@FContractNo
				 INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
				 LEFT OUTER JOIN ICPrcPlyEntry f1 on f1.FInterID=4 and f1.FRelatedID =b.FCustomer and f1.FItemID =c.FItemID and b.FDate between f1.FBegDate And f1.FEndDate 	
				 LEFT OUTER JOIN ICPrcPlyEntry F2 ON F2.FItemID =C.FItemID AND F2.FInterID=3 AND F2.FCuryID=B.FCurrencyID
				 WHERE ISNULL(F1.FPrice,0)=0 AND ISNULL(F2.FPrice,0)=0  
			)>0
			BEGIN
				SET @ADD_CN =41
			END
		END 
		ELSE IF @FHeadSelfS0155	=40364 and @FHeadSelfS0156=40360  ---不是样品 但是 是门店销售的	
		BEGIN
			IF(SELECT COUNT(*) FROM t_y_contractEntry_excel_upload A
				 INNER JOIN t_RPContract B ON B.FContractNo=@FContractNo
				 INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
				 LEFT OUTER JOIN ICPrcPlyEntry F1 ON F1.FInterID=4 and F1.FRelatedID=221312 and F1.FItemID =C.FItemID and B.FDate between F1.FBegDate And F1.FEndDate
				 WHERE ISNULL(F1.FPrice,0)=0  
			)>0
			BEGIN
				SET @ADD_CN =42
			END
		
		END	
		---5. 物料对应的总体积是否为零 
		IF(SELECT COUNT(*) FROM t_y_contractEntry_excel_upload a
			LEFT OUTER JOIN t_ICItem b on a.FNumber =b.FNumber 
			WHERE  ISNULL(B.FSize,0)*a.fquantity=0
			)>0
		BEGIN
			SET @ADD_CN =5
		END
		
		IF(SELECT COUNT(*) FROM t_RPContract WHERE FContractNo=@FContractNO)=1 and @ADD_CN=0
		BEGIN
			SELECT @FContractID=FContractID FROM t_RPContract WHERE FContractNo=@FContractNO
			---删除原来的合同表体的内容 (除了第一行外)
			IF(SELECT COUNT(*) FROM t_rpContractEntry A
			   INNER JOIN t_RPContract B ON A.FContractID=B.FContractID
			   WHERE B.FContractNo=@FContractNO AND A.FIndex >1
			   )>0
			BEGIN
				DELETE FROM t_rpContractEntry WHERE FContractID=(SELECT FContractID FROM t_RPContract WHERE FContractNo=@FContractNO)
				and FIndex >1
			END
			-- 分录第一行的在途天数 renbwo
		  select @finteger = isnull(finteger,0) from  t_rpContractEntry A
			   INNER JOIN t_RPContract B ON A.FContractID=B.FContractID
			   WHERE B.FContractNo=@FContractNO AND A.FIndex = 1
			-- 新增合同表体的内容
			DECLARE cur_contract CURSOR
			FOR
				select a.findex, e.FMapNumber as FCusItemNo1,e.FMapName as FCusItemName1
					 , c.FItemID as FProductID, c.FSaleUnitID as FUnitID, a.fquantity
					 , a.FBusinessDiscountRate, a.FTaxRate, a.FDate1, c.Fsize*a.fquantity as FTJSumY1 
					 , a.FExplanation
					 , CASE WHEN B.FHeadSelfS0155=40364 and B.FHeadSelfS0156=40361 THEN (CASE WHEN isnull(f1.FPrice,0)=0 THEN ISNULL(F2.FPrice,0) else isnull(f1.FPrice,0) end) 
					        WHEN B.FHeadSelfS0155=40364 and B.FHeadSelfS0156=40360 THEN ISNULL(F3.FPrice,0)
					        WHEN B.FHeadSelfS0155=40363 THEN 0 END					 
					 as FPrice1
					 , B.FExchangeRate				
				from t_y_contractEntry_excel_upload A
				INNER JOIN t_RPContract B ON B.FContractNo=@FContractNo
				inner join t_ICItem c on c.FNumber =a.FNumber 
				inner join t_Organization d on d.FItemID =b.FCustomer
				inner join ICItemMapping e on e.FID=4 and e.FPropertyID =1 and e.FCompanyID =b.FCustomer and e.FItemID=c.FItemID 
				LEFT OUTER join ICPrcPlyEntry f1 on f1.FInterID=4 and f1.FRelatedID =b.FCustomer and f1.FItemID =c.FItemID and b.FDate between f1.FBegDate And f1.FEndDate 	
				LEFT OUTER JOIN ICPrcPlyEntry F2 ON F2.FItemID =C.FItemID AND F2.FInterID=3 AND F2.FCuryID=B.FCurrencyID
				LEFT OUTER join ICPrcPlyEntry f3 on f3.FInterID=4 and f3.FRelatedID =221312 and f3.FItemID =c.FItemID and b.FDate between f3.FBegDate And f3.FEndDate 	
				order by b.FContractNo,a.FIndex
				
			OPEN cur_contract
			FETCH NEXT FROM cur_contract into @FIndex,@FCusItemNo1,@FCusItemName1
				, @FProductID, @FUnitID, @FQuantity
				, @FBusinessDiscountRate, @FTaxRate, @FDate1, @FTJSumY1
				, @FExplanation, @FPrice1, @FExchangeRate	
			WHILE @@FETCH_STATUS=0    
			
			BEGIN
				SET @FTaxPriceFor=round(@FPrice1,8)					---含税单价(原币)  从价格体系中过来
				SET @FTaxPrice = round(@FPrice1 * @FExchangeRate,8)	-- 含税单价(本位币 根据汇率换算的) 
				  ---参考金蝶帮助说明
				SET @FPriceFor=round(round(round(@FPrice1 * @FQuantity*(1-@FBusinessDiscountRate/100),4)- @FPrice1 * @FQuantity*(1-@FBusinessDiscountRate/100)/(1+@FTaxRate/100)*@FTaxRate/100,4)/(1-@FBusinessDiscountRate/100)/@FQuantity,8)
				SET @FPrice = ROUND(@FPriceFor * @FExchangeRate,8)							
				SET @FAmountFor = round(round(@FPrice1 * @FQuantity*(1-@FBusinessDiscountRate/100),4)- @FPrice1 * @FQuantity*(1-@FBusinessDiscountRate/100)/(1+@FTaxRate/100)*@FTaxRate/100,4)
				SET @FAmount =round(@FAmountFor* @FExchangeRate ,2)			--金额(本位币) A.FPrice *A.FQuantity  取小数点后2位
				SET @FTaxFor = @FPrice1/(1+@FTaxRate/100)* @FTaxRate/100 * @FQuantity * (1-@FBusinessDiscountRate/100)			-- 税额(原币) A.FTaxPriceFor/(1+A.FTaxRate/100)*A.FTaxRate/100*A.FQuantity*（1-折扣率/100）
				SET @FTaxFor=ROUND(@FTaxFor,4)
				SET @FTax = ROUND(@FTaxFor * @FExchangeRate,2)		-- 税额(本位币) a.FTaxFor * B.FExchangeRate 
				SET @FAmountIncludeTaxFor = round(@FPrice1 * @FQuantity*(1-@FBusinessDiscountRate/100),4)			-- 价税合计(原币)  A.FTaxPriceFor*A.FQuantity *(1-折扣率)
				SET @FAmountIncludeTax= round(@FPrice1 * @FQuantity *(1-@FBusinessDiscountRate/100) * @FExchangeRate,2)					--价税合计(本位币) A.FTaxPriceFor*A.FQuantity*B.FExchangeRate 
				SET @FFactPriceFor=@FPrice1*(1-@FBusinessDiscountRate/100)							--实际含税单价 FTaxPriceFor*(1-a.FBusinessDiscountRate/100)  含税单价*（1-折扣率/100）
				SET @FBusinessDiscountFor= ROUND(@FQuantity * round(@FPrice1,8)*@FBusinessDiscountRate/100,4) --折扣额(原币)
				SET @FBusinessDiscount = ROUND(@FQuantity * @FPrice1*@FBusinessDiscountRate/100*@FExchangeRate,2)
					
					
				INSERT INTO t_rpContractEntry(FContractID,FIndex,FCusItemNo1,FCusItemName1,FProductID,FAuxPropID,FUnitID,FQuantity
					,FSecUnitID,FsecCoefficient,FSecQty,FTaxPriceFor,FPriceFor,FBusinessDiscountRate,FFactPriceFor
					,FBusinessDiscountFor,FBusinessDiscount,FAmountIncludeTaxFor,FAmountIncludeTax,FTaxRate,FTaxFor,FTax,FPrice
					,FTaxPrice,FAmountFor,FAmount,FDate1,FTJSumY1,FExplanation,FQuantity_Base,FInvoiceQty_Relative
					,FInvoiceAmtFor_Relative,FInvoiceAmt_Relative,FBillQty_Relative,FOrderQty_Relative_Base,FSecInvoiceCommitQty
					,FSecOrderCommitQty,FReceiveAmountFor,FReceiveAmount,FUnInvoice_Qty,FUnInvoice_AmountFor,FUnInvoice_Amount
					,FUnReceive_Qty,FUnReceive_AmountFor,FUnReceive_Amount,FID_SRC,FEntryID_SRC,FClassID_SRC,FBillNo_SRC,FInteger
					) 
				Values(@FContractID,@FIndex,@FCusItemNo1,@FCusItemName1,@FProductID,0,@FUnitID,@FQuantity
					,0,0,0,@FTaxPriceFor,@FPriceFor,@FBusinessDiscountRate,@FFactPriceFor
					,@FBusinessDiscountFor,@FBusinessDiscount,@FAmountIncludeTaxFor,@FAmountIncludeTax,@FTaxRate,@FTaxFor,@FTax,@FPrice
					,@FTaxPrice,@FAmountFor,@FAmount,convert(datetime,@FDate1),@FTJSumY1,@FExplanation,@FQuantity,0
					,0,0,0,0,0
					,0,0,0,0,0,0
					,0,0,0,0,0,0,'',@finteger)		
			
			FETCH NEXT FROM cur_contract into @FIndex,@FCusItemNo1,@FCusItemName1
				, @FProductID, @FUnitID, @FQuantity
				, @FBusinessDiscountRate, @FTaxRate, @FDate1, @FTJSumY1
				, @FExplanation, @FPrice1, @FExchangeRate
			END
			CLOSE cur_contract
			DEALLOCATE cur_contract
			
			---更新合同分次付款金额	
	
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
			----更新合同收款表  结束
		
		END
		ELSE IF @ADD_CN =1
		BEGIN
			SET @M_MESSAGE= @FContractNO + ' 销售合同编号不存在或审核路线已经进行一审及以上!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
		END
		ELSE IF @ADD_CN =2  
		BEGIN
			SELECT TOP 1 @FNumber=A.FNumber FROM t_y_contractEntry_excel_upload a
			  LEFT OUTER JOIN t_ICItem b on a.FNumber =b.FNumber 
	         WHERE B.FNumber IS NULL
			
			SET @M_MESSAGE= @FNumber + ' 物料长代码不存在!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
	    END
	    ELSE IF @ADD_CN=3
	    BEGIN 
			SELECT TOP 1 @FNumber=A.FNumber from t_y_contractEntry_excel_upload A
			INNER JOIN t_RPContract B ON B.FContractNo=@FContractNO 
			INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
			LEFT OUTER JOIN ICItemMapping e on e.FID=4 and e.FPropertyID =1 and e.FCompanyID =b.FCustomer and e.FItemID=c.FItemID 
			WHERE (isnull(e.FMapNumber,'')='' or ISNULL(e.FMapName,'')='')
			
			SET @M_MESSAGE= @FNumber + ' 客户对应物料代码或名称不存在或为空值!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
		END
		ELSE IF @ADD_CN =41
		BEGIN
		---41. 客户对应价格体系是否存在/公司价格体系是否存在(样品的不检查)
			SELECT TOP 1 @FNumber=A.FNumber FROM t_y_contractEntry_excel_upload A
			 INNER JOIN t_RPContract B ON B.FContractNo=@FContractNo
			 INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
			 LEFT OUTER JOIN ICPrcPlyEntry f1 on f1.FInterID=4 and f1.FRelatedID =b.FCustomer and f1.FItemID =c.FItemID and b.FDate between f1.FBegDate And f1.FEndDate 	
			 LEFT OUTER JOIN ICPrcPlyEntry F2 ON F2.FItemID =C.FItemID AND F2.FInterID=3 AND F2.FCuryID=B.FCurrencyID
			 WHERE ISNULL(F1.FPrice,0)=0 AND ISNULL(F2.FPrice,0)=0  
			 
			 SET @M_MESSAGE= @FNumber + ' 客户价格体系和公司价格体系中都不存在!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
		END 	
		ELSE IF @ADD_CN =42
		BEGIN
		---42. 门店销售时 门店的价格体系中不存在 
			SELECT TOP 1 @FNumber=A.FNumber FROM t_y_contractEntry_excel_upload A
			 INNER JOIN t_RPContract B ON B.FContractNo=@FContractNo
			 INNER JOIN t_ICItem c on c.FNumber =a.FNumber 
			 LEFT OUTER JOIN ICPrcPlyEntry f1 on f1.FInterID=4 and f1.FRelatedID =221312 and f1.FItemID =c.FItemID and b.FDate between f1.FBegDate And f1.FEndDate 	
			 WHERE ISNULL(F1.FPrice,0)=0  
			 
			 SET @M_MESSAGE= @FNumber + ' 门店价格体系中不存在!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
		END 	
		ELSE IF @ADD_CN =5
		BEGIN	
		---5. 物料对应的总体积是否为零 
			SELECT TOP 1 @FNumber=A.FNumber FROM t_y_contractEntry_excel_upload a
			LEFT OUTER JOIN t_ICItem b on a.FNumber =b.FNumber 
			WHERE  ISNULL(B.FSize,0)*a.fquantity=0
			
			SET @M_MESSAGE= @FNumber + ' 物料的总体积不允许为零!'
			--RAISERROR(@M_MESSAGE,18,18) ----K3中用这个表示取消提交
			--ROLLBACK TRANSACTION		  ----K3中用这个表示取消提交
			RETURN   ---vb 中用这个表示直接退出程序
		END
		

END