/*
* AUTHOR:		RENBO
* DATE:			2017/12/06
* DESCRIPTIONS:	自动计算系数工资人员的执行工资
*/
--正常出勤薪酬	2	37	0	FPA1194
--正常加班薪酬	2	41	0	FPA1195
--计件工资合计	2	40	0	FPA1198
--法假薪酬		2	42	0	FPA1200
CREATE TRIGGER [dbo].[trig_t_pa_xishuact_update] 
   ON  [dbo].[t_pa_xishuactual]   AFTER update
   AS 
BEGIN
	SET NOCOUNT ON 
	if update(fmulticheckstatus) and (select fmulticheckstatus from inserted) = 16
	begin
	/* wage scope and the numbers of persons
	*/
	select a.fnumber,f.fpa1218 as fyear,f.fpa1219 as fmonth
	,c.fassessval as frate
	,sum(f.FPA1194+f.FPA1195+f.FPA1198+f.FPA1200) as wagesum
	,count(*) as personSum
	INTO #ratePayScope
	from	inserted    		d 
	join	t_pa_xishuactentry 	c on c.fid = d.fid
	join	t_pa_xishu			a on a.femp= c.femp and a.fclosedate > getdate()
	join	t_pa_xishuentry 	b on a.fid = b.fid 
	join	t_pa_personal   	e on e.f_102=b.fworkGRname  and (e.fpositionindex = 12 or e.fpositionindex = 13) and f_111 not like '%系数%'
	join	t_panewdata			f on f.fempid = e.fitemid  and f.fpa1218=convert(int,left(d.fperiod,4)) 
	and f.fpa1219 = convert(int,right(d.fperiod,2)) and isnull(f.FPA1194+f.FPA1195+f.FPA1198+f.FPA1200,0) >= 1500
	group by a.fnumber,f.fpa1218,f.fpa1219,c.fassessval
	
	/*update t_personal*/
	update t_pa_personal set f_105 = 0,f_106 = 0 ,f_107 = 0 where f_111 like '系数%'
	
	update t_pa_personal set f_106 = round(b.frate*b.wagesum/b.personsum,4)
	,f_107 = round(0.7*b.frate*b.wagesum/b.personsum,4) from t_pa_personal a 
	join t_pa_item c on a.fitemid = c.fitemid and c.fitemclassid = 3
	join #ratepayscope b on b.fnumber = c.fnumber
	where a.f_111 like '%系数%'

	drop table #ratepayscope 
end
end
GO

SET ANSI_PADDING OFF
GO

