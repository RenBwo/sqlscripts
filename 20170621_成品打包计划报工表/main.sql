alter procedure ProductPackagePlanDaily(@str1 varchar(1000),@str2 varchar(1000) )
as begin
set nocount on;

/*
if '*FSeqno*'='A'		select @str2=' ORDER BY fgzl, fCustomer,FPlanCommitDate,groupsn '
if '*FSeqno*'='C'		select @str2=' ORDER BY fCustomer, fgzl,groupsn '
if '*FSeqno*'='B'		select @str2=' ORDER BY FPlanCommitDate, fmodel,groupsn '
if '*FSeqno*'=''		select @str2=' ORDER BY fgzl, fCustomer ,groupsn'

if '@FSordNO@'<>''		select @str1= ' AND t05.FBillNo like '+''''+'%'+'@FSordNO@'+'%'+''''
else select @str1=''
if '*FStartFGZL*'<>''	select @str1=	@str1 + ' AND  t01.FGZl>='+''''+'*FStartFGZL*'+''''
if '#FEndFGZL#'<>''		select @str1=	@str1 + ' AND  t01.FGZl<='+''''+ '#FEndFGZL#'+''''
if '*CustNo*'<>''		select @str1=	@str1 + ' AND t06.FNumber like '+''''+'%'+'*CustNo*'+'%'+''''
if '********'<>''		select @str1=	@str1 + ' AND t02.FPlanCommitDate>='+''''+convert(char(8),CAST('********' as datetime),112)+''''
if '########'<>''		select @str1=	@str1 + ' AND t02.FPlanCommitDate<='+''''+convert(char(8),CAST('########' as datetime),112)+''''

*/
declare @sql0 varchar(6000),@sql1 varchar(2000),@sql2 varchar(200),@sql3 varchar(2000)
select @sql0 = '
select t01.fgzl,t03.fmodel ,t02.fheadselfj0192 as itemMapcustom,t02.fqty,t06.fnumber as fCustomer,
t08.fname as faccesoryname,t08.fmodel as faccessoryModel,t08.fnumber as faccessoryNumber,t07.fqtyscrap as fAccessoryStdQty
,row_number() over(partition by t01.fgzl,t03.fmodel,t02.fheadselfj0192,t02.fqty,t06.fnumber order by t08.fnumber ) as groupsn
,t02.fplancommitdate
into #t1
from  t_ypaichan_cp		t01
 join	icmo			t02 on t01.fgzl			= t02.fheadselfj0184	and t02.fworkshop = 227394 
 join	t_icitem		t03 on t03.fitemid		= t02.fitemid
 join	SEOrderEntry	t04 on t01.fgzl			= t04.FEntrySelfS0160  
 join	SEOrder			t05 on t04.FInterID		= t05.FInterID			and t05.FCancellation =0 --and t05.FChangeMark=0
 join	t_Organization	t06 on t06.fitemid		= t05.fcustid 
 join	PPBOMEntry		t07 on t07.ficmointerid	= t02.finterid
 join	t_ICItem		t08 on t08.FItemID		= t07.fitemid			and t08.fnumber not like ''13.%'' and (t08.fnumber < ''2.01.820'' or ''2.01.909'' < t08.fnumber)
where t01.fstatus = 1 and t01.fqty > 0  and t05.FBillNo is NOT null 
'
select @sql3 = ' ; select *  into #ProPackagDailyPlan  from (
select * from #t1
union
select t01.fgzl,t03.fmodel ,t02.fheadselfj0192 as itemMapcustom,t02.fqty,t06.fnumber as fCustomer,
 '''' as faccesoryname,'''' as faccessoryModel,'''' as faccessoryNumber,
0 as fAccessoryStdQty ,0 as groupsn,t02.fplancommitdate
from  t_ypaichan_cp		t01
 join	icmo			t02 on t01.fgzl			= t02.fheadselfj0184	and t02.fworkshop = 227394 
 join	t_icitem		t03 on t03.fitemid		= t02.fitemid
 join	SEOrderEntry	t04 on t01.fgzl			= t04.FEntrySelfS0160  
 join	SEOrder			t05 on t04.FInterID		= t05.FInterID			and t05.FCancellation =0 and t05.FChangeMark=0
 join	t_Organization	t06 on t06.fitemid		= t05.fcustid 
 join	PPBOMEntry		t07 on t07.ficmointerid	= t02.finterid
 left join	t_ICItem		t08 on t08.FItemID		= t07.fitemid	
where t01.fstatus = 1 and t01.fqty > 0  and t05.FBillNo is NOT null and t01.fgzl not in( select fgzl from #t1 )
'
select @sql1= '
 ;select (case when groupsn<2 then fgzl							else '''' end)	as 工作令
 	    ,(case when groupsn<2 then FModel						else '''' end)	as 型号
		,(case when groupsn<2 then itemMapcustom				else '''' end)	as 客户对应名称
		,(case when groupsn<2 then left(convert(varchar(20),FQty),charindex(''.'',convert(varchar(20),FQty)) - 1)	else '''' end)	as 数量
		/*,(case when groupsn<2 then FQty	else 0 end)	as 数量*/
		,(case when groupsn<2 then Fcustomer					else '''' end)	as 客户代码
		,isnull(faccesoryname,'''')												as 辅料名	
		,isnull(faccessoryModel,'''')											as 辅料规格型号	
		,fAccessoryStdQty														as 标准用量
		,isnull(faccessoryNumber,'''')											as 备注 
		,groupsn
		,fplancommitdate
from #ProPackagDailyPlan '
select @sql2 = ';drop table #ProPackagDailyPlan,#t1 '
exec(@sql0+@str1+@sql3+@str1+') w'+@sql1+@str2+@sql2)
end