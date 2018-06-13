 CREATE TABLE #bomMultiExpose
    (  
        FLevel    int null default 0,
        FParentID int,
		FItemID   int,
		fQtyPer		decimal(20,10), --单位用量
		fQty		decimal(20,10), --用量
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
select @level + 1 as flevel,a.fitemid as fparentid,b.fitemid as fitemid,b.fqty as fQtyPer, b.fqty * d.fqty as fqty,
c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a join icbomchild b on a.finterid = b.finterid 
  left join #t_useqty d on d.fitemid = a.fitemid
join t_icitem c on c.fitemid = b.fitemid 
where a.fitemid in (select fitemid from #bomMultiExpose where flevel = @level) and c.ferpclsid <> 1 ;
drop table #t_useqty
select @level = @level + 1 
end
--select * from #bomMultiExpose;
--drop table #bomMultiExpose;
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
select b.fnumber ,b.fname as assyname,a.fqty ,e.fname as opername,d.fpiecerate,d.fentryselfz0236 as frate,
d.fentryselfz0237 as fmakeqty ,
a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237 as amtpay,
@k1*a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237 as amtassure,
a.fqty*d.fpiecerate*d.fentryselfz0236*d.fentryselfz0237*(1+@k1)*@k2 as cost_worker
from #bomMultiExpose a 
join t_icitem b on a.fitemid = b.fitemid 
join t_Routing  c on c.fitemid = a.fitemid
join t_routingoper d on c.finterid = d.finterid
left join t_submessage e on e.finterid = d.foperid --and e.fparentid = 61
where b.ferpclsid <> 1  and b.fitemid not in (
select fitemid from t_icitem where substring(fnumber,6,5) > '819' and fnumber like '2.%')
and a.fqty > 0 
order by a.fnumber;



