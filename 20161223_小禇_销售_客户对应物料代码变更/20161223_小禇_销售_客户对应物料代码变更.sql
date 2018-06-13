--select top 10 * from icitemmapping
select c.fitemid as organizationid,c.fname,c.fnumber,item.fnumber,item.fitemid,item.fname,a.fmapnumber,a.fmapname 
from icitemmapping a 
join t_icitemcore item on a.fitemid = item.fitemid 
join t_organization c  on c.fitemid = a.fcompanyid 
where item.fnumber in ('01.01.12.1540-b20038','01.01.12.1478-yg','01.01.12.1479','01.01.12.1231-hg')
and c.fnumber like 'k.2.038%' ;
;--update
USE [AIS20091217151735]
GO
update a set a.fmapnumber = case b.fnumber when '01.01.12.1540-b20038' then '35913' when '01.01.12.1478-yg' then '35894' when '01.01.12.1479' then '35333' else '35912' end
from icitemmapping a 
join dbo.t_icitemcore b on a.fitemid = b.fitemid 
join t_organization c  on c.fitemid = a.fcompanyid 
where b.fnumber in ('01.01.12.1540-b20038','01.01.12.1478-yg','01.01.12.1479','01.01.12.1231-hg')
and c.fnumber like 'k.2.038%' ;

