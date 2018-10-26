declare 
	@FPlanFDate1	datetime,								--the First-finish Date 
	@FPlanFDate2	datetime								--the Last-finish DateAS
	
select  @FPlanFDate1='2017-12-01',@FPlanFDate2='2017-12-30'
select 
A.FHeadSelfJ0184,a.fbillno
,c.foperid,g.fname as fopername ,i.fname as fMateName 
,c.fqtyplan,c.fqtypass
,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))) as fplanenddate
,c.fendworkdate
,(case (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end )
when 1 then
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
else row_number() over( order by a.fplancommitdate,a.fbillno ) -
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
end )
as finishcount
,row_number() over( order by a.fplancommitdate,a.fbillno )
as sum0
,(case when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 
then 1 else 0 
end ) as finishStatus

,datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate)))) as diffhours

,convert(varchar(6),100*
convert(decimal(5,2),
convert(decimal(10,3),(case (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end )
when 1 then
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
else row_number() over( order by a.fplancommitdate,a.fbillno ) -
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
end ))/convert(decimal(10,3),row_number() over( order by a.fplancommitdate,a.fbillno )))
)+'%  ' as finishrate

from icmo a 
left join  SHWORKBILL b on a.finterid = b.ficmointerid 
	and a.fplanfinishdate between @FPlanFDate1 and @FPlanFDate2
 join  SHWORKBILLENTRY c on c.finterid = b.finterid and c.foperid in (40186,40469,40190,40185)
left join t_submessage g on g.finterid = c.foperid 
left join ppbomentry h on h.ficmointerid = a.finterid and h.foperid = c.foperid   
join t_icitem i on i.fitemid = h.fitemid
and (h.foperid in (40186,40190,40185) or (h.foperid = 40469 
and (i.fname like '%不锈钢%' or i.fname like '%铜%')))
where a.fbillno = 'z1710-157_004'
order by sum0,a.fplancommitdate 