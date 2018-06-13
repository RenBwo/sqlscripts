
/* 
 * date:			2015-09-06
 * AUTHOR:			YANGYUAN
 * DESCRIPTION:		吴总要求 
 * DESCRIPTION:		内贸客户 若客户以 0A.A1.%开头，则取公司/客户价格体系中的限价；
 * DESCRIPTION:		若以0A.A7.%开头，则取公司/客户价格体系中的报价；
 * 
 * TABLE NAME:    	PORFQEntry
 * TRIGGER NAME:  	AuxQty_PORFQ
 * CREATED BY: 		yangyuan
 * CREATION DATE: 	2005/08/01 17:07
 * DESCRIPTION:   	销售报价单相当于客户价格申请表和调价申请表使用  吴总要求
 * 销售报价单中的产品价格来源如下：价格类型 报价自动带出来(不同的货币选择对应货币的报价)>
 * 1. 客户价格体系  对应价格类型的报价
 * 2. 若无客户价格体系则 公司价格体系 价格类型不涉及  报价
 * 3. 若客户和公司价格体系中都无该产品的报价，则报错 

 */

CREATE TRIGGER [dbo].[AuxQty_PORFQ]
            ON [dbo].[PORFQEntry]
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    -----  销售报价单中的产品价格从公司价格体系中报价自动带出来(不同的货币选择对应货币的报价)
    -----  2014-11-21  BY YangYuan
    ----- 吴总要求  
    ------ 销售报价新增、修改时只更新 [PORFQEntry]  表，所有都放在这里写。
    DECLARE		@FInterID				INT,
				@FDetailID				INT,
				@FEntryID				INT,
				@FItemID				INT,
				@FCurrencyID			INT,
				@FAuxQty				DECIMAL(28,10), 
				@FAuxPrice				DECIMAL(28,10), 
				@FDescount				DECIMAL(28,10), 
				@FCess					DECIMAL(28,10),
				@FPrice					DECIMAL(28,10),
				@FPrice_bj				DECIMAL(28,10),		--公司/客户价格体系中的报价
				@FPrice_xj				DECIMAL(28,10),		--公司/客户价格体系中的限价
				@FCompanyPrice			DECIMAL(28,10),		--公司单价 吴总参考使用 
				@FCompanyPrice_bj		DECIMAL(28,10),		--公司单价 吴总参考使用  不允许修改，由系统自动带出公司价格体系的报价
				@FCompanyPrice_xj		DECIMAL(28,10),		--公司单价 吴总参考使用  不允许修改，由系统自动带出公司价格体系的限价
				@FPriceType				INT,
				@FCustID				INT,
				@FPriceSystemID			INT,				-- 物料价格类型
				@FCustID2				INT,				---物料价格类型中对应的专用客户内码
				@FRegionID1				INT,				-- 客户资料中的区域内码1
				@FRegionID2				INT,				-- 客户资料中的区域内码2
				@FRegionName			VARCHAR(255),		-- 物料价格类型中对应的专用客户的区域名称
				@FDateFrom1				DATETIME,			-- 物料价格类型对应生效日
				@FDateEnd1				DATETIME,			-- 物料价格类型对应失效日
				@FCustName2				VARCHAR(255), 		--物料价格类型中敌营的专用客户名称
				@FMapNumber				VARCHAR(80),
				@FMapName				VARCHAR(255),
				@FItemPriceType			INT,
				@M_MESSAGE				VARCHAR(1000),
				@FNote					VARCHAR(255),
				@X_ADD					INT 				
				
	
	SET NOCOUNT ON    
    
    SET		@X_ADD=0 
    SET		@M_MESSAGE=''       
    SET		@FMapNumber='-' 
    SET		@FMapName='-' 
    SET		@FPrice =0 
    SET		@FPrice_bj=0 
    SET		@FPrice_xj=0
   
	DECLARE seu_cur CURSOR
	FOR
		SELECT A.FInterID ,A.FDetailID, A.FEntryID, A.FItemID
			 , A.FAuxQty, A.FAuxPrice, A.FDescount --as 折扣率
			 , A.FCess --as 税率
			 , B.FCurrencyID, B.FCustID,A.FPriceType
		  FROM INSERTED a
		 INNER JOIN PORFQ b on a.FInterID = b.FInterID
		  	    
	OPEN seu_cur	    
	FETCH NEXT FROM seu_cur into @FInterID ,@FDetailID, @FEntryID, @FItemID
	              , @FAuxQty, @FAuxPrice, @FDescount, @FCess, @FCurrencyID, @FCustID, @FPriceType
	WHILE @@FETCH_STATUS=0    
	BEGIN
		---判断 物料 中的价格类型是否是区域限制 40560 /价格限制 40561 /正常价格  40562
		SELECT @FItemPriceType=ISNULL(a.F_142,0),@FRegionID1=ISNULL(b.FRegionID,0)
		     , @FDateFrom1=a.F_144, @FDateEnd1=a.F_145, @FCustName2=B.FNumber, @FRegionName=c.FName  
		     , @FCustID2= b.FItemID
		     --,@FNote=ISNULL(a.F_161,'') 
		FROM t_ICItemCustom a
		left outer join t_Organization b on a.F_143=b.FItemID 
		left outer join t_SubMessage c on c.FParentID =26 and c.FInterID =b.FRegionID
		WHERE a.FItemID =@FItemID 
		
		SELECT @FRegionID2=ISNULL(FRegionID,0) FROM t_Organization WHERE FItemID = @FCustID
		
		---公司单价 参考数据 吴总使用 2015-09-17 
		IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 AND FCuryID=@FCurrencyID)
		BEGIN
			SELECT @FCompanyPrice_bj=isnull(A.FPrice,0),@FCompanyPrice_xj=ISNULL(B.FLowPrice,0)
			  FROM ICPrcPlyEntry A
			  inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID 
			  WHERE A.FItemID =@FItemID AND A.FInterID=3 AND A.FCuryID=@FCurrencyID
		END
		ELSE
		BEGIN
			SET @FCompanyPrice_bj=0 
			SET @FCompanyPrice_xj=0 
		END
		----------   吴总要求 END 2015-09-17
		
		--区域限制  判断这个客户的区域是否是专用客户区域内的，且是在有效期内的，若是，则报错，不允许保存
	--	IF @FItemPriceType =40560 AND @FRegionID1=@FRegionID2  
	--	  and convert(char(8),GETDATE(),112) between convert(char(8),@FDateFrom1,112) and CONVERT(char(8),@FDateEnd1,112)
	--	  and @FCustID2<>@FCustID
		--BEGIN
	--		SET @X_ADD=2
	--	END
		--ELSE 
		--IF @FItemPriceType =40561 and convert(char(8),GETDATE(),112) between convert(char(8),@FDateFrom1,112) and CONVERT(char(8),@FDateEnd1,112)
		--- 价格限制的且在有效期内的 只能取公司价格体系
	--	BEGIN			
	--		IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 AND FCuryID=@FCurrencyID)
		--	BEGIN
		--		SELECT @FPrice_bj=isnull(A.FPrice,0),@FPriceSystemID=A.FInterID,@FPrice_xj=ISNULL(B.FLowPrice,0)
		--		  FROM ICPrcPlyEntry A
		--		  inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID 
			--	  WHERE A.FItemID =@FItemID AND A.FInterID=3 AND A.FCuryID=@FCurrencyID
		--	END
		--	ELSE 
			--BEGIN
			--	SET @X_ADD=3  ---公司价格体系不存在
		--	END
	--	END 
		--ELSE  --正常 的流程
		BEGIN 
			--客户价格体系  	价格类型  物料代码   相符的报价
			--客户价格体系 	存在时
			IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FInterID=4 and FRelatedID  =@FCustID and FItemID =@FItemID AND FPriceType=@FPriceType 
			and GETDATE()<=FEndDate
			)
			BEGIN
				SELECT @FPrice_bj=isnull(A.FPrice,0),@FPriceSystemID=A.FInterID ,@FPrice_xj=ISNULL(B.FLowPrice,0)
				  from ICPrcPlyEntry  A
				  inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID
				 WHERE A.FInterID=4 and A.FRelatedID =@FCustID and A.FItemID =@FItemID AND FPriceType=@FPriceType
			END 
			ELSE ----客户价格体系 不存在时
			BEGIN
				-- 公司价格体系  币别  物料  相符的报价	  一种物料的公司价格体系中人民币和美元只能有一条报价数据
				---公司价格体系 存在 
				IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 AND FCuryID=@FCurrencyID 
				and GETDATE()<=FEndDate
				)
				BEGIN
					SELECT @FPrice_bj=isnull(A.FPrice,0),@FPriceSystemID=A.FInterID,@FPrice_xj=ISNULL(B.FLowPrice,0)
					  FROM ICPrcPlyEntry  A
				     inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID
					  WHERE A.FItemID =@FItemID AND A.FInterID=3 AND FCuryID=@FCurrencyID
				END 
				ELSE		-- 公司价格体系 不存在 
				BEGIN
					--SET @FPrice=0
					SET @X_ADD =1
				END
			END
		END
	--	--物料代码适用车型自动关联到销售报价 不存在或为'' 则没有变化
	/*	IF EXISTS (SELECT 1 FROM t_ICItemCustom where  FItemID =@FItemID) 
		begin
		SELECT @fnote=(CASE WHEN f_161='' THEN '' ELSE isnull(f_161,'') END) 
			  FROM t_ICItemCustom
			  where FItemID =@FItemID  
			IF (@fnote<>'' )   ---若客户对应物料表中的客户对应物料 不是‘-’ 则更新
			BEGIN 
				UPDATE PORFQEntry
			       SET FNote=@fnote
			     WHERE FDetailID=@FDetailID			
			END
			
			
		
		ELSE
		BEGIN
			SET		@fnote='' 
		
		END
	end	*/
		
		
		
		--客户对应物料代码若存在 则自动关联到销售报价 不存在或为'-' 则没有变化
		IF EXISTS (SELECT 1 FROM ICItemMapping where FID =4 and FItemID =@FItemID and FPropertyID =1 and FCompanyID=@FCustID)
		BEGIN
			SELECT @FMapNumber=(CASE WHEN FMapNumber='' THEN '-' ELSE isnull(FMapNumber,'-') END) ,@FMapName =(CASE WHEN FMapName='' THEN '-' ELSE isnull(FMapName,'-') END)
			  FROM ICItemMapping 
			  where FID =4 and FItemID =@FItemID  and FPropertyID =1 and FCompanyID=@FCustID
			IF (@FMapNumber<>'-' )   ---若客户对应物料表中的客户对应物料 不是‘-’ 则更新
			BEGIN 
				UPDATE PORFQEntry
			       SET FCusItemID=@FMapNumber
			     WHERE FDetailID=@FDetailID			
			END
			IF  (@FMapName<>'-' )    ---若客户对应物料表中的客户对应物料名称不是‘-’ 则更新
			BEGIN
				UPDATE PORFQEntry
				   SET FCusItemName=@FMapName 
				 WHERE FDetailID=@FDetailID
			END
		END
		ELSE
		BEGIN
			SET		@FMapNumber='-' 
			SET		@FMapName='-' 		
		END
		---内贸客户 若客户以 0A.A1.%开头，则取公司/客户价格体系中的限价；其余依然取报价  2015-09-06 吴总要求 
		--IF (SUBSTRING((SELECT FNumber FROM t_Organization where FItemID =@FCustID),1,6)='0A.A1.')	
		--BEGIN
		--	SET @FPrice =@FPrice_xj
		--	SET @FCompanyPrice=@FCompanyPrice_xj 
	--	END
	--	ELSE 
		BEGIN
			SET @FPrice =@FPrice_bj
			SET @FCompanyPrice=@FCompanyPrice_bj
		END
				
		IF @X_ADD=1
		BEGIN
			SET @M_MESSAGE='第'+cast(isnull(@FEntryID,0) as char(3))+'行  客户/公司价格体系不存在!'
			RAISERROR(@M_MESSAGE,18,18)
			ROLLBACK TRANSACTION		
		END
		ELSE IF @X_ADD=2
		BEGIN 
			SET @M_MESSAGE='第'+cast(isnull(@FEntryID,0) as char(3))+'行物料是区域限制('+ @FRegionName + '),只能应用于:'+@FCustName2+' 客户,'
			SET @M_MESSAGE=@M_MESSAGE+ '期限('+convert(char(8),@FDateFrom1,112) +' - '+ CONVERT(char(8),@FDateEnd1,112) + ' )!'
			RAISERROR(@M_MESSAGE,18,18)
			ROLLBACK TRANSACTION	
		END
		ELSE IF @X_ADD=3
		BEGIN
			SET @M_MESSAGE='第'+cast(isnull(@FEntryID,0) as char(3))+'行物料是价格限制,公司价格体系不存在！'
			SET @M_MESSAGE =@M_MESSAGE+ ' 期限('+ CONVERT(CHAR(8),@FDateFrom1,112) + ' - ' +convert(char(8),@FDateEnd1,112)+' )'
			RAISERROR(@M_MESSAGE,18,18)
			ROLLBACK TRANSACTION
		END
		ELSE IF @FItemPriceType =40561 and @FCustID2<>@FCustID  and convert(char(8),GETDATE(),112) between convert(char(8),@FDateFrom1,112) and CONVERT(char(8),@FDateEnd1,112)
		BEGIN
			UPDATE  PORFQEntry
			SET FPrice =@FPrice ,FAuxPrice=@FPrice 
			  , FAuxPriceIncludeTax=@FPrice*(1+FCess/100)									--含税单价
			  , FAmount=@FPrice*FAuxQty*(1-0/100)											--金额
			  , FDescount=0																	--折扣率 清零
			  , FDiscountAmt=@FPrice*FAuxQty*(1+FCess/100)* 0/100							--折扣额 清零
			  , FAuxTaxPriceDiscount=@FPrice*(1+FCess/100)*(1-0/100)						--实际含税单价
			  , FTaxAmount=@FPrice*FAuxQty*FCess/100*(1-0/100)								--税额	
			  , FAmountIncludeTax=@FPrice*FAuxQty*(1+FCess/100)*(1-0/100)					--价税合计
			  , FPriceSystemID=@FPriceSystemID												--标注报价取得是公司价格体系还是客户价格体系
			  , FCompanyPrice=@FCompanyPrice												--公司单价 吴总参考使用 对应公司报价/限价 与客户价格到底差多少
			--,FNote=@FNote
			WHERE FDetailID=@FDetailID
		END
		ELSE
		BEGIN
			UPDATE  PORFQEntry
			SET FPrice =@FPrice ,FAuxPrice=@FPrice 
			  , FAuxPriceIncludeTax=@FPrice*(1+FCess/100)									--含税单价
			  , FAmount=@FPrice*FAuxQty*(1-FDescount/100)									--金额
			  , FDiscountAmt=@FPrice*FAuxQty*(1+FCess/100)* FDescount/100					--折扣额
			  , FAuxTaxPriceDiscount=@FPrice*(1+FCess/100)*(1-FDescount/100)				--实际含税单价
			  , FTaxAmount=@FPrice*FAuxQty*FCess/100*(1-FDescount/100)						--税额	
			  , FAmountIncludeTax=@FPrice*FAuxQty*(1+FCess/100)*(1-FDescount/100)			--价税合计
			  , FPriceSystemID=@FPriceSystemID												--标注报价取得是公司价格体系还是客户价格体系
			  , FCompanyPrice=@FCompanyPrice
			  --,FNote=@FNote												--公司单价 吴总参考使用 对应公司报价/限价 与客户价格到底差多少
			WHERE FDetailID=@FDetailID
		END	
		
	FETCH NEXT FROM seu_cur into @FInterID ,@FDetailID, @FEntryID, @FItemID
	              , @FAuxQty, @FAuxPrice, @FDescount, @FCess, @FCurrencyID, @FCustID, @FPriceType
	END
	CLOSE seu_cur
	DEALLOCATE seu_cur    
	    
	/*IF @X_ADD>0
	BEGIN
		SET @M_MESSAGE=@M_MESSAGE+ ' 客户/公司价格体系不存在!'
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
	END
	*/
	----系统自己带的程序
    
    UPDATE E
       SET E.FQtyFrom = CAST(I.FAuxQtyFrom AS DECIMAL(28, 16)) * CAST((ISNULL(U.FCoefficient, 1) + ISNULL(U.FScale, 0)) AS DECIMAL(28, 16)),
           E.FQtyTo = CAST(I.FAuxQtyTo AS DECIMAL(28, 16)) * CAST((ISNULL(U.FCoefficient, 1) + ISNULL(U.FScale, 0)) AS DECIMAL(28, 16)),
           E.FPrice = I.FAuxPrice / (ISNULL(U.FCoefficient, 1) + ISNULL(U.FScale, 0))
           --,e.FNote=@FNote
      FROM PORFQEntry E
           INNER JOIN inserted I ON E.FInterID = I.FInterID AND E.FEntryID = I.FEntryID
           INNER JOIN t_MeasureUnit U ON U.FItemID = I.FUnitID
  END
GO

SET ANSI_PADDING OFF
GO

