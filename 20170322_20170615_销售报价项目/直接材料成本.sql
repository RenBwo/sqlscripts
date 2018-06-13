--13裸包喷钎面积 01.01.13.0682-BJ 13.01.07.0682
declare @fnumber varchar(100) ,@s decimal(20,10)
select @fnumber = '01.01.13.0682-BJ'
--bom expose from 13.*
 CREATE TABLE #bomMultiExpose
    (  
        FLevel		int not null default 0,
        FParentID	int,
		FItemID		int,
		fQtyPer		decimal(20,10), --单位净用量
		fQty		decimal(20,10), --用量
		
		fitemsize	varchar(60),
        Fnumber     varchar(60),
        FbomInterID int
    )
declare @level int,@firstitem int ,@fparentqty decimal(20,10);
select @firstitem = fitemid ,@level = 0 from t_icitem where fnumber = @fnumber ;--292211 13.01.07.0682
insert into #bomMultiExpose(flevel,fitemid,fQtyPer,fqty,fnumber,fbominterid) 
select @level as flevel, @firstitem as fitemid, 1 as fqtyper,1 as fqty,c.fnumber as fnumber,a.finterid as fbominterid
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
join t_icitem c on c.fitemid = b.fitemid 
left join #t_useqty d on d.fitemid = a.fitemid
where a.fitemid in (select fitemid from #bomMultiExpose where flevel = @level )  ;
drop table #t_useqty
select @level = @level + 1 
end
/*
select * from t_icitem where fitemid = 292209
select * from   #bomMultiExpose
drop table #bomMultiExpose;
--select ferpclsid,	 fname,	fnumber from t_icitem where fitemid = 39471
--ferpclsid	 fname		fid
---3			委外加工	WWJG
---7			配置类		PZL
---1			外购		WG
---2			自制		ZZ
select * from ictransactiontype
SELECT top 20 round(fendbal/fendqty,4),* FROM ICBal where fyear = 2017 and fperiod = 3
select a.*,b.fname
from #bomMultiExpose a 
join		t_icitem b on a.fitemid  = b.fitemid 
where  b.ferpclsid = 1 
*/
declare @currentperiod varchar(2),@currentyear varchar(4)
select @currentyear = fvalue from t_systemprofile where fkey like 'currentyear' and fcategory = 'GL'
select @currentperiod = fvalue from t_systemprofile where fkey like 'currentperiod' and fcategory = 'GL'
select a.*,b.fname,b.fmodel, isnull(w.fauxprice,isnull(round(t4.fendbal/t4.fendqty,4),b.fplanprice)) as fprice 
from #bomMultiExpose a 
join		t_icitem b on a.fitemid  = b.fitemid 
left join  (select w9.fitemid,w9.fauxprice from 
      (select  b.fitemid ,max(b.fauxprice) as fauxprice
		from icstockbill a 
		join icstockbillentry b on a.ftrantype = 1 and a.finterid = b.finterid 
		join (
				select max(w1.fdate) as fdate,w2.fitemid 
				from icstockbill w1 join icstockbillentry w2 on w1.finterid = w2.finterid 
				where w1.ftrantype = 1 and 
				w1.fdate >= cast(@currentyear+right('00'+@currentperiod,2)+'01' as datetime) and 
				w1.fdate < dateadd(month,1,cast(@currentyear+right('00'+@currentperiod,2)+'01' as datetime))  group by w2.fitemid ) w on w.fdate = a.fdate and w.fitemid = b.fitemid 
		where a.fdate >= cast(@currentyear+right('00'+@currentperiod,2)+'01' as datetime) and 
		a.fdate < dateadd(month,1,cast(@currentyear+right('00'+@currentperiod,2)+'01' as datetime))
		group by b.fitemid) w9
		) w 		on w.fitemid = a.fitemid
left join	icbal t4 on t4.fitemid = a.fitemid and t4.fyear = @currentyear and t4.fperiod = @currentperiod -1
where  b.ferpclsid = 1 
order by b.fnumber
--select * from sysobjects where type = 'u' and name like 't_CostCalculateBD%';
--TRUNCATE TABLE  #bomMultiExpose
--drop table #bomMultiExpose;

