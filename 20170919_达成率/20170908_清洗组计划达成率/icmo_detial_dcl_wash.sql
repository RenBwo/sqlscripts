/*
 * DATE：			2017/09/04
 * AUTHOR：			RENBWO
 * DESCRIPTIONS:	清洗组达成率查询
 * DESCRIPTINOS：	生产领料单 清洗确认时间 需要清洗的作单独领料单
 * DESCRIPTIONS：	1、达成指标: 生产任务单完成个数/生产任务单独总数
 * DESCRIPTIONS：	2、达成标准：清洗确认时间=投料单的计划发料时间
 * 					(icstock.fheadselfb0435 =ppbomentry.fsenditemdate)
 * DESCRIPTIONS：	3、需要清洗的范围 清洗标记为Y（FHEADSELFB0436=y）
 * DESCRIPTIONS:	4、ICSTOCKBILLENTRY.FICMOINTERID=PPBOMENTRY.FICMOINTERID
 * 
 */
alter  PROCEDURE [dbo].[ICMO_DETAIL_DCL_wash] 
	@FPlanFDate1	datetime,								--the First-finish Date 
	@FPlanFDate2	datetime								--the Last-finish DateAS
as 
BEGIN
	SET NOCOUNT ON 

select w1.fbillno,w1.washflag,w1.lastsenddate,w1.washdate
,datediff(day,w1.washdate,w1.lastsenddate)  as diffday
,case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end as finishstatus
,case (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end)
when 1 then
row_number() over(partition by (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end) order by w1.fdate)
else 
row_number() over(order by w1.fdate) -
row_number() over(partition by (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end) order by w1.fdate)
end as finishcount

,row_number() over(order by w1.fdate) as sum0
,100*convert(decimal(10,2),
convert(decimal(10,3),(case (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end)
when 1 then
row_number() over(partition by (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end) order by w1.fdate)
else 
row_number() over(order by w1.fdate) -
row_number() over(partition by (case when datediff(day,w1.washdate,w1.lastsenddate) >=0 then 1 else 0 end) order by w1.fdate)
end) )/convert(decimal(10,3),row_number() over(order by w1.fdate)))
 as finishrate

from
	(select w.fdate,w.fbillno,w.fheadselfb0436 as washflag,max(w.fsenditemdate) as lastsenddate
	,w.fheadselfb0435 as washdate 
	from 
		( select a.fbillno,b.fitemid,a.fheadselfb0436,c.fsenditemdate,a.fheadselfb0435,a.fdate
		from	icstockbill 		a
		join 	icstockbillentry 	b  	on a.finterid = b.finterid 
										and a.fheadselfb0436='y'
		join 	ppbomentry 			c 	on c.ficmointerid = b.ficmointerid 
										and b.fitemid = c.fitemid 
		join	icmo				e	on e.finterid = b.ficmointerid 
										and e.fplanfinishdate between @FPlanFDate1 and @FPlanFDate2
		) w
	group by w.fbillno,w.fheadselfb0436,w.fheadselfb0435,w.fdate) w1 
order by w1.fdate

END
