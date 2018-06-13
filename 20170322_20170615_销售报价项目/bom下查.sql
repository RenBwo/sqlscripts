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
---3			委外加工	WWJG
---7			配置类		PZL
---1			外购		WG
---2			自制		ZZ

/*select --t1.fname,
t1.ferpclsid,t5.fname,t5.fid from t_ICItem t1 
		INNER JOIN t_Submessage t5   ON T1.FErpClsID=T5.FInterID AND T5.FTypeID=210
		group by t5.fid,t1.ferpclsid,t5.fname
			--	where t1.fitemid  in (select fitemid from #icitem) --物料基本信
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

---扁管产能
--工装要莜使用寿命/工步 模具的最大使用量（g）；		挤压模具最大产能 ： 最大使用量/(扁管米重*坯料尺寸); 挤压轮产能：50000000/(扁管米重*坯料尺寸)
--新增加字段		每米扁管的锌丝用量（g/扁管m）；	锌丝用量:	每米扁管的锌丝用量*坯料尺寸
--新增加字段		切断速度（m/min）纵向加工速度；	切断产能：	60*切断速度-600
--新增加字段		扁管压出速度(m/min）横向加工速度；	压出产能：	60*扁管压出速度/坯料尺寸;
--新增加字段		喷钎最大产能