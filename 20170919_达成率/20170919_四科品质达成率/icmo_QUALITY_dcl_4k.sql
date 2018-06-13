/*
 * DESCRIPTIONS:	品质达成率查询--四科(stockid=245481)
 * DESCRIPTIONS：	1、主要针对两个工序进行计算：扁管压出工序、扁管切断工序
 * DESCRIPTIONS：	2、扁管压出入库数量（盘料）/扁管压出材料领用数量（铝杆）
 * DESCRIPTIONS：	3、扁管切断入库数量（扁管）/扁管切断材料领用数量（盘料）
 * DESCRIPTIONS：	4、领料:四科仓库(带仓位管理）YL.07.0003 ITEMID 245481 
 * DESCRIPTIONS：	5、领料部门：四科 扁管压出工序 扁管切断工序 
 * DESCRIPTIONS：	6、入库：
 * t_bos200000014 factqty faccountqty
 * 
 * DATE：			20170919
 * AUTHOR：			RENBO
 */
alter PROCEDURE [dbo].[ICMO_QUALITY_DCL_4K] 
	@FPlanFDate1	datetime								--the DateScope start
	,@FPlanFDate2	datetime								--the DateScope end
/*	,@FBillNO1       nvarchar(50)							--the Start of BillNumber Order
	,@FBillNO2       nvarchar(50)							--the first of BillNumber Order
	,@FYN			 nvarchar(1)							--Whether Finishing the work
	,@FDptno1        nvarchar(50)							--the Start of Department number order
	,@FDptno2        nvarchar(50)							--the End of Department number order
	,@FNumber	     nvarchar(255)							--the Started Metarial number 
*/
	AS
BEGIN
	SET NOCOUNT ON 

declare @finqty1	decimal(20,6)
declare @finqty2	decimal(20,6)
declare @foutqty1	decimal(20,6)
declare @foutqty2	decimal(20,6)
declare @factqty	decimal(20,6)
declare @faccountqty decimal(20,6)
declare @deptnumber varchar(100)
declare @str1		varchar(1000)
declare @str2		varchar(1000)
declare @sql1		varchar(6000)
declare @sqlddl		varchar(8000)
declare @sqlfrom	varchar(7000)
declare @sqlwhere	varchar(7000)
declare @orderstr	varchar(3000)

--set @stockid = 245481
--set @deptnumber = 's6.04.0002'
--扁管压出材料领用数量（铝杆 03.a15.*）
select @foutqty1=sum(b.fqty)
from icstockbill a
join icstockbillentry b on a.finterid = b.finterid  
		and a.fstatus = 1 
		and a.ftrantype = 24
		and a.fcheckdate between @FPlanFDate1 and @FPlanFDate2 		
join t_icitem c on c.fitemid = b.fitemid and c.fnumber like '03.a15.%'
join t_department d on d.fname like '%扁管压出%' and d.fitemid = a.fdeptid
left join t_measureunit e on e.fmeasureunitid = b.funitid
group by d.fname, e.fname

--扁管压出入库数量（盘料 03.a18.*）
select @finqty1=sum(b.fqty)
from icstockbill a
join icstockbillentry b on a.finterid = b.finterid  
		and a.fstatus = 1 
		and a.ftrantype = 2
		and a.fcheckdate between @FPlanFDate1 and @FPlanFDate2  		
join t_icitem c on c.fitemid = b.fitemid and c.fnumber like '03.a18.%'
join t_department d on d.fname like '%扁管压出%' and d.fitemid = a.fdeptid
left join t_measureunit e on e.fmeasureunitid = b.funitid
group by d.fname, e.fname

--扁管切断材料领用数量（盘料 03.a18.*）
select @foutqty2=sum(b.fqty)
from icstockbill a
join icstockbillentry b on a.finterid = b.finterid  
		and a.fstatus = 1 
		and a.ftrantype = 24
		and a.fcheckdate between @FPlanFDate1 and @FPlanFDate2  		
join t_icitem c on c.fitemid = b.fitemid and c.fnumber like '03.a18.%'
join t_department d on d.fname like '%扁管切断%' and d.fitemid = a.fdeptid
left join t_measureunit e on e.fmeasureunitid = b.funitid
group by d.fname, e.fname

--扁管切断入库数量（扁管 30.*）
select @finqty2=sum(b.fqty*g.fqty)
from icstockbill a
join icstockbillentry b on a.finterid = b.finterid  
		and a.fstatus = 1 
		and a.ftrantype = 2
		and a.fcheckdate between @FPlanFDate1 and @FPlanFDate2 
join t_icitem c on c.fitemid = b.fitemid and c.fnumber like '30.%'
join t_department d on d.fname like '%扁管切断%' and d.fitemid = a.fdeptid
left join t_measureunit e on e.fmeasureunitid = b.funitid
join icbom f on f.fitemid = b.fitemid and f.fusestatus = 1072 and f.fstatus = 1
join icbomchild g on f.finterid = g.finterid 
left join t_measureunit g0 on g0.fmeasureunitid = g.funitid
group by d.fname, e.fname,c.fname,g0.fname
--盘点数据
select @factqty = factqty, @faccountqty=faccountqty
from t_bos200000014 where fmonth = month(@FPlanFDate1) and fmulticheckstatus = 16
--dcl
select '四科品质达成率' as ftitle,@foutqty1 as lvgOUT,@finqty1 as plIN ,round(100*@finqty1/@foutqty1,2) as "xrate%"
,@foutqty2 as plOUT,@finqty2 as pipeIn,round(100*@finqty2/@foutqty2,2) as "yrate%"
,@factqty as factqty,@faccountqty as faccountqty,round(100*@factqty/@faccountqty,2 ) as "zrate%"
,round(100*@finqty1*@finqty2*@factqty/(@foutqty1*@foutqty2*@faccountqty),2) as "rate%"

END /*

select month('2017-09-01'),* from t_bos200000014
select top 9 * from icbom f where  f.fusestatus = 1072 and f.fstatus = 1
select top 200 * from sysobjects where xtype = 'u' and name like '%measure%'
select top 20 * from t_measureunit
select * from ictranstype 
select * from ictransactiontype where fname like '%产品入库%'
select * from ictemplate where fid = 'a02'

EXEC ICMO_quality_DCL_4K  '2017-10-01', '2017-10-31' 
*/