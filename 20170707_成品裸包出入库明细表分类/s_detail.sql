--销售出库
_If [:gv_colname] ='xsckqty' _Then 
	Select v2.FItemID, t1.FNumber ,t1.FName , t1.FModel ,v1.FSupplyID, v1.FBillNo , v1.FCheckDate ,v2.FQty, 
		   (case when t1.FNumber between '01.01.%' and '01.09' THEN '成品'
					when t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%'  THEN '集流管'
					when t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' THEN '压板'
					when t1.FNumber like '01.14.%' THEN '扁管'
					when t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' THEN '支架'
					when t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' THEN '储液器'
					when t1.FNumber like '01.b49.10.%'  THEN '型材'
					when t1.FNumber like '13.%' then '裸包'
					else  '其它' end ) as ftypename
	From ICStockBill v1
	inner Join ICStockBillEntry v2 On v1.FInterID = v2.FInterID
	inner Join t_ICItem t1 On v2.FItemID = t1.FItemID
	Left outer Join t_Organization t2 On v1.FSupplyID=t2.FItemID
	Left outer Join t_Department t3 On t1.FSource =t3.FItemID
	Where v1.FTranType =21  
	    And  v1.FStatus>0 And v1.FCancelLation=0     
	    	and isnull(v1.fheadselfb0157,0) <>  293792 /* 20161215修改，不选择销售状态为销售分配的销售出库*/ 
	    And  v1.FCheckDate >=[:gv_fdate]  AND v1.FCheckDate <=[:gv_tdate] 
	    _If  [:gv_rowname] ='集流管'  _Then 
		And  (  t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%' )
	   _ElseIf  [:gv_rowname] ='压板' _Then  
		And  (t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' )
	   _ElseIf  [:gv_rowname] ='扁管' _Then  
		And  (t1.FNumber like '01.14.%') 
	  _ElseIf  [:gv_rowname] ='储液器' _Then    
		And  (t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%')  
 	    _ElseIf  [:gv_rowname] ='型材' _Then  
		And  (t1.FNumber like '01.b49.10.%')
 	    _ElseIf  [:gv_rowname] ='支架' _Then  
		And  ( t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%') 	
 	    _ElseIf  [:gv_rowname] ='成品' _Then  
		And	t1.FNumber between '01.01.%' and '01.09' 			
  	    _ElseIf  [:gv_rowname] ='裸包' _Then  
  	    	And  t1.FNumber like '13.%' 
  	    _Else
  	        And	 (t3.FName NOT LIKE '%七科%' OR  t3.FName IS NULL) --外购产品 销售出库
		And  t1.FNumber like '01.%'
		And  ( ( t1.FNumber  not like '01.11.%'  and t1.FNumber not like '01.12.%'  and t1.fnumber not like '01.b49.11.%')  
		And  (t1.FNumber not like '01.b49.10.%' )  
		And  (t1.FNumber not like '01.13.%' and t1.FNumber not like '01.15.%'  and t1.FNumber not like '01.40.%')   
		And  (t1.FNumber not like '01.10.%' and t1.fnumber not like '01.b49.03.%') 
		And  (t1.FNumber not like '01.50.%' and t1.fnumber not like '01.b49.00.%'  )   
		And   (t1.FNumber not like '01.14.%') )
  	    _EndIf
  	    ORDER BY v1.FBillNo, t1.FNumber
 -- 产品入库	  
_ElseIf  [:gv_colname] ='cprkqty'  _Then 
	Select v2.FItemID, t1.FNumber ,t1.FName , t1.FModel ,v1.FSupplyID, v1.FBillNo , v1.FCheckDate ,v2.FQty, 
	   	   (case when t1.FNumber between '01.01.%' and '01.09' THEN '成品'
					when t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%'  THEN '集流管'
					when t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' THEN '压板'
					when t1.FNumber like '01.14.%' THEN '扁管'
					when t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' THEN '支架'
					when t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' THEN '储液器'
					when t1.FNumber like '01.b49.10.%'  THEN '型材'
					when t1.FNumber like '13.%' then '裸包'
					else  '其它' end  ) as ftypename, t3.FName as Jhdpt
	From ICStockBill v1
	inner Join ICStockBillEntry v2 On v1.FInterID = v2.FInterID
	inner Join t_ICItem t1 On v2.FItemID = t1.FItemID
	Left outer Join t_Organization t2 On v1.FSupplyID=t2.FItemID
	Left outer Join t_Department t3 On v1.FDeptID=t3.FItemID 
	Where v1.FTranType =2
	    And  v1.FStatus>0 And v1.FCancelLation=0    
	    And  v1.FCheckDate >=[:gv_fdate]  AND v1.FCheckDate <=[:gv_tdate] 
	    _If  [:gv_rowname] ='集流管'  _Then 
		And  (  t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%' )
	   _ElseIf  [:gv_rowname] ='压板' _Then  
		And  (t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' )
	   _ElseIf  [:gv_rowname] ='扁管' _Then  
		And  (t1.FNumber like '01.14.%') 
	  _ElseIf  [:gv_rowname] ='储液器' _Then    
		And  (t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%')  
 	    _ElseIf  [:gv_rowname] ='型材' _Then  
		And  (t1.FNumber like '01.b49.10.%')
 	    _ElseIf  [:gv_rowname] ='支架' _Then  
		And  ( t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%') 	
 	    _ElseIf  [:gv_rowname] ='成品' _Then  
		And	t1.FNumber between '01.01.%' and '01.09' 			
  	    _ElseIf  [:gv_rowname] ='裸包' _Then  
  	    	And  t1.FNumber like '13.%' 
        _Else
  	        And	t3.FName NOT LIKE '%七科%'
		And  t1.FNumber like '01.%' 
		And  ( ( t1.FNumber  not like '01.11.%'  and t1.FNumber not like '01.12.%'  and t1.fnumber not like '01.b49.11.%')  
		And  (t1.FNumber not like '01.b49.10.%' )  
		And  (t1.FNumber not like '01.13.%' and t1.FNumber not like '01.15.%'  and t1.FNumber not like '01.40.%')   
		And  (t1.FNumber not like '01.10.%' and t1.fnumber not like '01.b49.03.%') 
		And  (t1.FNumber not like '01.50.%' and t1.fnumber not like '01.b49.00.%'  )   
		And   (t1.FNumber not like '01.14.%') )				
	 _EndIf
	 ORDER BY v1.FBillNo, t1.FNumber
-- 生产领料	  
_ElseIf  [:gv_colname] ='sclkqty'  _Then 
	Select v2.FItemID, t1.FNumber ,t1.FName , t1.FModel ,v1.FSupplyID, v1.FBillNo , v1.FCheckDate ,v2.FQty, 
		  (case when t1.FNumber between '01.01.%' and '01.09' THEN '成品'
					when t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%'  THEN '集流管'
					when t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' THEN '压板'
					when t1.FNumber like '01.14.%' THEN '扁管'
					when t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' THEN '支架'
					when t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' THEN '储液器'
					when t1.FNumber like '01.b49.10.%'  THEN '型材'
					when t1.FNumber like '13.%' then '裸包'
					else  '其它' end ) as ftypename
	From ICStockBill v1
	inner Join ICStockBillEntry v2 On v1.FInterID = v2.FInterID
	inner Join t_ICItem t1 On v2.FItemID = t1.FItemID
	Left outer Join t_Organization t2 On v1.FSupplyID=t2.FItemID
	Where v1.FTranType =24
	    And  v1.FStatus>0 And v1.FCancelLation=0    
	    And  v1.FCheckDate >=[:gv_fdate]  AND v1.FCheckDate <=[:gv_tdate] 
	_If  [:gv_rowname] ='裸包' _Then 
		And  t1.FNumber like '13.%' 
	_ElseIf  [:gv_rowname] ='成品' _Then  
		And   t1.FNumber between '01.01.%' and '01.09'
	_ElseIf  [:gv_rowname] ='集流管' _Then 
		And  ( t1.FNumber like '01.10.%'  or t1.fnumber like '01.b49.03.%' )
	 _ElseIf  [:gv_rowname] ='压板' _Then  
		And  ( t1.FNumber like '01.50.%'  or t1.fnumber like '01.b49.00.%' )
	 _ElseIf  [:gv_rowname] ='扁管' _Then  
		And  t1.FNumber like '01.14.%'		
	 _ElseIf  [:gv_rowname] ='储液器' _Then  
		And  (t1.FNumber like '01.13.%'  or t1.FNumber like '01.15.%'  or t1.FNumber like '01.40.%' ) 
	 _ElseIf  [:gv_rowname] ='型材' _Then  
		And  t1.FNumber like '01.b49.10.%'
	 _ElseIf  [:gv_rowname] ='支架' _Then  
		And  (t1.FNumber like '01.11.%'  or t1.FNumber like '01.12.%'  or t1.fnumber like '01.b49.11.%' )
	 _Else 
		And  1=0			
	 _EndIf
	 ORDER BY v1.FBillNo, t1.FNumber
 _EndIf 