CREATE trigger [dbo].[lwm_SCRW2] on [dbo].[ICMO]
for insert
as 
begin
--生产任务
update a 
set a.FHeadSelfJ0184=c.fentryselfs0160
----  2014-07-24  BY YANGYUAN CHANGE  吴总指示   入客户库数量   入裸包库数量
  , a.FHeadSelfJ0186=c.FEntrySelfS0162
  , a.FHeadSelfJ0187=c.FEntrySelfS0163
   ----  2016-05-20  BY xuyaoyao CHANGE  曲军要求 客户代码  
  , a.FHeadSelfJ0188= d.FNumber,
  a.FHeadSelfJ0192='1'
from icmo a 
inner join seorder b on a.forderinterid=b.finterid
inner join seorderentry c on c.finterid=b.finterid and c.fentryid=a.fsourceentryid
left outer join t_Organization d ON d.FItemID = b.FCustID
where  a.finterid in (select finterid from inserted)
--采购申请
--select * from t_tabledescription where fdescription like '%销售订单%'
--
--select * from icmo a inner join seorder b on a.forderinterid=b.finterid
	--			inner join seorderentry c on c.finterid=b.finterid and c.fentryid=a.fsourceentryid
--
--select FHeadSelfJ0184, * from icmo order by FHeadSelfJ0184
--select fentryselfs0160,* from seorderentry  
 

end