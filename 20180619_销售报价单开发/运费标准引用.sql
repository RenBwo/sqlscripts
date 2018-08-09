select * from t_item where  fitemclassid = 3029
select f_109,* from t_item_3029 --f_109 出货 条件 fitemid 物料内码
select f_125 from t_organization

select * from icclasstableinfo where fclasstypeid = 1007006 
order by fpage,ffieldname--fbase2 出货条件 fitemnumber 物料代码（内码）
--update icclasstableinfo set ffilter='FItemID = GetFldValue(Fitemnumber,1) AND F_109=GetFldValue(fbase2,1) '
where fid=22573

select top 8 * from v_ctoimappinggrp2 
select top 8 * from v_ctoimapping2 where fitemid = 276047
update icclasstableinfo 
set ffilter='FParentID0 = GetFldValue(FcustID,1) '--and FitemID = GetFldValue(FitemNumber,1)'
--ffilter='FParentID0 = 73013 and FitemID = 50621'
--,fsrctablename='v_ctoimapping2'
--,fsrctablenameas=(select ftablenameas from icclasstableinfo where  fid = 13954)
,ffiltergroup = 0
where fid=22575
--取消过滤规则，无效。
update icclasstableinfo set flookuptype=0,flookupclassid=0,fsrcfieldname=fsrctablenameas
,fdspfieldname=fsrctablenameas,ffndfieldname=fsrctablenameas,ffilter=fsrctablenameas 
where fid=22576

select top 2 b.fitemid,* from porfq a join porfqentry b on a.finterid = b.finterid order by a.fdate desc
--
select top 1 Fsize,fsize,* from porfqentry




