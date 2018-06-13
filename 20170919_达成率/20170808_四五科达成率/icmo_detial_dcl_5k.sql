/*
 * DESCRIPTIONS:	生产任务单明细及达成率查询--五科(stockid=245482)
 * DESCRIPTIONS：	1、生产任务单.工作令 生产任务单.物料内码--物料.FITEMID
 * DESCRIPTIONS：	2、达成标准：入库审核时间>=计划完工日期的次日10点
 * DESCRIPTIONS：	3、显示生产任务单编号 入库保存审核时间差
 * DESCRIPTIONS：	4、FTranType ：2-- 产成品入库
 * 
 * DATE：			20170808
 * AUTHOR：			RENBO
 */
alter PROCEDURE [dbo].[ICMO_DETAIL_DCL_5K] 
	@FPlanFDate1	datetime,								--the First-finish Date 
	@FPlanFDate2	datetime,								--the Last-finish Date
	@FBillNO1       nvarchar(50),							--the Start of BillNumber Order
	@FBillNO2       nvarchar(50),							--the first of BillNumber Order
	@FYN			nvarchar(1),							--Whether Finishing the work
	@FDptno1       nvarchar(50),							--the Start of Department number order
	@FDptno2       nvarchar(50),							--the End of Department number order
	@FNumber	   nvarchar(255)							--the Started Metarial number 
AS
BEGIN
	SET NOCOUNT ON 
	/*检查领料单、入库单的工作令号和生产任务单的工作令号是否一致，不一致时，修改领料单、入库单的工作令号*/
	declare @stockinterid int,@stockentryid int,@icmointerid int,@use_yn int
    select @use_yn=count(*)  from icstockbillentry a join icmo b on a.ficmointerid = b.finterid
	join icstockbill c on a.finterid = c.finterid
	where ((c.ftrantype = 2 and ISNULL(a.fentryselfa0238,0) <> b.fheadselfj0184) 
	or (c.ftrantype = 24 and isnull(a.fentryselfb0447,0) <> b.fheadselfj0184) )
	and b.fplanfinishdate > @FPlanFDate1
	if @use_yn > 0 
	begin
	declare  cu_icmo cursor for
	select  a.finterid,a.fentryid,b.finterid
	from icstockbillentry a join icmo b on a.ficmointerid = b.finterid
	join icstockbill c on a.finterid = c.finterid
	where ((c.ftrantype = 2 and isnull(a.fentryselfa0238,0) <> b.fheadselfj0184) 
	or (c.ftrantype = 24 and isnull(a.fentryselfb0447,0) <> b.fheadselfj0184) )
	and b.fplanfinishdate > @FPlanFDate1

	open cu_icmo
	fetch next from cu_icmo into @stockinterid ,@stockentryid ,@icmointerid 
	while @@fetch_status = 0
	begin
	update icstockbillentry 
	set fentryselfa0238 = left(b.fheadselfj0184,len(b.fheadselfj0184))
	from icstockbillentry a join icmo b on a.ficmointerid = b.finterid
    join icstockbill c on a.finterid = c.finterid and c.finterid = @stockinterid
    where c.finterid = @stockinterid and a.fentryid = @stockentryid 
    and b.finterid = @icmointerid   and c.ftrantype = 2  
    
	update icstockbillentry 
	set  fentryselfb0447 = left(b.fheadselfj0184,len(b.fheadselfj0184))
	from icstockbillentry a join icmo b on a.ficmointerid = b.finterid
    join icstockbill c on a.finterid = c.finterid
    where a.finterid = @stockinterid and a.fentryid = @stockentryid 
    and b.finterid = @icmointerid   and c.ftrantype = 24  

   /*modify icmo*/
   /*update icmo
	set fbillno = (case when (len(fbillno) - 4 - charindex('-',fbillno)) > 0 
	then left(fheadselfj0184,len(fheadselfj0184))+right(fbillno,len(fbillno) - 4 - charindex('-',fbillno)) 
	else left(fheadselfj0184,len(fheadselfj0184)) end)
	where finterid = @icmointerid
   */
    fetch next from cu_icmo into @stockinterid,@stockentryid,@icmointerid
	end 
	close cu_icmo
	deallocate cu_icmo
end
	/************检查结束*************************/
	
	Create Table #TemporaryTableA( 
     FInterId					int null,
     FBillNo					varchar(255) null,				--生产任务单编号
     FGZL						varchar(255) null,				--工作令号
     FNumber					varchar(255) null,				--代码
     FName						varchar(255) null,				--名字
     FModel						varchar(255) null,				--型号
     FWLSX						varchar(255) null,              --自制、外购
     FOPERNAME					varchar(255) null,				--工序
     fworkshop					varchar(255) null,				--生产车间
     funit						VARCHAR(255) NULL,				--计量单位
     FDWQty						decimal(28,10) default(0) null, --BOM Qty
     fMaterialStock				VARCHAR(255) NULL,				--发料仓库
     FF_102						VARCHAR(255) NULL,				--材质
     FBlankSize					VARCHAR(255) NULL,				--坯料尺寸
     FProductModel				VARCHAR(255) NULL,				--成品型号
     FCUSNM						VARCHAR(255) NULL,				--客户
     FPlanInStock				VARCHAR(255) NULL,				--计划接收仓库
     FPutInQty					decimal(28,10) default(0) null,	--投产数量
     FHeadSelfJ0186				decimal(28,10) default(0) null,
	 FHeadSelfJ0187				decimal(28,10) default(0) null,
     FCommitDate				DATETIME NULL,					--计划下达日期      
     FPlanCommitDate			DATETIME NULL,					--计划开工日期
     FPlanFinishDate			DATETIME NULL,					--计划完工日期
     FPDATE						VARCHAR(255) NULL,
     FPlanProduQty				decimal(28,10) default(0) null,	--计划成品装配数量
     fplanqty					decimal(28,10) default(0) null,	--计划数量
     FInStockQty				decimal(28,10) default(0) null,	--入库审核数量
     FSaveInStockQty			decimal(28,10) default(0) null,	--入库保存数量
     FCancleSumQty				decimal(28,10) default(0) null,	--总报废数量
     FUncompleteQty				decimal(28,10) default(0) null,	--未完成数量
     FGetMaterialQTY			decimal(28,10) default(0) null,	--领料数量
     FRealTimeInventory			decimal(28,10) default(0) null, --即时库存
     Freceivedate1				VARCHAR(255) NULL,				--产品库入库日期
     Fcheckdate1				VARCHAR(255) NULL,				--审核日期
     FDiffHoursCheck			INT NULL,						--入库保存审核时间差
     FProductStock				VARCHAR(255) NULL,				--产品库
     FPackedInQty				decimal(28,10) default(0) null,	--包装入库数量
     FUnpackedReceiveDate		VARCHAR(255) NULL,				--裸包入库日期
     FUnpackedRecCheckDate		VARCHAR(255) NULL,				--裸包入库审核日期
     FUnpackedStock				VARCHAR(255) NULL,				--裸包仓库
     FUnpackedInQty				decimal(28,10) default(0) null,	--裸包入库数量
     FDiffDates					INT NULL,						--时间差
     FDiffDatesForRate			INT NULL,						--时间差，达成率计算用
     FHeadSelfS0152				VARCHAR(1000) NULL,
     FLINE1						INT NULL						--Row Number
) 


Create Table #TemporaryTableB( 
 FLINE1 INT NULL,
 FCN INT NULL
) 

declare @fline1		int
declare @FDiffDates	int
declare @fcn		int
declare @stockid0	int,@stockid1 int,@stockid2	int,@stockid3	int,@stockid4	int,@stockid5	int
declare @deptnumber varchar(100)
declare @str1		varchar(1000)
declare @str2		varchar(1000)
declare @sql1		varchar(6000)
declare @sqlddl		varchar(8000)
declare @sqlfrom	varchar(7000)
declare @sqlwhere	varchar(7000)
declare @orderstr	varchar(3000)

set @fcn=0
/* 
 * select * from t_stock where (fname like '%五科%' or fname like '%纸箱%') and fdeleted = 0  --245482
 * select fnumber,* from t_Department where fname like '%五科%' and fdeleted=0
 */
set @stockid0 = 245482
set @stockid1 = 245465
set @stockid2 = 245466
set @stockid3 = 245467
set @stockid4 = 245468
set @stockid5 = 287722
set @deptnumber = 's6.0005'
set @str1=''
set @str2=''

if @FYN=''			set @str1=''
if @FYN='A'			set @str1=''
if @FYN='Y'			set @str1=' and isnull(a.FQty,0)-isnull(a.FStockQty,0)<=0'
if @FYN='N'			set @str1=' and isnull(a.FQty,0)-isnull(a.FStockQty,0)>0'

if @FBillNO1  <>''	set @str2= ' AND a.FBillNo>='+''''+@FBillNO1+''''
ELSE SET @STR2=''
if @FBillNO2 <>''	set @str2=@str2+' AND a.FBillNo<='+''''+@FBillNO2 +''''
if @FDptno1  <>''	set @str2=@str2+'  AND a1.FNumber>='+''''+@FDptno1 +'''' 
if @FDptno2 <>''	set @str2=@str2+'  AND a1.FNumber<='+''''+@FDptno2+''''
if @FNumber  <>''	set @str2=@str2+ '  AND b.FNUMBER LIKE '+''''+@FNumber +'%'+''''


--temptable 92 ，the total in-self-stock-qty per item
	SELECT a.FEntrySelfA0238,A.FICMOInterID
	     , a.FItemID 
	     , SUM(a.FQTY)									AS RUKU_QTY
	     , MAX(CONVERT(CHAR,B.FCheckDate,120))			AS check_date
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0231,120))		AS check_date2
	     , MAX(CONVERT(CHAR,B.FDATE,120))				AS LR_DATE
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0230,120))		AS LR_DATE2
	     , MAX(c.fname)									as NameReceivedStock
	into #t92  
	 FROM ICStockBillEntry A
	INNER JOIN ICStockBill B ON A.FInterID = B.FInterID 
	LEFT outer join t_stock c on c.fitemid= a.fdcstockid
	WHERE B.FTranType=2 and 
	(c.FItemID = @stockid0 or c.FItemID = @stockid1 or c.FItemID = @stockid2 
	or c.FItemID = @stockid3 or c.FItemID = @stockid4 or c.FItemID = @stockid5  )
	GROUP BY a.FEntrySelfA0238, a.FICMOInterID, a.FItemID 
--temptable 93	,the total in-other-stock-qty per item
	SELECT a.FEntrySelfA0238, A.FICMOInterID
	     , a.FItemID 
	     , SUM(a.FQTY)									AS RUKU_QTY
	     , MAX(CONVERT(CHAR,B.FCheckDate,120))			AS check_date
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0231,120))		AS check_date2
	     , MAX(CONVERT(CHAR,B.FDATE,120))				AS LR_DATE
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0230,120))		AS LR_DATE2
	     , MAX(c.fname)									as NameReceivedStock  
	 into #t93
	 FROM ICStockBillEntry A
	INNER JOIN ICStockBill B ON A.FInterID = B.FInterID 
	LEFT outer join t_stock c on c.fitemid= a.fdcstockid
	WHERE B.FTranType=2 and c.FItemID <> @stockid0
	 and c.FItemID <> @stockid1 and c.FItemID <> @stockid2
	 and c.FItemID <> @stockid3 and c.FItemID <> @stockid4
	 and c.FItemID <> @stockid5
	GROUP BY a.FEntrySelfA0238, a.FICMOInterID, a.FItemID 

	--temptable 96,the total in-stock-qty per item
 	SELECT a.FEntrySelfA0238, a.FICMOInterID
	     , a.FItemID 
	     , SUM(a.FQTY)												AS InStock_QTY			--入库数量
	     , MAX(CONVERT(CHAR,B.FCheckDate,120))						AS check_date			-- 审核日期
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0231,120))					AS check_date2			-- b.fheadselfa0231 审核时间
	     , MAX(CONVERT(CHAR,dateadd(hh,-10,B.FHeadSelfA0231),120))	AS check_date3			--审核时间 之后10小时
	     , MAX(CONVERT(CHAR,B.FDATE,120))							AS LR_DATE				-- 单据日期
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0230,120))					AS LR_DATE2				-- 保存时间
	     , MAX(c.fname)												as NameReceivedStock	-- 仓库名  
	into #t96
	 FROM ICStockBillEntry A
	INNER JOIN ICStockBill B ON A.FInterID = B.FInterID 
	LEFT outer join t_stock c on c.fitemid= a.fdcstockid
	WHERE B.FTranType=2
	GROUP BY a.FEntrySelfA0238, a.FICMOInterID, a.FItemID 
--temptable 94	
			SELECT a1.FEntrySelfB0447, a1.FItemID ,  sum(ISNULL(a1.FQty,0)) fqty 
			into #t94 
			FROM ICStockBillEntry  a1
			inner join ICStockBill  b1 on a1.FInterID = b1.FInterID 
			WHERE b1.FTranType = 24 /* 生产领料*/
			group by a1.FEntrySelfB0447, a1.FItemID
--temptable 95 ，real inventory
      SELECT FItemID, SUM(isnull(fqty,0)) as sum_qty 
	 into #t95
	 FROM ICInventory 
 	 GROUP by FItemID
	
--temptable 97,bom info
          select a.FItemID,b.FItemID as children_itemid, e.fname as oper_name, b.FQty
              ,  b.FSPID ,c.FName as stock_nm,B.FItemSize  
		 into #t97 
		 from ICBOM a
		 inner join ICBOMChild b on a.FInterID = b.FInterID
		 left outer join t_Stock c on c.FItemID =b.FStockID 
		 left outer join t_SubMessage e on e. FTypeID =61 and e.FInterID  = b.FOperID
		
--temptable 98 手工录入的01/13数量
				SELECT A.FHeadSelfJ0184, A.FItemID ,b.fname, sum(a.fqty) as c_qty  
					   , MAX(A.FOrderInterID) AS FOrderInterID, max(a.FHeadSelfJ0186) as FHeadSelfJ0186
					   , max(a.FHeadSelfJ0187) as FHeadSelfJ0187
					into #t98
					FROM ICMO  A
					INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
					WHERE a.FPlanOrderInterID =0			and /*计划订单号=0: 1/13*/
							  a.FBillNo not like 'WORK%'	and /*排除外包生产任务单*/
							  a.FMRP =1052					and /*手工录入 */
							  A.FCancellation=0 and
							  (a.fhandworkclose = 0 or a.fauxstockqty <> 0 )
					Group by A.FHeadSelfJ0184, A.FItemID ,b.fname
--temtable 99
					
             select fgzl,max(fpdate) fpdate 
				into #t99
				from t_yxjpai01 
				where fqty>0 group by fgzl
--temtable 100
			select fgzl,SUM(isnull(fqty,0)) fqty 
			into #t100
			from t_ypaichan01 where fqty>0 group by fgzl
--

SET @sqlddl='
insert into #TemporaryTableA
SELECT  A.FINTERID
	, a.FBillNo
	, a.FHeadSelfJ0184
	, b.fnumber
	, b.fname as fname1
	, b.fmodel
	, case when b.FErpClsID=2 then ''自制'' else ''外购 '' end        
	, e.oper_name as fopername
	, a1.FName as fworkshop
	, d.fname as funit
	, e.fqty as fdwqty
	, e.stock_nm as fMaterialStock
	, b.F_102 as ff_102
	, e.fitemsize as FBlankSize     
	, c.fname as FProductModel
	, f2.fnumber as fcusnm
	, f3.fNAME as FPlanInStock
	, c.c_qty as FPutInQty
	, isnull(c.FHeadSelfJ0186,0) as FHeadSelfJ0186
	, isnull(c.FHeadSelfJ0187,0) as FHeadSelfJ0187
	, a.FCommitDate
    , a.FPlanCommitDate
    , a.FPlanFinishDate
    , g1.fpdate as fpdate
    , g2.fqty as FPlanProduQty
    , round(a.fqty,4)  as fplanqty
    , round(a.FStockQty,4) as FInStockQty
    , j.InStock_QTY as FSaveInStockQty
    , ISNULL(K.FBAOFEI,0) AS FCancleSumQty
    , (case when (isnull(a.FQty,0)-isnull(a.FStockQty,0)-ISNULL(K.FBAOFEI,0))>0 
            then isnull(a.FQty,0)-isnull(a.FStockQty,0)-ISNULL(K.FBAOFEI,0)
		    else 0 end) as FUncompleteQty
    , i.fqty as FGetMaterialQTY
    , h.sum_qty  as  FRealTimeInventory
    , isnull(j1.LR_DATE2,j1.LR_DATE) as Freceivedate1
    , isnull(j1.check_date2,J1.check_date) as Fcheckdate1
    , DateDiff(hour,isnull(j1.LR_DATE2,j1.LR_DATE),isnull(j1.check_date2,J1.check_date))  AS FDiffHoursCheck
    , J1.NameReceivedStock AS fStockName1
    , ISNULL(J1.RUKU_QTY,0) AS FPackedInQty
    , isnull(j2.LR_DATE2,j2.LR_DATE) as FUnpackedReceiveDate
    , isnull(j2.check_date2,J2.check_date) as FUnpackedRecCheckDate
    , J2.NameReceivedStock AS fStockName2
    , ISNULL(J2.RUKU_QTY,0) AS FUnpackedInQty
    , DateDiff(DAY,cast(ISNULL(J.check_date,CONVERT(CHAR(8),GETDATE(),112)) as datetime),a.FPlanFinishDate)  AS FDiffDates
    , DateDiff(DAY,cast(ISNULL(J.check_date3,CONVERT(CHAR(8),GETDATE(),112)) as datetime),a.FPlanFinishDate)  AS FDiffDatesForRate
    , f.FHeadSelfS0152
    , ROW_NUMBER() over (order by A.FPlanFinishDate
					,(CASE WHEN SUBSTRING(A.FHeadSelfJ0184,1,1)=''Z'' then 1 else 2 end )
					, a.fbillno,a.finterid ) as fline1 '

 set @sqlfrom = ' 
 FROM Icmo a
 INNER join			t_icitem		b	ON b.fitemid= a.fitemid        
 LEFT OUTER JOIN	#t98			c	ON c.FHeadSelfJ0184=a.FHeadSelfJ0184 and c.FItemID =a.FItemID 
 LEFT outer join	t_MeasureUnit	d	on d.FMeasureUnitID=b.FProductUnitID   
 LEFT outer join	t_Department	a1	ON (CASE WHEN b.fsource=0 THEN 135 ELSE b.FSOURCE END)=a1.FItemID
 left outer join	#t97			e	on e.FItemID=c.fitemid AND e.children_itemid=a.fitemid
 LEFT outer JOIN	seorder			f	ON f.FInterId=(CASE WHEN a.FOrderInterID=0 THEN C.FOrderInterID ELSE a.FOrderInterID END)
 LEFT outer JOIN	t_Organization	f2	ON f2.fitemid=f.fcustid   
 LEFT OUTER JOIN	t_Stock			F3	ON F3.FItemID= F2.F_103   
 LEFT outer join	#t99			g1	on g1.FGZL=a.FHeadSelfJ0184  
 LEFT outer join	#t100			g2	on g2.FGZL=a.FHeadSelfJ0184  
 LEFT outer join	#t96			j	ON j.FEntrySelfA0238=A.FHeadSelfJ0184 AND j.FItemID =a.FItemID and j.FICMOInterID =a.FInterID    
 LEFT outer join	#t93			j1	ON j1.FEntrySelfA0238=A.FHeadSelfJ0184 AND j1.FItemID =a.FItemID and j1.FICMOInterID =a.FInterID    
 LEFT outer join	#t92			j2	ON j2.FEntrySelfA0238=A.FHeadSelfJ0184 AND j2.FItemID =a.FItemID and j2.FICMOInterID =a.FInterID
 LEFT outer JOIN	#t95			h	ON a.fitemid= h.fitemid   
 LEFT OUTER JOIN	#t94			i	on i.FEntrySelfB0447=a.FHeadSelfJ0184 and i.fitemid= a.fitemid	
 LEFT OUTER JOIN	t_yyoubang2014	K	ON K.FGZL =A.FHeadSelfJ0184 
				'

 SET @sqlwhere = '	WHERE a.Fstatus>0 and a.FCancellation=0 and a.FTrantype=85  AND (a.Fstatus<>3 or a.FStockFlag <>'' 14215 '')
					AND DateDiff(DAY,A.FPlanFinishDate,'+''''+convert(char(8),@FPlanFDate1,112)+''''+' )<=0 
					AND DateDiff(DAY,A.FPlanFinishDate,'+''''+convert(char(8),@FPlanFDate2,112)+''''+' )>=0 
					AND a1.FNumber LIKE '+''''+@deptnumber+''''+'  
					AND A.FHeadSelfJ0184 not like ''Z%''  
					AND A.FHeadSelfJ0184 not like ''YZ%''
					and a.fsuspend = 0
				'
								
set @orderstr = ' ORDER BY  A.FPlanFinishDate, (CASE WHEN SUBSTRING(A.FHeadSelfJ0184,1,1)=''Z'' then 1 else 2 end ), a.fbillno,a.finterid '
  
EXEC(@sqlddl+@sqlfrom+@sqlwhere+@str2+@str1+@orderstr)

DECLARE seu_cur CURSOR
FOR
   SELECT fline1, FDiffDates FROM #TemporaryTableA  ORDER by fline1	
OPEN seu_cur	    
FETCH NEXT FROM seu_cur into @fline1,@FDiffDates   
WHILE @@FETCH_STATUS=0	    
BEGIN
    select @fcn=COUNT(*) from #TemporaryTableA where FLINE1 <=@fline1 and FDiffDatesForRate<0
	insert into #TemporaryTableB
	values(@fline1, @fcn )
FETCH NEXT FROM seu_cur into  @fline1,@FDiffDates 
END
CLOSE seu_cur
DEALLOCATE seu_cur
 
 SELECT A.FBillNo 											as 生产任务单编号
 		, A.FGZL 											as 工作令号
 		, A.fnumber 										as 物料代码
		, A.FModel 											as 规格型号
		, a.fworkshop 										as 生产车间
	    , A.funit 											as 生产计量单位
	    , A.FHeadSelfS0152 									AS 客户特殊要求
	    , A.FCUSNM 											as 客户
        , A.fplanqty 										as 计划数量
        , CONVERT(CHAR(8),a.FCommitDate,112) 				as 计划下达日期         
        , CONVERT(CHAR(8),a.FPlanCommitDate,112) 			as 计划开工日期
        , CONVERT(CHAR(8),a.FPlanFinishDate,112) 			as 计划完工日期
        , A.FInStockQty 									as 入库审核数量
        , A.FSaveInStockQty 								as 入库保存数量
		, A.FDiffHoursCheck 								as 入库保存审核时间差
		, A.FUnpackedReceiveDate 							AS 入库保存日期
		, A.FUnpackedRecCheckDate 							as 入库审核日期
		, A.FUnpackedInQty  								AS 实入库数量
        , A.FUnpackedStock 									AS 入库仓库
        , A.FUncompleteQty   								as 未完成数量
        , A.FCancleSumQty   								AS 总报废数量
		, a.FDiffDatesForRate 								AS 实绩与计划差额天数
		, a.FLINE1, b.FCN
		, round((1-b.fcn/CAST(a.fline1 AS DECIMAL))*100,2) 	as 达成率 
		, C.fplanqty 										AS 计划数量合计每天
 
 FROM #TemporaryTableA A
 LEFT OUTER JOIN #TemporaryTableB B ON A.FLINE1  =B.FLINE1 
 LEFT OUTER JOIN (
		SELECT CONVERT(CHAR(8),FPlanFinishDate,112) AS FPlanFinishDate
		     , (case when substring(FGZL,1,1)='Z' THEN 1 ELSE 2 END ) AS QUFEN1
		     , SUM(fplanqty) AS fplanqty 
		  FROM #TemporaryTableA 
		  GROUP BY CONVERT(CHAR(8),FPlanFinishDate,112),(case when substring(FGZL,1,1)='Z' THEN 1 ELSE 2 END )
		) C ON C.FPlanFinishDate=CONVERT(CHAR(8),a.FPlanFinishDate,112) 
		       AND (case when substring(A.FGZL,1,1)='Z' THEN 1 ELSE 2 END )=C.QUFEN1

 ORDER BY A.FLINE1
 
 drop table #TemporaryTableA
 drop table #TemporaryTableB
 drop table #t92
 drop table #t93
 drop table #t94
 drop table #t95
 drop table #t96
 drop table #t97
 drop table #t98
 drop table #t99
 drop table #t100


END
