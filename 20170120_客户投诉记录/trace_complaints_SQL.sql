SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FSubSysID from t_DataFlowSubFunc where FSubFuncID=620122
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FTimeStamp FROM ICCLassType WHERE FID=1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT *, FCaption_CHS as FCaption
 FROM ICClassConsts
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICBillNo WHERE FBillID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 Select FFuncID,FSubSysID From t_SysFunction Where FNumber = 'QM0301' 
go
SELECT F.*,S.FSubSysID
FROM t_FuncControl F INNER JOIN t_SysFunction S ON F.FFuncID = S.FFuncID
INNER JOIN t_Mutex A ON F.FFuncID = A.FFuncID
WHERE A.FType =  8
 OR (A.FType = 2 AND A.FForbidden = 2)
 OR (A.FType = 4 AND F.FYear = 2017 AND A.FForbidden = 6201)
 OR (A.FType = 9 AND A.FForbidden = 2 AND F.FYear = 2017 AND F.FPeriod = 1)
 OR (A.FType = 10 AND A.FForbidden=6200301 AND F.FRowID = 0 AND F.FBizType='0')
 OR (A.FType = 1 AND A.FForbidden=6200301)

go
Select Max(FID) FID from t_FuncControl
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT t1.FSourClassTypeID as FClassID ,t2.FName_CHS as FName,  FAllowCopy,FAllowCheck,FAllowForceCheck, t1.FRemark, t1.FFlowControl,t1.FUseSpec 
 , T3.FKey As FSRCIDKey, T3.FCaption_CHS as FCaption
 FROM ICClassLink t1 left join ICClassType t2 on t1.FSourClassTypeID=t2.FID
 Left Join ICClassTableInfo t3 on t1.FDestClassTypeID = t3.FClassTypeID and t1.FSRCIDKey = t3.FKey
 where t1.FDestClassTypeID=1001701 and t1.FIsUsed=2 And t1.FSourClassTypeID in (Select FSourClassTypeID from ICClassLinkEntry where FDestClassTypeID = 1001701) AND t1.FUnControl & 2 = 2
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select a.*,isnull(b.ftable,'') as ftable,isnull(e.ffieldname,'') as FieldName from t_billcoderule a
 left join t_option e on a.fprojectid=e.fprojectid and a.fformatindex=e.fid
 Left OUter join t_checkproject b on a.fbilltype=b.fbilltypeid and a.fprojectval=b.ffield
 where a.fbilltypeid = '1001701' order by a.FClassIndex
go
select FBillTypeID,FProjectID,FProjectVal from t_billcoderule where FBillTypeID = '1001701' and FIsBy=1
go
SELECT FComponentSrv FROM t_ThirdPartyComponent WHERE FTypeID=4 AND FTypeDetailID=1001701 ORDER BY FIndex
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FID , FName From QMAinfo
 Where FID in (25,26,27,28,29)
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FID , FName From QMAInfo
 Where FID in (30,31,32,33,34)
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FID , FName From QMAInfo
 Where FID in (35,36,37,38)
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 4
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_ICItem x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 4 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 4
go
SET NO_BROWSETABLE ON
go
SET FMTONLY ON select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 4 WHERE 1=2  SET FMTONLY OFF
go
set fmtonly off
go
SET NO_BROWSETABLE OFF
go
select * from t_ICItem X2 where X2.FItemID = 235115 And  FItemID IN (Select FItemID From t_Item where FDetail = 1 and FItemClassID =  4 ) 
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 4
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_ICItem x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 4 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 4
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_ICItem x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 4 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 4
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_ICItem x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 4 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 4
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_ICItem x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 4 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 4
go
SET NO_BROWSETABLE ON
go
SET FMTONLY ON select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 4 WHERE 1=2  SET FMTONLY OFF
go
set fmtonly off
go
SET NO_BROWSETABLE OFF
go
select * from t_ICItem X2 where X2.FItemID = 52024 And  FItemID IN (Select FItemID From t_Item where FDetail = 1 and FItemClassID =  4 ) 
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select t_MeasureUnit.* from t_MeasureUnit Where FDeleted=0 AND  FUnitGroupID = 120 AND FConversation = 1 ORDER BY FNumber,FAuxClass,FCoefficient DESC
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select t_MeasureUnit.* from t_MeasureUnit Where FDeleted=0 AND  FUnitGroupID = 120 AND FConversation=1 ORDER BY FNumber,FAuxClass,FCoefficient DESC
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FErpClsID From t_icitem where FItemID=52024
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT ISNULL(FValue,0) FROM t_Systemprofile WHERE FCategory = 'IC' AND FKey = 'EnableMtoPlanMode'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT ISNULL(FValue,0) FROM t_Systemprofile WHERE FCategory = 'IC' AND FKey = 'SecUnit'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICInventory WHERE FBatchNo='N'  AND (FItemID=52024) AND FStockID=245508 AND FStockPlaceID= 4339
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 3
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_Emp x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 3 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 3
go
SET NO_BROWSETABLE ON
go
SET FMTONLY ON select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 3 WHERE 1=2  SET FMTONLY OFF
go
set fmtonly off
go
SET NO_BROWSETABLE OFF
go
select * from t_Emp X2 where X2.FItemID = 416 And  FItemID IN (Select FItemID From t_Item where FDetail = 1 and FItemClassID =  3 ) 
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName from t_ItemClass where FItemClassID = 2
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SELECT  TOP 50 t1.FItemID ,t1.FNumber,t1.FName,t1.FDetail FROM t_Item t1  with(index (uk_Item2)) LEFT JOIN t_Department x2 ON t1.FItemID = x2.FItemID  WHERE FItemClassID = 2 AND t1.FDetail=1  AND t1.FDeleteD=0  ORDER BY t1.FNumber
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|' WHERE FUserID=16415
 AND FSection='BillSet1001701' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1001701','GridProfile0','GridRowHeight=210|FID2_CtlIndex=1|FBillNo_CtlIndex=2|Row2_RowHeight=210|FItemID_CtlIndex=3|Row3_RowHeight=210|FItemID71959_CtlIndex=4|Row4_RowHeight=210|FItemID71969_CtlIndex=5|Row5_RowHeight=210|FUnitID_CtlIndex=6|Row6_RowHeight=210|FParentName_CtlIndex=7|FParentNumber_CtlIndex=8|FBatchNo_CtlIndex=9|Row9_RowHeight=210|FDealerID_CtlIndex=10|Row10_RowHeight=210|FDepID_CtlIndex=11|Row11_RowHeight=210|FAppealSum_CtlIndex=12|Row12_RowHeight=210|FAppealDT_CtlIndex=13|Row13_RowHeight=210|FAppealName_CtlIndex=14|Row14_RowHeight=210|FAppealStatusID_CtlIndex=15|Row15_RowHeight=210|FAppealAddress_CtlIndex=16|Row16_RowHeight=210|FAppealTel_CtlIndex=17|Row17_RowHeight=210|FAppealEmail_CtlIndex=18|Row18_RowHeight=210|FAppealZIP_CtlIndex=19|Row19_RowHeight=210|FAppealWayID_CtlIndex=20|Row20_RowHeight=210|FApppealTypeID_CtlIndex=21|Row21_RowHeight=210|FAppealContent_CtlIndex=22|Row22_RowHeight=210|FSimpleDeal_CtlIndex=23|Row23_RowHeight=210|FDealResult_CtlIndex=24|Row24_RowHeight=210|FMemo_CtlIndex=25|Row25_RowHeight=210|FBillerID_CtlIndex=26|Row26_RowHeight=210|FCreateDT_CtlIndex=27|Row27_RowHeight=210|FCheckerID_CtlIndex=28|Row28_RowHeight=210|FCheckDate_CtlIndex=29|Row29_RowHeight=210|Col1_ColWidth=0|Col2_ColWidth=3510|Col3_ColWidth=3510|Col4_ColWidth=6345|Col5_ColWidth=6585|Col6_ColWidth=240|')
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 2
go
SET NO_BROWSETABLE ON
go
SET FMTONLY ON select FSQLTableName, FVersion from t_ItemClass where FItemClassID = 2 WHERE 1=2  SET FMTONLY OFF
go
set fmtonly off
go
SET NO_BROWSETABLE OFF
go
select * from t_Department X2 where X2.FItemID = 212664 And  FItemID IN (Select FItemID From t_Item where FDetail = 1 and FItemClassID =  2 ) 
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FBatchManager FROM t_ICItem WHERE FItemID =52024
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FUseBillCodeRule FROM ICBillNo WHERE FBillID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select 1 from ICClassGroupInfo where FID=0
go
select 1 from QMClientServiceLog where FID=1001
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Update t_BillCodeRule Set FReChar = FReChar Where FBillTypeID = '1001701'
go
Update t_BillCodeBy Set FProjectVal = FProjectVal Where FBillTypeID = '1001701'
go
select a.*,isnull(b.ftable,'') as ftable,isnull(e.ffieldname,'') as FieldName from t_billcoderule a
 left join t_option e on a.fprojectid=e.fprojectid and a.fformatindex=e.fid
 Left OUter join t_checkproject b on a.fbilltype=b.fbilltypeid and a.fprojectval=b.ffield
 where a.fbilltypeid = '1001701' order by a.FClassIndex
go
select FBillTypeID,FProjectID,FProjectVal from t_billcoderule where FBillTypeID = '1001701' and FIsBy=1
go
select fid from icclasstype where FID>0 And FBillTypeID Not In(5,6) 
 and FBillTypeID<> 1 and fid =1001701
go
select ffieldname, FPage from icclasstableinfo where fclasstypeid=1001701 and fkeyword='BILLNO'
go
select ftablename from icclasstypeentry where fparentid=1001701 and findex=2
go
select FBillNo   from QMClientServiceLog where FBillNo='TS000002'
go
DECLARE @TmpID INT 
DECLARE @fprojectval varchar(80) 
select  @fprojectval='' 
SET @TmpID = (SELECT FID FROM t_BillCodeRule WITH(READUNCOMMITTED) WHERE fbilltypeid='1001701' and fprojectid=3)
update t_billcoderule set fprojectval = fprojectval+1,@fprojectval=isnull(fprojectval,1),flength=case when (flength-len(fprojectval)) >= 0 then flength else len(fprojectval) end where FID = @TmpID 
Update ICBillNo Set FCurNo = @fprojectval where fbillid = 1001701
go
SELECT FTemplateID FROM ICTransactionType WHERE FID=1001701
go
Select * From t_BillCodeRule Where FBillTypeID = '1001701' Order By FClassIndex
go
Update ICBillNo Set FDesc = 'TS+000003' Where FBillID = '1001701'
go
SELECT FComponentSrv FROM t_ThirdPartyComponent WHERE FTypeID=4 AND FTypeDetailID=1001701 ORDER BY FIndex
go
SELECT COUNT(*) FROM ICClassGroupInfo
 INNER JOIN QMClientServiceLog ON ICClassGroupInfo.FID=QMClientServiceLog.FID
 WHERE QMClientServiceLog.FBillNo='TS000002'
 AND ICClassGroupInfo.FClassTypeID=1001701
 AND ICClassGroupInfo.FID<>1001
go
INSERT INTO ICClassGroupInfo(FClassTypeID,FDetail,FID,FParentID) Values(1001701,1,1001,0)
go
INSERT INTO QMClientServiceLog(FID,FBillNo,FItemID,FUnitID,FName,FNumber,FBatchNo,FDealerID,FDepID,FAppealSum,FAppealDT,FAppealName,FAppealStatusID,FAppealAddress,FAppealTel,FAppealEmail,FAppealZIP,FAppealWayID,FApppealTypeID,FAppealContent,FSimpleDeal,FDealResult,FMemo,FBillerID,FCreateDT,FCheckerID,FCheckDate) Values(1001,'TS000002',52024,60424,'','','N',416,212664,1,'2017-01-20','tom','','','','','','','36','this is a sample','','','',16415,'2017-01-20',0,NULL)
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FCheckAfterSave FROM ICBillNo WHERE FBillID= 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT 
QMClientServiceLog.FBillNo,QMClientServiceLog.FItemID,t_ICItem.FNumber AS FItemID_FNDName,t_ICItem.FTrack AS FItemID_Track,t_ICItem.FBatchManager AS FItemID_BatchNoManage,t_ICItem.FQtyDecimal AS FItemID_FQtyDecimal,
t_ICItem.FPriceDecimal AS FItemID_FPriceDecimal,t_ICItem.FUnitGroupID AS FItemID_UnitGroupID,t_ICItem.FISKFPeriod AS FItemID_FISKFPeriod,t_ICItem.FNumber AS FItemID_DSPName,QMClientServiceLog.FItemID AS FItemID71959,t_ICItem.FName AS FItemID71959_DSPName,
QMClientServiceLog.FItemID AS FItemID71969,t_ICItem.FModel AS FItemID71969_DSPName,QMClientServiceLog.FUnitID,t_Measureunit.FNumber AS FUnitID_FNDName,t_Measureunit.FName AS FUnitID_DSPName,QMClientServiceLog.FBatchNo,
QMClientServiceLog.FDealerID,t_Emp.FNumber AS FDealerID_FNDName,t_Emp.FName AS FDealerID_DSPName,QMClientServiceLog.FDepID,t_Department.FNumber AS FDepID_FNDName,t_Department.FName AS FDepID_DSPName,
QMClientServiceLog.FAppealSum,QMClientServiceLog.FAppealDT,QMClientServiceLog.FApppealTypeID,QMAInfo1.FName AS FApppealTypeID_FNDName,QMAInfo1.FName AS FApppealTypeID_DSPName,QMClientServiceLog.FDealResult,
QMClientServiceLog.FBillerID,t_User.FName AS FBillerID_FNDName,t_User.FName AS FBillerID_DSPName,QMClientServiceLog.FCheckerID,t_user2.FName AS FCheckerID_FNDName,t_user2.FName AS FCheckerID_DSPName,
QMClientServiceLog.FAppealAddress,QMClientServiceLog.FAppealContent,QMClientServiceLog.FAppealEmail,QMClientServiceLog.FAppealName,QMClientServiceLog.FAppealStatusID,QMAinfo2.FName AS FAppealStatusID_FNDName,
QMAinfo2.FName AS FAppealStatusID_DSPName,QMClientServiceLog.FAppealTel,QMClientServiceLog.FAppealWayID,QMAInfo3.FName AS FAppealWayID_FNDName,QMAInfo3.FName AS FAppealWayID_DSPName,QMClientServiceLog.FAppealZIP,
QMClientServiceLog.FCheckDate,QMClientServiceLog.FCreateDT,ICClassGroupInfo.FID,QMClientServiceLog.FID AS FID2,ICClassGroupInfo.FLogic,QMClientServiceLog.FMemo,
QMClientServiceLog.FSimpleDeal,QMClientServiceLog.FNumber AS FParentNumber,QMClientServiceLog.FName AS FParentName,ICClassGroupInfo.FParentID,ICClassGroupInfo.FDetail,ICClassGroupInfo.FClassTypeID  FROM  ICClassGroupInfo  INNER JOIN QMClientServiceLog  ON ICClassGroupInfo.FID=QMClientServiceLog.FID
 LEFT  JOIN t_ICItem  ON QMClientServiceLog.FItemID=t_ICItem.FItemID AND t_ICItem.FItemID<>0
 LEFT  JOIN t_Measureunit  ON QMClientServiceLog.FUnitID=t_Measureunit.FItemID AND t_Measureunit.FItemID<>0
 LEFT  JOIN t_Emp  ON QMClientServiceLog.FDealerID=t_Emp.FItemID AND t_Emp.FItemID<>0
 LEFT  JOIN t_Department  ON QMClientServiceLog.FDepID=t_Department.FItemID AND t_Department.FItemID<>0
 LEFT  JOIN QMAinfo QMAinfo2 ON QMClientServiceLog.FAppealStatusID=QMAinfo2.FID
 LEFT  JOIN QMAInfo QMAInfo3 ON QMClientServiceLog.FAppealWayID=QMAInfo3.FID
 LEFT  JOIN QMAInfo QMAInfo1 ON QMClientServiceLog.FApppealTypeID=QMAInfo1.FID
 LEFT  JOIN t_User  ON QMClientServiceLog.FBillerID=t_User.FUserID AND t_User.FUserID<>0
 LEFT  JOIN t_User t_user2 ON QMClientServiceLog.FCheckerID=t_user2.FUserID AND t_user2.FUserID<>0
 WHERE ICClassGroupInfo.FID=1001
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FGroupID FROM t_Group WHERE FUserID=16415
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FTimeStamp FROM ICCLassType WHERE FID=1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT *, FCaption_CHS as FCaption
 FROM ICClassConsts
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICBillNo WHERE FBillID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FID FROM icClassMCTemplate WHERE FIsRun=1 AND FClassTypeID =1001701 order by fid desc 
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Delete From t_FuncControl Where FID=7903710 And FUserID=16415
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 Select FFuncID,FSubSysID From t_SysFunction Where FNumber = 'QM0302' 
go
SELECT F.*,S.FSubSysID
FROM t_FuncControl F INNER JOIN t_SysFunction S ON F.FFuncID = S.FFuncID
INNER JOIN t_Mutex A ON F.FFuncID = A.FFuncID
WHERE A.FType =  8
 OR (A.FType = 2 AND A.FForbidden = 2)
 OR (A.FType = 4 AND F.FYear = 2017 AND A.FForbidden = 6201)
 OR (A.FType = 9 AND A.FForbidden = 2 AND F.FYear = 2017 AND F.FPeriod = 1)
 OR (A.FType = 10 AND A.FForbidden=6200302 AND F.FRowID = 1001 AND F.FBizType='0')
 OR (A.FType = 1 AND A.FForbidden=6200302)

go
Select Max(FID) FID from t_FuncControl
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FKeyFieldName from t_AuditFunc where FClassTypeID=1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1001701'
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1001701
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select TOP 1 FBillNo from QMClientServiceLog where FID=1001
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')
go
INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16415,'BOS1001701_MNUFILESAVE',5,'单据保存完成-单据编号：TS000002','XUYAOYAO','192.168.1.99')
go
