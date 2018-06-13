select  top 10 * from icclasstype where fname_chs like '采购订单'
select top 10 * from ictransactiontype where fname like '采购订单'/*poorder poorderentry*/
select * from ictemplateentry where fid = 'p02'/*数量 FAUXQTY T	入库数量 FAUXSTOCKQTY*/


select b.fauxqty,b.fauxstockqty ,* 
from poorder a join poorderentry b on a.finterid = b.finterid  and a.fstatus = 1 
where a.fdate >= '2017-05-01' and isnull(b.fauxqty,0) < isnull(b.fauxstockqty,0)

update poorderentry set fauxqty = fauxstockqty
from poorder a join poorderentry b on a.finterid = b.finterid  and a.fstatus = 1 
where isnull(b.fauxqty,0) < isnull(b.fauxstockqty,0) and a.fdate >= '2017-05-01' 