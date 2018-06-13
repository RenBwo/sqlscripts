
select * from ICClassType where FName_CHS like '销售订单'
/*tablename:SEOrder */
select * from ICTemplate where FID = 's01' and FCaption like '%刻字%'
/*FHeadSelfS0150*/
select top 10 fheadselfs0150,* from seorder

select * from ICClassType where FName_CHS like '销售订单'
/*tablename:SEOrder */
select * from ICTemplate where FID = (select FID from ICTemplate
where FCaption like '生产任务单')   and FCaption like '%刻字%'
/*销售订单号: icmo.FOrderInterID  FHeadSelfJ01101*/
/*
trig for icmo.insert
update ICMO set FHeadSelfJ01101 = b.FHeadSelfS0150, FHeadSelfJ01102=datename(weekday,fplanfinishdate)
from icmo a join seorder b on a.forderinterid = b.finterid
where a.finterid = 315259
 
select top 2 fbillno,FHeadSelfJ01101,FHeadSelfJ01102,finterid,fplanfinishweekday,datename(weekday,fplanfinishdate) from icmo where fplanfinishdate > '2017-11-01'
*/
select top 3 * from ICMO a join SEOrder b on a.FOrderInterID = b.finterid 
and b.FDate > '2017-11-01'

select * from ICTemplateentry where FID = (select FID from ICTemplate
where FCaption like '领料单%')   and FHeadCaption like '%刻字%'
/* FEntrySelfB0456 刻字要求*/
select * from ICTemplateentry where FID = (select FID from ICTemplate
where FCaption like '产品入库%')   and FHeadCaption like '%刻字%'
/* FEntrySelfA0239	刻字要求*/ 
select * from ictranstype/*24	生产领料 ;2	产成品入库 */
/*
trig for icstock update
update icstockbillentry set  FEntrySelfB0456=c.FHeadSelfJ01101
from icstockbill a join icstockbillentry b on a.finterid = b.finterid  
and a.ftrantype = 24
join icmo c on b.ficmointerid = c.finterid where b.ficmointerid = 315259

update icstockbillentry set fentryselfa0239 =c.FHeadSelfJ01101
from icstockbill a join icstockbillentry b on a.finterid = b.finterid  
and a.ftrantype = 2
join icmo c on b.ficmointerid = c.finterid where b.ficmointerid = 315259
*/