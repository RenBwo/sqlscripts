/* 
 * 		custom fnumber
 * 		0a.a1.0464,0a.a1.0575,0c.c3.0015,K.5.145,k.3.011,k.3.034
 */
declare @a varchar(1000)
select @a = 'K.3.009'
/*
 * Custom Information
 * select * from t_organization where fnumber = @a  
 * select b.fenddate,c.fname,* from icprcply a join icprcplyentry b on a.finterid= b.finterid 
   left join t_organization c on b.frelatedid = c.fitemid
   where a.Fnumber = 'bdk-a08000' --客户价格体系
    AND c.fnumber = @a and b.fenddate < '2017-03-01'
    AND b.FRelatedID = 244398
*/

update b 
set b.fenddate = '2018/12/31'
from icprcply a join icprcplyentry b on a.finterid= b.finterid 
left join t_organization c on b.frelatedid = c.fitemid
where a.Fnumber = 'bdk-a08000' /*AND b.FRelatedID = 244398*/
and c.fnumber = @a