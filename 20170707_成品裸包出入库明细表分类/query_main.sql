SELECT AA.ftypename, sum(case when B.FTranType=21 then AA.FQty end) as xsckqty                  
				      , sum(case when B.FTranType=2  then AA.FQty end) as cprkqty
				      , sum(case when B.FTranType=24 then AA.FQty end) as sclkqty 
FROM (
	select  A.FInterID ,A.ftypename , SUM(A.FQty) FQty
	from (
		SELECT (case when t1.FNumber between '01.01.%' and '01.09' THEN '成品'
					when t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%'  THEN '集流管'
					when t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' THEN '压板'
					when t1.FNumber like '01.14.%' THEN '扁管'
					when t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' THEN '支架'
					when t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' THEN '储液器'
					when t1.FNumber like '01.b49.10.%'  THEN '型材'
					when t1.FNumber like '13.%' then '裸包'
					else  '其它' end ) as ftypename
			   ,v1.FInterID  , v1.FTranType,t1.FNumber ,t1.FName , t1.FModel ,v1.FSupplyID, v1.FBillNo ,v1.FCheckDate ,v2.FQty
		From ICStockBill v1
		inner Join ICStockBillEntry v2 On v1.FInterID = v2.FInterID
		inner Join t_ICItem t1 On v2.FItemID = t1.FItemID
		Left outer Join t_Department t3 On v1.FDeptID=t3.FItemID 
		where  v1.FStatus>0	AND v1.FCancelLation=0   and  v1.FTranType=2 
		  and  (t1.FNumber like '01.%' or t1.FNumber like '13.%')
		  AND (v1.FCheckDate  >=[:gv_fdate]  AND v1.FCheckDate <=[:gv_tdate]  )) A
	GROUP BY 	  A.FInterID ,A.ftypename 
	union all
		select  A.FInterID ,A.ftypename , SUM(A.FQty) FQty
	from (
		SELECT (case when t1.FNumber between '01.01.%' and '01.09' THEN '成品'
					when t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%'  THEN '集流管'
					when t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' THEN '压板'
					when t1.FNumber like '01.14.%' THEN '扁管'
					when t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' THEN '支架'
					when t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' THEN '储液器'
					when t1.FNumber like '01.b49.10.%'  THEN '型材'
					when t1.FNumber like '13.%' then '裸包'
					else  '其它' end  ) as ftypename
			   ,v1.FInterID  , v1.FTranType,t1.FNumber ,t1.FName , t1.FModel ,v1.FSupplyID, v1.FBillNo ,v1.FCheckDate ,v2.FQty
		From ICStockBill v1
		inner Join ICStockBillEntry v2 On v1.FInterID = v2.FInterID
		inner Join t_ICItem t1 On v2.FItemID = t1.FItemID
		Left outer Join t_Department t3 On t1.FSource=t3.FItemID 
		where  v1.FStatus>0	AND v1.FCancelLation=0    and  (v1.FTranType =24 or v1.FTranType =21 )
			and isnull(v1.fheadselfb0157,0) <>  293792 /* 20161215修改，不选择销售状态为销售分配的销售出库*/
		  and (t1.FNumber like '01.%' or t1.FNumber like '13.%')
		  AND (v1.FCheckDate  >=[:gv_fdate]  AND v1.FCheckDate <=[:gv_tdate]  )) A
	GROUP BY 	  A.FInterID ,A.ftypename 
	) AA
INNER JOIN  ICStockBill B ON AA.FInterID=B.FInterID
GROUP BY AA.ftypename