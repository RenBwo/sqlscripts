/*
 * AUTHOR:		RENBO
 * DATE:		2017/
 * DESCRIPTION:	投料需求分析
 * 
 */alter procedure AnalysisProductMaterialRequest(
@datestart			varchar(10)			,@dateend		varchar(10) 	,
@fnumberstartP 		varchar(30)=null 	,@fnumberendP	varchar(30)=null ,
@fnumberstartm 		varchar(30)=null 	,@fnumberendm	varchar(30)	=null,
@fdeptstart 		varchar(30)=null 	,@fdeptend 		varchar(30)=null	,
@fwarehousestart 	varchar(30)=null 	,@fwarehouseend varchar(30)=null	,
@ficmobillstart 	varchar(30)=null	,@ficmobillend 	varchar(30)=null	,
@ficmostatus1 		varchar(1)=null,
@ficmostatus3 		varchar(1)=null		,@ficmostatus5 	varchar(1)=null	
) as
begin
	set nocount on
	declare @sql1 varchar(3000)
	declare @strgroup varchar(600)
	declare @str0 varchar(500)
	declare @str1 varchar(500)
	declare @str2 varchar(500)
	declare @str3 varchar(500)
	declare @str4 varchar(500)
	declare @str5 varchar(500)
	declare @str6 varchar(500)
	set @str1=''
	set @str2=''
	set @str3=''
	set @str4=''
	set @str5=''
	set @str6=''
	
if (isnull(@datestart,'bangde')='bangde' or @datestart=''
or isnull(@dateend,'bangde')='bangde' or @dateend='') 
begin
	set @str0 = ' where t3.fplancommitdate =  dateadd(day,datediff(day,0,getdate()),0)' 
end 
else
begin
	set @str0 = ' where t3.fplancommitdate between convert(datetime,'''+@datestart+''') and  convert(datetime, '''+@dateend+''') '
end 
if (isnull(@fnumberstartm,'bangde')<>'bangde' and @fnumberstartm<>''
and isnull(@fnumberendm,'bangde')<>'bangde' and @fnumberendm<>'') 
begin
	set @str1=' and t5.fnumber between '''+@fnumberstartm+''' and '''+@fnumberendm+''' '
end

if (isnull(@fnumberstartp,'bangde')<>'bangde' and @fnumberstartp<>'' 
and isnull(@fnumberendp,'bangde')<>'bangde' and @fnumberendp<>'' ) 
begin 
    set @str2=' and t4.fnumber between '''+@fnumberstartP+''' and '''+@fnumberendP+''' '
end 
if (isnull(@fdeptstart,'bangde')<>'bangde' and @fdeptstart<>'' 
and isnull(@fdeptend,'bangde')<>'bangde' and @fdeptend<>'' ) 
begin 
	set @str3=' and t8.fnumber between '''+@fdeptstart+''' and '''+@fdeptend+''' '
end
if (isnull(@fwarehousestart,'bangde')<>'bangde' and @fwarehousestart<>''
and isnull(@fwarehouseend,'bangde')<>'bangde' and @fwarehouseend<>'' ) 
begin 
	set @str4=' and t9.fnumber between '''+@fwarehousestart+''' and '''+@fwarehouseend+''' '
end  
if (isnull(@ficmobillstart,'bangde')<>'bangde' and @ficmobillstart<>'' 
 and isnull(@ficmobillend,'bangde')<>'bangde' and @ficmobillend<>'' ) 
begin 
	set @str5 = ' and t3.fbillno between '''+@ficmobillstart+''' and '''+@ficmobillend+'''  '
end 

if @ficmostatus1='y'
begin
	set @str6=' and (t3.fstatus = 1 '
	
	if @ficmostatus3='y' 
	begin 
		set @str6=@str6+' or t3.fstatus = 3 '
	end
	if @ficmostatus5='y' 
	begin 
		set @str6=@str6+' or t3.fstatus = 5 '
	end
	set @str6=@str6+' )'
end
	else
	if @ficmostatus3='y' 
	begin
		set @str6=' and (t3.fstatus = 3 '
	if @ficmostatus5='y' 
	begin 
		set @str6=@str6+' or t3.fstatus = 5 '
	end
	set @str6=@str6+' )'
	end
	else
	if @ficmostatus5='y'
	begin
		set @str6=' and (t3.fstatus = 5) '
	end 
	 

set @sql1='
select t8.fname as fdept,t3.fbillno as ficmobill
,t4.fnumber as fproductcode,t4.fname as fproductname,t4.fmodel as fproductmodel
,t5.fnumber as fmatecode,t5.fname as fmatename,t5.fmodel as fmatemodel
,t2.fqtymust,t2.fstockqty,
(t2.fqtymust-t2.fstockqty) as funfetchqty,sum(t6.fqty) as finventory,t7.fname as fopername,
(sum(t6.fqty) - t2.fqtymust+t2.fstockqty) as diff
from ppbom t1
join ppbomentry t2 on t1.finterid = t2.finterid
join icmo t3 		on t3.finterid = t2.ficmointerid
left join t_icitem t4 on t4.fitemid = t1.fitemid
left join t_icitem t5 on t5.fitemid = t2.fitemid
left join icinventory t6 on t6.fitemid = t2.fitemid and t6.fstockid = t2.fstockid
left join t_submessage t7 on t7.ftypeid = 61 and t7.finterid = t2.foperid
left join t_item  t8 on t8.fitemclassid = 2 and t8.fdeleted = 0 and t8.fitemid = t1.fworkshop
left join t_stock t9	on t9.fitemid = t2.fstockid '


set @strgroup=' group by t8.fname,t3.fbillno ,t4.fnumber,t4.fname,t4.fmodel
,t5.fnumber,t5.fname ,t5.fmodel,t2.fqtymust,t2.fstockqty,t7.fname '  
execute(@sql1+@str0+@str1+@str2+@str3+@str4+@str5+@str6+@strgroup)
end
