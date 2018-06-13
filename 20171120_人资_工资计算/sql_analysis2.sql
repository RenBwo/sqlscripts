--ais20170110083702.dbo.
--ais20170714081229.dbo.
--t_pa_itemclass.fiteclassid  = 0 的是系统预置的,t_pa_item.fitemid = 0 的也是系统预置的
--不能删除
use AIS20091217151735
select * from t_pa_itemclass
--insert into t_pa_itemclass select * from ais20170110083702.dbo.t_pa_itemclass where FItemClassID > 0
select * from t_pa_item -- delete from t_pa_item where fitemid > 0
--t_pa_itempropdesc是系统预置的一些信息，包括工资类别等，删除后，新建工资类别和设置职员、设置部门时都会出错
--t_pa_itempropdesc 也记录了用户设置的一些信息，在删除的时候，要注意区别
select * from t_pa_itempropdesc where FItemClassID = 3 and FName like '%职%'

select * from ais20170110083702.dbo.t_pa_itempropdesc
--insert into t_pa_itempropdesc select * from ais20170110083702.dbo.t_pa_itempropdesc where FItemClassID =3
select * from t_PA_Department 
select * into t_pa_personal from ais20170711153728.dbo.t_pa_personal where 1=2
select FPositionIndex,* from t_PA_Personal
select * into t_pa_personal from ais20170110083702.dbo.t_pa_personal where 1=2
--truncate table t_pa_personal
--参照原表设置非空字段的默认值。
--T_PA_ITEMREF 和 T_PA_ITEMREFTYPE 系统也预置了一些内容，不能全部删除，否则在设置职工
--时，会提示”使用NULL 无效“
select * from t_PA_ItemRef --truncate table t_pa_itemref
select * from t_pa_itemreftype --truncate table t_pa_itemreftype
select * from ais20170110083702.dbo.t_pa_itemreftype
--insert into t_PA_ItemRefType select * from ais20170110083702.dbo.t_pa_itemreftype
--insert into t_PA_ItemRef select * from ais20170110083702.dbo.t_pa_itemref
--自定义职工工资项目表，FFIELDTYPE =-1 的是系统预留的,作关联用。
delete from t_PAItem where FFieldType <> -1
select * from ais20170714081229.dbo.t_paitem

/*insert into t_PAItem(FItemID,FItemName,	Fattrib	,FSno,	FCurrencyID	,FEmpField	,FIsPayRollData,	Fweisu,	FDataType,	FFieldType,	FFieldSize,	FIsEDit	,FItemName_CHT,	FItemName_EN	,FIsRedeployData,	FIsManagerVisable)
select FItemID,FItemName,	Fattrib	,FSno,	FCurrencyID	,FEmpField	,FIsPayRollData,	Fweisu,	FDataType,	FFieldType,	FFieldSize,	FIsEDit	,FItemName_CHT,	FItemName_EN	,FIsRedeployData,	FIsManagerVisable
from ais20170714081229.dbo.t_paitem where FFieldType <> -1
*/
select * from t_paitem
delete from t_PAItem where FItemid = 1071


--调整工资职工显示顺序，新增自定义的PROPID和原有的“对调”,不对调的话，不能在前端再增加自定义字段
--fopopid > 100 在ERP前端可以删除
select * from t_pa_itempropdesc where FItemClassID = 3 
select * from ais20170714081229.dbo.t_pa_itempropdesc where fitemclassid = 3 
update t_PA_ItemPropDesc set FPropID = 9 where FItemClassID = 3 and FPropID = 103
update t_PA_ItemPropDesc set FPropID = 10 where FItemClassID = 3 and FPropID = 104
update t_PA_ItemPropDesc set FPropID = 11 where FItemClassID = 3 and FPropID = 105
update t_PA_ItemPropDesc set FPropID = 12 where FItemClassID = 3 and FPropID = 106
update t_PA_ItemPropDesc set FPropID = 13 where FItemClassID = 3 and FPropID = 107
update t_PA_ItemPropDesc set FPropID = 14 where FItemClassID = 3 and FPropID = 108
update t_PA_ItemPropDesc set FPropID = 15 where FItemClassID = 3 and FPropID = 109
update t_PA_ItemPropDesc set FPropID = 16 where FItemClassID = 3 and FPropID = 110
update t_PA_ItemPropDesc set FPropID = 17 where FItemClassID = 3 and FPropID = 102
update t_PA_ItemPropDesc set FPropID = 18 where FItemClassID = 3 and FPropID = 33
update t_PA_ItemPropDesc set FPropID = 19 where FItemClassID = 3 and FPropID = 35
--部门，入厂时间，离职时间，职务，职务等级，职等名称，
update t_PA_ItemPropDesc set FPropID = 3 where FItemClassID = 3 and FPropID = 68

update t_PA_ItemPropDesc set FPropID = FPropID+33 where FItemClassID = 3 and FPropID >69 and FPropID < 90
select * from t_pa_itempropdesc where FItemClassID = 3 
--自定义字段默认值
--update t_PA_ItemPropDesc set FDefaultValue = 0 where FItemClassID = 3 and FPropID >7 and FPropID <16
--字段类型
update t_PA_ItemPropDesc set FDataType=5,FActualType = 5
where fitemclassid = 3 and FPropID = 8

--导入工资职员信息
/*职等名称	FGradeName
职等	FPositionIndex
特殊工龄	F_102
执行工资	F_103
基本工资	F_104
通讯补贴	F_105
燃油补贴	F_106
交通补贴	F_107
工资类型	F_108
工龄工资标准 F_109
*/
update t_pa_personal set 
	FPositionIndex =isnull(c.职等,0)
	,F_102 =c.特殊工龄
	,F_103 =c.执行工资	
	,F_104=c.基本工资	
	,F_105=c.通讯补贴	
	,F_106=c.燃油补贴	
	,F_107=c.交通补贴	
	,F_108=c.工资类型	
from t_pa_personal a join t_PA_Item b on a.FItemID = b.FItemID and b.FItemClassID = 3 
join t_pa_personal11$ c on c.职员代码=b.fnumber
/*设置工资项目*/
select * from t_panewdata
/*导入EXCEL数据
文件-〉引入
导入后要保存*/
/*导入ERP计件工资
编辑-〉引入计件工资
导入后要保存*/
/*计算非系数工资*/
select * from t_PANewData