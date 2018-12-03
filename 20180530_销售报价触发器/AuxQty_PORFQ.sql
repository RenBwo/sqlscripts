/* 
 * date:		2018/11/05
 * author:		renbo
 * description:	
 * 1、取消2018/08/18变更1
 * 2、增加 运费标准ftrantype字段
 * 3、美元小数位数 含质保金 2位，扣除质保金 4位，
 * 人民币-零部件 ：
 * 集流管：01.09
 * 储液器：01.40
 * 压板：01.09
 * 支架：01.11
 * 集流管组件：01.10
 * 小数位数2位，
 * 人民币-其他 小数位数0位
 * 4、接受客户目标价
 * 5、维持成交价格
 * 6、盛部 失效客户价格也要 20181109 
 * 
 * 
 * DATA:		2018/11/02
 * AUTHOR:		renbo
 * description:	客户历史销售数量，用公式取数 
 * EXEC	[dbo].[getHstQtyCustAndModel] @fitemid  ,@fcustid ，@fqty output
 * 
 * DATA:		2018/08/18
 * AUTHOR:		RENBO
 * DESCRIPTION:	1.单据子体的价格类型数据来源，从“价格类型”变更为“核算项目.运费标准.价格类型”，
 * 				本程序的 “porfqentry.FPriceType” 变更为“t_item_3029.f_107”
 * 				2.根据利润率计算含税价格 * 
 * 
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

alter TRIGGER [dbo].[AuxQty_PORFQ]
            ON [dbo].[PORFQEntry]
FOR INSERT, UPDATE
AS
BEGIN
	--RAISERROR('run here',18,1)
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
				@FPrice_bj				DECIMAL(28,10),	--公司/客户价格体系中的报价
				@FPrice_xj				DECIMAL(28,10),	--公司/客户价格体系中的限价
				@FCompanyPrice			DECIMAL(28,10),	--公司单价 吴总参考使用 
				@FCompanyPrice_bj		DECIMAL(28,10),	--公司单价 吴总参考使用  
														--不允许修改，由系统自动带出公司价格体系的报价
				@FCompanyPrice_xj		DECIMAL(28,10),	--公司单价 吴总参考使用  
														--不允许修改，由系统自动带出公司价格体系的限价
				@FPriceType				INT,
				@FCustID				INT,
				@FPriceSystemID			INT,			-- 物料价格类型
				@FCustID2				INT,			---物料价格类型中对应的专用客户内码
				@FRegionID1				INT,			-- 客户资料中的区域内码1
				@FRegionID2				INT,			-- 客户资料中的区域内码2
				@FRegionName			VARCHAR(255),	-- 物料价格类型中对应的专用客户的区域名称
				@FDateFrom1				DATETIME,		-- 物料价格类型对应生效日
				@FDateEnd1				DATETIME,		-- 物料价格类型对应失效日
				@FCustName2				VARCHAR(255), 	--物料价格类型中对应的专用客户名称
				@FMapNumber				VARCHAR(255),
				@FMapName				VARCHAR(255),
				@FItemPriceType			INT,
				@M_MESSAGE				VARCHAR(1000),
				@FNote					VARCHAR(255),
				@X_ADD					INT 
				,@fnotefromcomply		varchar(255)   --公司价格体系备注
				,@fsaledqtybymodel		decimal(28,10) --本型号历史销售数量
				,@fsaledqtybycust		decimal(28,10) --客户历史销售数量
				,@fUncountRateQulity    decimal(28,10) --质量保证赔偿金% 
				,@fUncountRateReturn    decimal(28,10) --返点%
				,@fqutoeExchRate        decimal(28,10) --报价汇率x.xxx
				,@FBillMakeDate 		datetime		--单据作成日期
				,@isSubAssy             int        		--是否是零部件，零部件人民币价格保留小数点后两位
				,@acceptCustPrice		int				--接受客户目标价
				,@remainNowPrice		int 			--保持现在的成交价格
				,@FpricByCustom			decimal(28,10)	--客户目标价格
				
	
	SET NOCOUNT ON    
    
    SET	@X_ADD=0 
    SET	@M_MESSAGE=''       
    SET	@FMapNumber='-' 
    SET	@FMapName='-' 
    SET	@FPrice =0 
    SET	@FPrice_bj=0 
    SET	@FPrice_xj=0
	set @fnotefromcomply=''
	set @fsaledqtybymodel=0
    set @fsaledqtybycust=0
    set @fUncountRateQulity=0
  	set @fUncountRateReturn=0
    set @fqutoeExchRate =0
    set @isSubAssy=0
   
	DECLARE seu_cur CURSOR
	FOR
		SELECT A.FInterID ,A.FDetailID, A.FEntryID, A.FItemID
			 , A.FAuxQty, A.FAuxPrice, A.FDescount --as 折扣率
			 , A.FCess --as 税率
			 , B.FCurrencyID, B.FCustID,A.FPriceType
			 ,B.fUncountRateQulity ,B.fUncountRateReturn
			 ,b.fqutoeExchRate
			 ,b.fdate
			 ,(case when left(c.fnumber,5) like '01.09' then 1
			   when left(c.fnumber,5) like '01.10' then 1
			   when left(c.fnumber,5) like '01.11' then 1
			   when left(c.fnumber,5) like '01.40' then 1
			   else 0 end) as isSubASSY
			  --,fcheckbox,facceptNowPrice
			  ,FAceptCstGoaPrice ,FKeepNowPrice,FpricByCustom
		 FROM INSERTED a
		 INNER JOIN PORFQ b on a.FInterID = b.FInterID
		 join t_icitem c on a.fitemid=c.fitemid
		  	    
	OPEN seu_cur	    
	FETCH NEXT FROM seu_cur into @FInterID ,@FDetailID, @FEntryID, @FItemID, @FAuxQty
	, @FAuxPrice, @FDescount, @FCess, @FCurrencyID, @FCustID, @FPriceType
	,@fUncountRateQulity ,@fUncountRateReturn,@fqutoeExchRate,@FBillMakeDate ,@isSubAssy
	,@acceptCustPrice,@remainNowPrice,@FpricByCustom
	WHILE @@FETCH_STATUS=0    
	BEGIN
		if (@acceptCustPrice =1 and @remainNowPrice = 1) 
		begin
		RAISERROR(N'不能同时选择“接受客户目标价”和“现在执行价格”',18,1)
		ROLLBACK TRANSACTION	
		end
		--RAISERROR(N'run here',18,1)
		EXEC [dbo].[getModelHistSaleQty]  @FItemID,@fsaledqtybymodel output
		EXEC [dbo].[getHstQtyCustAndModel]  @FItemID ,@FCustID ,@fsaledqtybycust output
		---判断 物料 中的价格类型是否是区域限制 40560 /价格限制 40561 /正常价格  40562
		SELECT @FItemPriceType=ISNULL(a.F_142,0),@FRegionID1=ISNULL(b.FRegionID,0)
		     , @FDateFrom1=a.F_144, @FDateEnd1=a.F_145, @FCustName2=left(B.FNumber,50)
		     , @FRegionName=left(c.FName,200)  
		     , @FCustID2= b.FItemID
		     --,@FNote=ISNULL(a.F_161,'') 
		FROM t_ICItemCustom a
		left outer join t_Organization b on a.F_143=b.FItemID 
		left outer join t_SubMessage c on c.FParentID =26 and c.FInterID =b.FRegionID
		WHERE a.FItemID =@FItemID 
		
		SELECT @FRegionID2=ISNULL(FRegionID,0) FROM t_Organization WHERE FItemID = @FCustID
		---公司单价 参考数据 吴总使用 2015-09-17 
		IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 
		AND FCuryID=@FCurrencyID)
		BEGIN
			SELECT @FCompanyPrice_bj=isnull(A.FPrice,0),@FCompanyPrice_xj=ISNULL(B.FLowPrice,0)
			,@fnotefromcomply=left(a.fnote,150) --20180718
			FROM ICPrcPlyEntry A
			inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID 
			and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID 
			WHERE A.FItemID =@FItemID AND A.FInterID=3 AND A.FCuryID=@FCurrencyID
		END
		ELSE
		BEGIN
			SET @FCompanyPrice_bj=0 
			SET @FCompanyPrice_xj=0 
		END
		----------   吴总要求 END 2015-09-17
		
	
		BEGIN 
			--客户价格体系  	价格类型  物料代码   相符的报价
			--客户价格体系 	存在时
			IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FInterID=4 and FRelatedID=@FCustID 
			and FItemID =@FItemID AND FPriceType=@FPriceType --and GETDATE()<=FEndDate 
			--盛部 失效客户价格也要 20181109 
			)
			BEGIN
				SELECT @FPrice_bj=isnull(A.FPrice,0),@FPriceSystemID=A.FInterID 
				,@FPrice_xj=ISNULL(B.FLowPrice,0)
				  from ICPrcPlyEntry  A
				  inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID 
				  and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID
				 WHERE A.FInterID=4 and A.FRelatedID =@FCustID and A.FItemID =@FItemID 
				 AND FPriceType=@FPriceType
			END 
			ELSE ----客户价格体系 不存在时
			BEGIN
				-- 公司价格体系  币别  物料  相符的报价一种物料的公司价格体系中人民币和美元只能有一条报价数据
				---公司价格体系 存在 
				IF EXISTS ( SELECT 1 FROM ICPrcPlyEntry WHERE FItemID =@FItemID AND FInterID=3 
				AND FCuryID=@FCurrencyID and GETDATE()<=FEndDate )
				BEGIN
					SELECT @FPrice_bj=isnull(A.FPrice,0),@FPriceSystemID=A.FInterID
					,@FPrice_xj=ISNULL(B.FLowPrice,0)
					  FROM ICPrcPlyEntry  A
				     inner join ICPrcPlyEntrySpec b on a.FInterID =b.FInterID 
				     and a.FRelatedID =b.FRelatedID and a.FItemID =b.FItemID
					  WHERE A.FItemID =@FItemID AND A.FInterID=3 AND FCuryID=@FCurrencyID
				END 
				ELSE		-- 公司价格体系 不存在 
				BEGIN
					--SET @FPrice=0
					SET @X_ADD =1
				END
			END
		END
	
	--客户对应物料代码若存在 则自动关联到销售报价 不存在或为'-' 则没有变化
		IF EXISTS (SELECT 1 FROM ICItemMapping where FID =4 and FItemID =@FItemID 
		and FPropertyID =1 and FCompanyID=@FCustID)
		BEGIN
			SELECT @FMapNumber=(CASE WHEN FMapNumber='' THEN '-' ELSE isnull(FMapNumber,'-') END)
			,@FMapName =(CASE WHEN FMapName='' THEN '-' ELSE isnull(FMapName,'-') END)
			
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
		
		BEGIN
			SET @FPrice =@FPrice_bj       ---20180810 公司价格体系和客户价格体系里的报价，都是含税价格
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
			SET @M_MESSAGE='第'+cast(isnull(@FEntryID,0) as char(3))+'行物料是区域限制('
			+ @FRegionName + '),只能应用于:'+@FCustName2+' 客户,'
			SET @M_MESSAGE=@M_MESSAGE+ '期限('+convert(char(8),@FDateFrom1,112) +' - '
			+ CONVERT(char(8),@FDateEnd1,112) + ' )!'
			RAISERROR(@M_MESSAGE,18,18)
			ROLLBACK TRANSACTION	
		END
		ELSE IF @X_ADD=3
		BEGIN
			SET @M_MESSAGE='第'+cast(isnull(@FEntryID,0) as char(3))
			+'行物料是价格限制,公司价格体系不存在！'
			SET @M_MESSAGE =@M_MESSAGE+ ' 期限('+ CONVERT(CHAR(8),@FDateFrom1,112) 
			+ ' - ' +convert(char(8),@FDateEnd1,112)+' )'
			RAISERROR(@M_MESSAGE,18,18)
			ROLLBACK TRANSACTION
		END
		ELSE IF @FItemPriceType =40561 and @FCustID2<>@FCustID  
		and convert(char(8),GETDATE(),112) between convert(char(8),@FDateFrom1,112) 
		and CONVERT(char(8),@FDateEnd1,112)
		BEGIN
			UPDATE  PORFQEntry
			SET FPrice =(case @fcurrencyid when 1 then 
					(case @isSubAssy when 1 then round(@FPrice/(1+@fcess/100),2)
					else round(@FPrice/(1+@fcess/100),0) end)
					else round(@FPrice/(1+@fcess/100),4) end)
				,FAuxPrice=(case @fcurrencyid when 1 then 
					(case @isSubAssy when 1 then round(@FPrice/(1+@fcess/100),2)
					else round(@FPrice/(1+@fcess/100),0) end)
					else round(@FPrice/(1+@fcess/100),4) end)
			 	,FAuxPriceIncludeTax=@FPrice							--含税单价(扣除质保金）
			 	,FTaxIncQGPrice = (case @fcurrencyid when 1 then 
			 		(case @isSubAssy when 1 then round(@FPrice/(1-@FuncountRateQulity/100),2)
					else round(@FPrice/(1-@FuncountRateQulity/100),0) end)
					else round(@FPrice/(1-@FuncountRateQulity/100),2) end)	--含税单价（含质保金）
			  	, FPriceSystemID=@FPriceSystemID			--标注报价取得是公司价格
			  												--体系还是客户价格体系
			  	, FCompanyPrice=@FCompanyPrice				--公司单价 吴总参考使用 对应公司报价/限价 
			  												--与客户价格到底差多少
			  	, FDescount=(case when @acceptCustPrice = 1  then fdescount
			  		when @remainNowPrice = 1 then 0			  	
			  	 else (100- 100*Fsumcost
					/(1-FrateGainByComFinalPric/100)*(1+@FCess/100)
					/(1-@fUncountRateReturn/100)
					/(FAuxPriceIncludeTax*@fqutoeExchRate)) end)						--折扣率
			  	, FDiscountAmt= (case when @acceptCustPrice = 1 then fdiscountamt
			  		when @remainNowPrice = 1 then 0			  	
			  		else (case @FCurrencyID when 1 
			  		then (case @issubassy when 1 then round(@FPrice*FAuxQty*FDescount/100,2) 
			  		else round(@FPrice*FAuxQty*FDescount/100,0) end)
			  		else round(@FPrice*FAuxQty*FDescount/100,4)
			  		end)	 end)												--折扣额 
				, FCustGoalUninclQGPric=(case @FCurrencyID 						--客户含税目标价格（扣除质保金）
									when 1 then round(@FpricByCustom*(1-@FuncountRateQulity/100),2)
									else round(@FpricByCustom*(1-@FuncountRateQulity/100),4) end)   
			  	/* 
			  	 * 美元 扣除质保金 四位小数
			  	 * 人民币 零部件 两位小数，其它 零位，不需要考虑是否扣除质保金
			  	 */
			  	, FAuxTaxPriceDiscount=(case 
			  		when @acceptCustPrice = 1 then FCustGoalUninclQGPric
			  		when @remainNowPrice = 1  then @FPrice
			  	    else (case @FCurrencyID 
			  	    	when 1 then (case @issubassy when 1 then round(@FPrice*(1-FDescount/100),2) 
			  		 				else round(@FPrice*(1-FDescount/100),0) end)
			  		 	else 
			  		 	round(round(@FPrice*(1-FDescount/100)/(1-@FuncountRateQulity/100),2)
			  		 			*(1-@FuncountRateQulity/100),4)
				  		 end)		
				  	end)										--实际含税单价(扣除质保金）
			  	 /* 
			  	 * 含质保金 两位小数
			  	 * 人民币 零部件 两位小数，其它 零位，不需要考虑是否扣除质保金
			  	 */
				 ,FauxTaxIncQGPrice = (case when @acceptCustPrice = 1 then @FpricByCustom 
			  		when @remainNowPrice = 1 then FTaxIncQGPrice
			  	  else (case @FCurrencyID when 1 
			  		 then (case @issubassy when 1 then round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),2) 
			  		 else round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),0) end) 
			  		 else round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),2)
				  		 end)				end)							--实际含税单价（含质保金）
			  	, FTaxAmount=(case @fcurrencyid when 1 then 
			  	   (case @issubassy when 1 then round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,2)
			  	   else round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,0) end)
			  	   else round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,4) end)	--税额	
			  	, FAmount=(case @fcurrencyid when 1 then 
			  	  (case @issubassy when 1 then round(@FPrice/(1+@fcess/100)*FAuxQty,2) 
			  	  else round(@FPrice/(1+@fcess/100)*FAuxQty,0) end ) 
			  	  else round(@FPrice/(1+@fcess/100)*FAuxQty,4) end)				--金额
			  	, FAmountIncludeTax=(case when @acceptCustPrice = 1 then @FpricByCustom
			  		 when @remainNowPrice = 1 then @FPrice
			  			else (case @FCurrencyID when 1 
			  		 then (case @issubassy when 1 then round(@FPrice*FAuxQty*(1-FDescount/100),2)
			  		  else round(@FPrice*FAuxQty*(1-FDescount/100),0) end)
			  		 else round(@FPrice*FAuxQty*(1-FDescount/100),4) end) 
			  		 end)									--价税合计				  	
			  	, Fnotefromcomply = @fnotefromcomply		--公司价格体系备注
			  	, fsaledqtybymodel = @fsaledqtybymodel		--型号历史销售数量
				, Fsaledqtybycust=@fsaledqtybycust   		--客户历史销售数量  
				
				, FGain=FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					/(1+@FCess/100)-Fsumcost		--利润额
				, FrateGain=100*(FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					/(1+@FCess/100)
					-Fsumcost)
					*(1+@FCess/100)
					/(FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					) 											--利润率%
				,FGainByCustom=(case @FpricByCustom when 0 then 0 else 
					@FpricByCustom*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					*(1-@fUncountRateQulity/100 )/(1+@FCess/100)
					-Fsumcost end)			--客户目标价利润额
				, FrateByCustom=100*(case @FpricByCustom when 0 then 0 else 
					(1- Fsumcost*(1+@FCess/100)/(@FpricByCustom*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					*(1-@fUncountRateQulity/100 ))) end)	 --客户目标价利率%
				
				
			WHERE FDetailID=@FDetailID
		END
		ELSE
		BEGIN
			UPDATE  PORFQEntry
			SET FPrice =(case @fcurrencyid when 1 then 
					(case @isSubAssy when 1 then round(@FPrice/(1+@fcess/100),2)
					else round(@FPrice/(1+@fcess/100),0) end)
					else round(@FPrice/(1+@fcess/100),4) end)
				,FAuxPrice=(case @fcurrencyid when 1 then 
					(case @isSubAssy when 1 then round(@FPrice/(1+@fcess/100),2)
					else round(@FPrice/(1+@fcess/100),0) end)
					else round(@FPrice/(1+@fcess/100),4) end)
			 	,FAuxPriceIncludeTax=@FPrice							--含税单价(扣除质保金）
			 	,FTaxIncQGPrice = (case @fcurrencyid when 1 then 
			 		(case @isSubAssy when 1 then round(@FPrice/(1-@FuncountRateQulity/100),2)
					else round(@FPrice/(1-@FuncountRateQulity/100),0) end)
					else round(@FPrice/(1-@FuncountRateQulity/100),2) end)	--含税单价（含质保金）
			  	, FPriceSystemID=@FPriceSystemID			--标注报价取得是公司价格
			  												--体系还是客户价格体系
			  	, FCompanyPrice=@FCompanyPrice				--公司单价 吴总参考使用 对应公司报价/限价 
			  												--与客户价格到底差多少
			    , FDescount=(case when @acceptCustPrice = 1  then fdescount
			  		when @remainNowPrice = 1 then 0			  	
			  	 else (100- 100*Fsumcost
					/(1-FrateGainByComFinalPric/100)*(1+@FCess/100)
					/(1-@fUncountRateReturn/100)
					/(FAuxPriceIncludeTax*@fqutoeExchRate)) end)						--折扣率
				, FCustGoalUninclQGPric=(case @FCurrencyID 						--客户含税目标价格（扣除质保金）
									when 1 then round(@FpricByCustom*(1-@FuncountRateQulity/100),2)
									else round(@FpricByCustom*(1-@FuncountRateQulity/100),4) end) 
			  	, FDiscountAmt= (case when @acceptCustPrice = 1 then fdiscountamt
			  		when @remainNowPrice = 1 then 0			  	
			  		else (case @FCurrencyID when 1 
			  		then (case @issubassy when 1 then round(@FPrice*FAuxQty*FDescount/100,2) 
			  		else round(@FPrice*FAuxQty*FDescount/100,0) end)
			  		else round(@FPrice*FAuxQty*FDescount/100,4)
			  		end)	 end)												--折扣额 
			    , FAuxTaxPriceDiscount=(case when @acceptCustPrice = 1 then FCustGoalUninclQGPric
			  		when @remainNowPrice = 1 then @FPrice			  	
			  	    else (case @FCurrencyID when 1 
			  		 then (case @issubassy when 1 then round(@FPrice*(1-FDescount/100),2) 
			  		 else round(@FPrice*(1-FDescount/100),0) end)
			  		 else round(round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),2)*(1-@FuncountRateQulity/100),4)
				  		 end)		end)										--实际含税单价(扣除质保金）
			  	,FauxTaxIncQGPrice = (case when @acceptCustPrice = 1 then  @FpricByCustom
			  		when @remainNowPrice = 1 then FTaxIncQGPrice
			  	  else (case @FCurrencyID when 1 
			  		 then (case @issubassy when 1 then round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),2) 
			  		 else round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),0) end) 
			  		 else round(@FPrice*(1-FDescount/100)
			  		 /(1-@FuncountRateQulity/100),2)
				  		 end)				end)							--实际含税单价（含质保金）
			  	, FTaxAmount=(case @fcurrencyid when 1 then 
			  	   (case @issubassy when 1 then round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,2)
			  	   else round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,0) end)
			  	   else round(@FPrice/(1+@fcess/100)*FAuxQty*@FCess/100,4) end)	--税额	
			  	, FAmount=(case @fcurrencyid when 1 then 
			  	  (case @issubassy when 1 then round(@FPrice/(1+@fcess/100)*FAuxQty,2) 
			  	  else round(@FPrice/(1+@fcess/100)*FAuxQty,0) end ) 
			  	  else round(@FPrice/(1+@fcess/100)*FAuxQty,4) end)				--金额
			  	, FAmountIncludeTax=(case when @acceptCustPrice = 1 then @FpricByCustom
			  		 when @remainNowPrice = 1 then @FPrice
			  			else (case @FCurrencyID when 1 
			  		 then (case @issubassy when 1 then round(@FPrice*FAuxQty*(1-FDescount/100),2)
			  		  else round(@FPrice*FAuxQty*(1-FDescount/100),0) end)
			  		 else round(@FPrice*FAuxQty*(1-FDescount/100),4) end) 
			  		 end)									--价税合计				  	
			  	, Fnotefromcomply = @fnotefromcomply		--公司价格体系备注
			  	, fsaledqtybymodel = @fsaledqtybymodel		--型号历史销售数量
				, Fsaledqtybycust=@fsaledqtybycust   		--客户历史销售数量  
				
				, FGain=FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					/(1+@FCess/100)-Fsumcost		--利润额
				, FrateGain=100*(FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					/(1+@FCess/100)
					-Fsumcost)
					*(1+@FCess/100)
					/(FAuxPriceIncludeTax*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					) 											--利润率%
				, FGainByCustom=(case @FpricByCustom when 0 then 0 else 
					@FpricByCustom*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					*(1-@fUncountRateQulity/100 )/(1+@FCess/100)
					-Fsumcost end)			--客户目标价利润额
				, FrateByCustom=100*(case @FpricByCustom when 0 then 0 else 
					(1- Fsumcost*(1+@FCess/100)/(@FpricByCustom*@fqutoeExchRate
					*(1-@fUncountRateReturn/100)
					*(1-@fUncountRateQulity/100 ))) end)	 --客户目标价利率%
				
			WHERE FDetailID=@FDetailID
		END	
		
	FETCH NEXT FROM seu_cur into @FInterID ,@FDetailID, @FEntryID, @FItemID
	              , @FAuxQty, @FAuxPrice, @FDescount, @FCess, @FCurrencyID, @FCustID
	              , @FPriceType,@fUncountRateQulity,@fUncountRateReturn,@fqutoeExchRate
	              ,@FBillMakeDate,@isSubAssy,@acceptCustPrice,@remainNowPrice,@FpricByCustom 
	END
	CLOSE seu_cur
	DEALLOCATE seu_cur    
	    
	
	----系统自己带的程序
    
    UPDATE E
       SET E.FQtyFrom = CAST(I.FAuxQtyFrom AS DECIMAL(28, 16)) * CAST((ISNULL(U.FCoefficient, 1)
       + ISNULL(U.FScale, 0)) AS DECIMAL(28, 16)),
           E.FQtyTo = CAST(I.FAuxQtyTo AS DECIMAL(28, 16)) * CAST((ISNULL(U.FCoefficient, 1)
           + ISNULL(U.FScale, 0)) AS DECIMAL(28, 16)),
           E.FPrice = I.FAuxPrice / (ISNULL(U.FCoefficient, 1) + ISNULL(U.FScale, 0))
           --,e.FNote=@FNote
      FROM PORFQEntry E
           INNER JOIN inserted I ON E.FInterID = I.FInterID AND E.FEntryID = I.FEntryID
           INNER JOIN t_MeasureUnit U ON U.FItemID = I.FUnitID
  END
