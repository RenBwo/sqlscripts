--drop table #bom;
--BOM²»ÄÜ³¬¹ý100²ã
with recursive_cte as (
select cast(FLevel as varchar(101)) as flevel,FParentID,FItemID,fQtyPer,fQty,fitemsize,Fnumber,FbomInterID ,cast('1.' as varchar(300)) as sn
from BDBomMulExpose where flevel = 0 
union all
select cast(a.flevel as varchar(101)) as flevel,a.FParentID,a.FItemID,a.fQtyPer,a.fQty,a.fitemsize,a.Fnumber,a.FbomInterID ,
cast(b.sn+right('000'+cast(row_number()over(order by a.flevel) as varchar(20)),3) as varchar(300)) as sn
from BDBomMulExpose a 
join recursive_cte b on a.fparentid = b.fitemid
)
select * into #bom from recursive_cte --option(maxrecursion 30)



declare @point varchar(101);
declare @i int,@y int;
select @point = '..',@i=0,@y=max(right(flevel,1)) from #bom
--select @Y
while (@i < @y)
begin
update #bom set flevel =@point+flevel where right(flevel,1) = @i+1;
select @point = '.'+@point,@i=@i+1
end
select  * from #bom order by sn;
