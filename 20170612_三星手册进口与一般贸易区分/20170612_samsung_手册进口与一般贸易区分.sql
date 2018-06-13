alter trigger trig_stock_samsung on icstockbill
for update as 
begin

--select * from ictranstype;
/*
1、在领料单上找出客户；
2、判断是否是手册管理客户；
3、判断领料单的仓库位置是否与手册管理的仓库位置一致
*/
if update(fstatus)
begin

declare @m int
/*
,@ftrantype int
,@n int
,@x int
select @ftrantype =ftrantype from inserted 
if @ftrantype = 24 
begin
select @m =  count(*) from inserted  
a join icstockbillentry b on a.finterid = b.finterid  and a.ftrantype = 24
join t_BOS200000011Entry2 c on b.fitemid = c.fbase1 
join t_bos200000011 d on c.fid = d.fid 
join icmo e on e.finterid = b.fsourceinterid 
join t_organization f on (f.fname like '%三星%' or f.fname like '%samsung%') and f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188
if @m >0 
begin
select @n =  count(*) from inserted  
a join icstockbillentry b on a.finterid = b.finterid  and a.ftrantype = 24
join t_BOS200000011Entry2 c on b.fitemid = c.fbase1 and c.fbase2 = b.fscstockid
join t_bos200000011 d on c.fid = d.fid 
join icmo e on e.finterid = b.fsourceinterid 
join t_organization f on f.fcyid = 1 and (f.fname like '%三星%' or f.fname like '%samsung%') and f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188

select @x =  count(*) from inserted  
a join icstockbillentry b on a.finterid = b.finterid  and a.ftrantype = 24
join t_BOS200000011Entry2 c on b.fitemid = c.fbase1 and c.fbase2 = b.fscstockid
join t_bos200000011 d on c.fid = d.fid 
join icmo e on e.finterid = b.fsourceinterid 
join t_organization f on f.fcyid > 1 and (f.fname like '%三星%' or f.fname like '%samsung%') and f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188

if @m <> (@n +@x)
begin
raiserror(N'对应苏州三星客户的仓库不正确',18,1);
return
end
end
end
end
*/
select @m =  count(*) 
from inserted  a 
join icstockbillentry		b	on a.finterid = b.finterid  and a.ftrantype = 24
join t_BOS200000011Entry2	c	on b.fitemid = c.fbase1 and c.fbase2 <> b.fscstockid
join t_bos200000011			d	on c.fid = d.fid 
join icmo					e	on e.finterid = b.fsourceinterid 
join t_organization			f	on f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188
if @m > 0
begin
raiserror(N'对应的客户仓库不正确',18,1);
return;
end
end
end