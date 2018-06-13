
--生产任务单： icmo ；fheadselfj0184:工作令 ;fbominterid bom内码
--bom ：icbom; Froutingid 工艺内码
--工艺 t_routing t_routingoper
--工序名称
select a.fheadselfj0184,a.fbillno,a.fworkshop,e.fname,c.fnote
from icmo a 
join icbom b on a.fbominterid = b.finterid and b.fstatus = 1 and b.fusestatus = 1072
join t_routingoper c on b.froutingid = c.finterid
join t_submessage e on e.finterid = c.foperid 
where a.fheadselfj0184 = '1612-118'
order by a.fbillno,c.finterid,c.fentryid;
select * from t_routing a join t_routingoper b on a.finterid= b.finterid where a.finterid = 2322;
select * from icbom where  froutingid = 2322;
select fheadselfj0184,* from icmo where fheadselfj0184 = '1612-118'
select fworkshop from icmo where   fheadselfj0184 = '1612-118';
--生产部门
select fparentid,fname,fitemid,fnumber from t_department where fparentid in ('280648','212054','212047','270610','279709','227396','212063')
 order by fnumber
 --
 select e.fname+c.fnote as fname,c.foperid
from icmo a 
join icbom b on a.fbominterid = b.finterid and b.fstatus = 1 and b.fusestatus = 1072
join t_routingoper c on b.froutingid = c.finterid
join t_submessage e on e.finterid = c.foperid 
where a.fheadselfj0184 in ('1612-118')
and a.fworkshop = 135 
order by fname
--
select fbominterid,* from icmo where fheadselfj0184 in ('1612-118') order by fbillno
select * from t_worktype where finterid = 57
