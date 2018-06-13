-- =============================================
-- Author:		<xuyaoyao>
-- Create date: <2016-05-03>
-- Description:	<六科弯管生产任务单明细及达成率查询>
-- 内容和二科生产任务单明细及达成率查询一致
--
--updated on 2017-03-29  by renbwo
--description: 挂起 ，不参加达成率计算。
--
-- =============================================
alter PROCEDURE [dbo].[ICMO_DETAIL_DCL_6K_WG] 
	@FPlanFDate1	datetime,
	@FPlanFDate2	datetime,	
	@FBillNO1       nvarchar(50),
	@FBillNO2       nvarchar(50),
	@FYN			nvarchar(1),
	@FDptno1       nvarchar(50),
	@FDptno2       nvarchar(50),
	@FNumber	   nvarchar(255)
AS
BEGIN
	
	SET NOCOUNT ON 
	Create Table #tempas( 
     FInterId					int null,
     FBillNo					varchar(255) null,          --生产任务单编号
     FGZL						varchar(255) null, 
     FNumber					varchar(255) null, 
     FName						varchar(255) null, 
     FModel						varchar(255) null, 
     FWLSX						varchar(255) null,
     FOPERNAME					varchar(255) null, 
     FSCCJ						varchar(255) null, 
     FJLDW						VARCHAR(255) NULL,
     FDWQty						decimal(28,10) default(0), 
     FFLCK						VARCHAR(255) NULL,     
     FF_102						VARCHAR(255) NULL,    
     FPLCC						VARCHAR(255) NULL,     
     FXCTLQTY					decimal(28,10) default(0),			-- 计划下料个数
     FCPXH						VARCHAR(255) NULL,
     FCUSNM						VARCHAR(255) NULL,
     FCUSCKNM					VARCHAR(255) NULL,
     FCPTCQty					decimal(28,10) default(0),
     FHeadSelfJ0186				decimal(28,10) default(0),
	 FHeadSelfJ0187				decimal(28,10) default(0),
     FCommitDate				DATETIME NULL,
     FPlanCommitDate			DATETIME NULL,
     FPlanFinishDate			DATETIME NULL,
     FPDATE						VARCHAR(255) NULL,
     FZPQTY						decimal(28,10) default(0),
     FJHQTY						decimal(28,10) default(0),
     FRKQTY						decimal(28,10) default(0),
     FRKBCQTY					decimal(28,10) default(0),
     FWWQTY						decimal(28,10) default(0),
     FLLQTY						decimal(28,10) default(0),
     FJSKCQTY					decimal(28,10) default(0),
     FRKDATE					VARCHAR(255) NULL,
     FSHDATE					VARCHAR(255) NULL,
     FHOURCE					INT NULL,    --入库保存审核时间差
     FRKNAME					VARCHAR(255) NULL,
     FDATECE					INT NULL,
     FDATECE_DA					INT NULL,    --时间差，达成率计算用     
     FLINE1						INT NULL
) 


Create Table #tempty( 
 FLINE1 INT NULL,
 FCN INT NULL
) 

declare @fline1 int
declare @fdatece int
declare @fcn	int

set @fcn=0
declare @str1 varchar(1000)
declare @str2 varchar(1000)
declare @sql1 varchar(6000)
declare @sql2 varchar(7000)

set @str1=''
set @str2=''

if @FYN='' set @str1=''
if @FYN='A' set @str1=''
if @FYN='Y' set @str1=' and isnull(a.FQty,0)-isnull(a.FStockQty,0)<=0'
if @FYN='N' set @str1=' and isnull(a.FQty,0)-isnull(a.FStockQty,0)>0'

if @FBillNO1  <>'' set @str2= ' AND a.FBillNo>='+''''+@FBillNO1+''''
ELSE SET @STR2=''
if @FBillNO2 <>'' set @str2=@str2+' AND a.FBillNo<='+''''+@FBillNO2 +''''
if @FDptno1  <>'' set @str2=@str2+'  AND a1.FNumber>='+''''+@FDptno1 +'''' 
if @FDptno2 <>'' set @str2=@str2+'  AND a1.FNumber<='+''''+@FDptno2+''''
if @FNumber  <>'' set @str2=@str2+ '  AND b.FNUMBER LIKE '+''''+@FNumber +'%'+''''


SET @sql2='
insert into #tempas
SELECT  A.FINTERID, a.FBillNo
     , a.FHeadSelfJ0184
     , b.fnumber
     , b.fname as fname1
     , b.fmodel
     , case when b.FErpClsID=2 then '+''''+'自制'+''''+' else '+''''+ '外购' +''''+' end        
     , e.oper_name as fopername
     , a1.FName as fsccj
     , d.fname as fjldw
     , isnull(e.fqty,0) as fdwqty
     , e.stock_nm as fflck
     , b.F_102 as ff_102
     , e.fitemsize as fplcc 
     , isnull(M.fxctlqty,0) as fxctlqty
     , c.fmodel as fcpxh
     , f2.fnumber as fcusnm
     , f3.fNAME as fcuscknm
     , isnull(c.c_qty,0) as fcptqty
     , isnull(c.FHeadSelfJ0186,0) as FHeadSelfJ0186
	 , isnull(c.FHeadSelfJ0187,0) as FHeadSelfJ0187
     , a.FCommitDate
    , a.FPlanCommitDate
    , a.FPlanFinishDate
    , g1.fpdate as fpdate
    , isnull(g2.fqty,0) as fzpqty
    , round(a.fqty,4)  as fjhqty
    , round(a.FStockQty,4) as frkqty
    , isnull(j.RUKU_QTY,0) as frkbcqty
    , isnull(a.FQty,0)-isnull(a.FStockQty,0) as fwwqty
    , isnull(i.fqty,0) as fllqty
    , isnull(h.sum_qty,0)  as  fjskcqty
    , isnull(j.LR_DATE2,j.LR_DATE) as frkdate
    , isnull(j.sh_date2,J.SH_DATE) as fshdate
    , DateDiff(hour,isnull(j.LR_DATE2,j.LR_DATE),isnull(j.sh_date2,J.SH_DATE))  AS fhource
    , J.NAME_RK AS A2
    , DateDiff(DAY,cast(ISNULL(J.SH_DATE,CONVERT(CHAR(8),GETDATE(),112)) as datetime),a.FPlanFinishDate)  AS fdatece
    , DateDiff(DAY,cast(ISNULL(J.SH_DATE3,CONVERT(CHAR(8),GETDATE(),112)) as datetime),a.FPlanFinishDate)  AS fdatece_da
    , ROW_NUMBER() over (order by A.FPlanFinishDate
					,(CASE WHEN SUBSTRING(A.FHeadSelfJ0184,1,1)=' + '''' + 'Z' + '''' +' then 1 else 2 end )
					, a.fbillno,a.finterid ) as fline1
 FROM Icmo a
INNER join t_icitem b ON b.fitemid= a.fitemid        
 LEFT OUTER JOIN (SELECT A.FHeadSelfJ0184, A.FItemID ,b.Fmodel, sum(isnull(a.fqty,0)) as c_qty  
					   , MAX(A.FOrderInterID) AS FOrderInterID, max(isnull(a.FHeadSelfJ0186,0)) as FHeadSelfJ0186
					   , max(isnull(a.FHeadSelfJ0187,0)) as FHeadSelfJ0187
					FROM ICMO  A
					INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
					WHERE a.FPlanOrderInterID =0 and a.FBillNo not like'+''''+ 'WORK%'+''''+'
					  and a.FMRP =1052
					  and A.FCancellation=0
					Group by A.FHeadSelfJ0184, A.FItemID ,b.Fmodel
  ) c ON c.FHeadSelfJ0184=a.FHeadSelfJ0184 and c.FItemID =a.FItemID 
  LEFT outer join t_MeasureUnit d on d.FMeasureUnitID=b.FProductUnitID   
  LEFT outer join t_Department a1 ON (CASE WHEN b.fsource=0 THEN 135 ELSE b.FSOURCE END)=a1.FItemID
  left outer join (
         select a.FItemID,b.FItemID as sun_itemid, e.fname as oper_name, b.FQty
              , c.FName as stock_nm, b.FSPID ,B.FItemSize  
		 from ICBOM a
		 inner join ICBOMChild b on a.FInterID = b.FInterID
		 left outer join t_Stock c on c.FItemID =b.FStockID 
		 left outer join t_SubMessage e on e. FTypeID =61 and e.FInterID  = b.FOperID
		) e on e.FItemID=c.fitemid AND e.sun_itemid=a.fitemid
 LEFT outer JOIN seorder f ON f.FInterId=(CASE WHEN a.FOrderInterID=0 THEN C.FOrderInterID ELSE a.FOrderInterID END)
 LEFT outer JOIN t_Organization f2 ON f2.fitemid=f.fcustid   
 LEFT OUTER JOIN t_Stock F3 ON F3.FItemID= F2.F_103   
 LEFT outer join (select fgzl,max(fpdate) fpdate from t_yxjpai01 where fqty>0 group by fgzl) g1 on g1.fgzl=a.FHeadSelfJ0184  
 LEFT outer join (select fgzl,SUM(isnull(fqty,0)) fqty from t_ypaichan01 where fqty>0 group by fgzl) g2 on g2.fgzl=a.FHeadSelfJ0184  
 LEFT outer join (
	SELECT a.FEntrySelfA0238, a.FICMOInterID
	     , a.FItemID 
	     , SUM(isnull(a.FQTY,0)) AS RUKU_QTY
	     , MAX(CONVERT(CHAR,B.FCheckDate,120)) AS SH_DATE
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0231,120)) AS SH_DATE2
	     , MAX(CONVERT(CHAR,dateadd(hh,-10,B.FHeadSelfA0231),120)) AS SH_DATE3 --审核时间之后10小时
	     , MAX(CONVERT(CHAR,B.FDATE,120)) AS LR_DATE
	     , MAX(CONVERT(CHAR,B.FHeadSelfA0230,120)) AS LR_DATE2
	     , MAX(c.fname) as NAME_RK  
	 FROM ICStockBillEntry A
	INNER JOIN ICStockBill B ON A.FInterID = B.FInterID 
	LEFT outer join t_stock c on c.fitemid= a.fdcstockid
	WHERE B.FTranType=2
	GROUP BY a.FEntrySelfA0238, a.FICMOInterID, a.FItemID 
	) j ON j.FEntrySelfA0238=A.FHeadSelfJ0184 AND j.FItemID =a.FItemID and j.FICMOInterID =a.FInterID      --原来以工作令为基准，变更为生产任务单编号为基准   
 LEFT outer JOIN (
     SELECT FItemID, SUM(isnull(fqty,0)) as sum_qty FROM ICInventory 
 	   GROUP by FItemID) h ON a.fitemid= h.fitemid   
 LEFT OUTER JOIN (
			SELECT a1.FEntrySelfB0447, a1.FItemID ,  sum(ISNULL(a1.FQty,0)) fqty  
			FROM ICStockBillEntry  a1
			inner join ICStockBill  b1 on a1.FInterID = b1.FInterID 
			WHERE b1.FTranType = 24
			group by a1.FEntrySelfB0447, a1.FItemID
		 ) i on i.FEntrySelfB0447=a.FHeadSelfJ0184 and i.fitemid= a.fitemid
	 LEFT OUTER JOIN (
	 select a.FICMOInterID, (case when ISNULL(b.FAuxQtyScrap,0)=0 then 0 else cast(ISNULL(b.FAuxQtyPick,0)/b.FAuxQtyScrap as int) end) as fxctlqty  
	  from PPBOM a
	  inner join PPBOMEntry b on a.FInterID =b.FInterID
	  where b.FUnitID =125 and a.FWorkSHop <>212056
	) M ON M.FICMOInterID =A.FInterID 
 WHERE a.Fstatus>0 and a.FCancellation=0 and a.FTrantype=85 
      AND (a.Fstatus<>3 or a.FStockFlag <>'+''''+'14215'+''''+')  
      AND DateDiff(DAY,A.FPlanFinishDate,'+''''+convert(char(8),@FPlanFDate1,112)+''''+' )<=0 
  AND DateDiff(DAY,A.FPlanFinishDate,'+''''+convert(char(8),@FPlanFDate2,112)+''''+' )>=0 
  AND a1.FNumber LIKE '+''''+'S6.06.%'+''''+'
  AND A.FHeadSelfJ0184 not like '+''''+'Z%'+''''+'
  AND A.FHeadSelfJ0184 not like '+''''+'YZ%'+'''' --工作令以Z或YZ开头的，不参加达成率计算 
   + 'and a.fsuspend = 0 '
   +@str2 +@str1 
  + ' ORDER BY  A.FPlanFinishDate, (CASE WHEN SUBSTRING(A.FHeadSelfJ0184,1,1)='+''''+'Z'+''''+' then 1 else 2 end ), a.fbillno,a.finterid '
  
EXEC(@sql2)

DECLARE seu_cur CURSOR
FOR
   SELECT fline1, fdatece FROM #tempas  ORDER by fline1	
OPEN seu_cur	    
FETCH NEXT FROM seu_cur into @fline1,@fdatece   
WHILE @@FETCH_STATUS=0	    
BEGIN
    select @fcn=COUNT(*) from #tempas where FLINE1 <=@fline1 and fdatece_da<0
	insert into #tempty
	values(@fline1, @fcn )
FETCH NEXT FROM seu_cur into  @fline1,@fdatece 
END
CLOSE seu_cur
DEALLOCATE seu_cur
 
 SELECT A.FBillNo as 生产任务单编号, A.FGZL as 工作令号, A.fnumber as 物料代码, A.fname as 物料名称
         , A.fmodel as 规格型号, A.FWLSX as 物料属性, A.FOPERNAME as 工序
         , a.FSCCJ as 生产车间, A.FJLDW as 生产计量单位, A.FDWQTY as 单位用量
         , A.FFLCK as 发料仓库, A.FF_102 as 材质
         , A.FPLCC as 坯料尺寸
         , a.fxctlqty as 计划下料个数
         ,  A.FCPXH as 成品型号
         , A.FCUSNM as 客户, A.FCUSCKNM AS 计划入库仓库, A.FCPTCqty as 成品投产数量
         , A.FHeadSelfJ0186 as 成品入客户库数量, A.FHeadSelfJ0187 AS 成品入裸包库数量
         , A.fpdate as 成品变更计划装配日
         , A.FZPqty as 成品装配数量
         , CONVERT(CHAR(8),a.FCommitDate,112) as 下达日期
         , CONVERT(CHAR(8),a.FPlanCommitDate,112) as 计划开工日期
         , CONVERT(CHAR(8),a.FPlanFinishDate,112) as 计划完工日期
         , A.FJHQTY as 计划数量, A.FRKQTY as 入库审核数量
         , A.FRKBCQTY as 入库保存数量
		 , A.FRKDATE AS 入库保存日期, A.FSHDATE as 入库审核日期
         , A.FHOURCE as 入库保存审核时间差
         , A.FRKNAME AS 入库仓库
         , A.FWWQTY as 未完成数量
         , FLLQTY as 领料数量, A.FJSKCQTY as  即时库存
		 , A.FDATECE AS  实绩与计划差额天数, a.FLINE1, b.FCN
		 , round((1-b.fcn/CAST(a.fline1 AS DECIMAL))*100,2) as 达成率 
		 , (case when a.fxctlqty=0 then 0 else ROUND(A.FRKQTY/a.fxctlqty*100,2) end) as 品质达成率
		 , D.FPJQCDCL AS 品质平均达成率
		 , C.FJHQTY AS 计划数量合计每天
 FROM #tempas A
 LEFT OUTER JOIN #tempty B ON A.FLINE1  =B.FLINE1 
 LEFT OUTER JOIN (
		SELECT CONVERT(CHAR(8),FPlanFinishDate,112) AS FPlanFinishDate
		     , (case when substring(fgzl,1,1)='Z' THEN 1 ELSE 2 END ) AS QUFEN1
		     , SUM(FJHQTY) AS FJHQTY 
		  FROM #tempas 
		  GROUP BY CONVERT(CHAR(8),FPlanFinishDate,112),(case when substring(fgzl,1,1)='Z' THEN 1 ELSE 2 END )
		) C ON C.FPlanFinishDate=CONVERT(CHAR(8),a.FPlanFinishDate,112) 
		       AND (case when substring(A.fgzl,1,1)='Z' THEN 1 ELSE 2 END )=C.QUFEN1
  LEFT OUTER JOIN (
		SELECT avg(case when  fxctlqty=0 then 0 else ROUnd(FRKQTY/fxctlqty*100,2) end) AS FPJQCDCL 
		  FROM #tempas 
		) D ON 1=1 
 ORDER BY A.FLINE1
 
 drop table #tempas
 drop table #tempty


END