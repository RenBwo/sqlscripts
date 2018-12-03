/*
 * DATE:			2018/01/31
 * AUTHOR:			RENBO
 * DESCRIPTIONS:	get price order:蓝字采购发票过去一年的平均不含税价格,计划价格
 * 
 * DATE:			2017/02/23
 * AUTHOR:			RENBO
 * DESCRIPTION: 	原来没有考虑外币，升级
 * 
 * CREATE date: 	2014-11-06
 * Author:			YangeYuan
 * Description:		<成本BOM 查询画面 根据SQL追踪的结果结合友邦实际需求进行修改 原ERP中的成本BOM查询不用了
 * DESCRIPTION:		get price order:入库价格,平均库存价格,供应商价格体系价格,计划价格
 * 
 * exec DBO.BOM_cb_list   'PFA-20','','A',0,'2014-11-01'   表头
 * exec DBO.BOM_cb_list   'PFA-201','','B',29044,'2014-11-01'   表体
 */

create PROCEDURE [dbo].[bom_cb_list_changed_20180131]
	@FName				NVARCHAR(255),
	@FCusno				NVARCHAR(255),
	@FQufn				NVARCHAR(1),
	@FParentItemid		INT,
	@FDate				NVARCHAR(8)
	
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @fexchangerrate decimal(13,8)				--汇率
	DECLARE @MinDate 		smalldatetime	,@MaxDate 	smalldatetime
	DECLARE @MinDayID 		int				,@MaxDayID 	int				,@selectrows int ,@LastBomLevel int 
	DECLARE @BOMMaxLevel 	smallint 		,@BOMLevel 	smallint 
	
	SELECT @fexchangerrate = fexchangerate FROM t_exchangerateentry 
	WHERE fcyfor = 1 AND fcyto = 1000 AND fenddate > getdate() AND fexchangeratetype = 1
	
	CREATE Table #ITEMPRICE(						-- itemprice
		 FIndex int IDENTITY, 
		 FItemID int null, 
		 FLastQty decimal(28,8) default(0) null, 
		 FLastAmount decimal(28,8) default(0) null, 
		 FPlanPrice decimal(28,8) default(0) null, 
		 FLastPrice decimal(28,8) default(0) null,
		 FNewPrice decimal(28,8) default(0) null) 
	CREATE  index #idx_FItemID ON #ITEMPRICE(FItemID)


	CREATE Table #BomCost(							--bom cost
		 FParentItemid	int,   ---成品物料内码  我加的看看,可以查多个成品  
		 FIndex int identity , 
		 FItemID int null , 
		 FNumber varchar(355) null, 
		 FShortNumber varchar(355) null, 
		 FName varchar(355) null, 
		 FModel varchar(355) null, 
		 FUnitName varchar(355) null, 
		 QtyDecimal smallint default(0) null, 
		 PriceDecimal smallint default(0) null, 
		 FQty decimal(28,8) default(0) null , 
		 FPlanPrice decimal(28,8) default(0) null, 
		 FPlanAmount decimal(28,8) default(0) null, 
		 FLastPrice decimal(28,8) default(0) null, 
		 FLastAmount decimal(28,8) default(0) null, 
		 FNewPrice decimal(28,8) default(0) null, 
		 FNewAmount decimal(28,8) default(0) null ) 
	CREATE clustered index #idx_FItemID  ON #BomCost(FItemID)

	CREATE Table #ParentData (
		 FIndex int identity , 
		 FItemID int null, 
		 FBom int default(0) null , 
		 FQty decimal(28,10) default(0) null, 
		 FObjID int default(0) null )  
	CREATE index #idx_FItemID ON #ParentData(FItemID)
	CREATE clustered index #idx_FIndex ON #ParentData(FIndex) 
	
	IF @FQufn IN('A','B','C')
	BEGIN
		INSERT INTO #ParentData (FItemID,FBom,FQty,FObjID) 
		SELECT t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0 
		FROM t_ICItem 	t1 
		JOIN icbom 		t2 ON t1.FItemID =t2.FItemID AND t2.FUseStatus=1072 AND t2.FStatus =1
		WHERE (t1.FName  LIKE '%'+ISNULL(@FName,'')+'%' OR t1.FModel  LIKE '%'+ ISNULL(@FName,'')+'%' 
		  		OR t1.Fnumber  LIKE '%'+ ISNULL(@FName,'')+'%' )
		AND t1.FNumber  LIKE '01.%'
	END
	ELSE 
	BEGIN
		INSERT INTO #ParentData (FItemID,FBom,FQty,FObjID) 
		SELECT t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0
		FROM t_ICItem 		t1 
		JOIN icbom 			t2 ON t1.FItemID =t2.FItemID AND t2.FUseStatus=1072 AND t2.FStatus =1
		JOIN t_Organization e1 ON e1.FNumber=@FCusno 
		JOIN ICPrcPlyEntry 	e2 ON e2.FInterID=4 AND e2.FRelatedID =e1.FItemID AND e2.FItemID =t1.FItemID 
		WHERE (t1.FName  LIKE '%'+ISNULL(@FName,'')+'%' OR t1.FModel  LIKE '%'+ ISNULL(@FName,'')+'%' 
				OR t1.Fnumber  LIKE '%'+ ISNULL(@FName,'')+'%' )
		ORDER BY  t1.FNumber 
	
	END
	


 --- GetBomOpen 展开嵌套SQL 开始 by wwq 版本v90 -------
	CREATE Table #BomData ( 
			FIndex 				int IDENTITY,
			FItemID 			int null,       					--物料ID
		 	FParentItemID 		int null, 							--根节点物料ID，当FBomLevel=0时，FItemID = FParentItemID
		 	FOFFSetDay 			decimal(28,10) DEFAULT(0) NOT NULL,	--子项物料提前期偏置 FBOMLevel=0 时 FOFFSetDay=0
		 	FNeedDate 			datetime null,						--需求日期,内部处理，用于计算累计提前期 
		 	FNeedQty 			decimal(28,14) default(0) null, 	--单位用量 
		 	FRelNeedQty 		decimal(28,14) default(0) null, 	--实际用量 
		 	FBOMLevel 			int null,     						--BOM层次
		 	FItemType 			int null,     						--10:虚拟件；4:配置；5：特征；6:规划 1：自制OR委外；0：采购
		 	FParentID 			int default(0) null,   				--内部使用，上级FINDEX
		 	FUpItemID 			int default(0) null,   				--内部使用，上级物料ID
		 	FUpBOM 				int default(0) null,   				--内部使用，上级BOM
		 	FRate   			decimal(28,10) default(0) null,  	--比率
		 	FScrap   			decimal(28,10) default(0) null, 	--损耗率
		 	FRelScrap 			decimal(28,10) default(0) null, 	--累计损耗率
		 	FSumParentTime 		decimal(28,10) default(0) null,   	--上级累计下来到本次的提前期合计
		 	FFixLeadTime 		decimal(28,10) default(0) null,     --物料固定提前期 
		 	FSumLeadtime 		decimal(28,10) default(0) null,    	--物料累计提前期
		 	FLeadTime 			decimal(28,10) default(0) null,    	--物料变动提前期
		 	FBatChangeEconomy 	decimal(28,10) default(0) null,    	--物料变动批量
		 	FSecInv 			decimal(28,10) default(0) null,    	--物料安全库存 
		 	FBom    			int default(0) null,                --BOM 
		 	FObjID  			int default(0) null,                --跟踪对象
		 	FGroupID 			int default(0) null,                --根节点FINDEX 
		 	FOperId 			int default(0) null,                --工序ID
		 	FOrderTrategy 		varchar(10) default('') null,     	--订货策略
		 	FPlanTrategy 		varchar(10) default('') null,      	--计划策略
		 	FMaterielType 		varchar(10) default('') null,     	--BOM子项类型 
		 	FMarshalType 		varchar(10) default('') null,      	--BOM子项配置属性 
		 	FBEGINDate 			datetime default('1900-01-01'),    	--BOM子项有效开始日期 
		 	FEndDate 			datetime default('2100-01-01'),    	--BOM子项有效结束日期 
		 	FAuxPropID 			int default(0),                  	--辅助属性 
		 	FHaveUptDate 		int default(0),        				--工厂日历更新标志 
		 	FHaveBomOpen 		smallint default(0) null,
		 	FSPID  				int default(0),						--发料仓库
		 	FStockID 			int default(0),						--发料仓位
		 	FIsCharSourceItem   Smallint default(0)  null,			--是否特性来源物料0/1(子项物料)
		 	FSourceItemID   	int default(0)    null,            	--若是特性物料 , 则记录特性来源物料(子项物料)
		 	FCharConfigID   	int default(0)   null,				--特性方案ID (子项物料)
		 	FDetailID       	uniqueidentIFier  null,				--唯一码 (子项物料)
		 	FBOMSkip        	smallint default(0)  null,			--BOM是否跳层
		 	FCalID         		int default(999)  null,				--工厂日历ID
		 	FDayID         		int default(0) null					--日历内码
		 	) 


	--1. --创建临时表
	
	--- BOM展开表的特性信息 -------
	IF Object_id('[tempdb].[dbo].[#TempChar]') IS NOT NULL 
	    TRUNCATE TABLE #TempChar
	ELSE 
	BEGIN 
	CREATE Table #TempChar ( 
	    	FIndex  	int not null,   --关联TempBomOpenDest 的Findex字段
	    	FCharID 	int null,       --特性ID
	    	FCharValID  int null    	--特性值
	    	) 
	END  

	--- 特性配置BOM展开临时表（结构相同于sDestTable） -------
	IF Object_id('[tempdb].[dbo].[#TempBomOpen_Char]') Is Not Null 
		 TRUNCATE TABLE #TempBomOpen_Char 
	 ELSE 
	 BEGIN 
		SELECT * INTO #TempBomOpen_Char FROM #BomData WHERE 1<>1  
	 END  

	SELECT @MinDayID=Min(FInterID),@MaxDayID=Max(FInterID),@MinDate=Min(FDay),@MaxDate=Max(FDay) 
	FROM t_MutiWorkCal 	WHERE FCalID=999 AND FInterID>0

	INSERT INTO  #BomData  (  FParentItemID,FItemID  ,FNeedDate,FNeedQty,FRelNeedQty,FBOMLevel
							,  FItemType
							,  FParentID,FFixLeadTime,FObjID,FPlanTrategy,FOrderTrategy
							,  FHaveBomOpen,FBom,FSumParentTime,FLeadTime,FBatChangeEconomy
							,  FIsCharSourceItem, FSourceItemID, FCharConfigID, FBOMSkip
							,  FAuxPropID, FCalID
							, FDayID
							)
	 SELECT u1.FItemID,u1.FItemID,u1.FDate,u1.FNeedQty,u1.FRelNeedQty, 0
		  , (CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' 
		  	THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END) FItemtype
		  , 0, t1.FFixLeadTime, 0, isnull(t5_1.FID,'MRP'), isnull(t5_2.FID,'LFL')
		  , 0, u1.FBom,0, t1.FLeadTime, T1.FBatChangeEconomy
		  , ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID
		  , t7.FBOMSkip, FAuxPropID, Isnull(t2.FCalID,'999') AS FCalID
		  , Isnull( ( SELECT FNxtID AS FDayID FROM t_MutiWorkCal  WHERE FCalID=Isnull(t2.FCalID,999) 
		  	AND FDay = u1.FDate),@MinDayID)  AS FDayID 
	 FROM (
		 SELECT distinct FItemID ,0 FObjID,FBom,convert(varchar(10),GetDate() ,121) AS FDate,1 AS FNeedQty
			 , 1 AS FRelNeedQty FROM #ParentData 
		  ) 					u1
	JOIN t_ICItem 				t1 		ON U1.FItemID=T1.FItemID
	JOIN t_Submessage 			t5   	ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210 --物料基本信息
	LEFT JOIN t_Submessage 		t5_1 	ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167  --计划策略
	LEFT JOIN t_SubMessage 		t5_2 	ON t1.FOrderTrategy = t5_2.FInterID AND t5_2.FTypeID = 169 --订货策略
	LEFT JOIN ICPlan_CharConfig t6 		ON u1.FItemID = t6.FItemID AND t6.FCheckerID > 0 
	LEFT JOIN ICBom 			t7 		ON u1.FBom = t7.FInterID 
	LEFT JOIN t_Department 		t2 		ON T1.FSource=t2.FItemID AND T1.FErpClsID  in (2,7,9)  
	CREATE index #idx_FItemID  	ON #BomData(FItemID) 
	CREATE index #idx_FBOM  	ON #BomData(FBOM) 

	UPDATE v1 SET v1.FBom = u1.FInterID, FBomSkip=u1.FBomSkip , v1.FAuxPropID=u1.FAuxPropID
	FROM #BomData 	v1 
	JOIN ICBom 		u1 ON v1.FItemID = u1.FItemID
	WHERE  isnull(v1.FBom,0) = 0 AND u1.FBomType <> 3 AND u1.FUseStatus = 1072

	UPDATE #BomData SET FGroupID = FIndex WHERE FBomLevel = 0 
	--更新特性物料的BOM
	UPDATE #BomData	SET  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FAuxPropID=C.FAuxPropID 
	FROM  #BomData  		A
	JOIN ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0  --特性方案
	JOIN ICBOM 				C ON B.FBomInterID = C.FInterID 
	WHERE A.FIsCharSourceItem=0 AND A.FCharConfigID>0

	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	SELECT A1.FIndex,C2.FCharID, C2.FCharValID
	FROM #BomData 				A1  --子项
	JOIN ICPlan_CharConfig 		C1 ON A1.FItemID=C1.FItemID  --特性配置方案
	JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	WHERE A1.FBomLevel = 0 AND  A1.FIsCharSourceItem=0 AND A1.FCharConfigID>0 

	SELECT @BOMMaxLevel = 30
	SELECT @BOMLevel =0 
	SELECT @selectrows = 0
	SELECT @selectrows = isnull(count(*),0) FROM #BomData     
	WHERE FHaveBomOpen = 0 AND FBomLevel = @BomLevel AND FItemType > 0 
		 AND FNeedQty>0 
		 
	 WHILE ( @selectrows >0 AND @BomLevel < @BomMaxLevel)
	 BEGIN 
		 --- FROM ICBOMChild 
		 INSERT INTO #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType
		 ,FParentID,FRate,FFixLeadTime,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy
		 ,FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime
		 ,FLeadTime,FBatChangeEconomy,FSecInv,FBEGINDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID
		 ,FSPID,FStockID,FOffSetDay, FDetailID, FCalID, FDayID, FBOM ) 
		  SELECT  u1.FParentItemID,v2.FItemID, t10.FPreDay AS FNeedDate,
		round(
		convert(decimal(28,15),
			(convert(decimal(28,15),u1.FNeedQty) * 
				 convert(decimal(28,15),
					 round(
						  convert( decimal(28,15),v2.FQty ) / convert( decimal(28,15),v1.FQty )
					 ,t1.FQtyDecimal + 4)
				 )
			)
		)*
		convert(decimal(28,15),
			(
				convert( decimal(28,15),(v2.FPercent /100) )
	            
			)
		)/(CASE WHEN v2.FScrap=100 THEN 1 ELSE (1-convert( decimal(28,15),(v2.FScrap /100) ))end)
		,t1.FQtyDecimal + 4)   AS FNeedQty, 
		round(
		convert(decimal(28,15),
			(convert(decimal(28,15),u1.FRelNeedQty) * 
				 convert(decimal(28,15),
					 round(
						  convert( decimal(28,15),v2.FQty ) / convert( decimal(28,15),v1.FQty )
					 ,t1.FQtyDecimal + 4)
				 )
			)
		)*
		convert(decimal(28,15),
			(
				convert( decimal(28,15),(v2.FPercent /100) )
	            
			)
		)
		,t1.FQtyDecimal + 4)   AS FRelNeedQty,(@BOMLevel +1) FBomLevel
		, (CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' 
			THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END)  FItemtype
		, u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4) FRate
		,t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL')
		,  (CASE WHEN (v2.FMaterielType=371 OR v2.FMaterielType=375) THEN 0 ELSE 1 END ) FMeterialType,u1.FObjID
		,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0)
		,(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 	,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBEGINDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID
	 	,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID ,IsNull(t2.FCalID,'999') AS FCalID ,t10.FPreID AS FDayID 
		,0 AS FBOM      
		FROM ( SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel AND FHaveBomOpen = 0 AND FItemType > 0 
				 AND FNeedQty>0 
	 		) 					u1
	 JOIN ICBOM 				v1    	ON u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	 JOIN ICBOMChild 			V2  	ON V1.FInterID=V2.FInterID       
	 JOIN T_ICItem 				t1   	ON V2.FItemID=T1.FItemID                                                             
	 JOIN t_SubMessage 			t5   	ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210         --子项物料类型                 
	 LEFT JOIN t_Submessage 	t5_1 	ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167  --子项物料计划策略       
	 LEFT JOIN t_SubMessage 	t5_2 	ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169 --子项物料订货策略     
	 LEFT JOIN t_Submessage 	t5_3 	ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173 --子项物料属性         
	 LEFT JOIN t_SubMessage 	t5_4 	ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174  --子项物料用途 通用、可选
	 LEFT JOIN t_Department 	t2 		ON T1.FSource=t2.FItemID AND T1.FErpClsID  in (2,7,9)   
	 LEFT JOIN t_MutiWorkCal 	t3 		ON t3.FCalID = u1.FCalID AND t3.FInterID >0 
				   AND t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime
				   + u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))
				   + (CASE WHEN v2.FOffSetDay > 0 THEN CEILING(v2.FOffSetDay) ELSE FLOOR(v2.FOffSetDay) END )) 
	 LEFT JOIN t_MutiWorkCal 	T10 	ON t10.FCalID=Isnull(t2.FCalID,999)
				   AND T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE t1.FDeleted=0 AND (((v2.FMaterielType=371 OR v2.FMaterielType=375)))
				 AND u1.FIsCharSourceItem = 0 AND u1.FCharConfigID = 0     --过滤掉特性来源物料和特性物料  

		 --- FROM ICCustChild
	IF @BomLevel >= 0 
	BEGIN 
	INSERT INTO #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,FParentID,FRate,FFixLeadTime
		 ,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy,FHaveBomOpen,FObjID,FOperID,FMaterielType
		 ,FMarshalType,FSumLeadTime,FSumParentTime,FLeadTime,FBatChangeEconomy,FSecInv,FBEGINDate,FEndDate
		 ,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID,FCalID, FDayID, FBOM ) 
	SELECT  u1.FParentItemID,v2.FItemID, 
	 t10.FPreDay AS FNeedDate,
		round(
			convert(decimal(28,15),
				(convert(decimal(28,15),u1.FNeedQty) * 
				 	convert(decimal(28,15),
					 	round(
						  convert( decimal(28,15),v2.FQty ) / convert( decimal(28,15),v1.FQty )
					 		,t1.FQtyDecimal + 4)
				 			)))*
			convert(decimal(28,15),
			(convert( decimal(28,15),(v2.FPercent /100) ) ))
			,t1.FQtyDecimal + 4)   AS FNeedQty, 
		round(
		convert(decimal(28,15),
			(convert(decimal(28,15),u1.FRelNeedQty) * 
				 convert(decimal(28,15),
					 round(
						  convert( decimal(28,15),v2.FQty ) / convert( decimal(28,15),v1.FQty )
					 ,t1.FQtyDecimal + 4)
				 )
			)
		)*
		convert(decimal(28,15),
			(
				convert( decimal(28,15),(v2.FPercent /100) )
	            
			)
		)
		,t1.FQtyDecimal + 4)   AS FRelNeedQty,(@BOMLevel +1) FBomLevel
		, (CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' 
		THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END)  FItemtype,u1.FIndex FParentID
		, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate
		,t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL')
		,(CASE WHEN (v2.FMaterielType=371 OR v2.FMaterielType=375) THEN 0 ELSE 1 END ) FMeterialType
		,u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0)
		,(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime,t1.FLeadTime
		,T1.FBatChangeEconomy,T1.FSecInv,v2.FBEGINDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID
		,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID ,IsNull(t2.FCalID,'999') AS FCalID
		,t10.FPreID AS FDayID,ISNULL(V2.FCustBOMCode,0) AS FBOM      
	FROM ( SELECT * FROM #BomData 
		WHERE FBomLevel = @BomLevel AND FHaveBomOpen = 0 AND FItemType > 0   AND FNeedQty>0 
		) 					 u1
	 JOIN ICBOM 			 v1      ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType=3                   
	 JOIN ICCustBOMChild 	 V2  	ON V1.FInterID=V2.FInterID 
	 JOIN T_ICItem 			 t1    	ON V2.FItemID=T1.FItemID                                                             
	 JOIN t_SubMessage 		 t5    	ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      	--子项物料类型                 
	 LEFT JOIN t_Submessage  t5_1  	ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage  t5_2  	ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage  t5_3  	ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage  t5_4  	ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	 LEFT JOIN t_Department  t2 	ON T1.FSource=t2.FItemID AND T1.FErpClsID  in (2,7,9)   
	 LEFT JOIN t_MutiWorkCal t3 	ON t3.FCalID = u1.FCalID AND t3.FInterID >0 
				   AND t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime
				   + u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (CASE WHEN v2.FOffSetDay > 0 
				   THEN CEILING(v2.FOffSetDay) ELSE FLOOR(v2.FOffSetDay) END )) 
	 LEFT JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)  AND T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE t1.FDeleted=0 AND (((v2.FMaterielType=371 OR v2.FMaterielType=375)))
     END 
-------------------------------------特性配置处理开始------------------------------------------
	--1. --创建临时表
	--判断是否有特性来源物料/特性物料存在
	IF EXISTS ( SELECT 1 FROM #BomData WHERE FBomLevel = @BomLevel AND (FIsCharSourceItem=1 OR FcharConfigID>0) )
	BEGIN

	--2. 处理父项为特性配置来源物料(特性物料的公用件也一样)
	INSERT INTO #BomData
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,FParentID,FRate
		 ,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,FHaveBomOpen,FObjID,FOperID
		 ,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,FLeadTime,FBatChangeEconomy,FSecInv
		 ,FBEGINDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, FBOM
		 , FIsCharSourceItem, FSourceItemID, FCharConfigID 	,FCalID, FDayID 
		 ) 
		 SELECT u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay AS FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (CASE WHEN (v2.FMaterielType=371 OR v2.FMaterielType=375) THEN 0 ELSE 1 END ) FMeterialType, --FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBEGINDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	v2.FDetailID,0 AS FBOM  
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 

		 FROM ( SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel AND FHaveBomOpen = 0 AND FItemType > 0 
				 AND FNeedQty>0 
				 AND ( FIsCharSourceItem=1 OR FcharConfigID>0 )     --特性来源物料和特性物料  
	) u1
	 JOIN ICBOM 				v1      ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	 JOIN ICBOMChild 			V2  	ON V1.FInterID=V2.FInterID 
	 JOIN T_ICItem 				t1    	ON V2.FItemID=T1.FItemID  
	 JOIN t_SubMessage 			t5    	ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage 	t5_1  	ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage 	t5_2  	ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage 	t5_3  	ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage 	t5_4  	ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN ICPlan_CharConfig t6 		ON V2.FItemID = t6.FItemID  AND t6.FCheckerID > 0  
	LEFT JOIN t_Department 		t2 		ON T1.FSource=t2.FItemID AND T1.FErpClsID  in (2,7,9)   
	 LEFT JOIN t_MutiWorkCal 	t3 		ON t3.FCalID = u1.FCalID AND t3.FInterID >0 
				   AND t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (CASE WHEN v2.FOffSetDay > 0 THEN CEILING(v2.FOffSetDay) ELSE FLOOR(v2.FOffSetDay) END )) 
	 LEFT JOIN t_MutiWorkCal 	T10 	ON t10.FCalID=Isnull(t2.FCalID,999)
				   AND T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE  t1.FDeleted=0  AND V2.FhasChar=0  --先只处理没有特性的公用件 
	 AND (((v2.FMaterielType=371 OR v2.FMaterielType=375)))

	--3. 处理父项为特性物料:
	--    3.2 插入子项数据
	INSERT INTO #TempBomOpen_Char 
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBEGINDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay,  FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	)
		  SELECT u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay AS FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (CASE WHEN (v2.FMaterielType=371 OR v2.FMaterielType=375) THEN 0 ELSE 1 END ) FMeterialType,--FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBEGINDay,V2.FEndDay, u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	 0 AS FBOM 
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID, v2.FDetailID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 

		 FROM ( SELECT * FROM #BomData 
			   WHERE FBomLevel 		= @BomLevel AND FHaveBomOpen = 0 AND FItemType > 0 
				 AND FNeedQty    	>0 
				 AND FcharConfigID	>0     --特性物料  
	) u1
	 JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3  
	 JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID 
	 JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID  
	 JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN ICPlan_CharConfig t6 ON V2.FItemID = t6.FItemID AND t6.FCheckerID > 0 
	LEFT JOIN t_Department t2 ON T1.FSource=t2.FItemID AND T1.FErpClsID  in (2,7,9)   
	 LEFT JOIN t_MutiWorkCal t3 ON t3.FCalID = u1.FCalID AND t3.FInterID >0 
				   AND t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (CASE WHEN v2.FOffSetDay > 0 THEN CEILING(v2.FOffSetDay) ELSE FLOOR(v2.FOffSetDay) END )) 
	 LEFT JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)
				   AND T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 
	AND t1.FDeleted=0 
	 AND V2.FhasChar > 0  --有特性的子项 
	 AND (((v2.FMaterielType=371 OR v2.FMaterielType=375)))

	IF EXISTS ( SELECT 1 FROM #TempBomOpen_Char WHERE FBomLevel= @BOMLevel +1 ) --判断该层是否有特性物料
	BEGIN
	--3.3 根据特性值过滤有特性的子项
	-- 取得符合条件的有特性的Bom子项
	DELETE t1 FROM #TempBomOpen_Char t1 
		LEFT JOIN 
	(
	 SELECT FIndex /* ,FParentItemID,FBom,FITEMID,FSourceItemID, COUNT(*) */ 
	FROM
	(
	 SELECT FIndex,FParentItemID,FBom,FITEMID,FSourceItemID, FCHARID,COUNT(*) FCOUNT FROM
	(
		 SELECT U.FIndex,u3.FItemID AS FParentItemID, U.FBom,U.FITEMID,U.FSourceItemID,U.FCharConfigID,D.FCHARID AS D_FCHARID,D.FCHARVALID,E.FNAME ,
			V.FCHARID AS FCHARID,b3.FCharID AS b3_FCharID,b3.FCharValID AS x_FCharValID
		-- SELECT *
		FROM #TempBomOpen_Char U
		Full JOIN --BOM子项外关联特性, 使每个子项都有该BOM全部的特性(BOM子项的特性  union 表头特性物料特性)
		(    SELECT DISTINCT FSourceItemID,FCharID FROM #TempBomOpen_Char a1
				 JOIN ICPlan_BOMChildChar b1 ON a1.FDetailID=b1.FDetailID WHERE a1.FBOMLevel=@BomLevel+1
			Union
			 SELECT DISTINCT b2.FSourceItemID,c2.FCharID
				FROM #BomData /*#TempBomOpen_Char*/ a2
				 JOIN icplan_CharConfig b2 ON a2.FCharConfigID=b2.Fid
				 JOIN icplan_charconfigEntry c2 ON b2.fid=c2.fid
				WHERE a2.FBOMLevel=@BomLevel
		)  V ON  U.FSourceItemID=v.FSourceItemID
		Left  JOIN  ICPlan_BOMChildChar D --获得BOM子项的特性值
			ON  U.FDetailID=D.FDetailID AND V.FCharID=d.FCharID
		LEFT JOIN ICPlan_CharacteristicEntry E ON D.FCHARVALID=E.FCHARVALID
	   --获得父项的特性过滤条件
		 JOIN #BomData AS u3 ON U.FParentID=u3.FIndex AND u3.FBOMLevel=@BOMLevel --父项物料
		LEFT JOIN icplan_CharConfig a3 ON u3.FItemID=a3.FItemID AND a3.FCheckerID > 0 
		LEFT JOIN icplan_charconfigEntry b3 ON a3.fid=b3.fid AND D.FCHARID=b3.FCHARID --特性匹配
		WHERE ( 1=1 AND U.FBOMLevel=@BOMLevel + 1
		AND ISNULL(D.FCHARVALID,0)=0 OR ISNULL(b3.FCHARVALID,0)=0 OR D.FCHARVALID=b3.FCHARVALID
		)  --ORDER BY   B.FINTERID,B.FENTRYID,B.FITEMID, V.FCHARID
	) M GROUP BY  FIndex,FParentItemID,FBom,FITEMID,FSourceItemID, FCHARID
	) N GROUP BY FIndex,FParentItemID,FBom,FITEMID,FSourceItemID
	HAVING COUNT(*) >=
		  (  SELECT COUNT(*) FROM
			  (    SELECT DISTINCT FSourceItemID,FCharID FROM #TempBomOpen_Char a1
					   JOIN ICPlan_BOMChildChar b1 ON a1.FDetailID=b1.FDetailID WHERE a1.FBOMLevel=@BomLevel+1
				   Union
				    SELECT DISTINCT a2.FSourceItemID,c2.FCharID
				   FROM #BomData /*#TempBomOpen_Char*/ a2
					    JOIN icplan_CharConfig b2 ON a2.FCharConfigID=b2.Fid
					    JOIN icplan_charconfigEntry c2 ON b2.fid=c2.fid
				   WHERE a2.FBOMLevel=@BomLevel
			  )   P
			WHERE P.FSourceItemID = N.FSourceItemID
			GROUP BY  FSourceItemID
		  )
	) t2 ON t1.FIndex=t2.FIndex 
	 WHERE t1.FBomLevel= @BOMLevel +1 AND t2.FIndex is Null 
	--3.4 将#TempBomOpen_Char的数据, INSERT INTO 到sDestTable

	INSERT INTO #BomData
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBEGINDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay,  FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	) 
	    SELECT  
		 FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBEGINDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	FROM #TempBomOpen_Char     WHERE FBomLevel= @BOMLevel +1

	END  --判断该层是否有特性物料

	--'更新sDestTable表的BOM信息
	UPDATE A
		SET  FBOM = C.FInterID , FBomSkip=C.FBomSkip
	FROM  #BomData  A
	    JOIN ICBOM C ON A.FItemID = C.FItemID
	WHERE A.FBOMLevel= @BOMLevel +1 AND A.FBom = 0  AND C.FUseStatus = 1072
	--5.  更新所有子项为特性配置来源物料, 根据BOM和特性来判断是否已有特性物料，如果有则更新为特性物料。

	--5.1 若是子项有特性来源物料，需要继承特性，保存到#TmpChar（参考GetCharBomOpen函数）
		--(子项没有父项的特性,则该特性被过滤
		--子项有父项没有的特性, 则特性值为空)
	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	 SELECT A1.FIndex, C2.FcharID, B2.FCharValID
	FROM #BomData A1  --子项
		 JOIN ICPLAN_ItemChar C1 ON A1.FItemID=C1.FItemID  --子项特性范围表
		 JOIN ICPLAN_ItemCharEntry C2 ON C1.FID=C2.FID
		 JOIN #BomData  A2  ON A1.FParentID =A2.FIndex --父项
		LEFT JOIN #TempChar  B2  ON A2.Findex=B2.Findex  --父项特性
				AND C2.FCharID=B2.FCharID   --过滤子项才有的特性
		WHERE A1.FBomLevel=@BomLevel + 1 AND A1.FIsCharSourceItem = 1 AND B2.FCharValID > 0 
		ORDER BY  A1.FIndex, C2.FCharID, B2.FCharValID

		--5.2 根据BOM和特性来判断是否已有特性物料
		UPDATE #BomData
		   SET FCharConfigID=B.FID, FItemID=B.FItemID, FSourceItemID=B.FSourceItemID, FBom=FBomInterID, FIsCharSourceItem = 0 
		   ,FFixLeadTime=T1.FFixLeadTime, FSumLeadTime=isnull(t1.FTotalTQQ,0) 
		   ,FLeadTime=t1.FLeadTime, FBatChangeEconomy=T1.FBatChangeEconomy, FSecInv=T1.FSecInv
		   ,FItemtype=(CASE t5.FID WHEN 'WG' THEN 0 WHEN 'ZZ' THEN 1 WHEN 'WWJG' THEN 1 WHEN 'PZL' THEN 4 WHEN 'XNJ' THEN 10  WHEN 'TZL' THEN 5 ELSE 6 END)
		   ,FPlanTrategy=isnull(t5_1.FID,'MRP')
		   ,FOrderTrategy=isnull(t5_2.FID,'LFL')
		-- SELECT B.FID,C.FID,*
			FROM #BomData A
			 JOIN ICPlan_CharConfig B ON A.FItemID=B.FSourceItemID AND B.FCheckerID > 0 
			LEFT JOIN   --也可以处理成NOT IN 语句
			(    --查询出有特性不匹配的特性方案
			 SELECT DISTINCT FIndex,FID FROM
				(
				 SELECT  A1.Findex,CASE WHEN B1.FID IS NULL THEN B2.FID ELSE B1.FID END AS FID,
						B1.FITEMID,B1.FSOURCEITEMID,A2.FcharValID AS FSourceCharValID, B2.FcharValID AS FCharValID
				FROM  ( SELECT * FROM #BomData WHERE FBOMLevel=@BOMLevel+1 AND FCharConfigID=0 ) A1
				 JOIN #TempChar A2 ON A1.Findex= A2.FIndex
				 JOIN  ICPlan_CharConfig B1 ON A1.FitemID=B1.FsourceItemID AND A1.FBOM=B1.FBOMInterID AND B1.FCheckerID > 0 
				FULL JOIN ICPlan_CharConfigEntry B2  ON B1.FID = B2.FID AND  A2.FCharValID= B2.FCharValID
					WHERE (A2.FcharValID Is Null OR B2.FcharValID Is Null)
				) AS M
			)  C  ON  (A.FIndex=c.FIndex OR c.findex is null) AND B.FID=C.FID
		    JOIN T_ICItem t1    ON B.FItemID=T1.FItemID -- AND t1.FDeleted = 0 
		    JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
		   LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
		   LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
		WHERE C.FID IS NULL AND A.FBOMLevel= @BOMLevel+1 AND A.FIsCharSourceItem = 1 AND A.FCharConfigID=0

			AND EXISTS ( SELECT 1 FROM #TempChar X WHERE A.FIndex=X.FIndex) 

	AND t1.FDeleted=0 

	END              ----判断是否有特性来源物料/特性物料存在

	--更新特性物料的相关信息
	UPDATE A
		SET  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FCharConfigID= isnull(b.Fid,0), 
		FSourceItemId=t1.FCharSourceItemId 
	FROM  #BomData  A 
	    JOIN t_icItemPlan t1 ON A.FItemID=t1.FItemID 
	   LEFT JOIN ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0 --特性方案 
	    JOIN ICBOM C ON B.FBomInterID = C.FInterID 
			WHERE A.FBomLevel = @BOMLevel +1 AND T1.FCharSourceItemId > 0 
	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	 SELECT A1.FIndex,C2.FCharID, C2.FCharValID
	FROM #BomData A1  --子项
		 JOIN ICPlan_CharConfig C1 ON A1.FItemID=C1.FItemID AND C1.FCheckerID > 0  --特性配置方案
		 JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	WHERE  A1.FBomLevel = @BOMLevel + 1 AND   A1.FCharConfigID>0 
	-------------------------------------特性配置处理结束------------------------------------------

	 UPDATE v1 SET v1.FBom = u1.FInterID, v1.FBomSkip=u1.FBomSkip 
	 FROM #BomData v1, ICBom u1 
	 WHERE v1.FBomLevel = @BomLevel + 1 AND v1.FItemType > 0 AND v1.FItemID = u1.FItemID 
	 AND isnull(v1.FBom,0) = 0 AND u1.FBomType <> 3 AND u1.FUseStatus = 1072
		 UPDATE #BomData SET FHaveBomOpen = 1 
		 WHERE FBomLevel = @BomLevel AND FHaveBomOpen = 0 AND FItemType > 0 AND FNeedQty>0 
		  SELECT @BomLevel = @BomLevel + 1 
		  SELECT @selectrows = 0
		  SELECT @selectrows = isnull(count(*),0) FROM #BomData     WHERE FHaveBomOpen = 0 AND FBomLevel = @BomLevel AND FItemType > 0 
		 AND FNeedQty>0 
	 END 

	 Delete FROM #BomData WHERE (FItemType = 10 OR FItemType = 5 OR (FBomSkip=1058 AND FBomLevel> 0)  )
	----跳层为是,则按虚拟件处理 
	UPDATE #BomData SET FItemType = 10 WHERE FBomSkip=1058 

	DROP TABLE #TempChar 
	DROP TABLE #TempBomOpen_Char 

	 -------------- BOM展开嵌套SQL 结束 ------------------------------------
	--planprice
	 INSERT INTO #ITEMPRICE (FItemID,FPlanPrice) 
	  SELECT v1.FItemID,isnull(t1.FPlanPrice,0) 
	 FROM ( SELECT FItemID,sum(FNeedQty) FNeedQty
		   FROM #BomData WHERE FBomLevel > 0 AND FItemType =0
		   GROUP BY FItemID) v1 
		   left outer JOIN  t_ICItem t1 ON v1.FItemID =t1.FItemID  
    --average price
	 UPDATE u1 SET u1.FLastPrice = u2.avrprice 
	 FROM #ITEMPRICE 	u1 	 
	 JOIN ( SELECT b.fitemid,b.funitid,sum(b.fstdamount) AS funtaxamount, sum(b.fqty) AS fqty
			,CASE  WHEN sum(b.fqty)>0 THEN round(sum(b.fstdamount)/sum(b.fqty),tt1.FPriceDecimal) ELSE 0 END AS avrprice
			FROM icpurchase a JOIN icpurchaseentry b ON a.FInterID = b.FInterID AND ( a.ftrantype = 75 OR a.ftrantype = 76 )
			JOIN t_Icitem 		tt1 	on b.FItemID = tt1.FItemID
			WHERE a.fcheckdate > dateadd(year,-1,dateadd(day,datedIFf(day,0,getdate()),0)) 
			AND isnull(b.fqty , 0)<> 0 AND isnull(b.fstdamount ,0) <> 0 
			AND a.fstatus = 1 AND a.frob =1 AND (isnull(fheadselfi0252,0) =0 OR isnull(fheadselfi0349,0 ) = 0)
			GROUP BY b.fitemid,b.funitid
			) 			u2 		on  u1.FItemID = u2.FItemID  
	
	UPDATE #ITEMPRICE SET FNewPrice =isnull(FLastPrice,isnull(fplanprice,0) )
	--INSERT INTO bomcost
	INSERT INTO #BomCost(FParentItemid ,FItemID,FNumber,FShortNumber,FName,FUnitName,QtyDecimal,PriceDecimal
		 ,  FModel,FQty,FPlanPrice,FPlanAmount,FLastPrice,FLastAmount,FNewPrice,FNewAmount) 
	  SELECT V1.FParentItemID,v1.FItemID,t1.FNumber,t1.FShortNumber,t1.FName,t2.FName FUnitName,t1.FQtyDecimal,t1.FPriceDecimal,
	  isnull(t1.FModel,'') FModel,(convert(decimal(28,15),v1.FNeedQty) * convert(decimal(28,15),u1.FQty)) Fqty ,v2.FPlanPrice,0.0 FPlanAmount,
	  v2.FLastPrice,0.0 FLastAmount, 
	  v2.FNewPrice, 0.0 FNewAmount 
	 FROM ( SELECT FParentItemID, FItemID, sum(FNeedQty) FNeedQty
		   FROM #BomData WHERE FBomLevel > 0 AND FItemType =0 
		   GROUP BY FParentItemID, FItemID)  	v1
	JOIN #ItemPrice 							v2 ON v1.FItemID = v2.FItemID
	JOIN #ParentData 							u1 ON v1.FParentItemID = u1.FItemID
	JOIN t_IcItem 								t1 ON v1.FItemID = t1.FItemID 
	JOIN t_MeasureUnit 							t2 ON t1.funitid=t2.fitemid
	ORDER BY  t1.FNumber 
	--UPDATE amount
	 UPDATE v1 SET v1.FPlanAmount =convert(decimal(28,15),v1.Fplanprice) * convert(decimal(28,15),v1.Fqty), 
	   v1.FLastAmount = convert(decimal(28,15),v1.FLastPrice) * convert(decimal(28,15),v1.FQty), 
	   v1.FNewAmount =  convert(decimal(28,15),v1.FnewPrice) * convert(decimal(28,15),v1.FQty) 
	 FROM #BomCost v1 
	 JOIN t_ICItem t1 ON v1.FItemID = t1.FItemID
 
 
 ---将纸箱价格清空
 UPDATE #BomCost
 SET FNewPrice=0,FNewAmount=0
 WHERE FItemID in(  SELECT c.FItemID FROM #BomCost a
 					 JOIN t_ICItem b ON a.FParentItemid =b.FItemID 
 					 JOIN t_ICItem c ON c.FItemID =a.FItemID 
 				WHERE (substring(c.FModel,len(c.FModel)-1,2))='90' AND (A.FName  LIKE '%纸箱%' OR A.FName  LIKE '%包装箱%') 
 					)
 
 INSERT INTO #BomCost(FParentItemid ,FNumber,FShortNumber,FQty,FPlanAmount,FLastAmount,FNewAmount)
  SELECT FParentItemid ,'合计','合计',sum(v1.FQty), sum(v1.FPlanAmount),Sum(v1.FLastAmount),sum(v1.FNewAmount) 
 FROM #BomCost v1  GROUP BY FParentItemid 
 
 ------------------成本BOM 查询结束------------------
 
 ------------将结果显示出来-------------------  
 IF @FQufn ='A'
 BEGIN
	   SELECT a.FItemID ,b.FNumber, b.FName,isnull(b.FModel,'') AS FModel
		   , k.FName AS FErpClsName,isnull(d.fname,'') AS FUnitID
		   , a.FQty, a.FYield, a.FUseStatus AS FUseStatusNum
		   , (CASE a.FUseStatus WHEN 1072 THEN '使用' ELSE '未使用' END) AS FUseStatus
		   , a.FVersion,b.FChartNumber,i.FRoutingName AS FRoutingID 
		   , isnull(g.Fname,'') AS  FCheckID,  a.FCheckDate,isnull(h.fname,'') AS FOperatorID
		   , a.FEnterTime,a.FNote,round(b.FPlanPrice,b.FPriceDecimal) FPlanPrice
		   , round(CAST( a.FQty AS Decimal(28,15)) * CAST( b.FPlanPrice AS DECIMAL(28,15)),b.FPriceDecimal) AS FPlanAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( b.FPlanPrice AS DECIMAL(28,15) ) InitFPlanAmount
		   , a.FitemID EditFitem,b.FQtyDecimal FQtyDecimal,b.FQtyDecimal FInitDecimal,b.FPriceDecimal
		   --20180201
		   , isnull(u2.avrprice,isnull( b.FPlanPrice ,0) ) FNewPrice
		   , round(CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(u2.avrprice,isnull( b.FPlanPrice ,0) ) AS DECIMAL(28,15) ),b.FPriceDecimal) AS FNewAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(u2.avrprice,isnull( b.FPlanPrice ,0) ) AS DECIMAL(28,15) ) AS FInitNewAmount 
		    --
		    , isnull(convert(varchar(20),convert(decimal(28,2),e.FNewAmount)),0) FNewAmount_detail
		   , isnull(e.FNewAmount,0) InitFNewAmount_detail
		   , ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
		   ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要再取值了
		   , (CASE WHEN ISNULL(s1.FName,'N')='N' THEN
				  (CASE WHEN b.FLength>0 THEN ROUND(((ISNULL(b.FLength,0)+ISNULL(b.FWidth,0))*0.001+0.08+0.018)*((ISNULL(b.FWidth,0)*2+ISNULL(b.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				   ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				   ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
				   ELSE 0 END)
			  ELSE 0 END)  AS 小箱套价格  ---不含税单价
		   , round(ISNULL(E.FPlanAmount,0)+(CASE WHEN ISNULL(s1.FName,'N')='N' THEN (CASE WHEN b.FLength>0 THEN ROUND(((ISNULL(b.FLength,0)+ISNULL(b.FWidth,0))*0.001+0.08+0.018)*((ISNULL(b.FWidth,0)*2+ISNULL(b.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2)
				 ELSE 0 END) ELSE 0 END),2)  AS tot_amount
		   , CASE WHEN (f.con1 >0 OR f2.con1 IS null) THEN 'N' ELSE 'Y' END AS QFCN1
		   , s1.FName AS BOM_YN
	 FROM 			icbom 		a 
	 JOIN	t_icitem 		b ON (a.FItemID = b.FItemID) 
	 JOIN	#ParentData 	c 	on c.FBom=a.FInterID AND c.FItemID =a.FItemID  
	 LEFT JOIN	T_MeasureUnit 	d 	on (b.FUnitID = d.FItemID) 
	 LEFT JOIN t_user 			g 	on (a.FCheckID = g.FUserID ) 
	 LEFT JOIN t_user 			h 	on (a.FOperatorID = h.FUserID) 
	 LEFT JOIN T_routing 		i 	on (a.FRoutingID = i.FInterID)
	 LEFT JOIN (
	 /* 
	  * 20180201 
	  */
		 SELECT b.fitemid,b.funitid,sum(b.fstdamount) AS funtaxamount, sum(b.fqty) AS fqty
			,CASE  WHEN sum(b.fqty)>0 THEN round(sum(b.fstdamount)/sum(b.fqty),4) ELSE 0 END AS avrprice
			FROM icpurchase a JOIN icpurchaseentry b ON a.FInterID = b.FInterID AND ( a.ftrantype = 75 OR a.ftrantype = 76 )
			WHERE a.fcheckdate > dateadd(year,-1,dateadd(day,datedIFf(day,0,getdate()),0)) 
			AND isnull(b.fqty , 0)<> 0 AND isnull(b.fstdamount ,0) <> 0 
			AND a.fstatus = 1 AND a.frob =1 AND (isnull(fheadselfi0252,0) =0 OR isnull(fheadselfi0349,0 ) = 0)
			GROUP BY b.fitemid,b.funitid
			 ) 						u2 	on a.FItemID  = u2.FItemID 
	  LEFT JOIN t_submessage 	k 	on k.FINTERID=b.Ferpclsid 
	  LEFT JOIN #BomCost 	e 	on e.FParentItemid =a.FItemID  AND e.FNumber ='合计'
	  LEFT JOIN ( ----有详细内容的里面有为零的
			 SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
			WHERE FNumber <>'合计' AND isnull(FPlanAmount,0)=0
			GROUP BY FParentItemid 
			) 					f 	on f.FParentItemid =a.FItemID  
	  LEFT JOIN (  ---没有任何详细内容的
			 SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
			WHERE FNumber <>'合计' 
			GROUP BY FParentItemid 
			)					f2 	on f2.FParentItemid =a.FItemID  
	  LEFT JOIN t_SubMessage s1 ON s1.FParentID='10012' AND s1.FInterID =a.FHeadSelfZ0134 
	  ORDER BY  B.FNumber
   
   END
   ELSE IF @FQufn ='B'
   BEGIN
		 SELECT a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' ELSE '' END) AS FErpClsnm
			 , ROUND(((ISNULL(c.FLength,0)+ISNULL(c.FWidth,0))*0.001+0.08+0.018)*((ISNULL(c.FWidth,0)*2+ISNULL(c.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 AS 小箱套价格	  ---不含税单价
		FROM #BomCost A
		LEFT JOIN t_ICItem b ON a.FItemID =b.FItemID 
		LEFT JOIN t_ICItem c ON c.FItemID =a.FParentItemid 
		WHERE FParentItemid =@FParentItemid
		ORDER BY  FParentItemid , FIndex    
   
   END 
   ELSE IF @FQufn ='C'
   BEGIN
		 SELECT c.FNumber AS fparent_fnumber,c.FName AS fparent_fname
		     , a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' ELSE '' END) AS FErpClsnm
			 , ROUND(((ISNULL(c.FLength,0)+ISNULL(c.FWidth,0))*0.001+0.08+0.018)*((ISNULL(c.FWidth,0)*2+ISNULL(c.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 AS 小箱套价格		  ---不含税单价
		FROM #BomCost A
		LEFT JOIN t_ICItem b ON a.FItemID =b.FItemID 
		LEFT JOIN t_ICItem c ON c.FItemID =a.FParentItemid 
		ORDER BY  C.FNumber, FIndex    
   
   END 
   ELSE IF @FQufn ='Z'
   BEGIN
   
		 SELECT C.FNumber AS 客户代码, c.FName AS 客户名称, I.FMapNumber AS 客户对应物料代码
			 , I.FMapName AS 客户对应物料名称, B.FNumber AS 物料代码
			 , B.FName AS 物料名称 ,B.F_146 AS 英文名称,B.FModel AS 规格型号, d.FName AS 辅助属性
			 , E.FNumber AS 计量单位代码, E.FName AS 计量单位
			 , B.F_131 AS 'OE代码', B.F_132 AS 'DPI代码', J.FName AS '产品结构形式' 
			 , J2.FName AS '芯体颜色标准', A.FBegQty AS '销货量(从)', A.FEndQty AS '销货量(到)'
			 , F.FNumber AS 币别代码, f.FName AS 币别
			 , G.FID AS 价格类型代码 , g.FName AS 价格类型
			 , A.FPrice AS 报价, F2.FName AS 最低限价币别, A2.FLowPrice AS 最低限价金额
			 , b2.FPlanAmount_detail  AS 成本价, b2.小箱套价格不含税
			 , CONVERT(CHAR(10),A.FBegDate,120) AS 生效日期, CONVERT(CHAR(10),a.FEndDate,120) AS 失效日期
			 , A.FLeadTime AS 销售提前期, A.FNote AS 备注
			 , (CASE WHEN A.FChecked=1 THEN '是' ELSE '否' END) AS 审核标志
			 , (CASE WHEN A2.FCanSell=1 THEN  '是' ELSE '否' END) AS 允许销售
			 , (CASE WHEN A2.FLPriceCtrl=1 THEN '是' ELSE '否' END) AS 最低价格控制
			 , H.FName AS 维护人, CONVERT(CHAR(10),A.FMaintDate,120) AS 维护日期, H2.FName AS 审核人
			 , (CASE WHEN CONVERT(DATETIME, a.FCheckDate) = '1900-01-01' THEN NULL ELSE CONVERT(CHAR(10),a.FCheckDate,120)  END) AS 审核日期
			 , B.FSize AS 包装箱体积
			 , (  SELECT top 1 isnull(FExchangeRate,0)  FROM t_ExchangeRateEntry  WHERE FExchangeRateType=1 AND GETDATE() between FBegDate AND FEndDate AND FCyTo =1000) AS 美元汇率
			 , (A.FPrice*(  SELECT top 1 isnull(FExchangeRate,0)  FROM t_ExchangeRateEntry  WHERE FExchangeRateType=1 AND GETDATE() between FBegDate AND FEndDate AND FCyTo =1000)
			 	 - b2.FPlanAmount_detail-b2.小箱套价格不含税 ) AS 边际利润
			 , b2.QFCN1, b2.BOM_YN 
		  FROM ICPrcPlyEntry A
		 JOIN ICPrcPlyEntrySpec A2 ON A.FInterID = A2.FInterID AND A.FItemID = A2.FItemID AND A.FRelatedID = A2.FRelatedID
		 JOIN ICPrcPly A3 ON A3.FInterID =A.FInterID
		 JOIN t_ICItem B ON A.FItemID =B.FItemID 
		 LEFT  JOIN t_Organization C ON a.FRelatedID=C.FItemID AND C.FItemID<>0
		  LEFT JOIN t_AuxItem D ON A.FAuxPropID=D.FItemID AND D.FItemID<>0							--辅助属性
		  LEFT JOIN t_Measureunit E ON A.FUnitID=E.FItemID AND E.FItemID<>0							--单位
		  LEFT JOIN t_Currency F ON A.FCuryID=F.FCurrencyID AND F.FCurrencyID<>0						--币别
		  LEFT JOIN t_Currency F2 ON A2.FLPriceCuryID=F2.FCurrencyID AND F2.FCurrencyID<>0			--最低限价币别
		  LEFT JOIN t_SubMessage G ON A.FPriceType=G.FInterID AND G.FInterID<>0						--价格类型
		  LEFT JOIN t_User H ON A.FMainterID=H.FUserID AND H.FUserID<>0								--维护人
		  LEFT JOIN t_User H2 ON A.FCheckerID=H2.FUserID AND H2.FUserID<>0
		  LEFT JOIN ICItemMapping I ON B.FItemID = I.FItemID AND I.FPropertyID = 1 AND A.FRelatedID = I.FCompanyID
		  LEFT JOIN t_SubMessage J ON J.FParentID =10007 AND J.FInterID =B.F_134
		  LEFT JOIN t_SubMessage J2 ON J2.FParentID=10008 AND J2.FInterID = B.F_135
		  LEFT JOIN (
				 SELECT a.FItemID, ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
					 ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要在取值了
					 , (CASE WHEN ISNULL(s1.FName,'N')='N' THEN 
					        (CASE WHEN b.F_119>0 THEN ROUND(((ISNULL(b.F_119,0)+ISNULL(b.F_120,0))*0.001+0.08+0.018)*((ISNULL(b.F_120,0)*2
					        +ISNULL(b.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)
					        +ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
								ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1
								+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
						     ELSE 0 END)
						 ELSE 0 END)  AS 小箱套价格不含税
					 , CASE WHEN (f.con1 >0 OR f2.con1 IS null) THEN 'N' ELSE 'Y' END AS QFCN1
					 , S1.FName AS BOM_YN
				FROM icbom a 
				JOIN t_icitem b ON (a.FItemID = b.FItemID) 
				JOIN #ParentData c ON c.FBom=a.FInterID AND c.FItemID =a.FItemID  
				LEFT JOIN #BomCost e ON e.FParentItemid =a.FItemID  AND e.FNumber ='合计'
				LEFT JOIN ( ----有详细内容的里面有为零的
					 SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
					WHERE FNumber <>'合计' AND isnull(FPlanAmount,0)=0
					GROUP BY FParentItemid 
				) f ON f.FParentItemid =a.FItemID  
				LEFT JOIN (  ---没有任何详细内容的
					 SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
					WHERE FNumber <>'合计' 
					GROUP BY FParentItemid 
				)f2 ON f2.FParentItemid =a.FItemID 
				LEFT JOIN t_SubMessage s1 ON s1.FParentID='10012' AND s1.FInterID =a.FHeadSelfZ0134 
			) b2 ON b2.FItemID =a.FItemID  
		  WHERE a.FInterID=4  AND B.FDeleted=0
		  AND c.fnumber=@FCusNo
		  AND (B.FNAME  LIKE '%'+ISNULL(@FName,'') +'%' OR B.FModel  LIKE '%'+ ISNULL(@FName,'')+'%' 
		  OR b.Fnumber  LIKE '%'+ ISNULL(@FName,'')+'%' )
		  ORDER BY  B.FNumber
  
  END
 -----------将临时表删除
 DROP TABLE #ItemPrice , #BomCost ,#ParentData ,#BomData 
	
END

