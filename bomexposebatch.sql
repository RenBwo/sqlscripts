with recursive_cte as ( select  a.fitemid  as firstitemid
		 		 ,cast(0  as varchar(101)) as flevel 
		 		 ,0 as FParentID,a.FItemID as fitemid
		 		 ,cast(1 as decimal(12,4) ) as fQtyPerAsy 
		 		 ,cast(1  as decimal(12,4) )as fQtyPerPro
		 		 ,a.funitid as funitid 
		 		 ,cast(0 as decimal(10,4) ) as fscrap 
		 		 ,cast('' as varchar(10)) as  fitemsize
		 		 ,a.FInterID as fbominterid
		 		 ,a.fbomnumber
		 		 ,cast('1' as varchar(300)) as sn
		 		 ,a.fstatus,a.fusestatus , cast ('.' as varchar(101)) as point
		 		 from icbom a  
				  join t_ICItem b on a.FItemID = b.fitemid
				  join "0temp"  c on b.FNumber=c.ŒÔ¡œ¥˙¬Î
				  where a.fusestatus = 1072 and a.fstatus = 1
				  union all 
				  select  c.firstitemid  as firstitemid 
				  ,cast(cast(c.flevel as int)+1 as varchar(101)) as flevel
				  ,a.fitemid as FParentID,b.FItemID as fitemid
				  ,cast(b.fqty as decimal(12,4) ) as fQtyPerAsy
				  ,cast(round(b.fqty*c.fQtyPerPro/(1-b.fscrap*0.01),4)  as decimal(12,4) ) as fQtyPerPro 
				  ,b.funitid as funitid,cast(b.fscrap as decimal(10,4)) as fscrap 
				  ,cast(b.fitemsize as varchar(10)) as  fitemsize 
				  ,a.FInterID as fbominterid,a.fbomnumber 
				  ,cast(c.sn+right('000'+cast(b.fentryid as varchar(20)),3) as varchar(300)) as sn
				  ,a.fstatus,a.fusestatus,cast(c.point+'......' as varchar(101)) as point 
		 		  
				  from icbom a join icbomchild b on a.finterid = b.finterid and a.fusestatus = 1072 
				  and a.fstatus = 1 
				  join recursive_cte c on a.fitemid = c.fitemid 
				  where a.fitemid = c.fitemid 
				  ) 
				  select * into #bom 
				  from recursive_cte  order by firstitemid,sn  

select b.FNumber,b.FName,b.FModel, c.FNumber,c.fname,c.fmodel,d.fname,a.fqtyperpro
,a.* 
from #bom a left join t_ICItemcore b on a.firstitemid = b.FItemID
left join t_ICItemCore c on c.FItemID = a.fitemid 
join t_MeasureUnit d on a.funitid = d.fitemid
where c.FNumber like '30.%'
order by a.firstitemid,a.sn  
drop table #bom