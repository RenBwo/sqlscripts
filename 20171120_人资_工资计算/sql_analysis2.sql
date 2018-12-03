--ais20170110083702.dbo.
--ais20170714081229.dbo.
--t_pa_itemclass.fiteclassid  = 0 ����ϵͳԤ�õ�,t_pa_item.fitemid = 0 ��Ҳ��ϵͳԤ�õ�
--����ɾ��
use AIS20091217151735
select * from t_pa_itemclass
--insert into t_pa_itemclass select * from ais20170110083702.dbo.t_pa_itemclass where FItemClassID > 0
select * from t_pa_item -- delete from t_pa_item where fitemid > 0
--t_pa_itempropdesc��ϵͳԤ�õ�һЩ��Ϣ�������������ȣ�ɾ�����½�������������ְԱ�����ò���ʱ�������
--t_pa_itempropdesc Ҳ��¼���û����õ�һЩ��Ϣ����ɾ����ʱ��Ҫע������
select * from t_pa_itempropdesc where FItemClassID = 3 and FName like '%ְ%'

select * from ais20170110083702.dbo.t_pa_itempropdesc
--insert into t_pa_itempropdesc select * from ais20170110083702.dbo.t_pa_itempropdesc where FItemClassID =3
select * from t_PA_Department 
select * into t_pa_personal from ais20170711153728.dbo.t_pa_personal where 1=2
select FPositionIndex,* from t_PA_Personal
select * into t_pa_personal from ais20170110083702.dbo.t_pa_personal where 1=2
--truncate table t_pa_personal
--����ԭ�����÷ǿ��ֶε�Ĭ��ֵ��
--T_PA_ITEMREF �� T_PA_ITEMREFTYPE ϵͳҲԤ����һЩ���ݣ�����ȫ��ɾ��������������ְ��
--ʱ������ʾ��ʹ��NULL ��Ч��
select * from t_PA_ItemRef --truncate table t_pa_itemref
select * from t_pa_itemreftype --truncate table t_pa_itemreftype
select * from ais20170110083702.dbo.t_pa_itemreftype
--insert into t_PA_ItemRefType select * from ais20170110083702.dbo.t_pa_itemreftype
--insert into t_PA_ItemRef select * from ais20170110083702.dbo.t_pa_itemref
--�Զ���ְ��������Ŀ��FFIELDTYPE =-1 ����ϵͳԤ����,�������á�
delete from t_PAItem where FFieldType <> -1
select * from ais20170714081229.dbo.t_paitem

/*insert into t_PAItem(FItemID,FItemName,	Fattrib	,FSno,	FCurrencyID	,FEmpField	,FIsPayRollData,	Fweisu,	FDataType,	FFieldType,	FFieldSize,	FIsEDit	,FItemName_CHT,	FItemName_EN	,FIsRedeployData,	FIsManagerVisable)
select FItemID,FItemName,	Fattrib	,FSno,	FCurrencyID	,FEmpField	,FIsPayRollData,	Fweisu,	FDataType,	FFieldType,	FFieldSize,	FIsEDit	,FItemName_CHT,	FItemName_EN	,FIsRedeployData,	FIsManagerVisable
from ais20170714081229.dbo.t_paitem where FFieldType <> -1
*/
select * from t_paitem
delete from t_PAItem where FItemid = 1071


--��������ְ����ʾ˳�������Զ����PROPID��ԭ�еġ��Ե���,���Ե��Ļ���������ǰ���������Զ����ֶ�
--fopopid > 100 ��ERPǰ�˿���ɾ��
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
--���ţ��볧ʱ�䣬��ְʱ�䣬ְ��ְ��ȼ���ְ�����ƣ�
update t_PA_ItemPropDesc set FPropID = 3 where FItemClassID = 3 and FPropID = 68

update t_PA_ItemPropDesc set FPropID = FPropID+33 where FItemClassID = 3 and FPropID >69 and FPropID < 90
select * from t_pa_itempropdesc where FItemClassID = 3 
--�Զ����ֶ�Ĭ��ֵ
--update t_PA_ItemPropDesc set FDefaultValue = 0 where FItemClassID = 3 and FPropID >7 and FPropID <16
--�ֶ�����
update t_PA_ItemPropDesc set FDataType=5,FActualType = 5
where fitemclassid = 3 and FPropID = 8

--���빤��ְԱ��Ϣ
/*ְ������	FGradeName
ְ��	FPositionIndex
���⹤��	F_102
ִ�й���	F_103
��������	F_104
ͨѶ����	F_105
ȼ�Ͳ���	F_106
��ͨ����	F_107
��������	F_108
���乤�ʱ�׼ F_109
*/
update t_pa_personal set 
	FPositionIndex =isnull(c.ְ��,0)
	,F_102 =c.���⹤��
	,F_103 =c.ִ�й���	
	,F_104=c.��������	
	,F_105=c.ͨѶ����	
	,F_106=c.ȼ�Ͳ���	
	,F_107=c.��ͨ����	
	,F_108=c.��������	
from t_pa_personal a join t_PA_Item b on a.FItemID = b.FItemID and b.FItemClassID = 3 
join t_pa_personal11$ c on c.ְԱ����=b.fnumber
/*���ù�����Ŀ*/
select * from t_panewdata
/*����EXCEL����
�ļ�-������
�����Ҫ����*/
/*����ERP�Ƽ�����
�༭-������Ƽ�����
�����Ҫ����*/
/*�����ϵ������*/
select * from t_PANewData