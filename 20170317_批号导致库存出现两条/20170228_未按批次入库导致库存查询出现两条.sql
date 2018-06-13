select * from icclasstype where fname_chs like '%库%';
select * from  sysobjects where xtype = 'U' and name like '%inv%';
select top 10 * from ICInventory;
SELECT * FROM ICStockBill --所有出入库单表头 其中:ftrantype值表示单据类型如下：1-采购入库 10-其他入库 21-销售出库 29-其他出库 41-调拨单 100-成本调整单
SELECT * FROM ICStockBillEntry --所有出入库单表体 表头与表体用finterid关联 
SELECT * FROM ICInventory --实仓库存表 即时存货表 
SELECT * FROM POInventory --虚仓库存表 
SELECT top 20 * FROM ICBal where  fitemid = 70044      --存货余额表
SELECT top 20 * FROM ICInvBal where fyear=2017 and fitemid = 70044       --库房存货余额表
SELECT  * FROM ICInvInitial --存货初始数据表

;select * from t_stock where fitemid in ('245462','245506') --劳保用品仓库 245462 ；办公用品仓库(带仓位管理) 245506
;select * from t_icitem where fitemid = 70044

;SELECT * FROM ICInvInitial where fitemid = 70044
;SELECT * FROM ICBal where  fitemid = 70044  and fyear > 2015 order by fyear,fperiod
;SELECT * FROM ICInvBal where fitemid = 70044  and fyear > 2015 order by fyear,fperiod
--实仓出入库
;select * from icstockbill a join icstockbillentry b on a.finterid = b.finterid 
where b.fitemid= 70044 and a.fdate between '2016-06-01' and '2016-07-01'
--实仓库存
;SELECT * FROM ICInventory where  fitemid = 70044  --stockid 245462

--虚仓调拨单
;select * from postockbill a join  postockbillentry b on a.finterid = b.finterid 
where b.fitemid = 70044 and a.fdate between '2016-06-01' and '2016-07-01'
--虚仓出入库
;select * from zpstockbill a join  zpstockbillentry b on a.finterid = b.finterid 
where b.fitemid = 70044 and a.fdate between '2016-06-01' and '2016-07-01'
--虚仓库存
;SELECT * FROM POInventory where  fitemid = 70044 --stockid 245506