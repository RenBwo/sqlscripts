
/* 
 * AUTHOR:		RENBO
 * DATE:		2018/01/30
 * DESCRIPTIONS:KPI_icmo_make_finish_rate
 * 
declare @period varchar(6)
declare @fplandatestart date,@fplandateend date
--DATEADD(mm, DATEDIFF(mm,0,getdate()), 0)
set @period = convert(varchar(6),dateadd(month,datediff(month,0,getdate())-1,0),112)
select @fplandatestart = convert(date,dateadd(month,datediff(month,0,getdate())-1,0))
select @fplandateend = convert(date,dateadd(day,-1,DATEADD(month, DATEDIFF(mm,0,getdate()), 0)))
--exec ICMO_DETAIL_DCL_1K_NEW @fplandatestart,@fplandateend,' ',' ',' ',' ',' ',	' '  
--exec sxh_ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ',' ',' ',' '
--EXEC ICMO_DETAIL_DCL_3K_NEW @fplandatestart,'01-31-2018',' ',' ',' ',' ',' ',' '
--EXEC ICMO_DETAIL_DCL_4K @fplandatestart,'01-31-2018',' ',' ',' ',' ',' ',' '
--EXEC ICMO_DETAIL_DCL_5K @fplandatestart,@fplandateend,' ',' ',' ',' ',' ',' '
--EXEC ICMO_DETAIL_DCL_6K_WG @fplandatestart,@fplandateend,' ',' ',' ','s6.06.0001','s6.06.0002',' '
EXEC ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0001','S6.07.0008',' '
EXEC ICMO_DETAIL_DCL_wash  @fplandatestart,@fplandateend
EXEC ICMO_DETAIL_DCL_xialiaozu  @fplandatestart,@fplandateend
--EXEC ICMO_quality_DCL_4K  @fplandatestart,@fplandateend

create table t_dachenglv(Period varchar(6),DEPT varchar(10),WorkShop varchar(20),Rate_dacheng decimal(6,2),Rate_quality_dacheng decimal(6,2))
*/

alter procedure KPI_icmo_make_finish_rate
as 
begin
	set nocount on
	set ansi_warnings off
declare @period 			varchar(6)
		,@fplandatestart 	date
		,@fplandateend 		date
		,@i 				int

set 	@period 		= convert(varchar(6),dateadd(month,datediff(month,0,getdate())-1,0),112)
select 	@fplandatestart = convert(date,dateadd(month,datediff(month,0,getdate())-1,0))
select 	@fplandateend 	= convert(date, DATEADD(month, DATEDIFF(month,0,getdate()), 0))
select 	@i				= count(*) from  t_dachenglv where period = @period
if @i > 0 
begin
	delete from t_dachenglv where period = @period
end

create table #t1(
	生产任务单编号	varchar(max)
	,工作令号			varchar(max)
	,物料代码 		varchar(max)
	,物料名称			varchar(max)
	,规格型号 		varchar(max)
	,物料属性			varchar(max)
	,工序			varchar(max)
	,生产车间	 		varchar(max)
	,生产计量单位		varchar(max)
	,单位用量	 		varchar(max)
	,发料仓库	 		varchar(max)
	,材质			varchar(max)
	,坯料尺寸 		varchar(max)
	,计划下料个数 		varchar(max)
	,成品型号	 		varchar(max)
	,客户			varchar(max)
	,计划入库仓库		varchar(max)
	,成品投产数量		varchar(max)
	,成品入客户库数量	varchar(max)
	,成品入裸包库数量	varchar(max)
	,成品变更计划装配日	varchar(max)
	,成品装配数量		varchar(max)
	,下达日期			varchar(max)
	,计划开工日期		varchar(max)
	,计划完工日期		varchar(max)
	,计划数量			varchar(max)
	,入库审核数量		varchar(max)
	,入库保存数量		varchar(max)
	,入库保存日期		varchar(max)
	,入库审核日期		varchar(max)
	,入库保存审核时间差	varchar(max)
	,入库仓库			varchar(max)
	,未完成数量		varchar(max)
	,领料数量			varchar(max)
	,即时库存			varchar(max)
	,实绩与计划差额天数	varchar(max)
	,FLINE1			varchar(max)
	,FCN			varchar(max)
	,达成率			varchar(max)
	,品质达成率		varchar(max)
	,品质平均达成率	varchar(max)
	,计划数量合计每天 	varchar(max)
	)
create table #t2(
	fbillno			varchar(max)
	,washflag		varchar(max)
	,lastenddate	varchar(max)
	,washdate		varchar(max)
	,diffday		varchar(max)
	,finishstatus	varchar(max)
	,finishcount 	varchar(max)
	,sum0			varchar(max)
	,finishrate		varchar(max)
	)

create table #t3(
	gzl				varchar(max)
	,fbillno		varchar(max)
	,fopreid		varchar(max)
	,fopername		varchar(max)
	,fmatename		varchar(max)
	,fqtyplan 		varchar(max)
	,fqtypass		varchar(max)
	,fplanenddate	varchar(max)
	,fendworkdate	varchar(max)
	,finishcount 	varchar(max)
	,sum0			varchar(max)
	,finishstatus	varchar(max)
	,diffhours		varchar(max)
	,finishrate 	varchar(max)
	)
create table #t4(
	ftitle			varchar(max)
	,lvgout			varchar(max)
	,pllin			varchar(max)
	,xrate			varchar(max)
	,plout			varchar(max)
	,pipein			varchar(max)
	,yrate			varchar(max)
	,factqty		varchar(max)
	,faccountqty	varchar(max)
	,zrate			varchar(max)
	,rate			varchar(max)
	)
create table #t5(
	生产任务单编号		varchar(max)
	,工作令号	 		varchar(max)
	,物料代码 		varchar(max)
	,规格型号 		varchar(max)
	,生产车间	 		varchar(max)
	,生产计量单位		varchar(max)
	,客户特殊要求 		varchar(max)
	,客户 			varchar(max)
	,计划数量 		varchar(max)
	,计划下达日期 		varchar(max)
	,计划开工日期 		varchar(max)
	,计划完工日期 		varchar(max)
	,入库审核数量 		varchar(max)
	,入库保存数量 		varchar(max)
	,入库保存审核时间差	varchar(max)
	,入库保存日期 		varchar(max)
	,入库审核日期 		varchar(max)
	,实入库数量 		varchar(max)
	,入库仓库			varchar(max)
	,未完成数量		varchar(max)
	,总报废数量 		varchar(max)
	,实绩与计划差额天数	varchar(max)
	,FLINE1			varchar(max)
	,FCN			varchar(max)
	,达成率			varchar(max)
	,计划数量合计每天 	varchar(max)
	)
create table #t6(
	生产任务单编号		varchar(max)
	,工作令号	 		varchar(max)
	,物料代码 		varchar(max)
	,规格型号 		varchar(max)
	,生产车间	 		varchar(max)
	,生产计量单位		varchar(max)
	,客户特殊要求 		varchar(max)
	,客户 			varchar(max)
	,计划数量 		varchar(max)
	,投产数量 		varchar(max)
	,计划入客户库数量 	varchar(max)
	,计划入裸包库数量 	varchar(max)
	,计划下达日期 		varchar(max)
	,计划开工日期 		varchar(max)
	,计划完工日期 		varchar(max)
	,计划成品变更装配日	varchar(max)
	,计划成品装配数量 	varchar(max)
	,入库审核数量 		varchar(max)
	,入库保存数量 		varchar(max)
	,入客户库保存日期 	varchar(max)
	,入客户库审核日期 	varchar(max)
	,入库保存审核时间差	varchar(max)
	,实入客户库数量 	varchar(max)
	,入客户库仓库 		varchar(max)
	,入裸包库保存日期 	varchar(max)
	,入裸包库审核日期 	varchar(max)
	,实入裸包库数量 	varchar(max)
	,入裸包库仓库 		varchar(max)
	,未完成数量 		varchar(max)
	,总报废数量 		varchar(max)
	,实绩与计划差额天数	varchar(max)
	,FLINE1			varchar(max)
	,FCN			varchar(max)
	,达成率			varchar(max)
	,计划数量合计每天 	varchar(max)
	)
--一科
delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_1K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.01.0001','S6.01.0001',' '  
insert into t_dachenglv
select @period,'一科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)  

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_1K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.01.0002','S6.01.0002',' ' 
insert into t_dachenglv
select @period,'一科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_1K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.01.0003','S6.01.0003',' ' 
insert into t_dachenglv
select @period,'一科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_1K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.01.0001','S6.01.0003',' ' 
insert into t_dachenglv
select @period,'一科' ,'汇总',达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)
--二科
delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0001','S6.02.0001',' '  
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)  

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0002','S6.02.0002',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0003','S6.02.0003',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0004','S6.02.0004',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0005','S6.02.0005',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0006','S6.02.0006',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0007','S6.02.0007',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0008','S6.02.0008',' ' 
insert into t_dachenglv
select @period,'二科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_2K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.02.0001','S6.02.0008',' ' 
insert into t_dachenglv
select @period,'二科' ,'汇总',达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)
--三科
delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0001','S6.03.0001',' '  
insert into t_dachenglv
select @period,'三科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)  

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0002','S6.03.0002',' ' 
insert into t_dachenglv
select @period,'三科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0003','S6.03.0003',' ' 
insert into t_dachenglv
select @period,'三科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0004','S6.03.0004',' ' 
insert into t_dachenglv
select @period,'三科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0005','S6.03.0005',' ' 
insert into t_dachenglv
select @period,'三科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_3K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.03.0001','S6.03.0005',' ' 
insert into t_dachenglv
select @period,'三科' ,'汇总',达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)
--六科
delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_6K_WG @fplandatestart,@fplandateend,' ',' ',' ','S6.06.0001','S6.06.0001',' '  
insert into t_dachenglv 
select @period,'六科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)  

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_6K_WG @fplandatestart,@fplandateend,' ',' ',' ','S6.06.0002','S6.06.0002',' ' 
insert into t_dachenglv 
select @period,'六科' ,生产车间,达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

delete from  #t1
insert into #t1 exec ICMO_DETAIL_DCL_6K_WG @fplandatestart,@fplandateend,' ',' ',' ','S6.06.0001','S6.06.0002',' ' 
insert into t_dachenglv 
select @period,'六科','汇总',达成率,品质平均达成率 from #t1 where fline1 =  (select max(convert(int,fline1)) as maxline from #t1)

drop table #t1
--物流
delete from  #t2
insert into #t2 exec ICMO_DETAIL_DCL_wash @fplandatestart,@fplandateend 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'物流' ,'清洗组',finishrate from #t2 where sum0 =  (select max(convert(int,sum0)) as maxline from #t2)

drop table #t2

delete from  #t3
insert into #t3 exec ICMO_DETAIL_DCL_xialiaozu @fplandatestart,@fplandateend 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'物流' ,'下料组',finishrate from #t3 where sum0 =  (select max(convert(int,sum0)) as maxline from #t3)

drop table #t3
--四科
delete from  #t4
insert into #t4 exec ICMO_quality_DCL_4K @fplandatestart,@fplandateend
update t_dachenglv set Rate_quality_dacheng = (select rate from #t4 ) where period = @period and dept like '四科'and workshop like  '汇总'

drop table #t4

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0001','S6.04.0001',' '  
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,生产车间,达成率 from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)  

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0002','S6.04.0002',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,生产车间,达成率  from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0003','S6.04.0003',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,生产车间,达成率  from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0004','S6.04.0004',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,生产车间,达成率  from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0005','S6.04.0005',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,生产车间,达成率  from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

delete from  #t5
insert into #t5 exec ICMO_DETAIL_DCL_4K @fplandatestart,@fplandateend,' ',' ',' ','S6.04.0001','S6.04.0005',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'四科' ,'汇总',达成率 from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

--五科
delete from #t5
insert into #t5 exec ICMO_DETAIL_DCL_5K @fplandatestart,@fplandateend,'','','','','','' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'五科' ,'汇总',达成率  from #t5 where fline1 =  (select max(convert(int,fline1)) as maxline from #t5)

drop table #t5
--七科
delete from #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0001','S6.07.0001',' '  
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率 from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)  

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0002','S6.07.0002',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0003','S6.07.0003',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率 from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0004','S6.07.0004',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0005','S6.07.0005',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率 from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0006','S6.07.0006',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0007','S6.07.0007',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0008','S6.07.0008',' ' 
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,生产车间,达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

delete from  #t6
insert into #t6 exec ICMO_DETAIL_DCL_7K_NEW  @fplandatestart,@fplandateend,' ',' ',' ','S6.07.0001','S6.07.0008',' '
insert into t_dachenglv(Period,DEPT,WorkShop,Rate_dacheng)
select @period,'七科' ,'汇总',达成率  from #t6 where fline1 =  (select max(convert(int,fline1)) as maxline from #t6)

drop table #t6
--报表
--delete from t_dachenglv where dept like '七科' and workshop like  '汇总' 
--select * from t_dachenglv where period = '201807' order by period,dept
--exec KPI_icmo_make_finish_rate
set ansi_warnings on
--deadlock
/*select    request_session_id spid,     OBJECT_NAME(resource_associated_entity_id) tableName    
from sys.dm_tran_locks   
where  resource_type='OBJECT' 
    --
    kill 139
    select * from t_emp
--
*/
end
