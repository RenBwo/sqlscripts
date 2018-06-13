
select  c.fname,c.fmodel,c.fnumber,b.fitemid,b.fqtyscrap,d.fheadselfj0184 as fgzl
			,row_number() over (partition by a.finterid order by b.fentryid) as sn
			from ppbom		a 
			join ppbomentry b on a.finterid = b.finterid		and a.fworkshop = 227394
			join t_icitem	c on c.fitemid	= b.fitemid
			join icmo		d on d.finterid = a.ficmointerid	and d.fworkshop = 227394
			where  fheadselfy0224 = '1705-604-a' and 
			a.fworkshop = 227394 and
			   c.fnumber not like '13.%' and c.fnumber not like '2.%'

 ;select d.fheadselfj0184 as fgzl, count(*) as assemblysum
  from ppbom a join ppbomentry b on a.finterid = b.finterid
join t_icitem c on c.fitemid = b.fitemid
join icmo d on d.finterid = a.ficmointerid 
 where --a.fheadselfy0224 = '1705-604-a' and 
 a.fworkshop = 227394
 and c.fnumber not like '13.%' and c.fnumber not like '2.%'
 group by d.fheadselfj0184
 order by assemblysum;
 select FHeadSelfJ0184,* from icmo where finterid in (691736
,691801
,691943
,691949)