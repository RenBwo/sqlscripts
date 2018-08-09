
alter trigger trig_icsale_ModelHisSaleQty 
on icsale for update,delete 
as 
begin
--根据销售发票，关联13代码
--根据13代码 ，反查出全部的01代码
--按13代码区分，计算出本型号产品的历史销售数量，
--自动更新到所有关联的01物料基础资料里
--按13代码+客户代码区分，计算出本型号产品的客户别历史销售数量，
--自动更新到客户物料对应表里历史销售数量（ModelHisSaleQty）
--本型号历史销售数量字段： t_icitemcustom.f_172
if update(fstatus)
begin
--销售发票上的产品代码
select distinct b.fitemid
into #tmpPitem
from inserted a 
join icsaleentry b on a.finterid = b.finterid 

--13代码
select b.fitemid  
into #tmpCitem  
from icbom a join icbomchild b on a.finterid = b.finterid 
join #tmpPitem c on c.fitemid = a.fitemid
join t_icitem d on d.fitemid = b.fitemid  and d.fnumber like '13.%'
--全部的01代码
select a.fitemid as parentitemid,b.fitemid childitemid
into #tmpAllPitem
from icbom a join icbomchild b on a.finterid = b.finterid and a.fstatus >0 
and a.fcancellation =0  and a.fusestatus = 1072
join #tmpCitem c on b.fitemid = c.fitemid

 --按13进行区分，计算出相对应的01代码的合计数量
select c.childitemid, isnull(sum(isnull(b.fqty,0)),0) as fsum 
into #tmpChQty
from icsale a join icsaleentry b 
on  a.finterid = b.finterid and a.fstatus > 0 and a.fcancellation = 0
join #tmpAllPitem c on c.parentitemid = b.fitemid 
group by c.childitemid

--升级本型号历史销售数量
update t_icitemcustom set f_172 = isnull(c.fsum,0)
from t_icitemcustom a 
join #tmpAllPitem b on b.parentitemid = a.fitemid
join #tmpChQty c  on c.childitemid = b.childitemid

--按13代码+客户 进行区分，计算出相对应的01代码的合计数量
select c.childitemid, a.fcustid,isnull(sum(isnull(b.fqty,0)),0) as fsum 
into #tmp13CustQty
from icsale a join icsaleentry b 
on  a.finterid = b.finterid and a.fstatus > 0 and a.fcancellation = 0
join #tmpAllPitem c on c.parentitemid = b.fitemid 
group by c.childitemid,a.fcustid
--升级本型号客户别历史销售数量
update  icitemmapping set ModelHstSaleQty = isnull(c.fsum,0)
from  icitemmapping a 
join #tmpAllPitem b on b.parentitemid = a.fitemid 
join #tmp13CustQty c  on c.childitemid = b.childitemid and c.fcustid = a.fcompanyid 

drop table #tmpAllPitem ,#tmpChQty ,#tmpCitem ,#tmpPitem,#tmp13CustQty
end 
end










--------