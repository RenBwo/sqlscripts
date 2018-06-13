--12 month
 ;select * from ( 
 select a.FSupplyID,SUM(isnull(b.famount,0)) as '1m' ,
 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 1 and YEAR(a.fdate)=2016
group by a.fsupplyid
union all 
select a.FSupplyID,0 as '1m',SUM(isnull(b.famount,0)) as '2m' ,
 0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 2 and YEAR(a.fdate)=2016
group by a.fsupplyid
union all
select a.FSupplyID,0 as '1m',0 as '2m',SUM(isnull(b.famount,0)) as '3m' ,
 0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 3 and YEAR(a.fdate)=2016
group by a.fsupplyid union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',SUM(isnull(b.famount,0)) as '4m'  ,
0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 4 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',0 as '4m',
SUM(isnull(b.famount,0)) as '5m' ,0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 5 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',0 as '4m',0 as '5m',
SUM(isnull(b.famount,0)) as '6m'  ,0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 6 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',
sUM(isnull(b.famount,0)) as '7m'  ,
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 7 and YEAR(a.fdate)=2016
group by a.fsupplyid
 union all 
select a.FSupplyID, 0 as '1m', 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 SUM(isnull(b.famount,0)) as '8m'  ,0 as '9m',0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 8 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m', 0 as '8m',
 SUM(isnull(b.famount,0)) as '9m'  ,0 as '10m',0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 9 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID,0 as '1m', 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',SUM(isnull(b.famount,0)) as '10m' ,
 0 as '11m',0 as '12m'
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 10 and YEAR(a.fdate)=2016
group by a.fsupplyid
 union all 
select a.FSupplyID,0 as '1m',
 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',SUM(isnull(b.famount,0)) as '11m' ,0 as '12m' 
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 11 and YEAR(a.fdate)=2016
group by a.fsupplyid 
union all 
select a.FSupplyID, 0 as '1m',
 0 as '2m',0 as '3m',0 as '4m',0 as '5m',0 as '6m',0 as '7m',
 0 as '8m',0 as '9m',0 as '10m',0 as '11m',SUM(isnull(b.famount,0)) as '12m' 
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID and a.FTranType = 21 
and MONTH(a.fdate) = 12 and YEAR(a.fdate)=2016
group by a.fsupplyid
) x
order by x.fsupplyid
