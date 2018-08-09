--客户物料对应表icitemmapping
--select top 2 * from icitemmapping
--select * from icclasstype where fname_chs like '%客户物料对应%'
--1007103	客户物料对应表	客戶物料對應表	Customer Material Mapping	0	v_CToIMappingGrp
select * from ICClassTypeEntry where fparentid=1007103 
select * from ICClassTableInfo where FClassTypeID = 1007103 order by fpage,fkey,fid
--select * from ICClassTableInfo where FID = 9012
--fparentid --customerid,fitemid ,fname,fnumber 
select * from v_ctoimappinggrp where FID = 57974
select * from v_ctoimapping where FEntryID = 57974
--select * from t_Organization where FItemID = 261163
/*insert into ICClassTableInfo (FClassTypeID	,FPage	,FCaption_CHS	,FCaption_CHT	,FCaption_EN	,FKey	,FFieldName	,FTableName	,FTableNameAs	,FListIndex	,FListClassName	,FVisible	,FEnable	,FNeedSave	,FMustInput	,FCtlType	,FProperty	,FLookUpType	,FLookUpClassID	,FLookUpList	,FSRCFieldName	,FSRCTableName	,FSRCTableNameAs	,FDSPFieldName	,FFNDFieldName	,FValueLocation	,FFilter	,FFilterGroup	,FValueType	,FDspColType	,FEditlen	,FValuePrecision	,FSaveRule	,FDefValue	,FAction	,FUserDefine	,FNote	,FKeyWord	,FLeft	,FTop	,FHeight	,FWidth	,FCondition	,FTabIndex	,FLock	,FSum	,FPrec	,FScale	,FLayer	,FLoadAction	,FUnControl	,FFont	,FSourceType	,FSubKey	,FParentKey	,FConditionExt	,FFrameBorder	,FFrameBorderColor	,FLabelWidth	,FLabelColor	,FTextColor	,FIsF7	,FContainer	,FStyle)
select FClassTypeID	,2	,'客户历史销售数量'	,'客户历史销售数量','客户历史销售数量','FcustModeSaleQty2'
,'FcustModeSaleQty','v_CToIMapping'	,FTableNameAs	,FListIndex	,FListClassName	,FVisible	,FEnable	,FNeedSave	,FMustInput	,FCtlType	,FProperty	,FLookUpType	,FLookUpClassID	,FLookUpList	,FSRCFieldName	,FSRCTableName	,FSRCTableNameAs	,FDSPFieldName	,FFNDFieldName	,FValueLocation	,FFilter	,FFilterGroup	,FValueType	,FDspColType	,FEditlen	,FValuePrecision	,FSaveRule	,FDefValue	,FAction	,FUserDefine	,FNote	,FKeyWord	,FLeft	,FTop	,FHeight	,FWidth	,FCondition	,FTabIndex	,FLock	,FSum	,FPrec	,FScale	,FLayer	,FLoadAction	,FUnControl	,FFont	,FSourceType	,FSubKey	,FParentKey	,FConditionExt	,FFrameBorder	,FFrameBorderColor	,FLabelWidth	,FLabelColor	,FTextColor	,FIsF7	,FContainer	,FStyle
from ICClassTableInfo where FClassTypeID = 1007103 and FID = 9005
*/
update icclasstableinfo set ffieldname='ModelHstSaleQty',FDefValue = 0 ,FUserDefine =1 ,FNote='custModelSaleQty',FAction = '',
FLeft=5500,FTop = 2200,FHeight = 500,FWidth = 3000 where FID in('26262','26265')
drop table v_ctoimapping2
create view  v_ctoimapping2 as 

SELECT     200000024 AS FClassTypeID, t1.FEntryID AS FID, t1.FItemID, t1.FEntryID, t1.FCompanyID AS FParentID, t1.FMapName AS FName, 
                      t1.FMapNumber AS FNumber, t2.FNumber AS FItemNumber, t1.ModelHstSaleQty
FROM         dbo.ICItemMapping AS t1 WITH (NOLOCK) INNER JOIN
                      dbo.t_ICItem AS t2 WITH (NOLOCK) ON t1.FItemID = t2.FItemID
WHERE     (t1.FPropertyID = 1)
drop table v_ctoimappinggrp2
create view  v_ctoimappinggrp2 as 
SELECT     FEntryID AS FID, FMapName AS FName, FMapNumber AS FNumber, 0 AS FParentID, '' AS FFullNumber, 0 AS FLevels, 1 AS FDetail, 
                      200000024 AS FClassTypeID, 0 AS FDiscontinued, 0 AS FLogic, FEntryID
FROM         dbo.ICItemMapping WITH (NOLOCK)
WHERE     (FPropertyID = 1)
