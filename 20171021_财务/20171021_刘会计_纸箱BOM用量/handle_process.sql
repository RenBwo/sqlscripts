/*select *  into "'20161206$'"  from  ais20170714081229.dbo."'20161206$'"
truncate table "'20161206$'" 
select * from ais20170714081229.dbo."'20161206$'"
导入数据错误,全是NULL
select * from "'20161206$'"

select t2.FNumber as  物料代码,t2.FName as 物料名称,t2.FModel as 规格型号,t4.FModel as 纸板规格,t4.FQty as BOM用量 from dbo."'20161206$'"  t1 
inner join t_ICItem t2 on t1.fnumber=t2.FNumber
left join icbom t3 on t2.FItemID=t3.FItemID
left join (select t2.FInterID as FInterID ,t1.FModel as FModel,t2.FQty from t_ICItem t1 
inner join icbomchild t2 on t1.FItemID=t2.FItemID) t4 on t3.FInterID=t4.FInterID
order by t2.FNumber
*/
select *  into "'20291206$'"  from  ais20170714081229.dbo."'20161206$'"
select * from "'20291206$'"
truncate table "'20291206$'" 
导入数据错误,全是NULL