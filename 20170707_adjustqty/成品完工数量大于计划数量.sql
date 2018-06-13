/*
存在因公报废

*/
select * from t_tabledescription where ftablename = 'shworkbillentry';
select * from t_fielddescription where ftableid = 1450001 and fdescription like '%调机%'--1450001
; select b.ficmointerid,b.finterid,* from shprocrptmain a join shprocrpt b on a.finterid = b.finterid  
where a.fbillno = 'gxhb678440'
;SELECT c.fwbinterid,a.FEntryIndex , a.FEntryID, a.FAuxQtyfinish,a.FAuxQtyscrap
						,c.FQtyPlan , c.FAuxQtyFinish,isnull(t1.FHeadSelfJ0196,0)
				 , c.FqualityChkID
			  from SHProcRpt A
			  INNER JOIN SHProcRptMain B ON A.FInterID =B.FInterID 
			  INNER JOIN SHWorkBillEntry C ON C.FWBInterID =B.FWBInterID 
			  inner join icmo t1 on b.ficmointerid=t1.finterid 
			  
			  WHERE A.FInterID=678123
			  ;
			  select FAuxQtyFinish,* from shworkbillentry where fwbinterid = 11919769