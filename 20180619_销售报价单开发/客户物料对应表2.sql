select * from v_ctoimappinggrp where   FID = 57974
select * from v_ctoimapping where FEntryID = 57974
select top 30 * from v_ctoimapping2
select * from v_ctoimappinggrp2 a join  v_ctoimapping2 b 
on a.FID = b.FID  where a.fid = 57974
--HEAD
--drop view v_ctoimappinggrp2
create view  v_ctoimappinggrp2 as 
SELECT      200000024 AS FClassTypeID,FEntryID AS FID, FEntryID
, 0  AS FParentID, FMapName AS FName, FMapNumber AS FNumber
, '' AS FFullNumber
, 0 AS FLevels, 1 AS FDetail,0 AS FDiscontinued, 0 AS FLogic
FROM         dbo.ICItemMapping WITH (NOLOCK)
WHERE     (FPropertyID = 1)

--BODY
--t_organization 
--F_115	返点%,F_116	标准利润率%,F_121	质量赔偿金折扣率%（批量事故除外）
--F_122	应收款账期,F_123	木托盘缠绕膜成本（元）
-- icitem 
-- F_171	RMB产品控制利润率 
-- F_175	USD产品控制利润率%
-- F_172	本型号历史销售数量
-- f_125 发货条件 
-- FvalueAddRate 增值税率
--drop view v_ctoimapping2
create view  v_ctoimapping2 as 
SELECT     200000024 AS FClassTypeID, t1.FEntryID AS FID, t1.FEntryID
, t1.FItemID as FitemID, t1.FMapName AS FName,t1.FMapNumber AS FNumber
,t2.FNumber AS FItemNumber,t2.FName as Fitemname
, t1.FCompanyID AS FParentID0, t3.fnumber as FcompaynNumber ,t3.FName as Fcompanyname
,isnull(t3.F_115,0.0) as FPointReturn 
,isnull(t3.F_116,0.0)  as FstdGainRate
,isnull(t3.F_121,0.0)  as FDiscountQuality
,isnull(t3.F_122,0.0)  as FAcctPeriod
,isnull(t3.F_123,0.0)  as FTuoPanCost
,isnull(t2.f_171,0.0)  as FRMBProdGainRte
,isnull(t2.f_175,0.0)  as FUSDProdGainRte
,isnull(t2.f_172,0.0)  as FModHstSaleQty
, t1.ModelHstSaleQty as FCustModHstSalQty
,t3.f_125 as FshipmentCondition,t4.fname as FshipmentConditionName
,t3.fvalueaddrate 
FROM         dbo.ICItemMapping AS t1 WITH (NOLOCK) 
INNER JOIN   dbo.t_ICItem AS t2 WITH (NOLOCK) ON t1.FItemID = t2.FItemID
join 		dbo.t_Organization t3 with (nolock) on t3.FItemID = t1.fcompanyid
left join t_submessage t4 on t3.f_125 = t4.finterid
WHERE     (t1.FPropertyID = 1)
--
select fisf7,* from icclasstableinfo where fclasstypeid = 200000024
update icclasstableinfo set fisf7=0 where fid in ('26296','26290')
update icclasstableinfo set fisf7=0 where fid in ('26353','26354')


