
--Data Source=192.168.200.5;Initial Catalog=AIS20161026113020;Persist Security Info=False;User ID=sa;Pooling=False;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=True
-- �϶�ͻ��������������ϵ��ֶγ��Ȳ����ã��ֶ���ϵͳ�����ֶΣ�������������ϳ��Ⱥ����ף�������������������е����Ƴ���,
-- ��Ӱ����ҵ�񵥾���Ҫ��ʾֵ�����̫�������е����״򡢲鿴�Ȼ������⣬�����ҵ��Ӱ�췶Χ̫�󣬶���һ��ͻ���Ҫ��ĳ��ȶ�
-- �᲻һ�����ǽ���ͻ������K/3�淶��д������������Ⱥ��Ѱ��ա�
-- ����һ�ֱ�ͨ��ʽ�����齫���ƾ�������,ͨ���Զ��������Ŀ�ֶζ�ȫ���ƽ���˵����
-- �����޸ĺ��Ӱ�쵽�����ϵ���ʾ�����⣬Ӱ��ϴ�������ʱ�޷�ͨ������������Ժ�İ汾�У����ǻ�������ȼ������й滮


/*use 
--AIS20091217151735 --formal DB
AIS20161026113020 --  test DB
go
*/
--
--insert excel data ;sheet1$�������ù���һ����a.���Ŵ��� ʵ���������ϴ��� ��a.�ɱ��������ʵ��������������
select 物料代码,count(*) as ww from tem_zhangzhao group by 物料代码 order by ww desc;
select a.物料代码 , a.毛重,b.fnumber,b.fname
from tem_zhangzhao a join t_icitem b on b.fnumber = a.物料代码 ;
update t_icitemDesign  set fgrossweight = a.毛重
from t_icitemDesign b join t_icitemcore c on b.fitemid = c.fitemid 
join tem_zhangzhao a 
on c.fnumber = a.物料代码


--adjust column width
/*;alter table t_icitemcore alter column fname varchar(160)*/
--update
;update b set b.fname = a.�ɱ��������
from sheet1$ a join t_icitemcore b on b.fnumber = a.���Ŵ���
where b.fnumber = a.���Ŵ���;
--retrieve view t_icitem
;exec sp_refreshview t_icitem
;select name  from sysobjects where type='V' and name like '%icitem%'
;select * from sysobjects where  name like 't_icitem%'
--
;select top 10 len(fname),* from t_ICItemcore where fnumber = '13.01.06.0675-H';
;select top 10 fgrossweight,* from t_ICItemBase;
;select top 10 fgrossweight,* from  t_ICItemMaterial;
;select top 10 fgrossweight,* from t_ICItemPlan;
;select top 10 fgrossweight,* from t_ICItemDesign;
;select top 10 fgrossweight,* from t_ICItemStandard;
;select top 10 fgrossweight,* from t_ICItemQuality;
;select top 10 fgrossweight,* from t_ICItemCustom;
;select top 10 fgrossweight,* from T_BASE_ICItemEntrance;
--�ɱ������� cbcostobjgroup
;select top 10 * from cbcostobj a  where a.fnumber = '13.01.06.0663-YG' 
;select top 10 * from cbcostitem





