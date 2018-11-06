select * from ictemplateentry where fheadcaption like '%偏置%' 
select * from ictemplate where fid like 'z01'
select top 20 foffsetday,* from icbom a join icbomchild b on a.finterid = b.finterid 


--select b.foffsetday,d.fname,d.fnumber,* 
--
update icbomchild set foffsetday = -4
from icbom a 
join icbomchild b on a.finterid = b.finterid 
join t_icitem c on c.fnumber like '13.%' and a.fitemid = c.fitemid
left join t_icitem d on d.fitemid = b.fitemid
where exists (select 1 from t_icitem where fnumber like '2.02.015.%' and fitemid = b.fitemid)

