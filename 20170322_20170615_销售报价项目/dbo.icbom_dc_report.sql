-- =============================================
-- Author:		<BY YangYuan>
-- Create date: <2015-01-09>
-- Description:	<BOM 多层展开 工艺路线多层展开 报表使用
-- @Fqufen =‘A' 单层BOM 展开
-- @Fqufen=’B'  工艺路线多层展开 2015-09-10  财务盛红春 徐君芳 要求
-- 否则 BOM 多层展开>
-- =============================================
CREATE PROCEDURE [dbo].[icbom_dc_report]
	@FinterID INT,
	@Fqufen	  VARCHAR(1)
AS
BEGIN

	SET NOCOUNT ON;
	Create Table #Mutidata (
			FIndex				int IDENTITY,
			FEntryID			INT, 
			FBomInterid			int, 
			FItemID				int null, 
			FNeedQty			decimal(28,14) default(0) null, 
			FBOMLevel			int null, 
			FItemType			int null, 
			FParentID			int default(0)null, 
			FRate				decimal(28,14) default(0) null, 
			FHistory			int default(0) null, 
			FHaveMrp			smallint default(0) null, 
			FLevelString		varchar(200) null, 
			FBom				int, 
			FMaterielType		int  default(371) null,
			FOperSN				Int NULL DEFAULT(0),
			FOperID				int default(0),
			FRootBOMID			int default(0)
		) 
	Create Table #MutiParentItem(
			FIndex				int IDENTITY,
			FEntryID			INT default(0), 
			FBomInterid			int, 
			FItemID				int null, 
			FNeedQty			decimal(28,14) default(0) null, 
			FBOMLevel			int null, 
			FItemType			int null,  
			FParentID			int default(0)null, 
			FRate				decimal(28,14) default(0) null, 
			FHistory			int default(0) null, 
			FHaveMrp			smallint default(0) null, 
			FLevelString		varchar(200) null , 
			FBom				int, 
			FMaterielType		int  default(371) null,
			FOperSN				Int NULL DEFAULT(0),
			FOperID				int default(0),
			FRootBOMID			int default(0)
			) 
	Create Table #Errors (
			FIndex				int IDENTITY, 
			FType				smallint default(0), 
			FErrText			nvarchar(355) 
		)
	IF @Fqufen ='B'		---工艺路线多层展开  使用的是物料内码
	BEGIN	
		Insert into #mutiParentItem (fbominterid,FItemID,FNeedQty,FBOMLevel,FParentID,FItemType,FBom,FRootBOMID) 
		Select a.finterid, t1.FItemID,a.fqty, 0,0
			 , (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 else 2 end) FItemtype
			 , t1.FItemID,a.finterid 
		  From icbom a
		 inner join t_ICItem t1 on t1.FItemID = a.fitemid
		 left join t_Submessage t5 on t1.FErpClsID = t5.FInterID 
		 where t5.FTypeID = 210 and  T1.FItemID =@FinterID
		 AND A.FStatus =1 AND A.FUseStatus=1072
	END
	ELSE			---BOM 单层展开和多层展开 使用的是 BOM内码
	BEGIN
		Insert into #mutiParentItem (fbominterid,FItemID,FNeedQty,FBOMLevel,FParentID,FItemType,FBom,FRootBOMID) 
		Select a.finterid, t1.FItemID,a.fqty, 0,0
			 , (case t5.FID when 'WG' then 0 when 'ZZ' then 1 when 'WWJG' then 1 else 2 end) FItemtype
			 , t1.FItemID,a.finterid 
		  From icbom a
		 inner join t_ICItem t1 on t1.FItemID = a.fitemid
		 left join t_Submessage t5 on t1.FErpClsID = t5.FInterID 
		 where t5.FTypeID = 210 and  a.finterid=@FinterID
	END

	
	 declare @p5 int
	 set @p5=0
	 declare @p6 nchar(400)
	 set @p6=N'                                                                                                                                                                                                                                                                                                                                                                                                                '
	 exec PlanMutiBomExpand 50,1,'1900-01-01 00:00:00','2100-01-01 00:00:00',@p5 output,@p6 output
	-- select @p5, @p6

/*@ExpandLevel int, ----展开级数
@Order smallint,  ----排序方式 0 自然顺序 ，1 物料代码，2 物料名称
@BeginDay datetime, --子项物料生效日期  
@EndDay datetime, --子项物料失效日期  
@Succeed smallint OUTPUT,----是否成功
@Reason varchar(400) OUTPUT ----失败原因
)
*/
IF @Fqufen='A'
BEGIN
	select a.FBomInterid,a.FEntryID,a.FLevelString FLevel,d.FEntryKey, b.fnumber FNumber
		 , b.fname FName,isnull(b.FModel,'') FModel, k.FName as FErpClsName
		 , b.FChartNumber AS FChartNumber,isnull(c.Fname,'') FUnitID, a.FNeedQty FQty
		 , a.FRate FQtyUnit, isnull(d.FScrap,0) as FScrap,d.FPositionNo,d.FItemSize,d.FItemSuite,d.FMachinePos
		 , isnull(e.Fname,'') FMaterielType
		 , (case d.FOperSN when 0 then '' else cast(d.FOperSN as varchar(255)) end) FOperSN
		 , isnull(f.Fname,'') FOperID, isnull(g.FName,'') FStockID
		 , (case b.FIsKeyItem when 0 then '否' else '是' end) FIsKeyItem
		 , (case h.FDeleted when 0 then '否' else '是' end)  FDeleted,d.FNote,d.FNote1
		 , d.FNote2,d.FNote3,isnull(i.fname,'') FUseStatus,a.FitemID EditFitem
		 , CASE WHEN (d.FBeginDay BETWEEN '1900-01-01' AND  '2100-01-01') THEN 0  
				WHEN (d.FEndDay BETWEEN '1900-01-01' AND  '2100-01-01' ) THEN 0  
				WHEN ('1900-01-01' >= d.FBeginDay AND '2100-01-01' <= d.FEndDay) THEN 0 
				ELSE 1 END AS FAlterBackColor, '253, 223, 223' AS FBackColor
		 , d.FBeginDay,d.FEndDay,d.FPercent,b.FQtyDecimal FInitDecimal
		 , b.FQtyDecimal FQtyDecimal ,l.FName as FEntrySelfZ0143, b.f_102, d.FNote1
	 from #Mutidata a
	 inner join t_icitem b on a.fitemid=b.fitemid
	 left outer join t_item c on b.funitid=c.fitemid
	 inner join icbomchild d on a.FBomInterid=d.finterid and a.FItemID=d.FItemID and a.FOperID=d.FOperID AND a.FEntryID=d.FEntryID
	 left outer join t_submessage e on d.FMaterielType=e.finterid
	 left outer join t_submessage f on d.FOperID=f.finterid
	 left outer join t_stock g on d.FStockID=g.FItemID
	 inner join t_item h on b.fitemid=h.fitemid
	 left outer join t_submessage i on b.fusestate=i.finterid
	 inner join  t_submessage k on b.FErpClsID = k.FinterID
	 left outer join t_SubMessage l on l.FParentID =10011 and l.FInterID =d.FEntrySelfZ0143
	 where a.FBOMLevel>0  order by a.FIndex desc
 END
 ELSE IF @Fqufen ='B'---物料对应所有层的工艺路线显示
 BEGIN	
	select a.FBomInterid,a.FEntryID,a.FLevelString FLevel,d.FEntryKey, a.FItemID, b.fnumber FNumber
		 , b.fname FName,isnull(b.FModel,'') FModel, k.FName as FErpClsName
		 , isnull(c.Fname,'') FUnitID, a.FNeedQty FQty, a.FRate FQtyUnit, isnull(d.FScrap,0) as FScrap
		 , isnull(i.fname,'') FUseStatus,a.FitemID EditFitem		
		 , d.FBeginDay,d.FEndDay,d.FPercent
		 , E.FBOMNumber ,F.FBillNo ,G.FOperSN,H.FID ,H.FName as fgxnm ,G.FWorkQty,G.FTimeRun
		 , G.FPieceRate , G.FEntrySelfZ0236,G.FEntrySelfZ0237
	 from #Mutidata a
	 inner join t_icitem b on a.fitemid=b.fitemid
	 left outer join t_item c on b.funitid=c.fitemid
	 inner join icbomchild d on a.FBomInterid=d.finterid and a.FItemID=d.FItemID and a.FOperID=d.FOperID AND a.FEntryID=d.FEntryID
	 left outer join t_submessage i on b.fusestate=i.finterid
	 inner join  t_submessage k on b.FErpClsID = k.FinterID
	 left outer join ICBOM E ON E.FItemID =A.FItemID AND E.FStatus =1 AND E.FUseStatus=1072
	 LEFT OUTER JOIN t_Routing F ON F.FInterID =E.FRoutingID 
	 LEFT OUTER JOIN t_RoutingOper G ON G.FInterID =F.FInterID 
	 LEFT OUTER JOIN t_SubMessage H ON H.FParentID =61 AND H.FInterID =G.FOperID 
	 where a.FBOMLevel>0  order by a.FIndex desc,G.FOperSN
 END
 ELSE 
 BEGIN
	select M2.FNumber AS FBOMGRP_NO ,m1.FNumber AS FNumber1 ,m1.FName AS FName1 ,m1.FModel AS FModel1
		 , b.fnumber AS FNumber2, b.fname AS FName2,isnull(b.FModel,'') AS FModel2
		 , ISNULL(F.FID,'') AS FOPER_NO, a.FRate FQtyUnit,isnull(l.FName,'无') as FEntrySelfZ0143
		 ,d.FItemSize,d.FItemSuite, isnull(d.FScrap,'0') as FScrap, D.FOffSetDay 
		 , substring(a.FLevelString,len(a.FLevelString)-CHARINDEX('.',reverse(a.FLevelString))+2,CHARINDEX('.',reverse(a.FLevelString))-1) as a2
		 , a.FEntryID, m3.FBillNo as frou_no 
		 , m1.FName+'   BOM 多层物料清单 借鉴' as fbt_nm , d.FNote1		 
	 from #Mutidata a
	 inner join t_icitem b on a.fitemid=b.fitemid
	 left outer join t_item c on b.funitid=c.fitemid
	 inner join icbomchild d on a.FBomInterid=d.finterid and a.FItemID=d.FItemID and a.FOperID=d.FOperID AND a.FEntryID=d.FEntryID
	 left outer join t_submessage e on d.FMaterielType=e.finterid
	 left outer join t_submessage f on d.FOperID=f.finterid
	 left outer join t_stock g on d.FStockID=g.FItemID
	 inner join t_item h on b.fitemid=h.fitemid
	 left outer join t_submessage i on b.fusestate=i.finterid
	 inner join  t_submessage k on b.FErpClsID = k.FinterID
	 left outer join t_SubMessage l on l.FParentID =10011 and l.FInterID =d.FEntrySelfZ0143
	 INNER join icbom m on m.FInterID =a.FBomInterid and m.FStatus =1 and m.FUseStatus=1072
	 INNER join t_ICItem m1 on m1.FItemID =m.FItemID 
	 INNER JOIN  ICBOMGroup M2 ON M2.FInterID=M.FParentID
	 LEFT OUTER JOIN t_Routing m3 on m3.FInterID =m.FRoutingID 
	 where a.FBOMLevel>0  
	 order by substring(a.FLevelString,len(a.FLevelString)-CHARINDEX('.',reverse(a.FLevelString))+2,CHARINDEX('.',reverse(a.FLevelString))-1)
			, a.FBomInterid,a.FEntryID
 
 END
 
	


 DROP TABLE #Mutidata
 DROP TABLE #mutiParentItem
 DROP TABLE #Errors
 
END