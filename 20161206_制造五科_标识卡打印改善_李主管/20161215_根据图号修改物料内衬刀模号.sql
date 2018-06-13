;select top 10 a.fitemid,a.fname,a.fchartnumber,a.fmodel,b.f_163
 from t_icitemcustom b join t_icitem a on a.fitemid = b.fitemid;
  ;select * from ictransactiontype
 ;select * from t_icitem where fmodel like '%ncdm%';
 
 ;select b.* from zpstockbill a join zpstockbillentry b  on a.finterid = b.finterid
 join t_icitem c on c.fmodel like '%ncdm%' and c.fitemid = b.fitemid
 --instock 
  select b.fitemid ,b.fdcspid,max(a.fdate) as findate 
 into #t1
 from zpstockbill a join zpstockbillentry b  on a.finterid = b.finterid and a.ftrantype = 6
 join t_icitem c on c.fmodel like '%ncdm%' and c.fitemid = b.fitemid 
 group by b.fitemid,b.fdcspid
 ;select * from #t1
 --outstock

 select b.fitemid ,max(a.fdate) as foutdate 
 into #t2
 from zpstockbill a join zpstockbillentry b  on a.finterid = b.finterid and a.ftrantype = 26
 join t_icitem c on c.fmodel like '%ncdm%' and c.fitemid = b.fitemid 
 group by b.fitemid
 --last instock
 ;select e.fitemid,e.fname,a.fitemid as a_fitemid,c.fmodel,e.fchartnumber,left(c.fmodel,len(c.fmodel) - 8) as lefmodel,a.fdcspid,d.fnumber 
 into #t3 
 from #t1 a left join #t2 b on a.fitemid = b.fitemid 
 join t_icitem c on c.fitemid = a.fitemid join t_stockplace d on d.fspid = a.fdcspid
 right join t_icitem e on e.fchartnumber = left(c.fmodel,len(c.fmodel) -8)
 where a.findate > isnull(b.foutdate,cast('1900-01-01' as date)) 
 and e.fsource =  '69836' and e.fname like '%衬%';
 --depart make 5 item
 ;select fname,substring(fname,charindex(' ',fname ) +1,len(fname) - charindex(' ',fname) )as fmodel0,fmodel,fchartnumber,fitemid 
 into #t4
 from t_icitem 
 where fsource = '69836' and fname like '%衬%'
 ;select * from #t4 ;
 ;--五科物料对应的仓位编号
 ;select * from #t3;
 select t4.fitemid as fitem,/*a.fitemid,c.fmodel,t4.fmodel0,left(c.fmodel,len(c.fmodel) - 8),a.fdcspid,*/d.fnumber,d.* from #t1 a left join #t2 b on a.fitemid = b.fitemid 
 join t_icitem c on c.fitemid = a.fitemid 
 join t_stockplace d on d.fspid = a.fdcspid
 right join #t4 t4 on t4.fmodel0 =left(c.fmodel,len(c.fmodel) -8)
 where a.findate > isnull(b.foutdate,cast('1900-01-01' as date));

 update a set a.F_163 = b.fnumber
 from  t_ICItemCustom a join #T3 b on a.fitemid = b.fitemid 
 join t_icitem c on a.fitemid = c.fitemid
 where c.FSource =  '69836' and c.fname like '%衬%'
 ;select a.fitemid,a.fname,b.f_163, c.fname from t_icitem a join t_icitemcustom b on a.fitemid = b.fitemid
 join t_stockplace c on c.fspid = b.f_163
 where a.fsource = 69836 and a.fname like '%衬%' 
 --  
 ;drop table #t1;
 ;drop table #t2;
 ;drop table #t3;
 ;drop table #t4;