--销售订单单价为0,批量修改
/*
select * from icclasstype where fname_chs like  '销售订单'
select * from  ictemplateentry where fid = 's01'
select  a.fcurrencyid,a.fcustid,b.fitemid,c.fprice
,b.fprice,b.fauxprice,b.fauxpricediscount,b.fauxtaxprice
 ,b.*
 from  seorder a join seorderentry b on a.finterid = b.finterid
 join icprcplyentry c on c.finterid = 4 and c.frelatedid = a.fcustid 
 and c.fitemid = b.fitemid and a.fcurrencyid = c.fcuryid
where fbillno like 'SEORD008746' and b.fauxprice > 0
 */

update seorderentry set fprice = c.fprice,fauxprice=c.fprice,
 fauxpricediscount=c.fprice,fauxtaxprice=c.fprice
 from  seorder a join seorderentry b on a.finterid = b.finterid
 join icprcplyentry c on c.finterid = 4 and c.frelatedid = a.fcustid 
 and c.fitemid = b.fitemid and a.fcurrencyid = c.fcuryid
where isnull(b.fprice,0) <=0
and fbillno in('SEORD008746','SEORD008830','SEORD008843','SEORD008739') 
