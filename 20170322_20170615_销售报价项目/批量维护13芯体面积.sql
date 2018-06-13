
declare cus_fnumber cursor scroll for
--需要钎焊接工艺的13物料
select f.fnumber from icbom a join icbomchild b on a.finterid = b.finterid
join t_routingoper d	on	d.finterid = a.froutingid
join t_submessage e		on  e.finterid = d.foperid 
join t_icitemcore f		on	f.fitemid = a.fitemid
where	e.FName		like '%钎%'	and
		f.fnumber	like '13.%'	and 
		f.fdeleted	=	0
group by a.fitemid,e.fname,f.fnumber;
open	cus_fnumber
declare @fnumber	varchar(100)	,
		@cv			decimal(20, 10)
while @@fetch_status = 0
begin
fetch next from cus_fnumber into @fnumber
EXEC	[dbo].[SAbout13] @fnumber ,@cv OUTPUT
update a set f_170=@cv from t_icitemcustom a 
join t_icitemcore b on a.fitemid = b.fitemid 
where b.fnumber =@fnumber and b.fdeleted =0
end
close cus_fnumber
deallocate cus_fnumber

