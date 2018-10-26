
/* 
 * DATE：			2017/09/04
 * AUTHOR：			RENBWO
 * DESCRIPTIONS:	生产任务单明细及达成率查询--下料
 * DESCRIPTINOS：	(第一道工序并且工序名包含“下料”)
 * DESCRIPTIONS：	1、达成指标: 生产任务单完成个数/生产任务单独总数
 * DESCRIPTIONS：	2、达成标准：工序汇报审核时间<=生产任务单计划开工日期的次日10点
 * DESCRIPTIONS：	3、显示生产任务单编号 审核时间差
 * DESCRIPTIONS:	4、工序汇报表：SHPROCRPTMAIN SHRPOCRPT
 * DESCRIPTIONS:	5、工序汇报审核时间 FCHECKDATE 工序代码 FOPERID 工序名称 FORERNAME 
 * DESCRIPTIONS:	6、生产任务单内码FICMOINTERID 累计实作数量  FAUXQTYFINISH 派工计划数量 FAUXQTYPLAN
 * DESCRIPTIONS：	7、派工派工计划开工日期 FPLANSTARTDATE 派工计划完工日期 FPLANENDDATE 
 * DESCRIPTIONS：	8、工作中心代码 FWORKCENTERID 工作中心名称 FWORKCENTNAME
 * DESCRIPTIONS:	9、下料工序属于物流科
 * 属于下料加工的范围：（王有全提供，任波整理）40185 下料集流管
 * 40186 下料压板支架
 * 40190 下料储液器型材
 * 40469 弯管管路下料 & （不锈钢 or 铜 ）

 * 工序计划单 SHWORKBILL SHWORKBILLENTRY fplanfinishdate
 * select * from icclasstype where fname_chs like '%领料%'
 * select * from ictransactiontype where fname like '%领料%'
 * SELECT * FROM ICTEMPLATE WHERE FID = 'B04' ORDER BY FTABINDEX
 * DESCRIPTIONS：	4、FTranType ：2-- 产成品入库
 * 
 */
CREATE  PROCEDURE [dbo].[ICMO_DETAIL_DCL_XIALIAOZU] 
	@FPlanFDate1	datetime,								--the First-finish Date 
	@FPlanFDate2	datetime								--the Last-finish DateAS
as 
BEGIN
	SET NOCOUNT ON 

/*
select  * from t_submessage where fname like '%下料压板支架%'--40186
select  * from t_submessage where fname like '%弯管管路下料%'--40469 
select  * from t_submessage where fname like '%下料储液器型材%'--40190
select  * from t_submessage where fname like '%下料集流管%'--40185
select top 6  * from icmo where fplanfinishdate between '01-08-2017' and '01-09-2017'
 select * from ictransactiontype where fname like '%生产投料%'*/

select 
A.FHeadSelfJ0184,a.fbillno
,c.foperid,g.fname as fopername ,i.fname as fMateName 
,c.fqtyplan,c.fqtypass
,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))) as fplanenddate
,c.fendworkdate
,(case (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end )
when 1 then
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
else row_number() over( order by a.fplancommitdate,a.fbillno ) -
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
end )
as finishcount
,row_number() over( order by a.fplancommitdate,a.fbillno )
as sum0
,(case when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 
then 1 else 0 
end ) as finishStatus

,datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate)))) as diffhours

,100*
convert(decimal(5,2),
convert(decimal(10,3),(case (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end )
when 1 then
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
else row_number() over( order by a.fplancommitdate,a.fbillno ) -
row_number() over(partition by (case 
when  datediff(hour,c.fendworkdate,dateadd(hour ,34,dateadd(day,0,datediff(day,0,a.fplancommitdate))))>=0 then 1 else 0 
end ) order by a.fplancommitdate,a.fbillno )
end ))/convert(decimal(10,3),row_number() over( order by a.fplancommitdate,a.fbillno )))
 as finishrate

from icmo a 
left join  SHWORKBILL b on a.finterid = b.ficmointerid 
	and a.fplanfinishdate between @FPlanFDate1 and @FPlanFDate2
 join  SHWORKBILLENTRY c on c.finterid = b.finterid and c.foperid in (40186,40469,40190,40185)
left join t_submessage g on g.finterid = c.foperid 
left join ppbomentry h on h.ficmointerid = a.finterid and h.foperid = c.foperid   
join t_icitem i on i.fitemid = h.fitemid
and (h.foperid in (40186,40190,40185) or (h.foperid = 40469 
and (i.fname like '%不锈钢%' or i.fname like '%铜%')))
order by sum0,a.fplancommitdate 

END
