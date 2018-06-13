declare 
@fnumberStart						varchar(30)	, 
@fnumberEND							varchar(30)	,
@fstockidStart						varchar(30)	,
@fstockidEnd						varchar(30)	,
@fspidStart							varchar(30)	,
@fspidEnd							varchar(30) ,
@CloseDate							datetime	,
@UnpackBomCheckStatus				varchar(1)	,
@UnpackBomUseStatus					varchar(1)	,
@ProdBomCheckStatus					varchar(1)	,
@ProdBomUseStatus					varchar(1)	,
@SaleStartDate						datetime	,
@SaleCloseDate						datetime	,
@SaleQtyMin							int			,
@SaleQtyMax							int			,
@days			int			 

declare		@currentyear	varchar(4)		 
		 ,	@currentperiod	varchar(2)
		 ,	@check			int

/* 
 * test data
 */		 
select @fnumberstart = '01.01.13.0647-hg',@fnumberend='01.01.13.0647-hg'

select @currentyear = fvalue from t_systemprofile where fkey like 'currentyear' and fcategory = 'GL'
select @currentperiod = fvalue from t_systemprofile where fkey like 'currentperiod' and fcategory = 'GL'


if isnull(ltrim(rtrim(@fnumberStart)),'bd') = 'bd' or @fnumberStart=''
begin  select @fnumberStart	=	(select min(fnumber ) from t_icitem) end
if isnull(ltrim(rtrim(@fnumberEND)),'bd') = 'bd' or @fnumberEND=''
begin  select @fnumberEND =	(select  min(fnumber ) from t_icitem ) end 
select @check= count(*) from t_icitem where  fnumber between @fnumberStart and @fnumberEND 
while @check > 50000
begin
raiserror('查询范围已经超过50000种物料，将会影响到系统性能,请缩小物料范围',18,1)   
return
end
if isnull(ltrim(rtrim(@fstockidStart)),'bd') = 'bd' or @fstockidStart=''
begin  select @fstockidStart	 =	 (select min(fnumber ) from t_stock) end
if isnull(ltrim(rtrim(@fstockidEnd)),'bd') = 'bd'  or @fstockidEnd=''
begin  select @fstockidEnd 	=	(select max(fnumber ) from t_stock ) end
if isnull(ltrim(rtrim(@fspidStart	)),'bd') = 'bd' or @fspidStart=''
begin  select @fspidStart	=	(select min(fnumber ) from t_stockplace ) end
if isnull(ltrim(rtrim(@fspidEnd	)),'bd') = 'bd' or @fspidEnd=''
begin  select @fspidEnd	=	(select max(fnumber ) from t_stockplace ) end
if isnull(@CloseDate,'1900-01-01') = '1900-01-01'  or @CloseDate=''
begin  select @CloseDate = dateadd(day,datediff(day,0,getdate()),0) end
if isnull(@SaleStartDate,'1900-01-01') ='1900-01-01' or @SaleStartDate=''
begin  select @SaleStartDate = dateadd(day,datediff(day,365,getdate()),0) end
if isnull(@SaleCloseDate,'1900-01-01') ='1900-01-01' or @SaleCloseDate=''
begin  select @SaleCloseDate = dateadd(day,datediff(day,0,getdate()),0) end
if isnull(@SaleQtyMin,0) = 0  
begin select @SaleQtyMin = -800 end
if isnull(@SaleQtyMax,0) = 0
begin select @SaleQtyMax	=	800 end		
if isnull(@days	,0) = 0 
begin  select @days	=	1 end


--select @fnumberStart as a,@fnumberEND as b  ,@fstockidStart as cv 	,@fstockidEnd as d ,@fspidStart as e,@fspidEnd as ff,@days as cc
--select @CloseDate,@UnpackBomCheckStatus,@UnpackBomUseStatus,@ProdBomCheckStatus,@ProdBomUseStatus	,@SaleStartDate,@SaleCloseDate,@SaleQtyMin,@SaleQtyMax	,@days
--select * from ictranstype    
--21	销售产品
--24	生产领料
--28	委外加工发出
--29	其他出库
--43	盘亏毁损
--83	销售发货  用在发货通知里 table:SEOutStock   出入库记录里没有使用这个transfertype
--入库
--1		外购入库
--73	采购退货 入库负数
--2		产成品入库
--3		自制入库
--5		委外加工入库
--10	其他入库
--40	盘盈入库
--或者入库或者出库
--41	仓库调拨


--至截止日期时的最后出库日期，计算账龄用
--有出库的情况下，账龄=截止日期 - 最后出库日期
select max(a.fdate) as MaxIssueDate,b.fitemid
into #MaxIssueDate0 
from icstockbill a join icstockbillentry b on a.finterid= b.finterid 
left join t_icitem c on c.fitemid = b.fitemid
where a.ftrantype in( '21','24','28','29') and a.fdate <= @CloseDate 
and isnull(a.fheadselfb0157,0) <> 293792	--销售状态不为销售分配
and isnull(b.fqty,0) <> 0					--有出库 数量
and c.fnumber between @fnumberStart and @fnumberEND
group by b.fitemid
--
-- 有入库并且没出库的情况下，账龄=截止日期 - 入库日期
select max(a.fdate) as MaxIssueDate,b.fitemid
into #MaxIssueDate1
from icstockbill a join icstockbillentry b on a.finterid= b.finterid 
left join t_icitem c on c.fitemid = b.fitemid
where a.ftrantype in( '1','2','3','5','10','73') 
and a.fdate <= @CloseDate 
and isnull(b.fqty ,0)<> 0							--有入库  数量
and b.fitemid not in (select fitemid from #MaxIssueDate0)	--没有出库记录 
and c.fnumber between @fnumberStart and @fnumberEND 
group by b.fitemid 
--没有出入库的情况 取系统建立日期 2010/04/01
select distinct cast('2010-04-01' as date) as MaxIssueDate ,a.fitemid 
into #MaxIssueDate2
from icinvbal a left join t_icitem c on c.fitemid = a.fitemid
where fyear= @currentyear 
and fperiod = @currentperiod 
and a.fitemid not in( select fitemid from #MaxIssueDate0)  --没有出库记录
and a.fitemid not in( select fitemid from #MaxIssueDate1)  --没有入库记录
and c.fnumber between @fnumberStart and @fnumberEND
--account age

select  mm.fitemid, datediff(day,mm.MaxIssueDate,@CloseDate) as totalDays,
floor(datediff(day,mm.MaxIssueDate,@CloseDate)/365) as AccountAgeYears ,
floor(datediff(day,mm.MaxIssueDate,@CloseDate)%365/30) as AccountAgeMonths,
datediff(day,mm.MaxIssueDate,@CloseDate)%365%30 as  AccountAgeDays 
into #AccountAge 
from ( select * from #MaxIssueDate0
union all
select * from #MaxIssueDate1  
union all
select * from #MaxIssueDate2 
) mm 
order by totalDays desc ,mm.AccountAgeDays desc
-- select * from #AccountAge
--至截止日期时库存量，
--icinventory 即时库存 icbal 月别库存 icinvbal 月别仓库别库存
--截止库存 = 当月期初库存 + 本月至截止日期的出入库
--select fnumber ,* from t_stockplace where fnumber between '0.' and 'zzzzz.'
--NewlyInitInv

select a.fitemid,a.fstockid,isnull(a.fstockplaceid,0) as fstockplaceid,sum(a.fbegqty) as fqty ,sum(a.fbegbal) as fbal
into #NewlyInitInv
from icinvbal a 
left join t_icitem		c	on c.fitemid = a.fitemid 
left join t_stock      t70	on t70.fitemid = a.fstockid
left join t_stockplace t71  on t71.fspid	= a.fstockplaceid
where a.fyear=@currentyear and a.fperiod =@currentperiod 
and c.fnumber			between @fnumberStart	and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by   a.fitemid,a.fstockid,a.fstockplaceid
--NORMAL RECEIVE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,isnull(t22.fdcspid,0) as fstockplaceid, sum(t22.fqty) as fqty,sum(t22.famount) as fbal
into #normal_in
from icstockbill		t21  
join icstockbillentry	t22		on t22.finterid = t21.finterid
left join t_icitem		t23		on t23.fitemid = t22.fitemid
left join t_stock      t70	on t70.fitemid = t22.fdcstockid
left join t_stockplace t71  on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '1','2','3','5','10','73')
and isnull(t22.fqty,0) <> 0
and t23.fnumber between @fnumberStart and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fdcstockid,t22.fdcspid
--ADJUST RECEIVE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,isnull(t22.fdcspid,0) as fstockplaceid, sum(t22.fqty) as fqty,sum(t22.famount) as fbal
into #adjust_in
from icstockbill		t21  
join icstockbillentry	t22		on t22.finterid = t21.finterid
left join t_icitem		t23		on t23.fitemid = t22.fitemid
left join t_stock      t70	on t70.fitemid = t22.fdcstockid
left join t_stockplace t71  on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '40','41')
and isnull(t22.fqty,0) <> 0 
and t23.fnumber between @fnumberStart and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fdcstockid,t22.fdcspid
--NORMAL ISSUE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,
isnull(t22.fdcspid,0)  as fstockplaceid,-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #normal_out
from icstockbill		t21  
join icstockbillentry	t22		on t22.finterid = t21.finterid
left join t_icitem		t23		on t23.fitemid = t22.fitemid
left join t_stock      t70	on t70.fitemid = t22.FDCStockID
left join t_stockplace t71  on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '21','29','43')
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792
and t23.fnumber between @fnumberStart and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fdcspid,t21.ftrantype,t22.fdcstockid
--PRODUCT ISSUE
select t22.fitemid as fitemid,t22.fscstockid as fstockid,isnull(t22.fdcspid,0)  as fstockplaceid,
-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #material_issue
from icstockbill		t21  
join icstockbillentry	t22		on t22.finterid = t21.finterid
left join t_icitem		t23		on t23.fitemid = t22.fitemid
left join t_stock      t70	on t70.fitemid = t22.fscstockid
left join t_stockplace t71  on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype = 24
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792
and t23.fnumber		between @fnumberStart and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fdcspid
--ADJUST ISSUE
select t22.fitemid as fitemid,t22.fscstockid as fstockid,isnull(t22.fscspid,0)  as fstockplaceid,
-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #adjust_out
from icstockbill		t21  
join icstockbillentry	t22		on t22.finterid = t21.finterid
left join t_icitem		t23		on t23.fitemid = t22.fitemid
left join t_stock      t70	on t70.fitemid =  t22.fscstockid
left join t_stockplace t71  on t71.fspid	= t22.fscspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype =41
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792
and t23.fnumber between @fnumberStart and @fnumberEND 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fscspid
--
select kk.fitemid,kk.fstockid,kk.fstockplaceid,sum(kk.fqty) as inv_qty,sum(kk.fbal) as amt
into #Inventory
from (select * from  #NewlyInitInv 
union all 
select * from #normal_in		--received
union all
select * from #adjust_in		-- 盘赢与调拔入库
union all 
select * from #normal_out		--ISSUE 出库
union all
select * from #material_issue	--ISSUE
union all 
select * from #adjust_out		--ISSUE 调拨出库 
) kk
group by  kk.fitemid,kk.fstockid,kk.fstockplaceid
-- select * from #Inventory
--上查BOM 找13和01
--bom
--drop table #bom   
--BOM不能超过100层
declare @level int,@lastitemid int    
select @lastitemid = 208607,@level = 0   
with recursive_cte as (
select b.FItemID as firstitemid ,cast(@level as varchar(101)) as flevel, b.FItemID as FItemID,a.FItemID as FParentID,cast(b.fqty as decimal(12,4)) as fQtyPerPro,
cast(1 as decimal(12,4))as fQty,b.funitid as funitid, cast(b.fscrap as decimal(10,4) ) as fscrap,
cast(b.fitemsize as varchar(10)) as fitemsize,--Fnumber,
b.FInterID as fbominterid,a.fbomnumber,
cast(right('000'+cast(row_number()over(order by b.finterid) as varchar(20)),3) as varchar(300)) as sn,
a.fstatus,a.fusestatus , 
cast ('.' as varchar(101)) as point
from icbom a join icbomchild b on a.finterid = b.finterid 
where b.fitemid in (select fitemid from t_icitem where fnumber between @fnumberStart and @fnumberEND )
union all
select c.firstitemid as firstitemid ,cast(cast(c.flevel as int)+1 as varchar(101)) as flevel,b.FItemID as fitemid,a.fitemid as FParentID,
cast(b.fqty as decimal(12,4) ) as fQtyPerPro,cast(round(b.fqty*c.fqty/(1-b.fscrap*0.01),4)  as decimal(12,4) )as fQty,
b.funitid as funitid,cast(b.fscrap as decimal(10,4)) as fscrap,
cast(b.fitemsize as varchar(10)) as  fitemsize,--a.Fnumber,
b.FInterID as fbominterid,a.fbomnumber,
cast(c.sn+right('000'+cast(row_number()over(order by a.finterid) as varchar(20)),3) as varchar(300)) as sn,
a.fstatus,a.fusestatus,cast(c.point+'.' as varchar(101)) as point
from icbom a join icbomchild b on a.finterid = b.finterid 
join recursive_cte c on b.fitemid = c.FParentID
where b.fitemid = c.FParentID
)
select * into #bom 
from recursive_cte --option(maxrecursion 3)
order by sn
--   select t1.fname,t1.fnumber ,t0.* from #bom t0 join t_icitem t1 on t0.fparentid = t1.fitemid
--order by t0.sn
   select distinct t0.fparentid, t1.fname,t1.fnumber ,t1.fmodel,t0.fstatus ,t0.firstitemid,t0.fusestatus
into #OfPackage 
from #bom t0
join	t_icitem t1	 on t0.fparentid = t1.fitemid 
where t1.fnumber like '13.%'  
order by t0.fstatus desc ,t1.fnumber

   select distinct t0.fparentid, t1.fname,t1.fnumber ,t1.fmodel,t0.fstatus ,t0.firstitemid ,t0.fitemid,t0.fusestatus
into #OfProduct
from #bom t0 
join t_icitem t1 on t0.fparentid = t1.fitemid
where t1.fnumber like '01.%' 
order by t0.fstatus desc ,t1.fnumber
--select * from #OfPackage
--select * from #OfProduct
--#lastSaleAMT
select t21.fitemid,isnull(cast(sum(t21.fqty) as decimal(10,2)),0) as SaleQty 
into #lastSaleAMT
from  icstockbill t20 
left join icstockbillentry t21 on  t20.finterid = t21.finterid
where t20.fdate >=@SaleStartDate 
and t20.fdate <= @SaleCloseDate
and t20.ftrantype = 21 
group by t21.fitemid 
--AccountAge Analyze
select w.* into #t_001 
from (
select 
t50.firstitemid,
t51.fparentid as unpackagedProID	,t51.fname as unpackagedFname,t51.fnumber as unpackagedFnubmer,
t51.fmodel as UnpackagedFmodel,
 t51.fstatus as unpackagedBomStatus,
t51.fusestatus  as unpackagedBomUseStatus,
t50.fparentid as ProductID	,t50.fname as ProductFname,t50.fnumber as ProductFnumber,
t50.fmodel as ProductFmodel, t50.fstatus as ProductBomStatus,
t50.fusestatus as productBomUseStatus
 from #OfProduct  t50
left join  #OfPackage t51 on  t50.firstitemid = t51.firstitemid and t50.fitemid = t51.fparentid
union 
select 
t51.firstitemid,
t51.fparentid as unpackagedProID	,t51.fname as unpackagedFname,t51.fnumber as unpackagedFnubmer,
t51.fmodel as UnpackagedFmodel,
 t51.fstatus as unpackagedBomStatus,
t51.fusestatus  as unpackagedBomUseStatus,
t50.fparentid as ProductID	,t50.fname as ProductFname,t50.fnumber as ProductFnumber,
t50.fmodel as ProductFmodel, t50.fstatus as ProductBomStatus,
t50.fusestatus as productBomUseStatus
 from #OfProduct  t50
right join  #OfPackage t51 on  t50.firstitemid = t51.firstitemid and t50.fitemid = t51.fparentid) w   


declare @sql varchar(2000)
,@sql2 varchar(500) = ''
,@sql3 varchar(500) =''
,@sql4 varchar(500) =''
,@sql5 varchar(500) =''   
select @sql = 'select t40.fitemid,t40.fnumber,t40.fmodel,t40.fname ,t45.fname as unitname,
t41.inv_qty,t41.amt,(case when isnull(t41.inv_qty,0) = 0 then 0 else round(t41.amt/t41.inv_qty,4) end ) as funitprice,
 t46.fname as stockname, t47.fnumber as stockplace,t42.totalDays,
 t43.unpackagedFname,t43.unpackagedFnubmer,t43.UnpackagedFmodel,
 (case t43.unpackagedBomStatus when 1 then ''审核'' when 0 then ''未审核'' else '''' end) as UPBomCheckStatus,
 (case t43.unpackagedBomUseStatus when 1072 then ''使用'' when 0 then  ''未使用''else  '''' end) as UPBomUseStatus,
 t43.ProductFnumber,t43.ProductFmodel,t43.ProductFname,
 (case t43.ProductBomStatus when 1 then ''审核'' when 0 then ''未审核'' else '''' end) as PRODBomCheckStatus,
 (case t43.productBomUseStatus when 1072 then ''使用'' when 0 then ''未使用'' else  '''' end) as ProdBomUseStatus
  , t44.SaleQty
from		t_ICItem			t40
join		#Inventory			t41		on t41.fitemid = t40.fitemid	 
left join	#AccountAge			t42		on t42.fitemid = t40.fitemid	
left join	#t_001				t43		on t43.firstitemid = t40.fitemid	
left join	#lastSaleAMT		t44		on t44.fitemid = (case when t40.fnumber like ''01.'+'%'+''' then t41.fitemid else t43.ProductID end)
left join	t_measureunit		t45		on t45.fitemid = t40.funitid	 
left join	t_stock				t46		on t46.fitemid = t41.fstockid	and t41.inv_qty <> 0
left join	t_stockplace		t47		on t47.fspid = t41.fstockplaceid

where 	isnull(t41.inv_qty,0) <> 0   
and	 isnull(t42.totaldays,0) >= '+ convert(varchar(10),@days)
+' and  isnull(t44.saleqty,0) between '+convert(varchar(10),@saleqtymin)+' and '+ convert(varchar(10),@saleqtymax)

if (@UnpackBomCheckStatus = 'y'  )
begin select @sql2 = ' and t43.unpackagedBomStatus = 1 ' end
if (@UnpackBomCheckStatus = 'n' )
begin select @sql2 = ' and t43.unpackagedBomStatus = 0 ' end
if (@UnpackBomUseStatus = 'y'   )
begin select @sql3 = ' and t43.unpackagedBomUseStatus  =  1072 ' end
if ( @UnpackBomUseStatus = 'n' )
begin select @sql3 = ' and t43.unpackagedBomUseStatus  =  1073 ' end
if (@prodBomCheckStatus = 'y'  )
begin select @sql4 = ' and  t43.ProductBomStatus =  1 ' end
if ( @prodBomCheckStatus = 'n' )
begin select @sql4 = ' and  t43.ProductBomStatus =  0 ' end
if (@prodBomUseStatus = 'y'  )
begin select @sql5 = ' and t43.productBomUseStatus =  1072 ' end
if ( @prodBomUseStatus = 'n' )
begin select @sql5 = ' and t43.productBomUseStatus = 1073 ' end
execute (@sql+@sql2+@sql3+@sql4+@sql5+' order by t42.totalDays')
/*
select * from #Inventory where fitemid = 49229
select * from t_stockplace	 where fitemid = 20152
*/

-- 即时库存，验证 select fqty,* from icinventory where fitemid = 28634

drop table  #AccountAge,#MaxIssueDate0,#MaxIssueDate1,#MaxIssueDate2
drop table  #Inventory,#NewlyInitInv,#normal_in,#normal_out,#material_issue	,#adjust_in,#adjust_out
drop table  #bom,#t_001
drop table	#OfProduct ,#OfPackage,#lastSaleAMT
select * from t_submessage where fname like '%使用'

