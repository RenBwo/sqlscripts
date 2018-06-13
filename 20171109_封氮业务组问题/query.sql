
select top 10 * from t_submessage where fname like '%封氮%'/*40166  40145 40390*/
select * from ICtemplateentry where FID = 'Z02'

select  a.fbillno,c.fnumber,c.fname,d.fname,e.fname,*  
from t_routingoper b join t_routing a on a.finterid = b.finterid
join t_icitem c on a.fitemid = c.fitemid
left join t_submessage d on d.finterid = b.foperid and d.fparentid = 61
left join t_submessage e on e.finterid = b.fteamid and e.fparentid = 62
where b.foperid = 40145 and b.fteamid = 40166 

update t_routingoper set fteamid = 40390
from t_routingoper b join t_routing a on a.finterid = b.finterid
join t_icitem c on a.fitemid = c.fitemid
left join t_submessage d on d.finterid = b.foperid and d.fparentid = 61
left join t_submessage e on e.finterid = b.fteamid and e.fparentid = 62
where b.foperid = 40145 and b.fteamid = 40166
