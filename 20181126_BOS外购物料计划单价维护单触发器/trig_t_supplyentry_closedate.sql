/*
 * author:		renbo
 * date:		2018/10/26
 * description: update t_bos200000025's fplanrice according to the t_supplyentry's fused
 * 
 * select top 3 fnumber, * from t_supplier where fnumber like 'aa.0b.05.0001'
 * select * from t_icitem where fnumber like '03.a15.00.095'
 * select top 2 * from t_supply where fitemid = 208607 and fsupid = 225927 
 * select top 2 * from t_supplyentry where fitemid = 208607 and fsupid = 225927 and fused =1
 */

create trigger trig_t_supplyentry_closedate on t_supplyentry after update  as
begin
	if update(fused) 
	begin
		if 1=(select a.fused from inserted a 
		where not exists(select 1 from  t_supplyentry b 
		where a.fitemid = b.fitemid and b.fused=1 and b.fentryid <> a.fentryid))
		begin
			update t_bos200000025entry  set fdate2=getdate()
			from inserted 				a 
			join t_bos200000025entry 	b on a.fitemid = b.fbase and b.fdate2 > getdate()
		end
	end 
end 





