create trigger trig_up_t_emp on t_base_emp for insert
as 
begin 
update t_pa_personal set 
f_102 = d.fname
,fbirthday = c.fbirthday
,femail = c.femail
,faddress = c.faddress
,fphone = c.fmobilephone
,fid = c.fid
,fduty = e1.fname
,fdegree = e.fname
,fhiredate = c.fhiredate
,fleavedate = c.fleavedate
,fempgroupid = e3.fitemrefid
,fitemdepid = f.fitemid
,fbankaccount = a.fbankaccount
from inserted 		c
join t_pa_item b   on c.fnumber = b.fnumber and b.fitemclassid = 3
join t_pa_personal a on a.fitemid = b.fitemid  
join t_department c1 on c1.fitemid = c.fdepartmentid
left join t_item d on c.f_102=d.fitemid
left join t_submessage e on e.finterid = c.fdegree
left join t_submessage e1 on e1.finterid = c.fduty
left join t_submessage e2 on e2.finterid = c.fempgroup
left join t_pa_itemref e3 on e3.fname = e2.fname and ftype = 90
left join t_pa_item f on f.fnumber = c1.fnumber

end