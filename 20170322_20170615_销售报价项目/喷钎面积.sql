alter procedure SAbout13(@fnumber varchar(100),@s decimal(20,10) output)  as 
begin
--13裸包喷钎面积 01.01.13.0682-BJ
--declare @fnumber varchar(100) ,@s decimal(20,10)
--select @fnumber = '13.01.07.0682'
--bom expose from 13.*
 CREATE TABLE #bomMultiExpose
    (  
        FLevel		int null default 0,
        FParentID	int,
		FItemID		int,
		fqty		decimal(20,10),
		fitemsize	varchar(60),
        Fnumber     varchar(60),
        FbomInterID int
    )
declare @level int,@firstitem int ,@x decimal(20,10),@y decimal(20,10);
select @firstitem = fitemid ,@level = 0 from t_icitem where fnumber = @fnumber ;--292211 13.01.07.0682
insert into #bomMultiExpose(flevel,fitemid,fqty,fnumber,fbominterid) 
select @level as flevel, @firstitem as fitemid,1 as fqty ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a 
join t_icitem c on c.fitemid = a.fitemid where a.fitemid =@firstitem  ;

while exists(select 1 from icbom where fitemid in (select fitemid from #bomMultiExpose where flevel = @level))
begin
insert into #bomMultiExpose(flevel,fparentid,fitemid,fqty,fitemsize,fnumber,fbominterid) 
select @level + 1 as flevel,a.fitemid as fparentid,b.fitemid as fitemid,b.fqty as fqty ,
b.fitemsize ,c.fnumber as fnumber,a.finterid as fbominterid
  from icbom a join icbomchild b on a.finterid = b.finterid 
join t_icitem c on c.fitemid = b.fitemid 
where a.fitemid in (select fitemid from #bomMultiExpose where flevel = @level )  ;
select @level = @level + 1 
end
/*
select * from t_icitem where fitemid = 292211
select * from  #bomMultiExpose
drop table #bomMultiExpose;
select * from icbom a join icbomchild b on a.finterid = b.finterid where a.finterid = 12255
select column_name,data_type from information_schema.columns where table_name = 'icbomchild' and column_name='fitemsize'
select fc * from t_icitem where fname like '%圆铝管%'
select * from t_icitemcustom 
*/
--x=fitemsize unit m

select a.*,b.fname 
into #t_x --drop table #t_x
from #bomMultiExpose a join t_icitem b on a.fparentid  = b.fitemid 
where b.fnumber like '30.%' and a.fitemid in (select fitemid from t_icitem where fnumber like '03.a18.%');
select @x = max(cast(rtrim(ltrim(fitemsize)) as numeric(20,10))) from #t_x;
--y =fiemsize=qty/f140米重；unit m
select a.*,b.fname,c.f_140 as Mweigth ,round(a.fqty/c.f_140,4) as y 
into #t_y  --drop table #t_y
from #bomMultiExpose a 
join t_icitem b on a.fparentid  = b.fitemid 
join t_icitemcustom c on c.fitemid = a.fitemid 
where b.fname like '%圆集流管1' 
and a.fitemid in (select fitemid from t_icitem where fnumber like '03.a01.%');
select @y=max(cast(rtrim(ltrim(fitemsize)) as numeric(20,10)))  from #t_y
if @y <=0 
begin
select  @y=max(y) from #t_y
end


--s=x*y unit unit m^2
select @s = @x * @y;

--select @s,@x,@y;
drop table #t_y;
drop table #t_x;
drop table #bomMultiExpose;
return @s
end