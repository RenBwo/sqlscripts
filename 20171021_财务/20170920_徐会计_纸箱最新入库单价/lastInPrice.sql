/*
 * 徐会计，提供了产品型号，要求查出纸箱单价
 * 纸箱单价取BOM子项的最新入库单价*用量
 * 纸箱BOM在产吕BOM下面，纸箱BOM的子bom是纸板
 */
select a.* from t_tabledescription a  where a.ftablename like 'icstockbill%'
select b.* from t_tabledescription a join  t_fielddescription b on a.ftableid = b.ftableid where a.ftablename = 'icstockbill'
select b.* from t_tabledescription a join  t_fielddescription b on a.ftableid = b.ftableid where a.ftablename = 'icstockbillentry'

select a.* from t_tabledescription a  where a.ftablename like 'icbom%'
select b.* from t_tabledescription a join  t_fielddescription b on a.ftableid = b.ftableid where a.ftablename = 'icbom'
select b.* from t_tabledescription a join  t_fielddescription b on a.ftableid = b.ftableid where a.ftablename = 'icbomchild'
select * from ictranstype
select * from t_icitem where fmodel in('10554','12321','12406','11035A','10265','10326','10391','10621','10780','10818','11342','10206A','10460','11121','11178','11282','12317','10223','10245','10270','10435','10722','10775','11169','10251','10702','12630','10262','10263','10434','10543','10974','11021','11036','11237','12227','12290','12203A','10266','10295','10327','10475','11077','12256','10220B','10345','10231','10370','11145','11173','12558','10301','10304','10306','10426','10470','10714','10754','11037','11038','12209','10261','10268','10284','10436','12324','11060','12445A'
) 
/*
 * last in_stock
 */
select t_lastdate.fitemid,t4.fnumber,t4.fname,t4.fmodel,t1.fprice,t_lastdate.fldate
from icstockbillentry t1
join
(
select  b.fitemid,max(a.fdate)  as fldate ,max(a.finterid) as finterid
from icstockbill a 
join icstockbillentry b on a.finterid = b.finterid and a.ftrantype in ('1','2','3','5','10') and b.fprice <> 0 
group by b.fitemid
) t_lastdate on t_lastdate.fitemid = t1.fitemid and t_lastdate.finterid=t1.finterid
join t_icitem t4 on t4.fitemid = t1.fitemid and t4.fdeleted = 0 
/*
 * expose bom parent_issue
 */
with recursive_cte as 
( select a.fitemid as firstitemid,cast(0 as varchar(101)) as flevel
, 0 as FParentID,a.FItemID as fitemid,cast(1 as decimal(12,4) ) as fQtyPerPro
,cast(1  as decimal(12,4) )as fQty,a.funitid as funitid
,cast(0 as decimal(10,4) ) as fscrap, cast('' as varchar(10)) as  fitemsize
,a.FInterID as fbominterid,a.fbomnumber,cast('1' as varchar(300)) as sn
,a.fstatus,a.fusestatus , cast ('.' as varchar(101)) as point 
from icbom a  
join t_icitem b on b.fmodel in ('10554','12321','12406','11035A','10265','10326','10391','10621','10780','10818','11342','10206A','10460','11121','11178','11282','12317','10223','10245','10270','10435','10722','10775','11169','10251','10702','12630','10262','10263','10434','10543','10974','11021','11036','11237','12227','12290','12203A','10266','10295','10327','10475','11077','12256','10220B','10345','10231','10370','11145','11173','12558','10301','10304','10306','10426','10470','10714','10754','11037','11038','12209','10261','10268','10284','10436','12324','11060','12445A'
) and a.fitemid = b.fitemid
where a.fusestatus = 1072 
and a.fstatus = 1 
union all  
select c.firstitemid as firstitemid
,  cast(cast(c.flevel as int)+1 as varchar(101)) as flevel
, a.fitemid as FParentID,b.FItemID as fitemid
, cast(b.fqty as decimal(12,4) ) as fQtyPerPro
, cast(round(b.fqty*c.fqty/(1-b.fscrap*0.01),4)  as decimal(12,4) )as fQty
,  b.funitid as funitid,cast(b.fscrap as decimal(10,4)) as fscrap
,  cast(b.fitemsize as varchar(10)) as  fitemsize,  a.FInterID as fbominterid,a.fbomnumber
,  cast(c.sn+right('000'+cast(b.fentryid as varchar(20)),3) as varchar(300)) as sn
, a.fstatus,a.fusestatus,cast(c.point+'......' as varchar(101)) as point  
from icbom a 
join icbomchild b on a.finterid = b.finterid and a.fusestatus = 1072 and a.fstatus = 1  
join recursive_cte c on a.fitemid = c.fitemid  where a.fitemid = c.fitemid 
)  
select * into #bomexpose from recursive_cte order by sn  

select  b.fmodel as ProductModel
,c.fnumber as ParentNum,c.fname as ParentName,c.fmodel as ParentModel
,d.fnumber as ChildNum,d.fname as ChildName,d.fmodel as ChildModel
,e.fdate as lastdate,a.fqty,f.fprice ,a.fqty*f.fprice as fboxprice
into #t7
from 		#bomExpose a 
join 		t_icitem b 			on b.fitemid = a.firstitemid
join 		t_icitem c			on c.fitemid = a.fparentid and c.fname like '%外箱%'
join 		t_icitem d 			on d.fitemid = a.fitemid 
join 		icstockbillentry f  on f.fitemid = a.fitemid
join 		icstockbill 	 e	on e.finterid = f.finterid
join
(
select  b.fitemid,max(a.finterid) as finterid
from icstockbill a 
join icstockbillentry b on a.finterid = b.finterid and a.ftrantype in ('1','2','3','5','10') and b.fprice <> 0 
group by b.fitemid
) t_lastdate on t_lastdate.fitemid = f.fitemid and t_lastdate.finterid=e.finterid

select www.productmodel,sum(www.fboxprice) as fboxprice from (
select distinct * from #t7
) www group by www.productmodel

