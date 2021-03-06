alter procedure getHstQtyCustAndModel(@fitemid int ,@fcustid int,@fqtysum decimal(28,10) output) 
as 
begin
select @fqtysum = isnull(sum(b.fqty),0) 
from icsale a  join icsaleentry b 
on a.finterid = b.finterid and a.fstatus > 0 
and a.fcancellation = 0  and b.fitemid in 
(
	select t1.fitemid from 
	icbom t1 join icbomchild t2 on t1.finterid = t2.finterid and t1.fstatus >0
	and t1.fcancellation =0  and t1.fusestatus = 1072
	join (select b.fitemid from icbom a join icbomchild b 
			on a.finterid = b.finterid
			and a.fitemid=@fitemid
		join t_icitem c on c.fitemid= b.fitemid 
			and c.fnumber like '13.%'
		) t3 on t3.fitemid = t2.fitemid
)
and a.fcustid = @fcustid

update  icitemmapping set ModelHstSaleQty = @fqtysum
where fitemid =@fitemid  and  fcompanyid=@fcustid

return 
/* test
	 select top 1 * from t_organization
	declare @fqty int,@fitemid0 int,@fcustid0 int
	select @fitemid0=28788,@fcustid0=553
	EXEC	[dbo].[getHstQtyCustAndModel] @fitemid0,@fcustid0,@fqty output
	select @fqty
	 
	 */
end










--------