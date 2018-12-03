/*
 * author:		renbo
 * date:		2018/11/06
 * description: update t_bos200000025's fplanrice according to the t_supplyentry's fused
 * select top 2 * from t_supply where fitemid = 208607 and fsupid = 225927 
 * select top 2 * from t_supplyentry where fitemid = 208607 and fsupid = 225927 and fused =1
 * 
 * drop trigger trig_t_supplyentry_closedate
 * 
 */

create trigger trig_t_supplyentry_closedate on t_supplyentry after update  as
begin
	declare @i int,@fentryid int
	if update(fused) 
	begin
		declare cursor_ren cursor 
		for
		select fentryid from inserted
		
		open cursor_ren
		fetch next from cursor_ren into @fentryid
		while @@fetch_status=0
		begin
			if 1=(select a.fused from inserted a 
			where fentryid=@fentryid
			and not exists(select 1 from  t_supplyentry b 
			where a.fitemid = b.fitemid and b.fused=1 and b.fentryid <> a.fentryid))
			begin
				update t_bos200000025entry  set fdate2=getdate()
				from inserted 				a 
				join t_bos200000025entry 	b on a.fitemid = b.fbase and b.fdate2 > getdate()
			end
		fetch next from cursor_ren into @fentryid
		end
		close cursor_ren
		deallocate cursor_ren
		
	end 
end 





