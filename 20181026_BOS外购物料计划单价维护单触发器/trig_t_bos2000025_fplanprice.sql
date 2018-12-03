/*
 * author:		renbo
 * date:		2018/10/26
 * description: update t_icitem's fplanrice according to the t_bos200000025
 * 				select top 2 fitemid,fplanprice,* from t_icitemmaterial
 * 				select top 3 * from t_bos200000025 a join t_bos200000025entry b on a.fid = b.fid
 */

alter trigger trig_t_bos2000025_fplanprice on t_bos200000025 
after update  as
begin
	if update(fmulticheckstatus)
	begin
		--close old record
		update t_bos200000025entry set fdate2 = dateadd(day,-1,getdate())
		from t_bos200000025entry g 
		where g.fdate2 > getdate()
		and exists (select 1 from inserted a 
		join t_bos200000025entry b on a.fid = b.fid
		and b.fbase=g.fbase and g.fentryid < b.fentryid)
		--update t_icitem
		update t_icitemmaterial set fplanprice=b.fprice
		from inserted 				a 
		join t_bos200000025entry 	b on a.fid = b.fid 
			and a.fmulticheckstatus = 16
		join t_icitemmaterial 		c on c.fitemid = b.fbase 
	end 
end 