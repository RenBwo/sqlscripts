create procedure getItselfHistSaleQty(@fitemid int ,@fqtysum decimal(20,4) output) 
as 
begin
select @fqtysum = isnull(sum(b.fqty),0) 
from icsale a  join icsaleentry b 
on a.finterid = b.finterid and a.fstatus > 0 
and a.fcancellation = 0 and b.fitemid =@fitemid

return 
/* test
	 
	declare @fqty int
	EXEC	[dbo].[getItselfHistSaleQty] 28788,@fqty output
	select @fqty
	 
	 */
end










--------