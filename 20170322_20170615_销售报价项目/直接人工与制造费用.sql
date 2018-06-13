 CREATE TABLE #bomMultiExpose
    (  
        FLevel    int not null default 0,
        FParentID int,
		FItemID   int,
		fQtyPer		decimal(20,10), --单位用量
		fQty		decimal(20,10), --用量
        fitemsize	varchar(60),
		Fnumber     varchar(60),
        FbomInterID  int
    )
declare @level int,@firstitem int ;
select @firstitem = 292209,@level = 0;
insert into #bomMultiExpose(flevel,fitemid,fQtyPer,fqty,fnumber,fbominterid) 
select @level as flevel, @firstitem as fitemid,1 as fqtyper,1 as fqty ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a 
join t_icitem c on c.fitemid = a.fitemid where a.fitemid =@firstitem  ;

while exists(select 1 from icbom where fitemid in (select fitemid from #bomMultiExpose where flevel = @level))
begin
select fitemid,fqty into #t_useqty from  #bomMultiExpose where flevel = @level 
insert into #bomMultiExpose(flevel,fparentid,fitemid,fQtyPer,fQty,fitemsize,fnumber,fbominterid) 
select @level + 1 as flevel,a.fitemid as fparentid,b.fitemid as fitemid,b.fqty as fQtyPer, 
round(b.fqty * d.fqty/(1-b.fscrap/100),10) as fqty, --fscrap  损耗率 
b.fitemsize ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a join icbomchild b on a.finterid = b.finterid 
  left join #t_useqty d on d.fitemid = a.fitemid
join t_icitem c on c.fitemid = b.fitemid 
where a.fitemid in (select fitemid from #bomMultiExpose where flevel = @level)  ;
drop table #t_useqty
select @level = @level + 1 
end
--select * from #bomMultiExpose;
--drop table #bomMultiExpose;drop table #t_useqty
--select fnumber from t_icitem where fitemid = 292209
--ferpclsid	 fname		fid
---3			委外加工	WWJG
---7			配置类		PZL
---1			外购		WG
---2			自制		ZZ

/*select --t1.fname,
t1.ferpclsid,t5.fname,t5.fid from t_ICItem t1 
		INNER JOIN t_Submessage t5   ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210
		group by t5.fid,t1.ferpclsid,t5.fname
			--	where t1.fitemid  in (select fitemid from #bomMultiExpose) --物料基本信
*/
declare @k1 decimal(20,10) ,@k2 decimal(20,10),@k3 decimal(20,10)
select @k1 = f_101 from t_item_3015 where fnumber like 'k1';
select @k2 = f_101 from t_item_3015 where fnumber like 'k2';
select @k3 = f_101 from t_item_3015 where fnumber like 'k3';
--直接人工
select d.foperid,d.fopersn,b.fnumber ,b.fname as assyname,e.fname as opername,a.fqty ,--零件数量
d.fpiecerate,--工价
d.fentryselfz0236 as frate,--系数
d.fentryselfz0237 as fmakeqty , --工件数
a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237 as amtpay,--直接人工
@k1*a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237 as amtassure,--保险
a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237*(1+@k1)*@k2 as cost_worker--制造费用-人工
into #t_costworker
from #bomMultiExpose a 
join t_icitem b on a.fitemid = b.fitemid 
join t_Routing  c on c.fitemid = a.fitemid
join t_routingoper d on c.finterid = d.finterid
left join t_submessage e on e.finterid = d.foperid and e.fparentid = 61
where b.ferpclsid <> 1  and b.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and a.fqty > 0 
order by a.fnumber;
--fyear fperiod
declare @currentperiod varchar(2),@currentyear varchar(4)
select @currentyear = fvalue from t_systemprofile where fkey like 'currentyear' and fcategory = 'GL'
select @currentperiod = fvalue from t_systemprofile where fkey like 'currentperiod' and fcategory = 'GL'
--电费与折旧
select t4.foperid,t4.fopersn,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty,
t7.fmaname,
isnull(t1.fqty*t4.fentryselfz0237*t7.fpower*0.4*1/ 
		(case t4.foperid when 40336 then 99              				/*钎焊炉工艺 40336*/
		  when 40494 then round(t11.fpressrate*60/20 ,4)  					/*扁管压出工艺40494*/
		  when 40495 then (t12.fcutrate*60 - 600)  								/*扁管切断工艺 40495*/
		  else round(t7.fcapacity/(case  when isnull(t4.fentryselfz0236,0)>0 then t4.fentryselfz0236 else 1 end),4) end)  /*其余工艺*/
		  ,0 ) as famtpower,    /*电费*/
		isnull(t1.fqty*t4.fentryselfz0237*t10.fdeprshould*t4.fentryselfz0236/(30*8* 
		 (case t4.foperid when 40336 then  99              				/*钎焊炉工艺 40336*/
		  when 40494 then round(t11.fpressrate*60/20,4)  					/*扁管压出工艺40494*/
		  when 40495 then (t12.fcutrate*60 - 600)  								/*扁管切断工艺 40495*/
		  else round(t7.fcapacity/(case  when isnull(t4.fentryselfz0236,0)>0 then t4.fentryselfz0236 else 1 end),4) end)  /*其余工艺*/
		 ),0) as fdepr  --折旧 depreciation
		 ,t11.fpressrate,t12.fcutrate,t11.FQtyZn,t11.fmaxqtymodel,t11.fcheckbox
into #t_machine
from #bomMultiExpose 				t1 
join t_icitem						t2		on t1.fitemid = t2.fitemid 
join t_Routing						t3		on t3.fitemid = t1.fitemid
join t_routingoper					t4		on t3.finterid = t4.finterid
left join t_submessage				t5		on t5.finterid = t4.foperid	and t5.fparentid = 61
left join t_CostCalculateBD			t6		on t6.foperno = t4.foperid
left join t_costcalculatebd_entry0	t7		on t6.fid = t7.fid
left join		t_fabalance				t10		on t10.fassetid = t7.fassetid	and t10.fyear = @currentyear and t10.fperiod = ( @currentperiod - 1)
left join t_costcalculate_flatpipe   t11		on t11.fpipenumber = t1.fitemid and t11.fcheckbox = 0
left join t_costcalculate_flatpipe   t12		on (select FParentID from #bomMultiExpose where fitemid = t12.fpipenumber) = t1.fitemid and t12.fcheckbox = 0 
where t2.ferpclsid <> 1  and t2.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and t1.fqty > 0 
order by t1.fnumber
--辅料
 select t4.foperid,t4.fopersn,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty, 
t8.faidname,t8.famtperope,t1.fqty*t4.fentryselfz0237*t8.FAMTPerOpe as famtAdi --辅料
into #t_adi
from #bomMultiExpose						t1 
join t_icitem						t2		on t1.fitemid = t2.fitemid 
join t_Routing						t3		on t3.fitemid = t1.fitemid
join t_routingoper					t4		on t3.finterid = t4.finterid
left join t_submessage				t5		on t5.finterid = t4.foperid	and t5.fparentid = 61
left join t_CostCalculateBD			t6		on t6.foperno = t4.foperid
left join t_costcalculatebd_entry1	t8		on t6.fid = t8.fid
where t2.ferpclsid <> 1  and t2.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and t1.fqty > 0 
order by t1.fnumber
 --工装模具
 select t4.foperid,t4.fopersn,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty, 
t9.fnamemodel,t9.famtperoper,t1.fqty*t4.fentryselfz0237*t9.famtperoper as famtmodel --工装模具
into #t_model
from #bomMultiExpose						t1 
join t_icitem						t2		on t1.fitemid = t2.fitemid 
join t_Routing						t3		on t3.fitemid = t1.fitemid
join t_routingoper					t4		on t3.finterid = t4.finterid
left join t_submessage				t5		on t5.finterid = t4.foperid	and t5.fparentid = 61
left join t_CostCalculateBD			t6		on t6.foperno = t4.foperid
left join t_costcalculatebd_entry2	t9		on t6.fid = t9.fid
where t2.ferpclsid <> 1  and t2.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and t1.fqty > 0 
order by t1.fnumber
 /*select * from t_Routing  c 
join t_routingoper d on c.finterid = d.finterid
where 
*/

---扁管产能
--工装要莜使用寿命/工步 模具的最大使用量（g）；		挤压模具最大产能 ： 最大使用量/(扁管米重*坯料尺寸); 挤压轮产能：50000000/(扁管米重*坯料尺寸)
--新增加字段		每米扁管的锌丝用量（g/扁管m）；	锌丝用量:	每米扁管的锌丝用量*坯料尺寸
--新增加字段		切断速度（m/min）纵向加工速度；	切断产能：	60*切断速度-600
--新增加字段		扁管压出速度(m/min）横向加工速度；	压出产能：	60*扁管压出速度/坯料尺寸;
--新增加字段		喷钎最大产能
--select * from t_submessage where fparentid = '61' and fname like '扁管压出' --工序
--select * from t_submessage where fid = '61'
--select * from t_item where fitemclassid = 3003 工序
--select * from t_item where fname like '%电价%'
/*select * from t_item_3014

select t_ca3.* from t_CostCalculateBD t_ca0 
join t_costcalculatebd_entry0 t_ca1		on t_ca0.fid = t_ca1.fid
join t_costcalculatebd_entry1 t_ca2		on t_ca0.fid = t_ca2.fid
join t_costcalculatebd_entry2 t_ca3		on t_ca0.fid = t_ca3.fid
where t_ca1.FCapacity <=0
*/
--
--ALTER TABLE t_costcalculatebd_entry0 DROP CONSTRAINT DF__t_CostCal__Funit__665BD209
--alter table t_costcalculatebd_entry0 drop column funit;
--exec sp_rename 't_costcalculatebd_entry0.ftext5',funit,'column'
--折旧 depreciation
--drop table #bomMultiExpose;drop table #t_model;drop table #t_adi;drop table #t_machine;drop table #t_costworker;
select foperid,fopersn,fnumber,	assyname,	sum(fqty) as fqty,	opername,fpiecerate,frate,fmakeqty,	amtpay,amtassure,
sum(cost_worker) as costworker
into #t_20
	 from #t_costworker
	 group by foperid,fopersn,fnumber,	assyname,	opername,	fpiecerate,	frate,	fmakeqty,	amtpay,amtassure
	 order by fnumber,fopersn;
select foperid,fopersn,	fnumber	,assyname,sum(fqty) as fqty,	opername	,fpiecerate	,frate,	fmakeqty,	
		sum(famtpower) as fmatpower,sum(fdepr) as fdepr 
		into #t_21
		from #t_machine 
		group by foperid,fopersn,fnumber	,assyname,opername	,fpiecerate	,frate,	fmakeqty
		order by fnumber,fopersn;
select foperid,	fopersn,fnumber	,assyname,sum(fqty) as fqty,	opername	,fpiecerate	,frate,	fmakeqty,
		sum(famtadi) as famtadi into #t_22
      from #t_adi
		group by foperid,fopersn,fnumber	,assyname,opername	,fpiecerate	,frate,	fmakeqty
		order by fnumber,fopersn;
select foperid,	fopersn,fnumber	,assyname,sum(fqty) as fqty,	opername	,fpiecerate	,frate,	fmakeqty,
		sum(famtmodel) as famtmodel into #t_23
      from #t_model
		group by foperid,fopersn,fnumber	,assyname,opername	,fpiecerate	,frate,	fmakeqty
		order by fnumber,fopersn;

select t1.foperid,t1.fopersn,t1.fnumber	,t1.assyname,t1.fqty,t1.opername,t1.fpiecerate,t1.frate,t1.fmakeqty,t1.amtpay,t1.amtassure,
		t1.costworker,t2.fmatpower,t2.fdepr,t3.famtadi,t4.famtmodel
		from #t_20 t1
		join  #t_21 t2  on t1.foperid=t2.foperid and t1.fnumber = t2.fnumber
		join  #t_22 t3 on t1.foperid=t3.foperid and t1.fnumber = t3.fnumber
		join  #t_23  t4 on t1.foperid=t4.foperid and t1.fnumber = t4.fnumber
--drop table #bomMultiExpose;drop table #t_model;drop table #t_adi;drop table #t_machine;drop table #t_costworker;
--drop table  #t_20;drop table  #t_21;drop table  #t_22;drop table  #t_23;
--select top 10  * from sysobjects where type = 'p' and name like '%bd%';
--select * from BDBomMulExpose
--select * from #t_machine