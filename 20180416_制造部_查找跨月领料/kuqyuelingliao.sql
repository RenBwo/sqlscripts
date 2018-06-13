/*
 * 制造部门要求，每月查找结案生产任务单中，跨月领料。
 * exec GetSpanMonthIssue '2018','4',''
 * */
alter procedure GetSpanMonthIssue( @year varchar(4) ,@month varchar(2),@gzl varchar(30)) as 
 set nocount on 
--set @year='2018'
--set @month = '03'

select ww.gzl,ww.fbillno,b.fname,ww.fplanfinishdate,ww.importdate,ww.issuedate
from
 (select e.fheadselfj0184 as gzl,e.fbillno,e.fplanfinishdate ,e.fworkshop
 ,max(a.fdate) as importdate,max(d.fdate) as issuedate
 from icstockbill a 
 join icstockbillentry b on a.finterid = b.finterid and a.ftrantype = 2 
 join icstockbillentry c on b.ficmointerid = c.ficmointerid 
 join icstockbill d on c.finterid = d.finterid and d.ftrantype = 24 
 join icmo e on e.fstatus = 3 and e.finterid = b.ficmointerid 
 where replace(convert(varchar(8),e.fplanfinishdate,21),'-','') =  @year+right('00'+@month,2)
 and  e.fheadselfj0184 like '%'+isnull(@gzl,'')+'%'
 group by e.fbillno,e.fplanfinishdate,e.fheadselfj0184,e.fworkshop
 )ww
 join t_item b on b.fitemid = ww.fworkshop
 where replace(convert(varchar(8),ww.issuedate,21),'-','') > replace(convert(varchar(8),ww.importdate,21),'-','')
 order by b.fname,ww.gzl,ww.fplanfinishdate
 
 
 
