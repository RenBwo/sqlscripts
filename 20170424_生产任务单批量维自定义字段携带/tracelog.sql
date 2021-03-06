exec sp_reset_connection 
select FUserID,* from t_Group where FUserID = 16690 and FGroupID = 1
select FUserID from t_Group where FUserID = 16690 and FGroupID = 1
select FUserID from t_Group where FUserID = 16690 and FGroupID = 1
select FUserID from t_Group where FUserID = 16690 and FGroupID = 1
SELECT v4.FCaption as FCaption, v3.FCaption_CHS as FDestCaption, v4.FFieldName as FSourFieldName,ISNull(u.FDestFKey,'') as FDestFieldName,u.FSourPage as FDestPage,u.FDestPage as FSourPage,v1.FTableName as FDestTable,Case When u.FSourPage=1 then v2.FHeadTable else v2.FEntryTable end as FSourTable,ISNull(v3.FValueType,0) as FDestCtlType,v4.FCtlType as FSourCtlType,v4.FMustInput 
 FROM ICTemplate v4 --LEFT JOIN ICTemplateEntry v5 ON v4.FID=v5.FID 
 LEFT JOIN ICTransActionType V2 on V2.FTemplateID=v4.FID 
 LEFT JOIN ICCLASSLINKENTRY u on ABS(u.FSourClassTypeID)=v2.FID AND u.FSourFKey=v4.FFieldName  and u.FSourClassTypeID = -85 and u.FDestClassTypeID =1002511
 LEFT JOIN ICClassTypeEntry v1 on u.FDestClassTypeID=v1.FParentID and u.FDestPage=v1.FIndex 
 LEFT JOIN ICClassTableInfo v3 on u.FDestFKey=v3.FKey and u.FDestClassTypeID=v3.FClassTypeID 
 Where v2.FID=85 AND v4.FNeedSave=1  AND v4.FDefaultCtl<>1 
 SELECT T2.FInterID,T2.FDay,T1.FItemID FROM T_Department T1 INNER JOIN T_MutiWorkCal T2 ON T2.FCalID=T1.FCalID WHERE T2.FInterID<>0 AND T1.FDProperty=1070 AND T1.FItemID IN (227394)

 Create Table #Temp(FEntryID int,FInterID int ,FBillNo NVarChar(255)) 
 SELECT Count(*) as FCount,t.FBillNo,'' as  FOldBillNo FROM #Temp t  Group By t.FBillNO Having  Count(*)>1 
 Union All  
 select t.FCount,t.FBillNo,ISNull(t1.FBillNo,'') as FOldBillNo from  
 (SELECT Count(*) as FCount,t.FBillNo,Sum(t.FInterID) as FInterID FROM #Temp t  Group By t.FBillNO Having  Count(*)=1) t 
 left join ICMO t1 on t.FBillNO=t1.FBillNO and t.FInterID<>t1.FInterID AND t1.FTranType=85
 DROP Table #Temp

SELECT FInterID,FEntryID From SEOrderEntry WHERE FBCommitQty>=FQty AND ( (FInterID=8681 AND FEntryID=8) )

UPDATE ICMaxNum SET FMaxNum =FMaxNum+1 WHERE FTableName='ICMO'
SELECT (FMaxNum-1) AS FMaxNum from ICMaxNum WHERE FTableName='ICMO'

Update t_BillCodeRule Set FReChar = FReChar Where FBillTypeID = '85'
Update t_BillCodeBy Set FProjectVal = FProjectVal Where FBillTypeID = '85'

select a.*,isnull(b.ftable,'') as ftable,isnull(e.ffieldname,'') as FieldName from t_billcoderule a
 left join t_option e on a.fprojectid=e.fprojectid and a.fformatindex=e.fid
 Left OUter join t_checkproject b on a.fbilltype=b.fbilltypeid and a.fprojectval=b.ffield
 where a.fbilltypeid = '85' order by a.FClassIndex

select FBillTypeID,FProjectID,FProjectVal from t_billcoderule where FBillTypeID = '85' and FIsBy=1

select fid from icclasstype where FID>0 And FBillTypeID Not In(5,6) 
 and FBillTypeID<> 1 and fid =85

select distinct a.fheadtable as TableName,b.ffieldname as BillFieldName from ictransactiontype a
inner join ictemplate b on a.ftemplateid = b.fid
and b.fctltype = 4 and a.fid = 85

select FBillNo   from ICMO where FBillNo='WORK641017'

DECLARE @TmpID INT 
DECLARE @fprojectval varchar(80) 
select  @fprojectval='' 
SET @TmpID = (SELECT FID FROM t_BillCodeRule WITH(READUNCOMMITTED) WHERE fbilltypeid='85' and fprojectid=3)
update t_billcoderule set fprojectval = fprojectval+1,@fprojectval=isnull(fprojectval,1),flength=case when (flength-len(fprojectval)) >= 0 then flength else len(fprojectval) end where FID = @TmpID 
Update ICBillNo Set FCurNo = @fprojectval where fbillid = 85

SELECT FTemplateID FROM ICTransactionType WHERE FID=85

Select * From t_BillCodeRule Where FBillTypeID = '85' Order By FClassIndex

Update ICBillNo Set FDesc = 'WORK+641018' Where FBillID = '85'

SELECT FComponentSrv FROM t_ThirdPartyComponent WHERE FTypeID=4 AND FTypeDetailID=85 ORDER BY FIndex

INSERT INTO ICMO(FBrNo, FInterID, FBillNo, FTranType, FType, FStatus, FCheckDate, FBillerID, FConfirmDate, FConfirmerID, FCommitDate, FConveyerID, FNote, FItemID,  FGMPBatchNo, FWorkTypeID, FCostObjID, FBomInterID, FRoutingID, FWorkShop, FCustID, FUnitID, FAuxQty, FInHighLimit, FAuxInHighLimitQty, FInLowLimit, FAuxInLowLimitQty, FPlanCommitDate, FPlanFinishDate,  FMrp, FOrderInterID, FSourceEntryID,FPlanConfirmed,FPlanMode,FMtoNO ,FHeadSelfJ0184)
VALUES ('0',675118,'WORK641017',85,1054,0,'2017-04-24',16690, NULL, NULL, NULL, NULL,'', 287277, '', 57, 287278, 42491,25892, 227394, 0, 60422, 15, 0, 15, 0, 15, '2017-04-24', '2017-04-24', 1052, 8681, 8, 0,14036,'','12356renbo-125')


SET TRANSACTION ISOLATION LEVEL READ COMMITTED

select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')

INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16690,'CJ0400',1,'编号为WORK641017的单据保存成功！','RENBO','192.168.1.99')

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

 Select FFuncID,FSubSysID From t_SysFunction Where FNumber = 'Jh0852' 

SELECT F.*,S.FSubSysID
FROM t_FuncControl F INNER JOIN t_SysFunction S ON F.FFuncID = S.FFuncID
INNER JOIN t_Mutex A ON F.FFuncID = A.FFuncID
WHERE A.FType =  8
 OR (A.FType = 2 AND A.FForbidden = 2)
 OR (A.FType = 4 AND F.FYear = 2017 AND A.FForbidden = 47)
 OR (A.FType = 9 AND A.FForbidden = 2 AND F.FYear = 2017 AND F.FPeriod = 4)
 OR (A.FType = 10 AND A.FForbidden=24852 AND F.FRowID = 675118 AND F.FBizType='0')
 OR (A.FType = 1 AND A.FForbidden=24852)


Select Max(FID) FID from t_FuncControl

