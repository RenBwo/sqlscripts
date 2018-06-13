-- =============================================
-- Author:		<By   YangeYuan>
-- Create date: <2014-11-06>
-- Description:	<成本BOM 查询界面 根据SQL追踪的结果结合友邦实际需求进行修改 原ERP中的成本BOM查询不用了>
---exec DBO.BOM_cb_list   'PFA-20','A',0,'2014-11-01'   表头
--exec DBO.BOM_cb_list   'PFA-201','B',29044,'2014-11-01'   表体
-- =============================================
create PROCEDURE [dbo].[BOM_cb_list]
	@FName				NVARCHAR(255),
	@FCusno				NVARCHAR(255),
	@FQufn				NVARCHAR(1),
	@FParentItemid		INT,
	@FDate				NVARCHAR(8)
	
AS
BEGIN
	
	Create Table #ITEMPRICE(   
		 FIndex int IDENTITY, 
		 FItemID int null, 
		 FLastQty decimal(28,8) default(0) null, 
		 FLastAmount decimal(28,8) default(0) null, 
		 FPlanPrice decimal(28,8) default(0) null, 
		 FLastPrice decimal(28,8) default(0) null,
		 FNewPrice decimal(28,8) default(0) null) 
	create  index #idx_FItemID on #ITEMPRICE(FItemID)

	Create Table #ITEMSTOCKPRICE( 
		 FIndex int identity , 
		 FItemID int null , 
		 FInterid int null, 
		 FEntryid int null, 
		 FCheckdate datetime null, 
		 FPrice decimal(28,8) default(0) null ) 
	create clustered index #idx_ITEMStockPRICE_FItemID  on #ITEMSTOCKPRICE(FItemID)

	Create Table #BomCost( 
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
	create clustered index #idx_FItemID  on #BomCost(FItemID)

	Create Table #ParentData (
		 FIndex int identity , 
		 FItemID int null, 
		 FBom int default(0) null , 
		 FQty decimal(28,10) default(0) null, 
		 FObjID int default(0) null )  
	create index #idx_FItemID on #ParentData(FItemID)
	create clustered index #idx_FIndex on #ParentData(FIndex) 
	
	IF @FQufn IN('A','B','C')
	BEGIN
		Insert into #ParentData (FItemID,FBom,FQty,FObjID) 
		Select t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0
		  From t_ICItem t1 
		  inner join icbom t2 on t1.FItemID =t2.FItemID and t2.FUseStatus=1072 and t2.FStatus =1
		  Where (t1.FName like '%'+ISNULL(@FName,'')+'%' or t1.FModel like '%'+ ISNULL(@FName,'')+'%' )
			and t1.FNumber like '01.%'
	END
	ELSE 
	BEGIN
		Insert into #ParentData (FItemID,FBom,FQty,FObjID) 
		Select t1.FItemID,t2.FInterID ,round(1,t1.FQtyDecimal+2),0
		  From t_ICItem t1 
		  inner join icbom t2 on t1.FItemID =t2.FItemID and t2.FUseStatus=1072 and t2.FStatus =1
		  inner join t_Organization e1 on e1.FNumber=@FCusno 
		  inner join ICPrcPlyEntry e2 on e2.FInterID=4 and e2.FRelatedID =e1.FItemID and e2.FItemID =t1.FItemID 
		  Where (t1.FName like '%'+ISNULL(@FName,'')+'%' or t1.FModel like '%'+ ISNULL(@FName,'')+'%' )
		order by t1.FNumber 
	
	END
	
	SET NOCOUNT ON;

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
	Set nocount on 
	--- BOM展开表的特性信息 -------
	If Object_id('[tempdb].[dbo].[#TempChar]') Is Not Null 
	    TRUNCATE TABLE #TempChar
	 else 
	begin 
	Create Table #TempChar ( 
	    FIndex  int not null,   --关联TempBomOpenDest 的Findex字段
	    FCharID int null,       --特性ID
	    FCharValID  int null )   --特性值 
	END  

	--- 特性配置BOM展开临时表（结构相同于sDestTable） -------
	If Object_id('[tempdb].[dbo].[#TempBomOpen_Char]') Is Not Null 
		 TRUNCATE TABLE #TempBomOpen_Char 
	 else 
	 begin 
	 SELECT * INTO #TempBomOpen_Char FROM #BomData WHERE 1<>1  
	 END  

	declare @MinDate smalldatetime,@MaxDate smalldatetime
	declare @MinDayID int,@MaxDayID int
	select @MinDayID=Min(FInterID),@MaxDayID=Max(FInterID),@MinDate=Min(FDay),@MaxDate=Max(FDay) 
	from t_MutiWorkCal 
	where FCalID=999 and FInterID>0


	Insert into  #BomData  (  FParentItemID,FItemID  ,FNeedDate,FNeedQty,FRelNeedQty,FBOMLevel
							,  FItemType
							,  FParentID,FFixLeadTime,FObjID,FPlanTrategy,FOrderTrategy
							,  FHaveBomOpen,FBom,FSumParentTime,FLeadTime,FBatChangeEconomy
							,  FIsCharSourceItem, FSourceItemID, FCharConfigID, FBOMSkip
							,  FAuxPropID, FCalID
							, FDayID
							)
	Select u1.FItemID,u1.FItemID,u1.FDate,u1.FNeedQty,u1.FRelNeedQty, 0
		  , (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end) FItemtype
		  , 0, t1.FFixLeadTime, 0, isnull(t5_1.FID,'MRP'), isnull(t5_2.FID,'LFL')
		  , 0, u1.FBom,0, t1.FLeadTime, T1.FBatChangeEconomy
		  , ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) as FCharConfigID, t7.FBOMSkip
		  , FAuxPropID, Isnull(t2.FCalID,'999') as FCalID
		  , Isnull( (select FNxtID as FDayID from t_MutiWorkCal  where FCalID=Isnull(t2.FCalID,999) AND FDay = u1.FDate),@MinDayID)  as FDayID 
	 From (
		select distinct FItemID ,0 FObjID,FBom,convert(varchar(10),GetDate() ,121) as FDate,1 AS FNeedQty
			 , 1 AS FRelNeedQty From #ParentData 
		  ) u1
		INNER JOIN t_ICItem t1 ON U1.FItemID=T1.FItemID
		INNER JOIN t_Submessage t5   ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210 --物料基本信息
		LEFT JOIN t_Submessage t5_1 ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167  --计划策略
		LEFT JOIN t_SubMessage t5_2 ON t1.FOrderTrategy = t5_2.FInterID and t5_2.FTypeID = 169 --订货策略
		LEFT JOIN ICPlan_CharConfig t6 ON u1.FItemID = t6.FItemID AND t6.FCheckerID > 0 
		LEFT JOIN ICBom t7 ON u1.FBom = t7.FInterID 
		left join t_Department t2 on T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)  
	create index #idx_FItemID  on #BomData(FItemID) 
	create index #idx_FBOM  on #BomData(FBOM) 


	Update v1 
	   Set v1.FBom = u1.FInterID, FBomSkip=u1.FBomSkip , v1.FAuxPropID=u1.FAuxPropID
	  From #BomData v1 
	 INNER JOIN ICBom u1 ON v1.FItemID = u1.FItemID
	 Where  isnull(v1.FBom,0) = 0 and u1.FBomType <> 3 and u1.FUseStatus = 1072

	Update #BomData Set FGroupID = FIndex Where FBomLevel = 0 
	--更新特性物料的BOM
	Update #BomData
		Set  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FAuxPropID=C.FAuxPropID 
	From  #BomData  A
	   inner join ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0  --特性方案
	   INNER JOIN ICBOM C ON B.FBomInterID = C.FInterID 
	Where A.FIsCharSourceItem=0 AND A.FCharConfigID>0

	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	select A1.FIndex,C2.FCharID, C2.FCharValID
	From #BomData A1  --子项
		INNER JOIN ICPlan_CharConfig C1 ON A1.FItemID=C1.FItemID  --特性配置方案
		INNER JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	Where A1.FBomLevel = 0 AND  A1.FIsCharSourceItem=0 AND A1.FCharConfigID>0 

	Set nocount on 
	 Declare @BOMMaxLevel smallint 
	 Declare @BOMLevel smallint 
	 Declare @SelectRows int 
	 Declare @LastBomLevel int 

	 select @BOMMaxLevel = 30
	 select @BOMLevel =0 
	 Select @SelectRows = 0
	 Select @SelectRows = isnull(count(*),0) From #BomData     where FHaveBomOpen = 0 and FBomLevel = @BomLevel and FItemType > 0 
		 and FNeedQty>0 
	 while ( @SelectRows >0 and @BomLevel < @BomMaxLevel)
	 Begin 

		 --- From ICBOMChild 
		 Insert Into #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, 
			 FCalID, FDayID, FBOM ) 
		 Select  u1.FParentItemID,v2.FItemID, t10.FPreDay as FNeedDate,
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
	,t1.FQtyDecimal + 4)   as FNeedQty, 
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
	,t1.FQtyDecimal + 4)   as FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty As Float) * 1.0 / Cast(v1.FQty As Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 or v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID 
	 ,IsNull(t2.FCalID,'999') as FCalID 
	 ,t10.FPreID as FDayID 
	,0 AS FBOM      
	From (select * from #BomData 
			   where FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 
	 ) u1
	INNER JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	INNER JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID       
	INNER JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID                                                             
	INNER JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	left join t_Department t2 on T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left Join t_MutiWorkCal t3 on t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left Join t_MutiWorkCal T10 on t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 and t1.FDeleted=0 
	 --AND ISNULL(t1.FIsCharSourceItem,0)=0 and Isnull(t1.FCharSourceItemID,0)=0  --子项过滤掉特性来源物料和特性物料 
	 and (((v2.FMaterielType=371 or v2.FMaterielType=375)))
				 and u1.FIsCharSourceItem = 0 And u1.FCharConfigID = 0     --过滤掉特性来源物料和特性物料  

		 --- From ICCustChild
		 if @BomLevel >= 0 
		 Begin 
		 Insert Into #BomData
		 ( FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FRelScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, 
			 FCalID, FDayID, FBOM ) 
		 Select  u1.FParentItemID,v2.FItemID, 
	 t10.FPreDay as FNeedDate,
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
		)
	,t1.FQtyDecimal + 4)   as FNeedQty, 
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
	,t1.FQtyDecimal + 4)   as FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty As Float) * 1.0 / Cast(v1.FQty As Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 or v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , V2.FDetailID 
	 ,IsNull(t2.FCalID,'999') as FCalID 
	 ,t10.FPreID as FDayID 
	,ISNULL(V2.FCustBOMCode,0) AS FBOM      
	From (select * from #BomData 
			   where FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 ) u1
	INNER JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType=3                   
	INNER JOIN ICCustBOMChild V2  ON V1.FInterID=V2.FInterID 
	INNER JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID                                                             
	INNER JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	left join t_Department t2 on T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left Join t_MutiWorkCal t3 on t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left Join t_MutiWorkCal T10 on t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 and t1.FDeleted=0 
	 and (((v2.FMaterielType=371 or v2.FMaterielType=375)))

     End 
-------------------------------------特性配置处理开始------------------------------------------
	--1. --创建临时表
	--判断是否有特性来源物料/特性物料存在
	IF EXISTS (SELECT 1 FROM #BomData WHERE FBomLevel = @BomLevel AND (FIsCharSourceItem=1 OR FcharConfigID>0) )
	BEGIN

	--2. 处理父项为特性配置来源物料(特性物料的公用件也一样)
		 Insert Into #BomData
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay, FDetailID, FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID --, FBOMSkip
	,FCalID, FDayID 
	) 
		 Select u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay as FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   as FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   as FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty As Float) * 1.0 / Cast(v1.FQty As Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 or v2.FMaterielType=375) then 0 else 1 end ) FMeterialType, --FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay,u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	v2.FDetailID,0 AS FBOM  
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) as FCharConfigID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') as FCalID 
	 ,t10.FPreID as FDayID 
	From (select * from #BomData 
			where	FBomLevel = @BomLevel	and 
					FHaveBomOpen = 0		and 
					FItemType > 0			and 
					FNeedQty>0 				and 
					( FIsCharSourceItem=1 OR FcharConfigID>0 )     --特性来源物料和特性物料  
	) u1
	INNER JOIN	ICBOM v1				ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3                  
	INNER JOIN	ICBOMChild V2			ON V1.FInterID=V2.FInterID 
	INNER JOIN	T_ICItem t1				ON V2.FItemID=T1.FItemID  
	INNER JOIN	t_SubMessage t5			ON T1.FErpclsID=T5.FInterID			AND T5.FTypeID=210      --子项物料类型                 
	LEFT JOIN	t_Submessage t5_1		ON T1.FPlanTrategy=T5_1.FInterID	AND T5_1.FTypeID=167   --子项物料计划策略       
	LEFT JOIN	t_SubMessage t5_2		ON T1.FOrderTrategy=t5_2.FInterID	AND T5_2.FTypeID=169  --子项物料订货策略     
	LEFT JOIN	t_Submessage t5_3		ON V2.FMaterielType=T5_3.FInterID	AND T5_3.FTypeID=173  --子项物料属性         
	LEFT JOIN	t_SubMessage t5_4		ON V2.FmarshalType=T5_4.FInterID	AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN	ICPlan_CharConfig t6	ON V2.FItemID = t6.FItemID			and t6.FCheckerID > 0  
	left join	t_Department t2			on T1.FSource=t2.FItemID			and T1.FErpClsID  in (2,7,9)   
	Left Join	t_MutiWorkCal t3		on t3.FCalID = u1.FCalID			and t3.FInterID >0				and 
										t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	Left Join	t_MutiWorkCal T10		on t10.FCalID=Isnull(t2.FCalID,999)	and T10.FDay = Isnull(t3.FDay,@MinDate)
	 
	WHERE	1=1			and 
		t1.FDeleted=0	and 
		V2.FhasChar=0	and	--先只处理没有特性的公用件 
	  (((v2.FMaterielType=371 or v2.FMaterielType=375)))

	--3. 处理父项为特性物料:
	--    3.2 插入子项数据
		 Insert Into #TempBomOpen_Char 
		 (FParentItemID,FItemID,FNeedDate,FNeedQty,FRelNeedQty,FBomLevel,FItemType,
			 FParentID,FRate,FFixLeadTime,FScrap,FGroupID,FPlanTrategy,FOrderTrategy,
			 FHaveBomOpen,FObjID,FOperID,FMaterielType,FMarshalType,FSumLeadTime,FSumParentTime,       FLeadTime,FBatChangeEconomy,FSecInv,FBeginDate,FEndDate,FUpItemID,FUpBOM,FAuxPropID,FSPID,FStockID,FOffSetDay,  FBOM 
	, FIsCharSourceItem, FSourceItemID, FCharConfigID, FDetailID --, FBOMSkip
	,FCalID, FDayID 
	)
		 Select u1.FParentItemID,v2.FItemID,
	--当日期扣减小于1753-01-01将出现错误,由于BOM有效期最小1900，因此用1900
	 t10.FPreDay as FNeedDate,
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   as FNeedQty, 
	 round(convert(decimal(28,15),(convert(decimal(28,15),u1.FRelNeedQty) * convert(decimal(28,15), round(convert(decimal(28,15),v2.FQty) * convert(decimal(28,15),CONVERT(DECIMAL(28,15),1.0) / CONVERT(DECIMAL(28,15),v1.FQty)) ,t1.FQtyDecimal + 4))))*  convert(decimal(28,15), convert(decimal(28,15),(v2.FPercent /100))),t1.FQtyDecimal + 4)   as FRelNeedQty, 
		  (@BOMLevel +1) FBomLevel, (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 when 'PZL' then 4 when 'XNJ' then 10  when 'TZL' then 5 else 6 end)  FItemtype, 
		  u1.FIndex FParentID, round( Cast(v2.FQty As Float) * 1.0 / Cast(v1.FQty As Float),t1.FQtyDecimal + 4)  FRate,
		  t1.FFixLeadTime FFixLeadTime,0, u1.FGroupID,
		  isnull(t5_1.FID,'MRP'),isnull(t5_2.FID,'LFL'), 
		  (case when (v2.FMaterielType=371 or v2.FMaterielType=375) then 0 else 1 end ) FMeterialType,--FHaveBomOpen,
		  u1.FObjID,v2.FOperID,isnull(t5_3.FID,'COM'),isnull(t5_4.FID,'COM'),isnull(t1.FTotalTQQ,0),(isnull(u1.FFixLeadTime,0) + isnull(u1.FSumParentTime,0) ) FSumParentTime 
	 ,t1.FLeadTime,T1.FBatChangeEconomy,T1.FSecInv,v2.FBeginDay,V2.FEndDay, u1.FItemID,V1.FInterID,V2.FAuxPropID,V2.FSPID,V2.FStockID ,v2.FOffSetDay , 
	 0 AS FBOM 
	 ,ISNULL(t1.FIsCharSourceItem,0), ISNULL(t6.FSourceItemID,0), ISNULL(t6.FID,0) as FCharConfigID, v2.FDetailID 
	--, t7.FBOMSkip
	 ,IsNull(t2.FCalID,'999') as FCalID 
	 ,t10.FPreID as FDayID 

		 From (select * from #BomData 
			   where FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 
				 and FNeedQty>0 
				 and  FcharConfigID>0     --特性物料  
	) u1
	INNER JOIN ICBOM v1       ON /*u1.FItemID=V1.FItemID AND*/ u1.FBOM=V1.FInterID AND V1.FBOMType<>3  
	INNER JOIN ICBOMChild V2  ON V1.FInterID=V2.FInterID 
	INNER JOIN T_ICItem t1    ON V2.FItemID=T1.FItemID  
	INNER JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
	 LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
	 LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
	 LEFT JOIN t_Submessage t5_3  ON V2.FMaterielType=T5_3.FInterID AND T5_3.FTypeID=173  --子项物料属性         
	 LEFT JOIN t_SubMessage t5_4  ON V2.FmarshalType=T5_4.FInterID AND T5_4.FTypeID=174   --子项物料用途 通用、可选
	LEFT JOIN ICPlan_CharConfig t6 ON V2.FItemID = t6.FItemID and t6.FCheckerID > 0 
	left join t_Department t2 on T1.FSource=t2.FItemID and T1.FErpClsID  in (2,7,9)   
	 Left Join t_MutiWorkCal t3 on t3.FCalID = u1.FCalID and t3.FInterID >0 
				   and t3.FInterID = (u1.FDayID - CEILING(u1.FFixLeadTime+ u1.FRelNeedQty*(u1.FLeadTime/u1.FBatChangeEconomy))+ (case when v2.FOffSetDay > 0 then CEILING(v2.FOffSetDay) else FLOOR(v2.FOffSetDay) end )) 
	 Left Join t_MutiWorkCal T10 on t10.FCalID=Isnull(t2.FCalID,999)
				   and T10.FDay = Isnull(t3.FDay,@MinDate)
	 WHERE 1=1 
	AND t1.FDeleted=0 
	 and V2.FhasChar > 0  --有特性的子项 
	 and (((v2.FMaterielType=371 or v2.FMaterielType=375)))

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
		SELeCT U.FIndex,u3.FItemID as FParentItemID, U.FBom,U.FITEMID,U.FSourceItemID,U.FCharConfigID,D.FCHARID AS D_FCHARID,D.FCHARVALID,E.FNAME ,
			V.FCHARID AS FCHARID,b3.FCharID as b3_FCharID,b3.FCharValID as x_FCharValID
		--SELECT *
		FROM #TempBomOpen_Char U
		Full Join --BOM子项外关联特性, 使每个子项都有该BOM全部的特性(BOM子项的特性  union 表头特性物料特性)
		(   select DISTINCT FSourceItemID,FCharID from #TempBomOpen_Char a1
				inner join ICPlan_BOMChildChar b1 on a1.FDetailID=b1.FDetailID Where a1.FBOMLevel=@BomLevel+1
			Union
			select DISTINCT b2.FSourceItemID,c2.FCharID
				From #BomData /*#TempBomOpen_Char*/ a2
				inner join icplan_CharConfig b2 on a2.FCharConfigID=b2.Fid
				inner join icplan_charconfigEntry c2 on b2.fid=c2.fid
				Where a2.FBOMLevel=@BomLevel
		)  V ON  U.FSourceItemID=v.FSourceItemID
		Left  Join  ICPlan_BOMChildChar D --获得BOM子项的特性值
			ON  U.FDetailID=D.FDetailID and V.FCharID=d.FCharID
		LEFT JOIN ICPlan_CharacteristicEntry E ON D.FCHARVALID=E.FCHARVALID
	   --获得父项的特性过滤条件
		Inner join #BomData as u3 on U.FParentID=u3.FIndex and u3.FBOMLevel=@BOMLevel --父项物料
		LEFT Join icplan_CharConfig a3 on u3.FItemID=a3.FItemID and a3.FCheckerID > 0 
		LEFT join icplan_charconfigEntry b3 on a3.fid=b3.fid and D.FCHARID=b3.FCHARID --特性匹配
		WHERE ( 1=1 AND U.FBOMLevel=@BOMLevel + 1
		AND ISNULL(D.FCHARVALID,0)=0 OR ISNULL(b3.FCHARVALID,0)=0 OR D.FCHARVALID=b3.FCHARVALID
		)  --ORDER BY  B.FINTERID,B.FENTRYID,B.FITEMID, V.FCHARID
	) M GROUP BY  FIndex,FParentItemID,FBom,FITEMID,FSourceItemID, FCHARID
	) N GROUP BY FIndex,FParentItemID,FBom,FITEMID,FSourceItemID
	HAVING COUNT(*) >=
		  ( SELECT COUNT(*) FROM
			  (   select DISTINCT FSourceItemID,FCharID from #TempBomOpen_Char a1
					  inner join ICPlan_BOMChildChar b1 on a1.FDetailID=b1.FDetailID Where a1.FBOMLevel=@BomLevel+1
				   Union
				   select DISTINCT a2.FSourceItemID,c2.FCharID
				   From #BomData /*#TempBomOpen_Char*/ a2
					   inner join icplan_CharConfig b2 on a2.FCharConfigID=b2.Fid
					   inner join icplan_charconfigEntry c2 on b2.fid=c2.fid
				   Where a2.FBOMLevel=@BomLevel
			  )   P
			Where P.FSourceItemID = N.FSourceItemID
			GROUP BY  FSourceItemID
		  )
	) t2 on t1.FIndex=t2.FIndex 
	 Where t1.FBomLevel= @BOMLevel +1 and t2.FIndex is Null 
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
	   INNER JOIN ICBOM C ON A.FItemID = C.FItemID
	Where A.FBOMLevel= @BOMLevel +1 AND A.FBom = 0  and C.FUseStatus = 1072
	--5.  更新所有子项为特性配置来源物料, 根据BOM和特性来判断是否已有特性物料，如果有则更新为特性物料。

	--5.1 若是子项有特性来源物料，需要继承特性，保存到#TmpChar（参考GetCharBomOpen函数）
		--(子项没有父项的特性,则该特性被过滤
		--子项有父项没有的特性, 则特性值为空)
	INSERT into #TempChar (Findex, FCharID, FCharValID )
	SELECT A1.FIndex, C2.FcharID, B2.FCharValID
	From #BomData A1  --子项
		INNER JOIN ICPLAN_ItemChar C1 ON A1.FItemID=C1.FItemID  --子项特性范围表
		INNER JOIN ICPLAN_ItemCharEntry C2 ON C1.FID=C2.FID
		INNER JOIN #BomData  A2  ON A1.FParentID =A2.FIndex --父项
		Left Join #TempChar  B2  ON A2.Findex=B2.Findex  --父项特性
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
			Inner join ICPlan_CharConfig B ON A.FItemID=B.FSourceItemID AND B.FCheckerID > 0 
			Left Join   --也可以处理成NOT IN 语句
			(    --查询出有特性不匹配的特性方案
			SELECT DISTINCT FIndex,FID FROM
				(
				SELECT  A1.Findex,CASE WHEN B1.FID IS NULL THEN B2.FID ELSE B1.FID END AS FID,
						B1.FITEMID,B1.FSOURCEITEMID,A2.FcharValID AS FSourceCharValID, B2.FcharValID AS FCharValID
				FROM  (SELECT * FROM #BomData WHERE FBOMLevel=@BOMLevel+1 AND FCharConfigID=0 ) A1
				Inner join #TempChar A2 ON A1.Findex= A2.FIndex
				INNER join  ICPlan_CharConfig B1 ON A1.FitemID=B1.FsourceItemID and A1.FBOM=B1.FBOMInterID AND B1.FCheckerID > 0 
				FULL join ICPlan_CharConfigEntry B2  ON B1.FID = B2.FID AND  A2.FCharValID= B2.FCharValID
					Where (A2.FcharValID Is Null Or B2.FcharValID Is Null)
				) AS M
			)  C  ON  (A.FIndex=c.FIndex or c.findex is null) and B.FID=C.FID
		   INNER JOIN T_ICItem t1    ON B.FItemID=T1.FItemID -- AND t1.FDeleted = 0 
		   INNER JOIN t_SubMessage t5    ON T1.FErpclsID=T5.FInterID AND T5.FTypeID=210      --子项物料类型                 
		   LEFT JOIN t_Submessage t5_1  ON T1.FPlanTrategy=T5_1.FInterID AND T5_1.FTypeID=167   --子项物料计划策略       
		   LEFT JOIN t_SubMessage t5_2  ON T1.FOrderTrategy=t5_2.FInterID AND T5_2.FTypeID=169  --子项物料订货策略     
		Where C.FID IS NULL AND A.FBOMLevel= @BOMLevel+1 AND A.FIsCharSourceItem = 1 AND A.FCharConfigID=0

			AND EXISTS (SELECT 1 FROM #TempChar X WHERE A.FIndex=X.FIndex) 

	AND t1.FDeleted=0 

	END              ----判断是否有特性来源物料/特性物料存在

	--更新特性物料的相关信息
	Update A
		Set  FBOM = B.FBomInterID , FBomSkip=C.FBomSkip, FCharConfigID= isnull(b.Fid,0), 
		FSourceItemId=t1.FCharSourceItemId 
	From  #BomData  A 
	   INNER JOIN t_icItemPlan t1 on A.FItemID=t1.FItemID 
	   Left join ICPlan_CharConfig  B ON A.FitemID=B.FitemID AND B.FCheckerID > 0 --特性方案 
	   INNER JOIN ICBOM C ON B.FBomInterID = C.FInterID 
			WHERE A.FBomLevel = @BOMLevel +1 AND T1.FCharSourceItemId > 0 
	INSERT INTO #TempChar (Findex, FCharID, FCharValID )
	select A1.FIndex,C2.FCharID, C2.FCharValID
	From #BomData A1  --子项
		INNER JOIN ICPlan_CharConfig C1 ON A1.FItemID=C1.FItemID AND C1.FCheckerID > 0  --特性配置方案
		INNER JOIN ICPlan_CharConfigEntry C2 ON C1.FID=C2.FID
	Where  A1.FBomLevel = @BOMLevel + 1 AND   A1.FCharConfigID>0 
	-------------------------------------特性配置处理结束------------------------------------------

	 Update v1 Set v1.FBom = u1.FInterID, v1.FBomSkip=u1.FBomSkip 
	 From #BomData v1, ICBom u1 
	 Where v1.FBomLevel = @BomLevel + 1 and v1.FItemType > 0 and v1.FItemID = u1.FItemID 
	 and isnull(v1.FBom,0) = 0 and u1.FBomType <> 3 and u1.FUseStatus = 1072
		 Update #BomData Set FHaveBomOpen = 1 
		 Where FBomLevel = @BomLevel and FHaveBomOpen = 0 and FItemType > 0 and FNeedQty>0 
		 Select @BomLevel = @BomLevel + 1 
		 Select @SelectRows = 0
		 Select @SelectRows = isnull(count(*),0) From #BomData     where FHaveBomOpen = 0 and FBomLevel = @BomLevel and FItemType > 0 
		 and FNeedQty>0 
	 End 

	 Delete From #BomData Where (FItemType = 10 or FItemType = 5 or (FBomSkip=1058 AND FBomLevel> 0)  )
	----跳层为是,则按虚拟件处理 
	Update #BomData SET FItemType = 10 WHERE FBomSkip=1058 

	DROP TABLE #TempChar 
	DROP TABLE #TempBomOpen_Char 

	 -------------- BOM展开嵌套SQL 结束 ------------------------------------

	 Insert into #ITEMPRICE (FItemID,FPlanPrice) 
	 Select v1.FItemID,isnull(t1.FPlanPrice,0) 
	 From (select FItemID,sum(FNeedQty) FNeedQty
		   From #BomData Where FBomLevel > 0 and FItemType =0
		   Group by FItemID) v1 left outer join  t_ICItem t1 on v1.FItemID =t1.FItemID  

	 Update u1 set u1.FLastPrice = (case when( isnull(u2.FLastAmount,0) =0 or isnull(u2.FLastQty,0) = 0) then 0 else round(u2.FLastAmount / u2.FLastQty,tt1.FPriceDecimal) end )  
	 From #ITEMPRICE u1, t_Icitem tt1 ,(      Select v1.FItemID,sum(round(isnull(v1.FBegQty,0),t1.FPriceDecimal)) FLastQty ,sum(Round(isnull(v1.FBegBal,0),t1.FPriceDecimal)) FLastAmount 
		 From ICBal v1,t_ICItem t1
		 where v1.FYear = 2014 and v1.FPeriod = 8
		 and v1.FItemID in (select s1.FItemID From #ItemPrice s1) 
		 and not (v1.FBegQty = 0 and v1.FBegBal = 0) and v1.FItemID = t1.FItemID 
		 group by v1.FItemID ) u2
	 Where u1.FItemID = u2.FItemID and u1.FItemID = tt1.FItemID 

		  Insert into #ITEMSTOCKPRICE (FItemID,FInterid,FEntryid,FCheckdate,FPrice)
	--取得每个物料的最新价格 
	SELECT vv2.FItemId ,vv1.FInterid,vv2.FEntryid, vv1.fCheckdate  ,vv2.FPrice 
					 FROM  icstockbill vv1 inner join icstockbillentry vv2  on vv2.finterid = vv1.finterid 
	 inner join #ITEMPRICE u on vv2.FItemID=u.FItemID  
	 inner join (select T2.FItemID,max(T1.FCheckDate) As FCheckDate FROM  icstockbill T1 inner join icstockbillentry T2  on T1.finterid = T2.finterid 
		Where  T1.FTranType in (1,2,5,10)  and T2.fprice <> 0 and T1.Fdate<=convert(char(10),getdate(),121) 
		group by T2.FItemID) TmpA on TmpA.FItemID=vv2.FItemID and TmpA.FCheckDate=vv1.fCheckDate 
					Where  
						  vv1.FTranType in (1,2,5,10)  and vv2.fprice <> 0 and vv1.Fdate <=convert(char(10),getdate(),121) 
					--group by vv2.FItemId,  vv1.fCheckdate  , vv1.finterid,  vv2.fentryid 
				order by  vv2.FItemId, vv1.fCheckdate  desc, vv1.finterid desc ,vv2.fentryid desc 

		 Update u1 set u1.FNewPrice = isnull(u2.FPrice,0) 
		 From #ITEMPRICE u1 Left Join 
	( Select  v2.FItemID,v2.Fprice
	from  #ITEMSTOCKPRICE v2   
	where  CONVERT(VARCHAR,v2.FItemID)+'|' + CONVERT(VARCHAR,v2.fCheckdate,111) + '|' + CONVERT(VARCHAR,v2.finterid) +'|' + CONVERT(VARCHAR,v2.fentryid) 
	=(SELECT top 1 CONVERT(VARCHAR,vv2.FItemId ) + '|' + CONVERT(VARCHAR,vv2.fCheckdate,111) + '|'+ CONVERT(VARCHAR,vv2.finterid) +'|' + CONVERT(VARCHAR,vv2.fentryid) 
					 FROM  #ITEMSTOCKPRICE vv2   
					Where V2.FItemid = vv2.FItemid order by Vv2.FItemID,vv2.fcheckDate desc,vv2.finterid desc,vv2.fentryid desc )
	) u2 
			 On u1.FItemID  = u2.FItemID 

		 Update u1 set u1.FNewPrice =u1.FLastPrice  
		 From #ITEMPRICE u1  
	   where exists       (Select v2.FItemID 
			 from ICStockBill v1 inner join ICStockBillEntry v2 on v1.finterid = v2.finterid 
			 where v1.FTranType in (1,2,5,10) and convert(char(8),v1.Fdate,112)<=@FDate
	 and v1.FStatus > 0  and u1.FItemId =v2.FItemId ) 
		and u1.FNewPrice=0 

     Update u1 set u1.FNewPrice = u1.FPlanPrice From #ITEMPRICE u1 where u1.FNewPrice=0

	 Insert into #BomCost(FParentItemid ,FItemID,FNumber,FShortNumber,FName,FUnitName,QtyDecimal,PriceDecimal
		 ,  FModel,FQty,FPlanPrice,FPlanAmount,FLastPrice,FLastAmount,FNewPrice,FNewAmount) 
	 Select V1.FParentItemID,v1.FItemID,t1.FNumber,t1.FShortNumber,t1.FName,t2.FName FUnitName,t1.FQtyDecimal,t1.FPriceDecimal,
	  isnull(t1.FModel,'') FModel,(convert(decimal(28,15),v1.FNeedQty) * convert(decimal(28,15),u1.FQty)) Fqty ,v2.FPlanPrice,0.0 FPlanAmount,
	  v2.FLastPrice,0.0 FLastAmount, 
	  v2.FNewPrice, 0.0 FNewAmount 
	 From (select FParentItemID, FItemID, sum(FNeedQty) FNeedQty
		   From #BomData Where FBomLevel > 0 and FItemType =0 
		   Group by FParentItemID, FItemID)  v1,#ItemPrice v2,#ParentData u1,t_IcItem t1,t_MeasureUnit t2 
	 Where v1.FParentItemID = u1.FItemID and v1.FItemID = v2.FItemID and t1.funitid=t2.fitemid
	  and v1.FItemID = t1.FItemID  Order By t1.FNumber 

	 Update v1 Set v1.FPlanAmount =convert(decimal(28,15),v1.Fplanprice) * convert(decimal(28,15),v1.Fqty), 
	   v1.FLastAmount = convert(decimal(28,15),v1.FLastPrice) * convert(decimal(28,15),v1.FQty), 
	   v1.FNewAmount =  convert(decimal(28,15),v1.FnewPrice) * convert(decimal(28,15),v1.FQty) 
	 From #BomCost v1, t_ICItem t1 
	 where v1.FItemID = t1.FItemID
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
	select A.FParentItemid ,A.FItemID--, b.FNumber ,b.FName ,c.FNumber ,c.FName ,c.FPlanPrice
         , (case when (B.FName like 'NBD-%' OR B.FName like 'TBD-%') THEN  round((c.FPlanPrice+22.5)/1.17,4) 
				 when b.FName like 'SBD-%' THEN round((c.FPlanPrice+22)/1.17,4) 
                 ELSE round((c.FPlanPrice+12)/1.17,4)  END) AS FPlanPrice
	 from #BomCost A
	 inner join t_ICItem B on B.FItemID =A.FParentItemid   --成品
	 inner join t_ICItem c on c.FItemID =A.FItemID 
	 where A.FItemID =208607
	 --order by b.FName 
	) A
 INNER JOIN #BomCost B ON A.FParentItemid =B.FParentItemid AND A.FItemID =B.FItemID 
 WHERE b.fitemid=208607   ---铝杆
*/
 
 
 ---将纸箱价格清空
 update #BomCost
 set FNewPrice=0,FNewAmount=0
 where FItemID in(
 select c.FItemID from #BomCost a
 inner join t_ICItem b on a.FParentItemid =b.FItemID 
 inner join t_ICItem c on c.FItemID =a.FItemID 
 where (substring(c.FModel,len(c.FModel)-1,2))='90' AND (A.FName LIKE '%纸箱%' OR A.FName LIKE '%包装箱%') 
 )
 
 Insert into #BomCost(FParentItemid ,FNumber,FShortNumber,FQty,FPlanAmount,FLastAmount,FNewAmount)
 Select FParentItemid ,'合计','合计',sum(v1.FQty), sum(v1.FPlanAmount),Sum(v1.FLastAmount),sum(v1.FNewAmount) 
 From #BomCost v1 
 GROUP BY FParentItemid 
 
 ------ 对没有计划单价的 从 供应商价格体系中取最大的报价------ 吴总指示  20141220
UPDATE #BomCost
SET FPlanPrice=a.FPrice/1.17,FPlanAmount=A.FPrice/1.17 *FQty 
from (
	SELECT FItemID, max(FPrice) as FPrice
	 from t_SupplyEntry 
	group by FItemID 
	) a
inner join #BomCost b on b.FItemID=a.FItemID 
where b.FPlanPrice=0
AND b.FNumber <>'合计'	  

------更新为零的计划单价后再更新合计计划金额  同上一起做的  
update #BomCost 
set FPlanAmount =a.FPlanAmount
from (
select FParentItemid ,SUM(FPlanAmount )as FPlanAmount from #BomCost 
where FNumber <>'合计'	  
group by FParentItemid ) a
inner join #BomCost b on a.FParentItemid =b.FParentItemid 
where FNumber ='合计'	  

 ------------------成本BOM 查询结束------------------
 
 ------------将结果显示出来-------------------  
 if @FQufn ='A'
 BEGIN
	  select a.FItemID ,b.FNumber, b.FName,isnull(b.FModel,'') as FModel
		   , k.FName as FErpClsName,isnull(d.fname,'') as FUnitID
		   , a.FQty, a.FYield, a.FUseStatus as FUseStatusNum
		   , (case a.FUseStatus when 1072 then '使用' else '未使用' end) as FUseStatus
		   , a.FVersion,b.FChartNumber,i.FRoutingName as FRoutingID 
		   , isnull(g.Fname,'') as  FCheckID,  a.FCheckDate,isnull(h.fname,'') as FOperatorID
		   , a.FEnterTime,a.FNote,round(b.FPlanPrice,b.FPriceDecimal) FPlanPrice
		   , round(CAST( a.FQty AS Decimal(28,15)) * CAST( b.FPlanPrice AS DECIMAL(28,15)),b.FPriceDecimal) as FPlanAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( b.FPlanPrice AS DECIMAL(28,15) ) InitFPlanAmount
		   , a.FitemID EditFitem,b.FQtyDecimal FQtyDecimal,b.FQtyDecimal FInitDecimal,b.FPriceDecimal
		   , isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) FNewPrice
		   , round(CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) AS DECIMAL(28,15) ),b.FPriceDecimal) as FNewAmount
		   , CAST( a.FQty AS DECIMAL(28,15) ) * CAST( isnull(case when u2.FItemID is null then b.FPlanPrice else isnull(u2.FPrice,0) end,0) AS DECIMAL(28,15) ) as FInitNewAmount 
		   , isnull(convert(varchar(20),convert(decimal(28,2),e.FNewAmount)),0) FNewAmount_detail
		   , isnull(e.FNewAmount,0) InitFNewAmount_detail
		   , ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
		   ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要在取值了
		   , (case when ISNULL(s1.FName,'N')='N' THEN
				  (case when b.F_119>0 then ROUND(((ISNULL(b.F_119,0)+ISNULL(b.F_120,0))*0.001+0.08+0.018)*((ISNULL(b.F_120,0)*2+ISNULL(b.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				   ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				   ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
				   else 0 end)
			  ELSE 0 END)  as 小箱套价格  ---不含税单价
		   , round(ISNULL(E.FPlanAmount,0)+(CASE WHEN ISNULL(s1.FName,'N')='N' THEN (case when b.F_119>0 then ROUND(((ISNULL(b.F_119,0)+ISNULL(b.F_120,0))*0.001+0.08+0.018)*((ISNULL(b.F_120,0)*2+ISNULL(b.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2)
				 else 0 end) ELSE 0 END),2)  as tot_amount
		   , case when (f.con1 >0 or f2.con1 IS null) then 'N' ELSE 'Y' END AS QFCN1
		   , s1.FName as BOM_YN
	 from icbom a 
	 inner join t_icitem b on (a.FItemID = b.FItemID) 
	 inner join #ParentData c on c.FBom=a.FInterID and c.FItemID =a.FItemID  
	 left join T_MeasureUnit d on (b.FUnitID = d.FItemID) 
	 left join t_user g on (a.FCheckID = g.FUserID ) 
	 left join t_user h on (a.FOperatorID = h.FUserID) 
	 Left join T_routing i on (a.FRoutingID = i.FInterID)
	 left join (
		Select top 1 v2.FItemID,v2.Fprice 
		  from icstockbill v1 
		  inner join icstockbillentry v2  on v2.finterid = v1.finterid 
		 Where v1.FTranType in (1,2,5,10) and v2.FItemID =41264
		   and v1.FStatus > 0 
		   and  v2.fprice <> 0 and v1.Fdate <GetDate() 
		 order by  v1.fCheckdate desc ,v1.finterid desc,v2.fentryid desc 
	   ) u2 On a.FItemID  = u2.FItemID 
	 Left Join (
		Select top 1 v2.FItemID 
		  from ICStockBill v1 
		  inner join ICStockBillEntry v2 on v1.finterid = v2.finterid 
		  where v1.FTranType in (1,2,5,10) and v2.FItemID =41264 and v1.FStatus > 0 
		   and convert(char(8),v1.Fdate,112)<=@FDate  order by v1.fdate desc,v1.FInterID desc
	   ) u3 On a.FItemID  = u2.FItemID  
	  Left join t_submessage k on k.FINTERID=b.Ferpclsid 
	  left outer join #BomCost e on e.FParentItemid =a.FItemID  and e.FNumber ='合计'
	  left outer join ( ----有详细内容的里面有为零的
			select FParentItemid, COUNT(*) as con1 from #BomCost 
			where FNumber <>'合计' and isnull(FPlanAmount,0)=0
			group by FParentItemid 
			) f on f.FParentItemid =a.FItemID  
	  left outer join (  ---没有任何详细内容的
			select FParentItemid, COUNT(*) as con1 from #BomCost 
			where FNumber <>'合计' 
			group by FParentItemid 
			)f2 on f2.FParentItemid =a.FItemID  
	  left outer join t_SubMessage s1 on s1.FParentID='10012' and s1.FInterID =a.FHeadSelfZ0134 
	  order by B.FNumber
   
   END
   ELSE IF @FQufn ='B'
   BEGIN
		Select a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' else '' end) as FErpClsnm
			 , ROUND(((ISNULL(c.F_119,0)+ISNULL(c.F_120,0))*0.001+0.08+0.018)*((ISNULL(c.F_120,0)*2+ISNULL(c.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 as 小箱套价格	  ---不含税单价
		from #BomCost A
		left outer join t_ICItem b on a.FItemID =b.FItemID 
		left outer join t_ICItem c on c.FItemID =a.FParentItemid 
		WHERE FParentItemid =@FParentItemid
		order by FParentItemid , FIndex    
   
   END 
   ELSE IF @FQufn ='C'
   BEGIN
		Select c.FNumber as fparent_fnumber,c.FName as fparent_fname
		     , a.* 
			 , (CASE WHEN b.FErpClsID=1 THEN '外购' WHEN b.FErpClsID=2 THEN '自制' WHEN b.FErpClsID=3 THEN '委外加工'
					 WHEN b.FErpClsID=5 THEN '虚拟件' else '' end) as FErpClsnm
			 , ROUND(((ISNULL(c.F_119,0)+ISNULL(c.F_120,0))*0.001+0.08+0.018)*((ISNULL(c.F_120,0)*2+ISNULL(c.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
				 ROUND((ISNULL(c.F_122,0)*0.001+0.04)*((ISNULL(c.F_123,0)+40)*0.001)*2.59/1.17,2) +
				 ROUND(((ISNULL(c.F_126,0)*0.001)*4+0.1+(ISNULL(c.F_124,0)*0.001)+0.01*4)*(ISNULL(c.f_125,0)*0.001)*2.59/1.17,2) 
				 as 小箱套价格		  ---不含税单价
		from #BomCost A
		left outer join t_ICItem b on a.FItemID =b.FItemID 
		left outer join t_ICItem c on c.FItemID =a.FParentItemid 
		order by C.FNumber, FIndex    
   
   END 
   ELSE IF @FQufn ='Z'
   BEGIN
   
		SELECT C.FNumber AS 客户代码, c.FName as 客户名称, I.FMapNumber as 客户对应物料代码
			 , I.FMapName AS 客户对应物料名称, B.FNumber AS 物料代码
			 , B.FName AS 物料名称 ,B.F_146 AS 英文名称,B.FModel AS 规格型号, d.FName as 辅助属性
			 , E.FNumber AS 计量单位代码, E.FName as 计量单位
			 , B.F_131 AS 'OE代码', B.F_132 AS 'DPI代码', J.FName AS '产品结构形式' 
			 , J2.FName AS '芯体颜色标准', A.FBegQty AS '销货量(从)', A.FEndQty AS '销货量(到)'
			 , F.FNumber AS 币别代码, f.FName as 币别
			 , G.FID AS 价格类型代码 , g.FName as 价格类型
			 , A.FPrice as 报价, F2.FName as 最低限价币别, A2.FLowPrice as 最低限价金额
			 , b2.FPlanAmount_detail  as 成本价, b2.小箱套价格不含税
			 , CONVERT(CHAR(10),A.FBegDate,120) AS 生效日期, CONVERT(CHAR(10),a.FEndDate,120) as 失效日期
			 , A.FLeadTime as 销售提前期, A.FNote AS 备注
			 , (CASE WHEN A.FChecked=1 THEN '是' else '否' END) AS 审核标志
			 , (CASE WHEN A2.FCanSell=1 THEN  '是' else '否' END) AS 允许销售
			 , (CASE WHEN A2.FLPriceCtrl=1 THEN '是' else '否' END) AS 最低价格控制
			 , H.FName AS 维护人, CONVERT(CHAR(10),A.FMaintDate,120) AS 维护日期, H2.FName AS 审核人
			 , (CASE WHEN CONVERT(DATETIME, a.FCheckDate) = '1900-01-01' THEN NULL ELSE CONVERT(CHAR(10),a.FCheckDate,120)  END) AS 审核日期
			 , B.F_104 AS 包装箱体积
			 , ( select top 1 isnull(FExchangeRate,0)  from t_ExchangeRateEntry  where FExchangeRateType=1 and GETDATE() between FBegDate and FEndDate and FCyTo =1000) as 美元汇率
			 , (A.FPrice*( select top 1 isnull(FExchangeRate,0)  from t_ExchangeRateEntry  where FExchangeRateType=1 and GETDATE() between FBegDate and FEndDate and FCyTo =1000)
			 	 - b2.FPlanAmount_detail-b2.小箱套价格不含税 ) as 边际利润
			 , b2.QFCN1, b2.BOM_YN 
		  FROM ICPrcPlyEntry A
		 INNER JOIN ICPrcPlyEntrySpec A2 ON A.FInterID = A2.FInterID AND A.FItemID = A2.FItemID AND A.FRelatedID = A2.FRelatedID
		 INNER JOIN ICPrcPly A3 ON A3.FInterID =A.FInterID
		 INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
		 LEFT  JOIN t_Organization C ON a.FRelatedID=C.FItemID AND C.FItemID<>0
		  LEFT JOIN t_AuxItem D ON A.FAuxPropID=D.FItemID AND D.FItemID<>0							--辅助属性
		  LEFT JOIN t_Measureunit E ON A.FUnitID=E.FItemID AND E.FItemID<>0							--单位
		  LEFT JOIN t_Currency F ON A.FCuryID=F.FCurrencyID AND F.FCurrencyID<>0						--币别
		  LEFT JOIN t_Currency F2 ON A2.FLPriceCuryID=F2.FCurrencyID AND F2.FCurrencyID<>0			--最低限价币别
		  LEFT JOIN t_SubMessage G ON A.FPriceType=G.FInterID AND G.FInterID<>0						--价格类型
		  LEFT JOIN t_User H ON A.FMainterID=H.FUserID AND H.FUserID<>0								--维护人
		  LEFT JOIN t_User H2 ON A.FCheckerID=H2.FUserID AND H2.FUserID<>0
		  LEFT OUTER JOIN ICItemMapping I ON B.FItemID = I.FItemID AND I.FPropertyID = 1 AND A.FRelatedID = I.FCompanyID
		  LEFT OUTER JOIN t_SubMessage J ON J.FParentID =10007 AND J.FInterID =B.F_134
		  LEFT OUTER JOIN t_SubMessage J2 ON J2.FParentID=10008 AND J2.FInterID = B.F_135
		  left outer join (
				select a.FItemID, ISNULL(E.FPlanAmount,0) AS FPlanAmount_detail
					 ---BOM 一审标志为'Y'表示纸箱的BOM 已经创建完成，所以小箱套的价格不需要在取值了
					 , (case when ISNULL(s1.FName,'N')='N' THEN 
					        (case when b.F_119>0 then ROUND(((ISNULL(b.F_119,0)+ISNULL(b.F_120,0))*0.001+0.08+0.018)*((ISNULL(b.F_120,0)*2+ISNULL(b.F_121,0))*0.001+0.04+0.01)*2*2.59/1.17,2)+
								ROUND((ISNULL(b.F_122,0)*0.001+0.04)*((ISNULL(b.F_123,0)+40)*0.001)*2.59/1.17,2) +
								ROUND(((ISNULL(b.F_126,0)*0.001)*4+0.1+(ISNULL(b.F_124,0)*0.001)+0.01*4)*(ISNULL(b.f_125,0)*0.001)*2.59/1.17,2) 
						     else 0 end)
						 ELSE 0 END)  as 小箱套价格不含税
					 , case when (f.con1 >0 or f2.con1 IS null) then 'N' ELSE 'Y' END AS QFCN1
					 , S1.FName AS BOM_YN
				from icbom a 
				inner join t_icitem b on (a.FItemID = b.FItemID) 
				inner join #ParentData c on c.FBom=a.FInterID and c.FItemID =a.FItemID  
				left outer join #BomCost e on e.FParentItemid =a.FItemID  and e.FNumber ='合计'
				left outer join ( ----有详细内容的里面有为零的
					select FParentItemid, COUNT(*) as con1 from #BomCost 
					where FNumber <>'合计' and isnull(FPlanAmount,0)=0
					group by FParentItemid 
				) f on f.FParentItemid =a.FItemID  
				left outer join (  ---没有任何详细内容的
					select FParentItemid, COUNT(*) as con1 from #BomCost 
					where FNumber <>'合计' 
					group by FParentItemid 
				)f2 on f2.FParentItemid =a.FItemID 
				left outer join t_SubMessage s1 on s1.FParentID='10012' and s1.FInterID =a.FHeadSelfZ0134 
			) b2 on b2.FItemID =a.FItemID  
		  WHERE a.FInterID=4  AND B.FDeleted=0
		  AND c.fnumber=@FCusNo
		  AND (B.FNAME LIKE '%'+ISNULL(@FName,'') +'%' or B.FModel like '%'+ ISNULL(@FName,'')+'%' )
		  ORDER BY B.FNumber
  
  END
 -----------将临时表删除
 Drop table #ItemPrice 
 Drop Table #BomCost 
 Drop Table #ParentData 
 Drop Table #ITEMSTOCKPRICE 
 Drop Table #BomData 
	
END