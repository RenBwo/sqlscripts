alter procedure ICStorageManage_renbo(@fcustomer varchar(60) = ''	)
as	
begin
	/*
	 exec ICStorageManage_renbo
	 * */
select t3.fcustomer,t3.fcustname,t3.Fnumber as fstocknum,t3.FName as fstockname
,t6.fnumber as fprodnum,t6.fname as fprodname,t6.fmodel as fprodmodel
,case when ISNULL(t4.FMaxstorage,0) = 0 then NULL else t4.FMaxstorage END as FMaxStorage
, case when ISNULL(t4.fminstorage,0) = 0 then NULL else t4.fminstorage END  AS fminstorage
,t7.fqty  as frealqty
from (  select t2.ftypeid,t1.FName,t1.FNumber AS FNumber,t1.FDetail,t1.FParentid
		,t1.FItemID as fstockid ,t5.fnumber as fcustomer,t5.fname as fcustname
		from t_item 		t1  
		left join  t_Stock 	t2  on t1.FItemid=t2.FitemID  and t2.FNumber like t1.FNumber + '%' and t1.fitemclassid = 5
 		join t_organization t5 	on t1.FitemID = t5.f_103 and t1.fitemclassid = 5
		where t5.fnumber like '%'+@fcustomer+'%'
		)					t3 
left join ICStorageSet	 	t4  on t3.fstockid=t4.fstockid and t4.fcheck = 1 
left join t_icitem 			t6 	on t4.fitemid = t6.fitemid
left join (select fitemid,fstockid,sum(isnull(fqty,0)) as fqty from icinventory group by fitemid,fstockid
			) 		     	t7 	on t4.fitemid = t7.fitemid  and t4.fstockid = t7.fstockid
where t4.fcheck = 1
order by t3.FNumber 
end
