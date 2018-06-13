 CREATE TABLE #ICItem
    (  
        FLevel    int null default 0,
        FParentID int,
		FItemID   int,
        Fnumber     varchar(60),
        FbomInterID  int
    )
declare @level int,@firstitem int ;
select @firstitem = 87537,@level = 0;
insert into #icitem(flevel,fparentid,fitemid,fbominterid,fnumber) 
select @level as flevel,a.fitemid as fparentid,b.fitemid as fitemid,a.finterid as fbominterid,
c.fnumber as fnumber  from icbom a join icbomchild b on a.finterid = b.finterid 
join t_icitem c on c.fitemid = a.fitemid where b.fitemid =@firstitem;
--select * from #icitem;
--drop table #icitem;
while exists(select 1 from icbomchild where fitemid in (select fparentid from #icitem where flevel = @level))
begin
insert into #icitem(flevel,fparentid,fitemid,fbominterid,fnumber) 
select @level + 1 as flevel,a.fitemid as fparentid,b.fitemid as fitemid,a.finterid as fbominterid,
c.fnumber as fnumber  from icbom a join icbomchild b on a.finterid = b.finterid 
join t_icitem c on c.fitemid = a.fitemid 
where b.fitemid in (select fparentid from #icitem where flevel = @level);
select @level = @level + 1 
end
select * from #icitem  where fnumber like '01.%' or  fnumber like '13.%' order by fnumber;
