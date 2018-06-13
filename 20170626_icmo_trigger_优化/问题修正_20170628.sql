/*
修正，icmo.fheadselfj0189 错误得选取了ICMO.fheadselfj0190的值，手动修复
*/

--工序汇报涉及的ICMO.FINTERID
select distinct T1.FICMOINTERID
 into  #t1  --drop table #t1,#a
 from  shprocrptmain t1 
 join  shprocrpt     t2 on t1.finterid = t2.finterid 
WHERE   T1.FDATE = '2017-06-27'
--相关FINTERID 的汇总
select distinct T1.FICMOINTERID,sum(t2.FOperAuxQtyScrap) as gong ,sum(t2.FOperAuxQtyForItem) as liao
into #a
from  shprocrptmain t1 
join  shprocrpt     t2 on t1.finterid = t2.finterid 
join  #t1  t3 on t3.ficmointerid = t1.ficmointerid
group by t1.ficmointerid
--select * from #A
--找出有差异的部分，缩小需要手动修正的范围，尽量减小对原数据的影响
select a.finterid,( a.fheadselfj0189-b.gong) as diff,( a.fheadselfj0190-b.liao) as diff2
from icmo a join #a b on a.finterid = b.ficmointerid
order by diff desc
--order by diff2 desc
-- result: icmo interid :'714599','701638','701432','714616','702375','701648','701633','701130','701637'
--手动修正
update icmo set fheadselfj0189 = b.gong,FHeadSelfJ0190= b.liao
from icmo a join #a b on a.finterid = b.ficmointerid
where a.finterid in ('714599','701638','701432','714616','702375','701648','701633','701130','701637')

update t1 set t1.FHeadSelfJ0191=t1.FQty-t1.FAuxStockQty-t1.FHeadSelfJ0189-t1.FHeadSelfJ0190 
from icmo t1 where  t1.FInterID in('714599','701638','701432','714616','702375','701648','701633','701130','701637')
--找出FBILLNO ,在K3里看一下
select fbillno from icmo where finterid in('714599','701638','701432','714616','702375','701648','701633','701130','701637')