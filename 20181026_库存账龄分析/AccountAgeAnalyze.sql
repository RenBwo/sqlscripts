/*
 * author:   	renbo
 * date:		2018/10/26
 * description: bug modify
 * 
 * 账龄分析
 * author :renbwo
 * date :2017/06/01
 * test
 * execute AccountAgeAnalyze
 * 
 */
--/*
alter PROCEDURE [dbo].[AccountAgeAnalyze]
(@fnumberStart						varchar(30)	, 
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
@run_key 							int			,
@days								int			 )
as 
begin	
--*/
/*
--test
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
@days								int	

set @fnumberStart=''						
set @fnumberEND	=''
set @days=3000
--test end
*/
	if isnull(@run_key,0) <9
	begin
		return
	end 
declare		@currentyear	varchar(4)		 
		 ,	@currentperiod	varchar(2)
		 ,	@check			int
/*scope control
 
if  @days<90
begin
raiserror('账龄天数太小，可能形成内存不足错误；请加大账龄天数的数值',18,1)
return
end
*/
select @currentyear = fvalue from t_systemprofile where fkey like 'currentyear' and fcategory = 'GL'
select @currentperiod = fvalue from t_systemprofile where fkey like 'currentperiod' and fcategory = 'GL'
if isnull(ltrim(rtrim(@fnumberStart)),'bd') = 'bd' or @fnumberStart=''
begin  select  @fnumberStart = (select min(fnumber ) from t_icitem) end
if isnull(ltrim(rtrim(@fnumberEND)),'bd') = 'bd' or @fnumberEND=''
begin  select @fnumberEND =	(select  max(fnumber ) from t_icitem ) end 
 
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



--select @fnumberStart as a,@fnumberEND as b  ,@fstockidStart as cv 	,@fstockidEnd as d ,@fspidStart as e,@fspidEnd as ff,@days as cc
--select @CloseDate,@UnpackBomCheckStatus,@UnpackBomUseStatus,@ProdBomCheckStatus,@ProdBomUseStatus	,@SaleStartDate,@SaleCloseDate,@SaleQtyMin,@SaleQtyMax	,@days
--select * from ictranstype 
--21	销售产品
--24	生产领料
--28	委外加工发出
--29	其他出库
--43	盘亏毁损
--83	销售发货  用在发货通知里 table:SEOutStock出入库记录里没有使用这个transfertype
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

/*
 * 最后出库日期,离截止日期最近的出库日期
 */
--有出库,取最后出库日期
select max(a.fdate) as MaxIssueDate,b.fitemid
into #MaxIssueDate0 
from icstockbill 		a 
join icstockbillentry 	b on a.finterid= b.finterid 
join t_icitem 			c on c.fitemid = b.fitemid
where a.ftrantype in( '21','24','28','29') and a.fdate <= @CloseDate 
and isnull(a.fheadselfb0157,0) <> 293792	--销售状态不为销售分配
and isnull(b.fqty,0) <> 0					--有出库 数量
and c.fnumber between @fnumberStart and @fnumberEND
group by b.fitemid
-- 有入库并且没出库,取入库日期
select max(a.fdate) as MaxIssueDate,b.fitemid
into #MaxIssueDate1
from icstockbill 		a 
join icstockbillentry 	b on a.finterid= b.finterid 
join t_icitem 			c on c.fitemid = b.fitemid
where a.ftrantype in( '1','2','3','5','10','73') 
and a.fdate <= @CloseDate 
and isnull(b.fqty ,0)<> 0							--有入库  数量
and not exists(select 1 from #MaxIssueDate0 where fitemid = b.fitemid )	--没有出库记录 
and c.fnumber between @fnumberStart and @fnumberEND 
group by b.fitemid 
--没有出入库 取系统建立日期 2010/04/01
select distinct cast('2010-04-01' as date) as MaxIssueDate ,a.fitemid 
into #MaxIssueDate2
from icinvbal a 
join t_icitem c on c.fitemid = a.fitemid
where fyear= @currentyear 
and fperiod = @currentperiod  
and not exists (select 1 from #MaxIssueDate0 where fitemid = a.fitemid) --没有出库记录
and not exists (select 1 from #MaxIssueDate1 where fitemid = a.fitemid) --没有入库记录
and c.fnumber between @fnumberStart and @fnumberEND
/*
 * account age
 * 1.有出库的情况下，账龄=截止日期 - 最后出库日期
 * 2.有入库并且没出库的情况下，账龄=截止日期 - 入库日期
 * 3.没有出入库的情况,账龄=截止日期- 2010/04/01
 */
select  mm.fitemid
,datediff(day,mm.MaxIssueDate,@CloseDate) 				as AcctAgeDay
,floor(datediff(day,mm.MaxIssueDate,@CloseDate)/365) 	as AcctAgeYPart
,floor(datediff(day,mm.MaxIssueDate,@CloseDate)%365/30) as AcctAgeMPart
,datediff(day,mm.MaxIssueDate,@CloseDate)%365%30 		as AcctAgeDayPart 
into #AccountAge 
from ( select * from #MaxIssueDate0
union all
select * from #MaxIssueDate1  
union all
select * from #MaxIssueDate2 
) mm 
where datediff(day,mm.MaxIssueDate,@CloseDate)>= @days
order by AcctAgeDay desc ,mm.AcctAgeDayPart desc

drop table #MaxIssueDate0,#MaxIssueDate1,#MaxIssueDate2

--select a.*,b.fnumber from #AccountAge a join t_icitem b on a.fitemid = b.fitemid  order by b.fnumber
/* 
 * 至截止日期时库存量，
 * icinventory 即时库存 
 * icbal 月别库存 
 * icinvbal 月别仓库别库存
 * 截止库存 = 当月期初库存 + 本月至截止日期的出入库
 * select fnumber ,* from t_stockplace where fnumber between '0.' and 'zzzzz.'
 */
--NewlyInitInv
select a.fitemid,a.fstockid,isnull(a.fstockplaceid,0) as fstockplaceid,sum(a.fbegqty) as fqty
,sum(a.fbegbal) as fbal
into #NewlyInitInv
from icinvbal 			a 
join #AccountAge  		b   on b.fitemid = a.fitemid
left join t_stock      	t70	on t70.fitemid = a.fstockid
left join t_stockplace 	t71 on t71.fspid	= a.fstockplaceid
where a.fyear=@currentyear and a.fperiod =@currentperiod 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by   a.fitemid,a.fstockid,a.fstockplaceid
--NORMAL RECEIVE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,isnull(t22.fdcspid,0) as fstockplaceid
, sum(t22.fqty) as fqty,sum(t22.famount) as fbal
into #normal_in
from icstockbill		t21  
join icstockbillentry	t22	on t22.finterid = t21.finterid
join #AccountAge  		t23	on t23.fitemid = t22.fitemid
left join t_stock      	t70	on t70.fitemid = t22.fdcstockid
left join t_stockplace 	t71	on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '1','2','3','5','10','73')
and isnull(t22.fqty,0) <> 0
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fdcstockid,t22.fdcspid
--ADJUST RECEIVE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,isnull(t22.fdcspid,0) as fstockplaceid, sum(t22.fqty) as fqty,sum(t22.famount) as fbal
into #adjust_in
from icstockbill		t21  
join icstockbillentry	t22	on t22.finterid = t21.finterid
join #AccountAge  		t23	on t23.fitemid = t22.fitemid
left join t_stock      	t70	on t70.fitemid = t22.fdcstockid
left join t_stockplace 	t71 on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '40','41')
and isnull(t22.fqty,0) <> 0 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fdcstockid,t22.fdcspid
--NORMAL ISSUE
select t22.fitemid as fitemid,t22.fdcstockid as fstockid,
isnull(t22.fdcspid,0)  as fstockplaceid,-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #normal_out
from icstockbill		t21  
join icstockbillentry	t22	on t22.finterid = t21.finterid
join #AccountAge  		t23	on t23.fitemid = t22.fitemid
left join t_stock      	t70	on t70.fitemid = t22.FDCStockID
left join t_stockplace 	t71	on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype in( '21','29','43')
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792 
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fdcspid,t21.ftrantype,t22.fdcstockid
--PRODUCT ISSUE
select t22.fitemid as fitemid,t22.fscstockid as fstockid,isnull(t22.fdcspid,0)  as fstockplaceid,
-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #material_issue
from icstockbill		t21  
join icstockbillentry	t22	on t22.finterid = t21.finterid
join #AccountAge  		t23	on t23.fitemid = t22.fitemid
left join t_stock      	t70	on t70.fitemid = t22.fscstockid
left join t_stockplace 	t71	on t71.fspid	= t22.fdcspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype = 24
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fdcspid
--ADJUST ISSUE
select t22.fitemid as fitemid,t22.fscstockid as fstockid,isnull(t22.fscspid,0)  as fstockplaceid,
-1*sum(t22.fqty) as fqty,-1*sum(t22.famount)  as fbal
into #adjust_out
from icstockbill		t21  
join icstockbillentry	t22	on t22.finterid = t21.finterid
join #AccountAge  		t23	on t23.fitemid = t22.fitemid
left join t_stock      	t70	on t70.fitemid =  t22.fscstockid
left join t_stockplace 	t71	on t71.fspid	= t22.fscspid
where year(t21.fdate) >= @currentyear 
and month(t21.fdate) >= @currentperiod 
and t21.fdate <= @CloseDate
and t21.ftrantype =41
and isnull(t22.fqty ,0) <> 0
and isnull(t21.fheadselfb0157,0) <> 293792
and t70.fnumber			between @fstockidStart	and @fstockidEnd
and t71.fnumber			between @fspidStart		and @fspidEND
group by t22.fitemid,t22.fscstockid,t22.fscspid
--
select kk.fitemid,kk.fstockid,kk.fstockplaceid,sum(kk.fqty) as inv_qty,sum(kk.fbal) as amt
into #Inventory
from (
select * from #NewlyInitInv 
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
drop table  #NewlyInitInv ,#normal_in,#adjust_in,#normal_out,#material_issue,#adjust_out
--select * from #Inventory

/*
 * 上查BOM 找13和01
 */
--bom
--drop table #bom
--BOM不能超过100层
declare @level int --,@lastitemid int 
select @level = 0 --, @lastitemid = 208607

with recursive_cte as (
select b.FItemID as firstitemid ,cast(@level as varchar(101)) as flevel
,b.FItemID as FItemID,a.FItemID as FParentID
,cast(b.fqty as decimal(12,4)) as fQtyPerPro,cast(1 as decimal(12,4))as fQty
,b.funitid as funitid, cast(b.fscrap as decimal(10,4) ) as fscrap,
cast(b.fitemsize as varchar(10)) as fitemsize,--Fnumber,
b.FInterID as fbominterid,a.fbomnumber,
cast(right('000'+cast(row_number()over(order by b.finterid) as varchar(20)),3) as varchar(300)) as sn,
a.fstatus,a.fusestatus , 
cast ('.' as varchar(101)) as point
from icbom 			a 
join icbomchild 	b on a.finterid = b.finterid 
join #AccountAge  	c on c.fitemid = b.fitemid
union all
select c.firstitemid as firstitemid ,cast(cast(c.flevel as int)+1 as varchar(101)) as flevel
,b.FItemID as fitemid,a.fitemid as FParentID,
cast(b.fqty as decimal(12,4) ) as fQtyPerPro,cast(round(b.fqty*c.fqty/(1-b.fscrap*0.01),4)  as decimal(12,4) )as fQty,
b.funitid as funitid,cast(b.fscrap as decimal(10,4)) as fscrap,
cast(b.fitemsize as varchar(10)) as  fitemsize,--a.Fnumber,
b.FInterID as fbominterid,a.fbomnumber,
cast(c.sn+right('000'+cast(row_number()over(order by a.finterid) as varchar(20)),3) as varchar(300)) as sn,
a.fstatus,a.fusestatus,cast(c.point+'.' as varchar(101)) as point
from icbom 			a 
join icbomchild 	b on a.finterid = b.finterid 
join recursive_cte 	c on b.fitemid = c.FParentID
)
select * into #bom 
from recursive_cte --option(maxrecursion 3)
order by sn
--select t1.fname,t1.fnumber ,t0.* from #bom t0 join t_icitem t1 on t0.fparentid = t1.fitemid
--order by t0.sn 
select xo.* into #BomMap
from (
select  a.firstitemid as firstitemid,a.fitemid as itemId13,a.fparentid as itemId01 
from #bom a join t_icitemcore b 
on a.fitemid = b.fitemid and b.fnumber like '13.%' 
union all
select  a.firstitemid as firstitemid,0 as itemId13,a.fitemid as itemId01 
from #bom a join t_icitemcore b 
on a.firstitemid = b.fitemid and b.fnumber like '01.%'
) xo 
drop table  #bom
--#HisSaleQty
declare @sql01 varchar(1000)
,@sql02 varchar(100) = ''
,@sql03 varchar(100) =''
,@sql04 varchar(100) =''
,@sql05 varchar(100) =''
,@sql06 varchar(100) =''
,@sql07 varchar(100) =''

set @sql01='  select t21.fitemid,isnull(sum(t21.fqty),0) as SaleQty 
into #HisSaleList
from  icstockbill 				t20 
join icstockbillentry 			t21 on t20.finterid=t21.finterid
join (select distinct itemid01 from #BomMap where isnull(itemid01,0)<>0)  	
								t22	on t22.itemId01=t21.fitemid
where t20.ftrantype = 21 
and isnull(t20.fheadselfb0157,0) <> 293792'
if isnull(@SaleStartDate,'1900-01-01') <>'1900-01-01' and  @SaleStartDate<>''
begin  set @sql02='and t20.fdate >='+@SaleStartDate  end
if isnull(@SaleCloseDate,'1900-01-01') <>'1900-01-01' and  @SaleCloseDate<>''
begin set @sql03='and t20.fdate <= '+@SaleCloseDate  end
set @sql04=' group by t21.fitemid '
--test exec(@sql01+@sql02+@sql03+@sql04)
set @sql05='   select * into  #HisSaleQty from #HisSaleList  where  1=1 '
if isnull(@SaleQtyMin,0) > 0 
begin set @sql06= ' and saleqty > '+convert(varchar(10),@SaleQtyMin)  end
if isnull(@SaleQtyMax,0)>0
begin set @sql07=' and saleqty<= '+convert(varchar(10),@SaleQtyMax) end
--test exec(@sql01+@sql02+@sql03+@sql04+@sql05+@sql06+@sql07)
--AccountAge Analyze
declare @sql1 varchar(3000)
,@sql2 varchar(100) =''
,@sql3 varchar(100) =''
,@sql4 varchar(100) =''
,@sql5 varchar(100) =''
,@sql6 varchar(100) =''
,@sql7 varchar(100) =''

select @sql1 = '  select t40.fitemid,''   ''+t40.fnumber as fnumber,t40.fmodel,t40.fname ,t45.fname as unitname
,t41.inv_qty,t41.amt
,(case when isnull(t41.inv_qty,0) = 0 then 0 else round(t41.amt/t41.inv_qty,4) end ) as funitprice
,t46.fname as stockname, t47.fnumber as stockplace
,t42.AcctAgeDay
,''   ''+right(''00''+convert(varchar(4),t42.AcctAgeYPart),2)+'' 年 ''
+right(''00''+convert(varchar(2),t42.AcctAgeMPart),2)+'' 个月 ''
+right(''00''+convert(varchar(2),t42.AcctAgeDayPart),2)+'' 天   '' as yMd
,t43.fname as Fname13
,t43.fnumber as Fnubmer13
,t43.fmodel as Fmodel13
,(case t60.fstatus when 1 then ''审核'' when 0 then ''未审核'' else '''' end) as UPBomCheckStatus
,t50.fname as UPBomUseStatus
,t62.Fnumber as fnumber01,t62.Fmodel as fmodel01,t62.Fname as fname01
,(case t61.fstatus when 1 then ''审核'' when 0 then ''未审核'' else '''' end) as PRODBomCheckStatus
,t51.fname as ProdBomUseStatus
,t44.SaleQty
from #AccountAge			t42 
join #Inventory				t41	on t42.fitemid = t41.fitemid and isnull(t41.inv_qty,0) <> 0
left join 	#bommap 		t99 on t99.firstitemid = t42.fitemid
left join	#HisSaleQty		t44	on t44.fitemid =t99.itemid01
left join 	t_ICItem		t40 on t41.fitemid = t40.fitemid
left join	t_measureunit	t45	on t45.fitemid = t40.funitid
left join 	t_ICItem		t43 on t43.fitemid = t99.itemid13
left join 	t_ICItem	 	t62 on t62.fitemid = t99.itemid01
left join	t_stock			t46	on t46.fitemid = t41.fstockid	
left join	t_stockplace	t47	on t47.fspid = t41.fstockplaceid
left join   icbom 			t60 on t60.fitemid = t99.itemid13
left join 	icbom 			t61 on t61.fitemid = t99.itemid01
left join	t_submessage	t50	on t50.finterid = t60.fusestatus
left join	t_submessage	t51	on t51.finterid = t61.fusestatus
 where 1=1 '

if (@UnpackBomCheckStatus = 'y'  )
begin select @sql2 = ' and t60.fstatus = 1 ' end
if (@UnpackBomCheckStatus = 'n' )
begin select @sql2 = ' and t60.fstatus = 0 ' end
if (@UnpackBomUseStatus = 'y'   )
begin select @sql3 = ' and t60.fusestatus  =  1072 ' end
if ( @UnpackBomUseStatus = 'n' )
begin select @sql3 = ' and t60.fusestatus  =  1073 ' end
if (@prodBomCheckStatus = 'y'  )
begin select @sql4 = ' and  t61.fstatus =  1 ' end
if ( @prodBomCheckStatus = 'n' )
begin select @sql4 = ' and  t61.fstatus =  0 ' end
if (@prodBomUseStatus = 'y'  )
begin select @sql5 = ' and t61.fusestatus =  1072 ' end
if ( @prodBomUseStatus = 'n' )
begin select @sql5 = ' and t61.fusestatus = 1073 ' end
set @sql6=' order by t42.AcctAgeDay desc '
set @sql7=' drop table  #HisSaleList,#HisSaleQty'
execute (@sql01+@sql02+@sql03+@sql04+@sql05+@sql1+@sql2+@sql3+@sql4+@sql5+@sql6+@sql7)
/*
select * from #Inventory where fitemid = 49229
select * from t_stockplace	 where fitemid = 20152
*/
drop table  #AccountAge, #Inventory

-- 即时库存，验证 select fqty,* from icinventory where fitemid = 28634
end

