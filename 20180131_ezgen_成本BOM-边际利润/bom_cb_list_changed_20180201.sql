/*
 * DATE:			2018/2/01
 * AUTHOR:			RENBO
 * DESCRIPTIONS:	get planprice order:蓝字采购发票过去一年的平均不含税价格,计划价格
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
 * exec DBO.BOM_cb_list_changed_20180201  '34017-b','','A',0,'2014-11-01'   表头
 * exec DBO.BOM_cb_list_changed_20180201  '34017-b','','B',149879,'2014-11-01'   表体
 */

Alter PROCEDURE [dbo].[bom_cb_list]
	@FName				NVARCHAR(255),
	@FCusno				NVARCHAR(255),
	@FQufn				NVARCHAR(1),
	@FParentItemid		INT,
	@FDate				NVARCHAR(8)
	
AS
BEGIN
SET NOCOUNT ON 
declare @fexchangerrate decimal(13,8)				--汇率
declare @MinDate smalldatetime,@MaxDate smalldatetime
declare @MinDayID int, @MaxDayID int
	
SELECT @fexchangerrate = fexchangerate FROM t_exchangerateentry 
WHERE fcyfor = 1 and fcyto = 1000 and fenddate > getdate() and fexchangeratetype = 1
	
	Create Table #ITEMPRICE(						-- itemprice
		 FIndex int IDENTITY, 
		 FItemID int null, 
		 FLastQty decimal(28,8) default(0) null, 
		 FLastAmount decimal(28,8) default(0) null, 
		 FPlanPrice decimal(28,8) default(0) null, 
		 FLastPrice decimal(28,8) default(0) null,
		 FNewPrice decimal(28,8) default(0) null) 
	create  index #idx_FItemID ON #ITEMPRICE(FItemID)

	Create Table #ITEMSTOCKPRICE(					--stock price
		 FIndex int identity , 
		 FItemID int null , 
		 FInterid int null, 
		 FEntryid int null, 
		 FCheckdate datetime null, 
		 FPrice decimal(28,8) default(0) null ) 
	create clustered index #idx_ITEMStockPRICE_FItemID  ON #ITEMSTOCKPRICE(FItemID)

	Create Table #BomCost(							--bom cost
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
	create clustered index #idx_FItemID  ON #BomCost(FItemID)

	Create Table #ParentData (
		 FIndex int identity , 
		 FItemID int null, 
		 FBom int default(0) null , 
		 FQty decimal(28,10) default(0) null, 
		 FObjID int default(0) null )  
	create index #idx_FItemID ON #ParentData(FItemID)
	create clustered index #idx_FIndex ON #ParentData(FIndex) 
	
	IF @FQufn IN('A','B','C')
	BEGIN
		INSERT INTO #ParentData (FItemID,FBom,FQty,FObjID) 
		SELECT t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0
		  FROM t_ICItem t1 
		  JOIN icbom t2 ON t1.FItemID =t2.FItemID and t2.FUseStatus=1072 and t2.FStatus =1
		  WHERE (t1.FName LIKE '%'+ISNULL(@FName,'')+'%' OR t1.FModel LIKE '%'+ ISNULL(@FName,'')+'%' OR t1.Fnumber LIKE '%'+ ISNULL(@FName,'')+'%' )
			and t1.FNumber LIKE '01.%'
	END
	ELSE 
	BEGIN
		INSERT INTO #ParentData (FItemID,FBom,FQty,FObjID) 
		SELECT t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0
		  FROM t_ICItem t1 
		  JOIN icbom t2 ON t1.FItemID =t2.FItemID and t2.FUseStatus=1072 and t2.FStatus =1
		  JOIN t_Organization e1 ON e1.FNumber=@FCusno 
		  JOIN ICPrcPlyEntry e2 ON e2.FInterID=4 and e2.FRelatedID =e1.FItemID and e2.FItemID =t1.FItemID 
		  WHERE (t1.FName LIKE '%'+ISNULL(@FName,'')+'%' OR t1.FModel LIKE '%'+ ISNULL(@FName,'')+'%' OR t1.Fnumber LIKE '%'+ ISNULL(@FName,'')+'%' )
		order by t1.FNumber 
	
	END
	
	

 --- GetBomOpen 展开嵌套SQL 开始 by wwq 版本v90 -------
	Create Table #BomData ( 
		FIndex int IDENTITY,
		FItemID int null,       --物料ID
		 FParentItemID int null, --根节点物料ID，当FBomLevel=0时，FItemID = FParentItemID
		 FOFFSetDay decimal(28,10) DEFAULT(0) NOT NULL,--子项物料提前期偏置 FBOMLevel=0 时 FOFFSetDay=0
		 FNeedDate datetime null,--需求日期,内部处理，用于计算累计提前期 
		 FNeedQty decimal(28,14) default(0) null, --单位用量 
		 FRelNeedQty decimal(28,14) default(0) null, --实际用量 
		 FBOMLevel int null,     --BOM层次
		 FItemType int null,     --10:虚拟件；4:配置；5：特征；6:规划 1：自制OR委外；0：采购
		 FParentID int default(0) null,   --内部使用，上级FINDEX
		 FUpItemID int default(0) null,   --内部使用，上级物料ID
		 FUpBOM int default(0) null,   --内部使用，上级BOM
		 FRate   decimal(28,10) default(0) null,  --比率
		 FScrap   decimal(28,10) default(0) null, --损耗率
		 FRelScrap decimal(28,10) default(0) null, --累计损耗率
		 FSumParentTime decimal(28,10) default(0) null,   --上级累计下来到本次的提前期合计
		 FFixLeadTime decimal(28,10) default(0) null,       --物料固定提前期 
		 FSumLeadtime decimal(28,10) default(0) null,    --物料累计提前期
		 FLeadTime decimal(28,10) default(0) null,    --物料变动提前期
		 FBatChangeEconomy decimal(28,10) default(0) null,    --物料变动批量
		 FSecInv decimal(28,10) default(0) null,    --物料安全库存 
		 FBom    int default(0) null,                    --BOM 
		 FObjID  int default(0) null,                    --跟踪对象
		 FGroupID int default(0) null,                   --根节点FINDEX 
		 FOperId int default(0) null,                    --工序ID
		 FOrderTrategy varchar(10) default('') null,     --订货策略
		 FPlanTrategy varchar(10) default('') null,      --计划策略
		 FMaterielType varchar(10) default('') null,     --BOM子项类型 
		 FMarshalType varchar(10) default('') null,      --BOM子项配置属性 
		 FBeginDate datetime default('1900-01-01'),      --BOM子项有效开始日期 
		 FEndDate datetime default('2100-01-01'),        --BOM子项有效结束日期 
		 FAuxPropID int default(0),                      --辅助属性 
		 FHaveUptDate int default(0),                    --工厂日历更新标志 
		 FHaveBomOpen smallint default(0) null,
		 FSPID  int default(0),								--发料仓库
		 FStockID int default(0),							--发料仓位
		 FIsCharSourceItem   Smallint default(0)  null,		--是否特性来源物料0/1(子项物料)
		 FSourceItemID   int default(0)    null,            --若是特性物料 , 则记录特性来源物料(子项物料)
		 FCharConfigID   int default(0)   null,				--特性方案ID (子项物料)
		 FDetailID       uniqueidentifier  null,			--唯一码 (子项物料)
		 FBOMSkip        smallint default(0)  null,			--BOM是否跳层
		 FCalID         int default(999)  null,				--工厂日历ID
		 FDayID         int default(0) null					--日历内码 
		 ) 


	--1. --创建临时表
	 
	--- BOM展开表的特性信息 -------
	If Object_id('[tempdb].[dbo].[#TempChar]') Is Not Null 
	    TRUNCATE TABLE #TempChar
	 else 
	begin 
	Create Table #TempChar ( 
	    FIndex  	int not null,   --关联TempBomOpenDest 的Findex字段
	    FCharID 	int null,       --特性ID
	    FCharValID  int null )      --特性值 
	END  

	--- 特性配置BOM展开临时表（结构相同于sDestTable） -------
	If Object_id('[tempdb].[dbo].[#TempBomOpen_Char]') Is Not Null 
		 TRUNCATE TABLE #TempBomOpen_Char 
	 else 
	 begin 
	 SELECT * INTO #TempBomOpen_Char FROM #BomData WHERE 1<>1  
	 END  


	SELECT @MinDayID=Min(FInterID),@MaxDayID=Max(FInterID),@MinDate=Min(FDay),@MaxDate=Max(FDay) 
	from t_MutiWorkCal 
	WHERE FCalID=999 and FInterID>0


	INSERT INTO  #BomData  (  FParentItemID,FItemID  ,FNeedDate,FNeedQty,FRelNeedQty,FBOMLevel
							,  FItemType
							,  FParentID,FFixLeadTime,FObjID,FPlanTrategy,FOrderTrategy
							,  FHaveBomOpen,FBom,FSumParentTime,FLeadTime,FBatChangeEconomy
							,  FIsCharSourceItem, FSourceItemID, FCharConfigID, FBOMSkip
							,  FAuxPropID, FCalID
							, FDayID
							)
	SELECT u1.FItemID,u1.FItemID,u1.FDate,u1.FNeedQty,u1.FRelNeedQty, 0
		  , (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end) FItemtype
		  , 0, t1.FFixLeadTime, 0, isnull(t5_1.FID,'MRP'), isnull(t5_2.FID,'LFL')
		  , 0, u1.FBom,0, t1.FLeadTime, T1.FBatChangeEconomy
		  , ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID, t7.FBOMSkip
		  , FAuxPropID, Isnull(t2.FCalID,'999') AS FCalID
		  , Isnull( (SELECT FNxtID AS FDayID FROM t_MutiWorkCal  WHERE FCalID=Isnull(t2.FCalID,999) AND FDay = u1.FDate),@MinDayID)  AS FDayID 
	 FROM (
		SELECT distinct FItemID ,0 FObjID,FBom,convert(varchar(10),GetDate() ,121) AS FDate,1 AS FNeedQty
			 , 1 AS FRelNeedQty FROM #ParentData 
		  ) u1
		JOIN t_ICItem t1 ON U1.FItemID=T1.FItemID
		JOIN t_Submessage t5   ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210 --物料基本信息
		LEFT JOIN t_Submessage t5_1 ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167  --计划策略
		LEFT JOIN t_SubMessage t5_2 ON t1.FOrderTrategy = t5_2.FInterID and t5_2.FTypeID = 169 --订货策略
		LEFT JOIN ICPlan_CharConfig t6 ON u1.FItemID = t6.FItemID AND t6.FCheckerID > 0 
		LEFT JOIN ICBom t7 ON u1.FBom = t7.FInterID 
		left JOIN t_Department t2 ON T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)  
	create index #idx_FItemID  ON #BomData(FItemID) 
	create index #idx_FBOM  ON #BomData(FBOM) 


	Update v1 
	   Set v1.FBom = u1.FInterID, FBomSkip=u1.FBomSkip , v1.FAuxPropID=u1.FAuxPropID
	  FROM #BomData v1 
	 JOIN ICBom u1 ON v1.FItemID = u1.FItemID
	 WHERE  isnull(v1.FBom,0) = 0 and u1.FBomType <> 3 and u1.FUseStatus = 1072

	Update #BomData Set FGroupID = FIndex WHERE FBomLevel = 0 
	--更新特性物料的BOM
	Update #BomData
		Set  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FAuxPropID=C.FAuxPropID 
	From  #BomData  A
	   JOIN ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0  --特性方案
	   JOIN ICBOM C ON B.FBomInterID = C.FInterID 
	WHERE A.FIsCharSourceItem=0 AND A.FCharConfigID>0

	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	SELECT A1.FIndex,C2.FCharID, C2.FCharValID
	From #BomData A1  --子项
		JOIN ICPlan_CharConfig C1 ON A1.FItemID=C1.FItemID  --特性配置方案
		JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	WHERE A1.FBomLevel = 0 AND  A1.FIsCharSourceItem=0 AND A1.FCharConfigID>0 

	 
	 Declare @BOMMaxLevel smallint 
	 Declare @BOMLevel smallint 
	 Declare @SELECTRows int 
	 Declare @LastBomLevel int 

	 SELECT @BOMMaxLevel = 30
	 SELECT @BOMLevel =0 
	 SELECT @selectrows = 0
	 SELECT @selectrows = isnull(count(*),0) FROM #BomData     WHERE FHaveBomOpen = 0 and FBomLevel = @BomLevel and FItemType > 0 
		 and FNeedQty>0 
	 while ( @selectrows >0 and @BomLevel < @BomMaxLevel)
	 Begin 

		 --- FROM ICBOMChild 
		 INSERT INTO #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, 
			 FCalID, FDayID, FBOM ) 
		 SELECT u1.FParentItemID,v2.FItemID, t10.FPreDay AS FNeedDate,
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
		)/(case when v2.FScrap=100 then 1 else (1-convert( decimal(28,15),(v2.FScrap /100) ))end)
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
	,t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 OR v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID 
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 
	,0 AS FBOM      FROM (SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 
	 ) u1
	JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID       
	JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID                                                             
	JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	left JOIN t_Department t2 ON T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left JOIN t_MutiWorkCal t3 ON t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 and t1.FDeleted=0 
	 --AND ISNULL(t1.FIsCharSourceItem,0)=0 and Isnull(t1.FCharSourceItemID,0)=0  --子项过滤掉特性来源物料和特性物料 
	 and (((v2.FMaterielType=371 OR v2.FMaterielType=375)))
				 and u1.FIsCharSourceItem = 0 And u1.FCharConfigID = 0     --过滤掉特性来源物料和特性物料  

		 --- FROM ICCustChild
		 if @BomLevel >= 0 
		 Begin 
		 INSERT INTO #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, 
			 FCalID, FDayID, FBOM ) 
		 SELECT u1.FParentItemID,v2.FItemID, 
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
	,t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 OR v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID 
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 
	,ISNULL(V2.FCustBOMCode,0) AS FBOM      FROM (SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 ) u1
	JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType=3                   
	JOIN ICCustBOMChild V2  ON V1.FInterID=V2.FInterID 
	JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID                                                             
	JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	left JOIN t_Department t2 ON T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left JOIN t_MutiWorkCal t3 ON t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 and t1.FDeleted=0 
	 and (((v2.FMaterielType=371 OR v2.FMaterielType=375)))

     End 
-------------------------------------特性配置处理开始------------------------------------------
	--1. --创建临时表
	--判断是否有特性来源物料/特性物料存在
	IF EXISTS (SELECT 1 FROM #BomData WHERE FBomLevel = @BomLevel AND (FIsCharSourceItem=1 OR FcharConfigID>0) )
	BEGIN

	--2. 处理父项为特性配置来源物料(特性物料的公用件也一样)
		 INSERT INTO #BomData
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID --, FBOMSkip
	,FCalID, FDayID 
	) 
		 SELECT u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay AS FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 OR v2.FMaterielType=375) then 0 else 1 end ) FMeterialType, --FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	v2.FDetailID,0 AS FBOM  
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 

		 FROM (SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 
				 and ( FIsCharSourceItem=1 OR FcharConfigID>0 )     --特性来源物料和特性物料  
	) u1
	JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID 
	JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID  
	JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN ICPlan_CharConfig t6 ON V2.FItemID = t6.FItemID  and t6.FCheckerID > 0  
	left JOIN t_Department t2 ON T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left JOIN t_MutiWorkCal t3 ON t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 
	AND t1.FDeleted=0 
	 and V2.FhasChar=0  --先只处理没有特性的公用件 
	 and (((v2.FMaterielType=371 OR v2.FMaterielType=375)))

	--3. 处理父项为特性物料:
	--    3.2 插入子项数据
		 INSERT INTO #TempBomOpen_Char 
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay,  FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	)
		 SELECT u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay AS FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   AS FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty AS Float) * 1.0 / Cast(v1.FQty AS Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 OR v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,--FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay, u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	 0 AS FBOM 
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) AS FCharConfigID, v2.FDetailID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') AS FCalID 
	 ,t10.FPreID AS FDayID 

		 FROM (SELECT * FROM #BomData 
			   WHERE FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 
				 and  FcharConfigID>0     --特性物料  
	) u1
	JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3  
	JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID 
	JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID  
	JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN ICPlan_CharConfig t6 ON V2.FItemID = t6.FItemID and t6.FCheckerID > 0 
	left JOIN t_Department t2 ON T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left JOIN t_MutiWorkCal t3 ON t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left JOIN t_MutiWorkCal T10 ON t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 
	AND t1.FDeleted=0 
	 and V2.FhasChar > 0  --有特性的子项 
	 and (((v2.FMaterielType=371 OR v2.FMaterielType=375)))

	IF EXISTS (SELECT 1 FROM #TempBomOpen_Char WHERE FBomLevel= @BOMLevel +1 ) --判断该层是否有特性物料
	BEGIN
	--3.3 根据特性值过滤有特性的子项
	-- 取得符合条件的有特性的Bom子项
	DELETE t1 FROM #TempBomOpen_Char t1 
		Left JOIN 
	(
	SELECT FIndex /* ,FParentItemID,FBom,FITEMID,FSourceItemID, COUNT(*) */ 
	From
	(
	SELECT FIndex,FParentItemID,FBom,FITEMID,FSourceItemID, FCHARID,COUNT(*) FCOUNT FROM
	(
		SELECT U.FIndex,u3.FItemID AS FParentItemID, U.FBom,U.FITEMID,U.FSourceItemID,U.FCharConfigID,D.FCHARID AS D_FCHARID,D.FCHARVALID,E.FNAME ,
			V.FCHARID AS FCHARID,b3.FCharID AS b3_FCharID,b3.FCharValID AS x_FCharValID
		--SELECT *
		FROM #TempBomOpen_Char U
		Full JOIN --BOM子项外关联特性, 使每个子项都有该BOM全部的特性(BOM子项的特性  union 表头特性物料特性)
		(   SELECT DISTINCT FSourceItemID,FCharID FROM #TempBomOpen_Char a1
				JOIN ICPlan_BOMChildChar b1 ON a1.FDetailID=b1.FDetailID WHERE a1.FBOMLevel=@BomLevel+1
			Union
			SELECT DISTINCT b2.FSourceItemID,c2.FCharID
				From #BomData /*#TempBomOpen_Char*/ a2
				JOIN icplan_CharConfig b2 ON a2.FCharConfigID=b2.Fid
				JOIN icplan_charconfigEntry c2 ON b2.fid=c2.fid
				WHERE a2.FBOMLevel=@BomLevel
		)  V ON  U.FSourceItemID=v.FSourceItemID
		Left  JOIN  ICPlan_BOMChildChar D --获得BOM子项的特性值
			ON  U.FDetailID=D.FDetailID and V.FCharID=d.FCharID
		LEFT JOIN ICPlan_CharacteristicEntry E ON D.FCHARVALID=E.FCHARVALID
	   --获得父项的特性过滤条件
		JOIN #BomData AS u3 ON U.FParentID=u3.FIndex and u3.FBOMLevel=@BOMLevel --父项物料
		LEFT JOIN icplan_CharConfig a3 ON u3.FItemID=a3.FItemID and a3.FCheckerID > 0 
		LEFT JOIN icplan_charconfigEntry b3 ON a3.fid=b3.fid and D.FCHARID=b3.FCHARID --特性匹配
		WHERE ( 1=1 AND U.FBOMLevel=@BOMLevel + 1
		AND ISNULL(D.FCHARVALID,0)=0 OR ISNULL(b3.FCHARVALID,0)=0 OR D.FCHARVALID=b3.FCHARVALID
		)  --ORDER BY  B.FINTERID,B.FENTRYID,B.FITEMID, V.FCHARID
	) M GROUP BY  FIndex,FParentItemID,FBom,FITEMID,FSourceItemID, FCHARID
	) N GROUP BY FIndex,FParentItemID,FBom,FITEMID,FSourceItemID
	HAVING COUNT(*) >=
		  ( SELECT COUNT(*) FROM
			  (   SELECT DISTINCT FSourceItemID,FCharID FROM #TempBomOpen_Char a1
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
	 WHERE t1.FBomLevel= @BOMLevel +1 and t2.FIndex is Null 
	--3.4 将#TempBomOpen_Char的数据, INSERT INTO 到sDestTable

	INSERT INTO #BomData
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay,  FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	) 
	   SELECT 
		 FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	FROM #TempBomOpen_Char     WHERE FBomLevel= @BOMLevel +1

	END  --判断该层是否有特性物料

	--'更新sDestTable表的BOM信息
	Update A
		Set  FBOM = C.FInterID , FBomSkip=C.FBomSkip
	From  #BomData  A
	   JOIN ICBOM C ON A.FItemID = C.FItemID
	WHERE A.FBOMLevel= @BOMLevel +1 AND A.FBom = 0  and C.FUseStatus = 1072
	--5.  更新所有子项为特性配置来源物料, 根据BOM和特性来判断是否已有特性物料，如果有则更新为特性物料。

	--5.1 若是子项有特性来源物料，需要继承特性，保存到#TmpChar（参考GetCharBomOpen函数）
		--(子项没有父项的特性,则该特性被过滤
		--子项有父项没有的特性, 则特性值为空)
	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	SELECT A1.FIndex, C2.FcharID, B2.FCharValID
	From #BomData A1  --子项
		JOIN ICPLAN_ItemChar C1 ON A1.FItemID=C1.FItemID  --子项特性范围表
		JOIN ICPLAN_ItemCharEntry C2 ON C1.FID=C2.FID
		JOIN #BomData  A2  ON A1.FParentID =A2.FIndex --父项
		Left JOIN #TempChar  B2  ON A2.Findex=B2.Findex  --父项特性
				And C2.FCharID=B2.FCharID   --过滤子项才有的特性
		WHERE A1.FBomLevel=@BomLevel + 1 And A1.FIsCharSourceItem = 1 AND B2.FCharValID > 0 
		ORDER BY A1.FIndex, C2.FCharID, B2.FCharValID

		--5.2 根据BOM和特性来判断是否已有特性物料
		UPDATE #BomData
		   SET FCharConfigID=B.FID, FItemID=B.FItemID, FSourceItemID=B.FSourceItemID, FBom=FBomInterID, FIsCharSourceItem = 0 
		   ,FFixLeadTime=T1.FFixLeadTime, FSumLeadTime=isnull(t1.FTotalTQQ,0) 
		   ,FLeadTime=t1.FLeadTime, FBatChangeEconomy=T1.FBatChangeEconomy, FSecInv=T1.FSecInv
		   ,FItemtype=(case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)
		   ,FPlanTrategy=isnull(t5_1.FID,'MRP')
		   ,FOrderTrategy=isnull(t5_2.FID,'LFL')
		--SELECT B.FID,C.FID,*
			FROM #BomData A
			JOIN ICPlan_CharConfig B ON A.FItemID=B.FSourceItemID AND B.FCheckerID > 0 
			Left JOIN   --也可以处理成NOT IN 语句
			(    --查询出有特性不匹配的特性方案
			SELECT DISTINCT FIndex,FID FROM
				(
				SELECT A1.Findex,CASE WHEN B1.FID IS NULL THEN B2.FID ELSE B1.FID END AS FID,
						B1.FITEMID,B1.FSOURCEITEMID,A2.FcharValID AS FSourceCharValID, B2.FcharValID AS FCharValID
				FROM  (SELECT * FROM #BomData WHERE FBOMLevel=@BOMLevel+1 AND FCharConfigID=0 ) A1
				JOIN #TempChar A2 ON A1.Findex= A2.FIndex
				JOIN  ICPlan_CharConfig B1 ON A1.FitemID=B1.FsourceItemID and A1.FBOM=B1.FBOMInterID AND B1.FCheckerID > 0 
				FULL JOIN ICPlan_CharConfigEntry B2  ON B1.FID = B2.FID AND  A2.FCharValID= B2.FCharValID
					WHERE (A2.FcharValID Is Null OR B2.FcharValID Is Null)
				) AS M
			)  C  ON  (A.FIndex=c.FIndex OR c.findex is null) and B.FID=C.FID
		   JOIN T_ICItem t1    ON B.FItemID=T1.FItemID -- AND t1.FDeleted = 0 
		   JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
		   LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
		   LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
		WHERE C.FID IS NULL AND A.FBOMLevel= @BOMLevel+1 AND A.FIsCharSourceItem = 1 AND A.FCharConfigID=0

			AND EXISTS (SELECT 1 FROM #TempChar X WHERE A.FIndex=X.FIndex) 

	AND t1.FDeleted=0 

	END              ----判断是否有特性来源物料/特性物料存在

	--更新特性物料的相关信息
	Update A
		Set  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FCharConfigID= isnull(b.Fid,0), 
		FSourceItemId=t1.FCharSourceItemId 
	From  #BomData  A 
	   JOIN t_icItemPlan t1 ON A.FItemID=t1.FItemID 
	   Left JOIN ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0 --特性方案 
	   JOIN ICBOM C ON B.FBomInterID = C.FInterID 
			WHERE A.FBomLevel = @BOMLevel +1 AND T1.FCharSourceItemId > 0 
	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	SELECT A1.FIndex,C2.FCharID, C2.FCharValID
	From #BomData A1  --子项
		JOIN ICPlan_CharConfig C1 ON A1.FItemID=C1.FItemID AND C1.FCheckerID > 0  --特性配置方案
		JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	WHERE  A1.FBomLevel = @BOMLevel + 1 AND   A1.FCharConfigID>0 
	-------------------------------------特性配置处理结束------------------------------------------

	 Update v1 Set v1.FBom = u1.FInterID, v1.FBomSkip=u1.FBomSkip 
	 FROM #BomData v1, ICBom u1 
	 WHERE v1.FBomLevel = @BomLevel + 1 and v1.FItemType > 0 and v1.FItemID = u1.FItemID 
	 and isnull(v1.FBom,0) = 0 and u1.FBomType <> 3 and u1.FUseStatus = 1072
		 Update #BomData Set FHaveBomOpen = 1 
		 WHERE FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 and FNeedQty>0 
		 SELECT @BomLevel = @BomLevel + 1 
		 SELECT @selectrows = 0
		 SELECT @selectrows = isnull(count(*),0) FROM #BomData     WHERE FHaveBomOpen = 0 and FBomLevel = @BomLevel and FItemType > 0 
		 and FNeedQty>0 
	 End 

	 Delete FROM #BomData WHERE (FItemType = 10 OR FItemType = 5 OR (FBomSkip=1058 AND FBomLevel> 0)  )
	----跳层为是,则按虚拟件处理 
	Update #BomData SET FItemType = 10 WHERE FBomSkip=1058 

	DROP TABLE #TempChar 
	DROP TABLE #TempBomOpen_Char 

	 -------------- BOM展开嵌套SQL 结束 ------------------------------------
	--planprice
	 INSERT INTO #ITEMPRICE (FItemID,FPlanPrice) 
	 SELECT v1.FItemID,isnull(t1.FPlanPrice,0) 
	 FROM (SELECT FItemID,sum(FNeedQty) FNeedQty
		   FROM #BomData WHERE FBomLevel > 0 and FItemType =0
		   GROUP BY FItemID) v1 
		    LEFT  JOIN  t_ICItem t1 ON v1.FItemID =t1.FItemID  
    --average price,planprice
	 Update u1 set u1.FLastPrice = (case when( isnull(u2.FLastAmount,0) =0 OR isnull(u2.FLastQty,0) = 0) then 0 else round(u2.FLastAmount / u2.FLastQty,tt1.FPriceDecimal) end )  
	 FROM #ITEMPRICE 	u1  
	 JOIN t_Icitem 		tt1 	on u1.FItemID = tt1.FItemID 
	 JOIN (SELECT v1.FItemID,sum(round(isnull(v1.FBegQty,0),t1.FPriceDecimal)) FLastQty ,sum(Round(isnull(v1.FBegBal,0),t1.FPriceDecimal)) FLastAmount 
		 	From ICBal 			v1
		 	JOIN t_ICItem 		t1 ON v1.FItemID = t1.FItemID and v1.FYear = 2014 and v1.FPeriod = 8
		 	WHERE v1.FItemID in (SELECT s1.FItemID FROM #ItemPrice s1) 
		 	and not (v1.FBegQty = 0 and v1.FBegBal = 0)  
		 	GROUP BY v1.FItemID ) u2 ON  u1.FItemID = u2.FItemID  
	--instock price
	INSERT INTO #ITEMSTOCKPRICE (FItemID,FInterid,FEntryid,FCheckdate,FPrice)
	--取得每个物料的最新价格 
	SELECT vv2.FItemId ,vv1.FInterid,vv2.FEntryid, vv1.fCheckdate  ,vv2.FPrice 
	 FROM  icstockbill 				vv1 
	 JOIN icstockbillentry 	vv2  	on vv2.finterid = vv1.finterid 
	 JOIN #ITEMPRICE 			u 		on vv2.FItemID=u.FItemID  
	 JOIN (SELECT T2.FItemID,max(T1.FCheckDate) AS FCheckDate FROM  icstockbill T1 JOIN icstockbillentry T2  ON T1.finterid = T2.finterid 
		WHERE  T1.FTranType in (1,2,5,10)  and T2.fprice <> 0 and T1.Fdate<=convert(char(10),getdate(),121) 
		GROUP BY T2.FItemID) 		TmpA 	on TmpA.FItemID=vv2.FItemID and TmpA.FCheckDate=vv1.fCheckDate 
	 WHERE  vv1.FTranType in (1,2,5,10)  and vv2.fprice <> 0 and vv1.Fdate <=convert(char(10),getdate(),121) 
					--GROUP BY vv2.FItemId,  vv1.fCheckdate  , vv1.finterid,  vv2.fentryid 
	order by  vv2.FItemId, vv1.fCheckdate  desc, vv1.finterid desc ,vv2.fentryid desc 
	--update #itemprice fnewprice
	Update u1 set u1.FNewPrice = isnull(u2.FPrice,0) 
	From #ITEMPRICE u1 
	Left JOIN 	( SELECT v2.FItemID,v2.Fprice
					from  #ITEMSTOCKPRICE v2   
				WHERE  CONVERT(VARCHAR,v2.FItemID)+'|' + CONVERT(VARCHAR,v2.fCheckdate,111) + '|' + CONVERT(VARCHAR,v2.finterid) +'|' + CONVERT(VARCHAR,v2.fentryid) 
				=(	SELECT top 1 CONVERT(VARCHAR,vv2.FItemId ) + '|' + CONVERT(VARCHAR,vv2.fCheckdate,111) + '|'+ CONVERT(VARCHAR,vv2.finterid) +'|' + CONVERT(VARCHAR,vv2.fentryid) 
					FROM  #ITEMSTOCKPRICE vv2   
					WHERE V2.FItemid = vv2.FItemid order by Vv2.FItemID,vv2.fcheckDate desc,vv2.finterid desc,vv2.fentryid desc )
				) 	u2 	 ON u1.FItemID  = u2.FItemID 

	Update u1 set u1.FNewPrice =u1.FLastPrice  
	From #ITEMPRICE u1  
	WHERE exists	(SELECT v2.FItemID 
			 			from ICStockBill 			v1 
			 			JOIN ICStockBillEntry v2 ON v1.finterid = v2.finterid 
			 			WHERE v1.FTranType in (1,2,5,10) and convert(char(8),v1.Fdate,112)<=@FDate 
			 			and v1.FStatus > 0  and u1.FItemId =v2.FItemId ) 
		and u1.FNewPrice=0 

    Update #ITEMPRICE set FNewPrice = FPlanPrice  WHERE FNewPrice=0
	--INSERT INTO bomcost
	INSERT INTO #BomCost(FParentItemid ,FItemID,FNumber,FShortNumber,FName,FUnitName,QtyDecimal,PriceDecimal
		 ,  FModel,FQty,FPlanPrice,FPlanAmount,FLastPrice,FLastAmount,FNewPrice,FNewAmount) 
	 SELECT V1.FParentItemID,v1.FItemID,t1.FNumber,t1.FShortNumber,t1.FName,t2.FName FUnitName,t1.FQtyDecimal,t1.FPriceDecimal,
	  isnull(t1.FModel,'') FModel,(convert(decimal(28,15),v1.FNeedQty) * convert(decimal(28,15),u1.FQty)) Fqty ,v2.FPlanPrice,0.0 FPlanAmount,
	  v2.FLastPrice,0.0 FLastAmount, 
	  v2.FNewPrice, 0.0 FNewAmount 
	 FROM (SELECT FParentItemID, FItemID, sum(FNeedQty) FNeedQty
		   FROM #BomData WHERE FBomLevel > 0 and FItemType =0 
		   GROUP BY FParentItemID, FItemID)  	v1
	JOIN #ItemPrice 							v2 ON v1.FItemID = v2.FItemID
	JOIN #ParentData 							u1 ON v1.FParentItemID = u1.FItemID
	JOIN t_IcItem 								t1 ON v1.FItemID = t1.FItemID 
	JOIN t_MeasureUnit 							t2 ON t1.funitid=t2.fitemid
	Order By t1.FNumber 
	--update amount
	 Update v1 Set v1.FPlanAmount =convert(decimal(28,15),v1.Fplanprice) * convert(decimal(28,15),v1.Fqty), 
	   v1.FLastAmount = convert(decimal(28,15),v1.FLastPrice) * convert(decimal(28,15),v1.FQty), 
	   v1.FNewAmount =  convert(decimal(28,15),v1.FnewPrice) * convert(decimal(28,15),v1.FQty) 
	 FROM #BomCost v1 
	 JOIN t_ICItem t1 ON v1.FItemID = t1.FItemID
 ---将3.15.00.095	95	铝杆A1100	铝杆盘料 的价格变更成计划单价  
 ----  NBD TBD 的加工费：22.5元/公斤
 ----  SBD  的加工费：22元/公斤
 ----  其余 的加工费：12元/公斤

 /*update  #BomCost 
 set FPlanPrice=a.FPlanPrice
   , FPlanAmount = a.FPlanPrice*b.FQty 
   , FNewPrice=A.FPlanPrice
   , FNewAmount=A.FPlanPrice*B.FQty 
 FROM (
	SELECT A.FParentItemid ,A.FItemID--, b.FNumber ,b.FName ,c.FNumber ,c.FName ,c.FPlanPrice
         , (case when (B.FName LIKE 'NBD-%' OR B.FName LIKE 'TBD-%') THEN  round((c.FPlanPrice+22.5)/1.17,4) 
				 when b.FName LIKE 'SBD-%' THEN round((c.FPlanPrice+22)/1.17,4) 
                 ELSE round((c.FPlanPrice+12)/1.17,4)  END) AS FPlanPrice
	 FROM #BomCost A
	 JOIN t_ICItem B ON B.FItemID =A.FParentItemid   --成品
	 JOIN t_ICItem c ON c.FItemID =A.FItemID 
	 WHERE A.FItemID =208607
	 --order by b.FName 
	) A
 JOIN #BomCost B ON A.FParentItemid =B.FParentItemid AND A.FItemID =B.FItemID 
 WHERE b.fitemid=208607   ---铝杆
*/
 
 
 ---将纸箱价格清空
 update #BomCost
 set FNewPrice=0,FNewAmount=0
 WHERE FItemID in( SELECT c.FItemID FROM #BomCost a
 					JOIN t_ICItem b ON a.FParentItemid =b.FItemID 
 					JOIN t_ICItem c ON c.FItemID =a.FItemID 
 				WHERE (substring(c.FModel,len(c.FModel)-1,2))='90' AND (A.FName LIKE '%纸箱%' OR A.FName LIKE '%包装箱%') 
 					)
 
 INSERT INTO #BomCost(FParentItemid ,FNumber,FShortNumber,FQty,FPlanAmount,FLastAmount,FNewAmount)
 SELECT FParentItemid ,'合计','合计',sum(v1.FQty), sum(v1.FPlanAmount),Sum(v1.FLastAmount),sum(v1.FNewAmount) 
 FROM #BomCost v1 
 GROUP BY FParentItemid 
 
 ------ 计划单价,先取供应商价格体系中取最大的报价 再取物料信息的计划单价 ------ 吴总指示  20141220
UPDATE b
SET b.FPlanPrice=a.avrPrice,b.FPlanAmount=a.avrPrice * b.fqty		-- 20180201
from (SELECT b.fitemid,b.funitid,sum(b.fstdamount) AS funtaxamount, sum(b.fqty) AS fqty
			,CASE  WHEN sum(b.fqty)>0 THEN round(sum(b.fstdamount)/sum(b.fqty),tt1.FPriceDecimal) ELSE 0 END AS avrprice
			FROM icpurchase a JOIN icpurchaseentry b ON a.FInterID = b.FInterID AND ( a.ftrantype = 75 OR a.ftrantype = 76 )
			JOIN t_Icitem 		tt1 	on b.FItemID = tt1.FItemID 
			WHERE a.fcheckdate > dateadd(year,-1,dateadd(day,datedIFf(day,0,getdate()),0)) 
			AND isnull(b.fqty , 0)<> 0 AND isnull(b.fstdamount ,0) <> 0 
			AND a.fstatus = 1 AND a.frob =1 AND (isnull(fheadselfi0252,0) =0 AND isnull(fheadselfi0349,0 ) = 0)
			GROUP BY b.fitemid,b.funitid,tt1.FPriceDecimal
			) a
JOIN #BomCost b ON b.FItemID=a.FItemID AND b.FNumber <>'合计'	  

------更新为零的计划单价后再更新合计计划金额  同上一起做的  
update #BomCost 
set FPlanAmount =a.FPlanAmount
from (
SELECT FParentItemid ,SUM(FPlanAmount )as FPlanAmount FROM #BomCost 
WHERE FNumber <>'合计'	  
GROUP BY FParentItemid ) a
JOIN #BomCost b ON a.FParentItemid =b.FParentItemid 
WHERE FNumber ='合计'	  

 ------------------成本BOM 查询结束------------------
 
 ------------将结果显示出来-------------------  
 if @FQufn ='A'
 BEGIN
	  SELECT a.FItemID ,b.FNumber, b.FName,isnull(b.FModel,'') AS FModel
		   , k.FName AS FErpClsName,isnull(d.fname,'') AS FUnitID
		   , a.FQty, a.FYield, a.FUseStatus AS FUseStatusNum
		   , (case a.FUseStatus when 1072 then '使用' else '未使用' end) AS FUseStatus
		   , a.FVersion,b.FChartNumber,i.FRoutingName AS FRoutingID 
		   , isnull(g.Fname,'') AS  FCheckID,  a.FCheckDate,isnull(h.fname,'') AS FOperatorID
		   , a.FEnterTime,a.FNote,round(b.FPlanPrice,b.FPriceDecimal) FPlanPrice
		   , round(CAST( a.FQty AS Decimal(28,15)) * CAST( b.FPlanPrice AS DECIMAL(28,15)),b.FPriceDecimal) AS FPlanAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( b.FPlanPrice AS DECIMAL(28,15) ) InitFPlanAmount
		   , a.FitemID EditFitem,b.FQtyDecimal FQtyDecimal,b.FQtyDecimal FInitDecimal,b.FPriceDecimal
		   , isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) FNewPrice
		   , round(CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) AS DECIMAL(28,15) ),b.FPriceDecimal) AS FNewAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) AS DECIMAL(28,15) ) AS FInitNewAmount 
		   , isnull(convert(varchar(20),convert(decimal(28,2),e.FNewAmount)),0) FNewAmount_detail
		   , isnull(e.FNewAmount,0) InitFNewAmount_detail
		   , ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
		   ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要在取值了
		   , (case when ISNULL(s1.FName,'N')='N' THEN
				  (case when b.FLength>0 then ROUND(((ISNULL(b.FLength,0)+ISNULL(b.FWidth,0))*0.001+0.08+0.018)*((ISNULL(b.FWidth,0)*2+ISNULL(b.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				   ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				   ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
				   else 0 end)
			  ELSE 0 END)  AS 小箱套价格  ---不含税单价
		   , round(ISNULL(E.FPlanAmount,0)+(CASE WHEN ISNULL(s1.FName,'N')='N' THEN (case when b.FLength>0 then ROUND(((ISNULL(b.FLength,0)+ISNULL(b.FWidth,0))*0.001+0.08+0.018)*((ISNULL(b.FWidth,0)*2+ISNULL(b.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2)
				 else 0 end) ELSE 0 END),2)  AS tot_amount
		   , case when (f.con1 >0 OR f2.con1 IS null) then 'N' ELSE 'Y' END AS QFCN1
		   , s1.FName AS BOM_YN
	 FROM icbom a 
	 JOIN t_icitem b ON (a.FItemID = b.FItemID) 
	 JOIN #ParentData c ON c.FBom=a.FInterID and c.FItemID =a.FItemID  
	 left JOIN T_MeasureUnit d ON (b.FUnitID = d.FItemID) 
	 left JOIN t_user g ON (a.FCheckID = g.FUserID ) 
	 left JOIN t_user h ON (a.FOperatorID = h.FUserID) 
	 Left JOIN T_routing i ON (a.FRoutingID = i.FInterID)
	 left JOIN (
		SELECT top 1
		 v2.FItemID,v2.Fprice 
		  FROM icstockbill v1 
		  JOIN icstockbillentry v2  ON v2.finterid = v1.finterid 
		 WHERE v1.FTranType in (1,2,5,10) --and v2.FItemID =41264
		   and v1.FStatus > 0 
		   and  v2.fprice <> 0 and v1.Fdate <GetDate() 
		order by  v1.fCheckdate desc ,v1.finterid desc,v2.fentryid desc 
	   ) u2 ON a.FItemID  = u2.FItemID 
	 Left JOIN (
		SELECT top 1 v2.FItemID 
		  FROM ICStockBill v1 
		  JOIN ICStockBillEntry v2 ON v1.finterid = v2.finterid 
		  WHERE v1.FTranType in (1,2,5,10) and v2.FItemID =41264 and v1.FStatus > 0 
		   and convert(char(8),v1.Fdate,112)<=@FDate  order by v1.fdate desc,v1.FInterID desc
	   ) u3 ON a.FItemID  = u2.FItemID  
	  Left JOIN t_submessage k ON k.FINTERID=b.Ferpclsid 
	   LEFT  JOIN #BomCost e ON e.FParentItemid =a.FItemID  and e.FNumber ='合计'
	   LEFT  JOIN ( ----有详细内容的里面有为零的
			SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
			WHERE FNumber <>'合计' and isnull(FPlanAmount,0)=0
			GROUP BY FParentItemid 
			) f ON f.FParentItemid =a.FItemID  
	   LEFT  JOIN (  ---没有任何详细内容的
			SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
			WHERE FNumber <>'合计' 
			GROUP BY FParentItemid 
			)f2 ON f2.FParentItemid =a.FItemID  
	   LEFT  JOIN t_SubMessage s1 ON s1.FParentID='10012' and s1.FInterID =a.FHeadSelfZ0134 
	  order by B.FNumber
   
   END
   ELSE IF @FQufn ='B'
   BEGIN
		SELECT a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' else '' end) AS FErpClsnm
			 , ROUND(((ISNULL(c.FLength,0)+ISNULL(c.FWidth,0))*0.001+0.08+0.018)*((ISNULL(c.FWidth,0)*2+ISNULL(c.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 AS 小箱套价格	  ---不含税单价
		from #BomCost A
		 LEFT  JOIN t_ICItem b ON a.FItemID =b.FItemID 
		 LEFT  JOIN t_ICItem c ON c.FItemID =a.FParentItemid 
		WHERE FParentItemid =@FParentItemid
		order by FParentItemid , FIndex    
   
   END 
   ELSE IF @FQufn ='C'
   BEGIN
		SELECT c.FNumber AS fparent_fnumber,c.FName AS fparent_fname
		     , a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' else '' end) AS FErpClsnm
			 , ROUND(((ISNULL(c.FLength,0)+ISNULL(c.FWidth,0))*0.001+0.08+0.018)*((ISNULL(c.FWidth,0)*2+ISNULL(c.FHeight,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 AS 小箱套价格		  ---不含税单价
		from #BomCost A
		 LEFT  JOIN t_ICItem b ON a.FItemID =b.FItemID 
		 LEFT  JOIN t_ICItem c ON c.FItemID =a.FParentItemid 
		order by C.FNumber, FIndex    
   
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
			 , (CASE WHEN A.FChecked=1 THEN '是' else '否' END) AS 审核标志
			 , (CASE WHEN A2.FCanSell=1 THEN  '是' else '否' END) AS 允许销售
			 , (CASE WHEN A2.FLPriceCtrl=1 THEN '是' else '否' END) AS 最低价格控制
			 , H.FName AS 维护人, CONVERT(CHAR(10),A.FMaintDate,120) AS 维护日期, H2.FName AS 审核人
			 , (CASE WHEN CONVERT(DATETIME, a.FCheckDate) = '1900-01-01' THEN NULL ELSE CONVERT(CHAR(10),a.FCheckDate,120)  END) AS 审核日期
			 , B.FSize AS 包装箱体积
			 , ( SELECT top 1 isnull(FExchangeRate,0)  FROM t_ExchangeRateEntry  WHERE FExchangeRateType=1 and GETDATE() between FBegDate and FEndDate and FCyTo =1000) AS 美元汇率
			 , (A.FPrice*( SELECT top 1 isnull(FExchangeRate,0)  FROM t_ExchangeRateEntry  WHERE FExchangeRateType=1 and GETDATE() between FBegDate and FEndDate and FCyTo =1000)
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
		   LEFT  JOIN ICItemMapping I ON B.FItemID = I.FItemID AND I.FPropertyID = 1 AND A.FRelatedID = I.FCompanyID
		   LEFT  JOIN t_SubMessage J ON J.FParentID =10007 AND J.FInterID =B.F_134
		   LEFT  JOIN t_SubMessage J2 ON J2.FParentID=10008 AND J2.FInterID = B.F_135
		   LEFT  JOIN (
				SELECT a.FItemID, ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
					 ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要在取值了
					 , (case when ISNULL(s1.FName,'N')='N' THEN 
					        (case when b.F_119>0 then ROUND(((ISNULL(b.F_119,0)+ISNULL(b.F_120,0))*0.001+0.08+0.018)*((ISNULL(b.F_120,0)*2+ISNULL(b.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
								ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
								ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
						     else 0 end)
						 ELSE 0 END)  AS 小箱套价格不含税
					 , case when (f.con1 >0 OR f2.con1 IS null) then 'N' ELSE 'Y' END AS QFCN1
					 , S1.FName AS BOM_YN
				from icbom a 
				JOIN t_icitem b ON (a.FItemID = b.FItemID) 
				JOIN #ParentData c ON c.FBom=a.FInterID and c.FItemID =a.FItemID  
				 LEFT  JOIN #BomCost e ON e.FParentItemid =a.FItemID  and e.FNumber ='合计'
				 LEFT  JOIN ( ----有详细内容的里面有为零的
					SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
					WHERE FNumber <>'合计' and isnull(FPlanAmount,0)=0
					GROUP BY FParentItemid 
				) f ON f.FParentItemid =a.FItemID  
				 LEFT  JOIN (  ---没有任何详细内容的
					SELECT FParentItemid, COUNT(*) AS con1 FROM #BomCost 
					WHERE FNumber <>'合计' 
					GROUP BY FParentItemid 
				)f2 ON f2.FParentItemid =a.FItemID 
				 LEFT  JOIN t_SubMessage s1 ON s1.FParentID='10012' and s1.FInterID =a.FHeadSelfZ0134 
			) b2 ON b2.FItemID =a.FItemID  
		  WHERE a.FInterID=4  AND B.FDeleted=0
		  AND c.fnumber=@FCusNo
		  AND (B.FNAME LIKE '%'+ISNULL(@FName,'') +'%' OR B.FModel LIKE '%'+ ISNULL(@FName,'')+'%'  OR b.Fnumber LIKE '%'+ ISNULL(@FName,'')+'%' )
		  ORDER BY B.FNumber
  
  END
 -----------将临时表删除
 DROP TABLE #ItemPrice ,#BomCost ,#ParentData , #ITEMSTOCKPRICE ,#BomData 
	
END
