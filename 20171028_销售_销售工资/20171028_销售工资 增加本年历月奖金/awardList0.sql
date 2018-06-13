/*没有使用
 * */
drop procedure query_saler_wage_renbo
alter procedure query_saler_wage_renbo(@fyear int,@fmonth int)
as 
set @fyear=2017
set @fmonth = 8
SELECT FYEAR, FMONTH, CASE WHEN FStatus=0 THEN '未审核' ELSE '审核' end as FStatus
     , FNumber, FName, FAmount1, FAmount2, FPlanAmount, FAmount3, FSaleBaseAmount
     , FDrawPercentage,	FProceedsAmount1, FProceedsAmount2, FProceedsAmount3, FPayAmount10
     , FPayAmount20, FPayAmount30, FPayAmount40, FActAmount, FPayBaseAmount, FPayPercentage
     , FTotBaseAmount, FTotPercentage, FTotAmount ,sum(ftotamount) as fyeartotal
     into tmPay0
FROM SalerPay
WHERE fyear=@fyear and fmonth = @fmonth
group by FYEAR, FMONTH,  FStatus, FNumber, FName, FAmount1, FAmount2, FPlanAmount, FAmount3, FSaleBaseAmount
     , FDrawPercentage,	FProceedsAmount1, FProceedsAmount2, FProceedsAmount3, FPayAmount10
     , FPayAmount20, FPayAmount30, FPayAmount40, FActAmount, FPayBaseAmount, FPayPercentage
     , FTotBaseAmount, FTotPercentage, FTotAmount 
declare @i int,@j int
declare @sql varchar(1000),@result varchar(1000),@drop varchar(200)

select @j=1, @i = @fmonth


if @i > 1 
begin
while @j < @i
begin
	set @sql=' select a.*,b.FDrawPercentage as 销售提成'+convert(varchar(200),@j)
+'月,b.FPayPercentage as 回款提成'+convert(varchar(200),@j)
+'月,b.FTotPercentage as 提成小计'+convert(varchar(200),@j)
+'月 into tmPay'+convert(varchar(200),@j)
+' from tmpay'+convert(varchar(200),@j-1)+' a join salerpay b on a.fnumber = b.fnumber and a.fyear=b.fyear '
+'and b.fmonth = '+convert(varchar(200),@j)+''
 set @drop=' drop table  tmpay'+convert(varchar(200),@j-1)
	/*select len(@sql),convert(varchar(100),left(@sql,100))
		,convert(varchar(100),substring(@sql,101,200))
		,convert(varchar(100),substring(@sql,201,300))
	select len(@result),convert(varchar(100),left(@result,100))
		,convert(varchar(100),substring(@result,101,200))
		,convert(varchar(100),substring(@result,201,300))*/
	exec(@sql+@drop)
	
	select @j=@j+1	
	end	
end 

set @result=' select * into #rpttable from tmpay'+convert(varchar(200),@j-1)
set @drop=' drop table  tmpay'+convert(varchar(200),@j-1)
exec(@result+@drop+' select * from #rpttable')

--drop table  tmpay4,tmpay3,tmpay2,tmpay1,tmpay0
--select * from tmpay4