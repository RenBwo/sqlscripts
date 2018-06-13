/**********************    ON ICMO  AFTER UPDATE *****************
IF @FSTATUS=1
begin
--writer: RenBwo
--Date: 2017/02/06
--Description: 生产任务单增加“是否有火焰焊接”字段
update icmo set fheadselfj0198 =isnull(f.fname,'') ,fheadselfj0199 = isnull(h.fname ,'')
from icmo		a 
join		inserted		b on a.finterid = b.finterid 
join		icbom			c on c.finterid	= b.fbominterid	and c.fusestatus	=1072	and c.fstatus = 1 
left join	t_routing		d on d.finterid = c.froutingid
left join	t_routingoper	e on e.finterid = d.finterid	and e.foperid		=40004 
left join	t_submessage	f on f.finterid = e.foperid
left join	t_routingoper	g on g.finterid = d.finterid	and g.foperid		=40359
left join	t_submessage	h on h.finterid = g.foperid
end
-- */
----------分解
;select * from t_icitem where fnumber like '%0864-hg%';
select fitemid,finterid from icmo where  fheadselfj0184 = '1702-857' and fbillno='1702-857-1'; --237517
select froutingid,* from icbom where fitemid = 237517;
select * from t_routing where finterid =7715;
select * from t_routingoper where finterid =7715 and foperid = 40004;
--update test
declare @ad varchar(30)
select @ad = '1612-1332'
update a set fheadselfj0198 =isnull(e.fname,''),fheadselfj0199 =isnull(g.fname,'')
from icmo a 
join icbom b  on b.fitemid = a.fitemid
left join t_routing c on c.finterid = b.froutingid
left join t_routingoper d on d.finterid = b.froutingid and d.foperid =40004
left join t_submessage e on e.finterid = d.foperid
left join t_routingoper f on f.finterid = c.finterid and f.foperid =40359
left join t_submessage g on g.finterid = f.foperid
where   a.fheadselfj0184 = a.fbillno AND Fplancommitdate > '2016-12-20'
--SELECT TOP 5 * FROM ICMO  where  fheadselfj0184 =  fbillno AND Fplancommitdate > '2016-12-20' and fstatus = 1
--
select f.fname,h.fname, * from icmo		a 
join		icmo 		b on a.finterid = b.finterid  and b.finterid = 655752
join		icbom			c on c.finterid	= b.fbominterid	and c.fusestatus	=1072	and c.fstatus = 1 
left join	t_routing		d on d.finterid = c.froutingid
left join	t_routingoper	e on e.finterid = d.finterid	and e.foperid		=40004 
left join	t_submessage	f on f.finterid = e.foperid
left join	t_routingoper	g on g.finterid = d.finterid	and g.foperid		=40359
left join	t_submessage	h on h.finterid = g.foperid
