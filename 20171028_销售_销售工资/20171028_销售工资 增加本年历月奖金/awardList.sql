set nocount on
/*
 * 2017/10/28
 * 目前使用的这个
 * */
declare @i int,@j int,@fyear int,@fmonth int
declare @sql varchar(8000),@result varchar(1000),@drop varchar(1000),@column varchar(1000)
select @fyear=2017,@fmonth =01
--select @fyear='@FYear@',@fmonth = '@FMonth@'
select @j=1, @i= max(fmonth ) FROM SalerPay where fyear=year(getdate()) 

set @column=''
set @sql=' SELECT a.FYEAR, a.FMONTH, CASE WHEN a.FStatus=0 THEN ''未审核'' ELSE ''审核'' end as FStatus
     , a.FNumber, a.FName, a.FAmount1, a.FAmount2, a.FPlanAmount, a.FAmount3, a.FSaleBaseAmount
     , a.FDrawPercentage,	a.FProceedsAmount1, a.FProceedsAmount2, a.FProceedsAmount3, a.FPayAmount10
     , a.FPayAmount20, a.FPayAmount30, a.FPayAmount40, a.FActAmount, a.FPayBaseAmount, a.FPayPercentage
     , a.FTotBaseAmount, a.FTotPercentage, a.FTotAmount ,yeartotal.fyeartotal
     into #tmPay0
FROM SalerPay a
left join ( select fyear,FStatus,fnumber,sum(ftotamount) as fyeartotal 
from salerpay where fyear='+convert(varchar(20),@fyear)
+' group by fyear,fnumber,fstatus ) yeartotal 
on a.fyear=yeartotal.fyear and a.fnumber = yeartotal.fnumber and a.fstatus=yeartotal.fstatus 
WHERE a.fyear='+convert(varchar(20),@fyear)+' and a.fmonth = '+convert(varchar(20),@fmonth)


set @drop=' drop table #tmpay0'


while @j-1 < @i and @fyear = (select year(getdate()))
	begin
		set @sql=@sql
		+' select a.*,b.FDrawPercentage as 销售提成'+convert(varchar(200),@j)
		+'月,b.FPayPercentage as 回款提成'+convert(varchar(200),@j)
		+'月,b.FTotPercentage as 提成小计'+convert(varchar(200),@j)
		+'月 into #tmPay'+convert(varchar(200),@j)
		+' from #tmpay'+convert(varchar(200),@j-1)+' a left join salerpay b on a.fnumber = b.fnumber and a.fyear=b.fyear '
		+' and b.fmonth = '+convert(varchar(200),@j)+''
		set @result = ''
		set @drop=@drop + ' drop table  #tmpay'+convert(varchar(200),@j)
		select @j=@j+1	
	end	
while @j-1 < 12 and @fyear < (select year(getdate()))
	begin
		set @sql=@sql
		+' select a.*,b.FDrawPercentage as 销售提成'+convert(varchar(200),@j)
		+'月,b.FPayPercentage as 回款提成'+convert(varchar(200),@j)
		+'月,b.FTotPercentage as 提成小计'+convert(varchar(200),@j)
		+'月 into #tmPay'+convert(varchar(200),@j)
		+' from #tmpay'+convert(varchar(200),@j-1)+' a left join salerpay b on a.fnumber = b.fnumber and a.fyear=b.fyear '
		+' and b.fmonth = '+convert(varchar(200),@j)+''
		set @result = ''
		set @drop=@drop + ' drop table  #tmpay'+convert(varchar(200),@j)
		select @j=@j+1	
	end	



while @i< 12   and @fyear = (select year(getdate()))
begin
set @column=@column+' ,0 as 销售提成'+convert(varchar(4),@i+1)+'月,0 as 回款提成'+convert(varchar(4),@i+1)
+'月,0 as 提成小计'+convert(varchar(4),@i+1)+'月'
select @i=@i+1
end


set @result='select * '+@column+' from #tmpay'+convert(varchar(200),@j-1)
	/*select len(@result),convert(varchar(100),left(@result,100))
		,convert(varchar(100),substring(@result,101,200))
		,convert(varchar(100),substring(@result,201,300))*/
exec(@sql+@result+@drop)



--drop table  tmpay4,tmpay3,tmpay2,tmpay1,tmpay0
--select * from tmpay4