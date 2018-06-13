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
select b.fnumber ,b.fname as "ass'y name",a.fqty ,e.fname as opername,d.fpiecerate,d.fentryselfz0236 as frate,d.fentryselfz0237 as fmakeqty 
from #icitem a 
join t_icitem b on a.fitemid = b.fitemid 
join t_Routing  c on c.fitemid = a.fitemid
join t_routingoper d on c.finterid = d.finterid
left join t_submessage e on e.finterid = d.foperid --and e.fparentid = 61
where b.ferpclsid <> 1  and b.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and a.fqty > 0 
order by a.fnumber;
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