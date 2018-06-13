CREATE TABLE #ICItem
    (  
        FLevel    int null default 0,
        FParentID int,
		FItemID   int,
		fqty      decimal(20,10),
        Fnumber     varchar(60),
        FbomInterID  int
    )
declare @level int,@firstitem int ;
select @firstitem = 292209,@level = 0;
insert into #icitem(flevel,fitemid,fqty,fnumber,fbominterid) 
select @level as flevel, @firstitem as fitemid,1 as fqty ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a 
join t_icitem c on c.fitemid = a.fitemid where a.fitemid =@firstitem  ;

while exists(select 1 from icbom where fitemid in (select fitemid from #icitem where flevel = @level))
begin
insert into #icitem(flevel,fparentid,fitemid,fqty,fnumber,fbominterid) 
select @level + 1 as flevel,a.fitemid as fparentid,b.fitemid as fitemid,b.fqty ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a join icbomchild b on a.finterid = b.finterid 
join t_icitem c on c.fitemid = b.fitemid 
where a.fitemid in (select fitemid from #icitem where flevel = @level) and c.ferpclsid <> 1 ;
select @level = @level + 1 
end
--select * from #icitem;
--drop table #icitem;
--select fnumber from t_icitem where fitemid = 292209
--ferpclsid	 fname		fid
---3			ί��ӹ�	WWJG
---7			������		PZL
---1			�⹺		WG
---2			����		ZZ

/*select --t1.fname,
t1.ferpclsid,t5.fname,t5.fid from t_ICItem t1 
		INNER JOIN t_Submessage t5   ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210
		group by t5.fid,t1.ferpclsid,t5.fname
			--	where t1.fitemid  in (select fitemid from #icitem) --���ϻ�����
*/
declare @k1 decimal(20,10) ,@k2 decimal(20,10)
select @k1 = f_101 from t_item_3015 where fnumber like 'k1';
select @k2 = f_101 from t_item_3015 where fnumber like 'k2';
--������۾�
select t4.foperid,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty, t1.fqty*t4.fpiecerate*t4.fentryselfz0236*t4.fentryselfz0237 as amtpay,
t7.fmaname,t7.fstdcost,t1.fqty*t4.fentryselfz0237*t7.fstdcost as famtpower, --�豸���
round(t1.fqty*t4.fentryselfz0237*t10.fhasdepr/(30*8*t7.FCapacity),10) as fdepr --�۾� depreciation
,t11.fpressrate
from #icitem						t1 
join t_icitem						t2		on t1.fitemid = t2.fitemid 
join t_Routing						t3		on t3.fitemid = t1.fitemid
join t_routingoper					t4		on t3.finterid = t4.finterid
left join t_submessage				t5		on t5.finterid = t4.foperid	and t5.fparentid = 61
left join t_CostCalculateBD			t6		on t6.foperno = t4.foperid
left join t_costcalculatebd_entry0	t7		on t6.fid = t7.fid
left join		t_fabalance				t10		on t10.fassetid = t7.fassetid	and t10.fyear = year(getdate()) and t10.fperiod =  month(dateadd(month,-2,getdate()))
left join t_costcalculate_flatpipe   t11		on t11.fpipenumber = t1.fitemid
where t2.ferpclsid <> 1  and t2.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and t1.fqty > 0 
order by t1.fnumber
--����
 select t4.foperid,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty, t1.fqty*t4.fpiecerate*t4.fentryselfz0236*t4.fentryselfz0237 as amtpay,
t8.faidname,t8.famtperope,t1.fqty*t4.fentryselfz0237*t8.FAMTPerOpe as famtAdi --����
from #icitem						t1 
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
 --��װģ��
 select t4.foperid,t2.fnumber ,t2.fname as assyname,t1.fqty ,t5.fname as opername,t4.fpiecerate,t4.fentryselfz0236 as frate,
t4.fentryselfz0237 as fmakeqty, t1.fqty*t4.fpiecerate*t4.fentryselfz0236*t4.fentryselfz0237 as amtpay,
t9.fnamemodel,t9.famtperoper,t1.fqty*t4.fentryselfz0237*t9.famtperoper as famtmodel --��װģ��
into #t_model
from #icitem						t1 
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

---��ܲ���
--��װҪݯʹ������/���� ģ�ߵ����ʹ������g����		��ѹģ�������� �� ���ʹ����/(�������*���ϳߴ�); ��ѹ�ֲ��ܣ�50000000/(�������*���ϳߴ�)
--�������ֶ�		ÿ�ױ�ܵ�п˿������g/���m����	п˿����:	ÿ�ױ�ܵ�п˿����*���ϳߴ�
--�������ֶ�		�ж��ٶȣ�m/min������ӹ��ٶȣ�	�жϲ��ܣ�	60*�ж��ٶ�-600
--�������ֶ�		���ѹ���ٶ�(m/min������ӹ��ٶȣ�	ѹ�����ܣ�	60*���ѹ���ٶ�/���ϳߴ�;
--�������ֶ�		��ǥ������
--select * from t_submessage where fparentid = '61' and fname like '���ѹ��' --����
--select * from t_item where fitemclassid = 3003 ����
--select * from t_item where fname like '%���%'
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
--�۾� depreciation


--drop table #icitem;
--drop table #t_costmakelist;