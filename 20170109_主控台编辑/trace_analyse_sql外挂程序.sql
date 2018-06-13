--外挂程序跟踪
use master 
go
Select distinct g.cacc_name,g.cdbname From t_KdAccount_gl g,sysdatabases u where g.cdbname=u.name 
go
Select distinct g.cacc_name,g.cdbname From t_KdAccount_gl g,sysdatabases u where g.cdbname=u.name 
go
select * from t_KDaccount_gl
go
select convert(nvarchar(4),serverproperty('ProductVersion'))
go
Select FValue From t_SystemProfile Where FCategory='Base' and FKey ='ServicePack'
go
use master
go
update t_KDAccount_gl set cacc_name ='txt' where cdbName ='AIS20091217151735'
go
use AIS20161114132150
go 
Select FValue From t_SystemProfile Where FCategory='Base' and FKey ='AcctType'
go
Select FValue From t_SystemProfile Where FCategory='Base' and FKey ='ServicePack'
go
use master
go
select * from t_KDAccount_gl where  cdbname='AIS20091217151735'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
use AIS20161114132150
go 
Select * From t_user Where FUserID = 16394
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')
go
INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16394,'A00702',1,'','ERP','192.168.200.4')
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue, FReadonly from t_SystemProfile where FCategory ='Base' and FKey = 'ServicePack'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID, FName, FDescription, FUserTypeID,FForbidden,FDataVokeType,FPortUser from t_User where abs(FUserID) between 16384 and 2147483647 Order By FUserID 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue, FReadonly from t_SystemProfile where FCategory ='Base' and FKey = 'ServicePack'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID, FName, FDescription, FForbidden,FDataVokeType from t_User where FUserID between 0 and 16383 Order By FUserID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FUserID,FParentID,FLevel,FNumber,FState,FName
 FROM t_UserType WHERE FUserID>0 
 order by FLevel,FUserID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16394 AND FWorkStation = 'ERP'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue, FReadonly from t_SystemProfile where FCategory ='Base' and FKey = 'ServicePack'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID, FName, FDescription, FUserTypeID,FForbidden,FDataVokeType,FPortUser from t_User where abs(FUserID) between 16384 and 2147483647 Order By FUserID 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')
go
INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16394,'A00702',3,'','ERP','192.168.200.4')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT COUNT(FID) FROM t_UserProfile WHERE FUserID = 16394 AND FCategory = 'UserMgr' AND FKey = 'SelUserType'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * From t_user Where FUserID = 16394
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue From t_systemprofile Where FCategory='base' And FKey='InitDataLanguage'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FValue From t_SystemProfile Where FCategory='Base' And FKey IN ('Type','AcctType','UUID')
go
Select FName,FUserID,FSafeMode,FSid,FForbidden,FSSOUsername From t_user Where FName= 'kingdee' And abs(FUserID) >= 16384
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select top 1 * from t_systemprofile
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FUInValidDate,FPwCreateDate,FPwValidDay from t_User 
 where FUserID=16415
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')
go
INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16415,'MAIN00001',5,'用户:kingdee登录K/3主控台成功','XUYAOYAO','192.168.1.99')
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
Select FAuthRight from t_User  where FUserID=16415
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp as lngTimeStamp From t_DataFlowTimeStamp Where FName = 'DataFlow'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp as lngTimeStamp From t_DataFlowTimeStamp Where FName = 'DataFlow'
go
Select  FTopClassID,FTopClassName as FTopClassName_CHS, FTopClassName_CHT, FTopClassName_EN,FTopClassName As FTopClassName,FIndex,FVisible,FShowSysType,FAcctType,FToolTips As FToolTips  From t_DataFlowTopClass Order by FIndex
go
Select  FSubSysID,FName as FName_CHS, FName_CHT, FName_EN,FName As FName,FTopClassID,FClassName,FIndex, FVisible,FShowSysType,FAcctType,FRefresh,FNote As FNote,FAppClassName,FHelpFileName, FTipID,FUpdateBaseData,FSubID  From t_DataFlowSubSystem Order by FIndex,FSubSysID
go
Select  FSubFuncID,FSubSysID,FIndex,FFuncName as FFuncName_CHS, FFuncName_CHT, FFuncName_EN,FFuncName As FFuncName,FClassName,FClassParam,FVisible, FAcctType,FFuncType,FRefresh,FSetEnable,FSubID,FIsEdit From t_DataFlowSubFunc Order by FIndex,FSubFuncID
go
Select  FDetailFuncID, FFuncName as FFuncName_CHS, FFuncName_CHT, FFuncName_EN,FFuncName As FFuncName,FSubFuncID,FIndex,FClassName,FClassParam, FIsNormal,FHelpCode,FVisible,FAcctType,FFuncType,FEnable,FShowName As FShowName,FIsEdit From t_DataFlowDetailFunc Order by FIndex,FDetailFuncID
go
Select  FAccttype,FacctTrade,FName As FName,FDesc As FDesc,FShowName As FShowName,FNumber,FForbidden,FDeleted  From t_DataFlowAcctType Order by FAccttype
go
Select * From t_DataFlowProfile
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp  From t_DataFlowTimeStamp Where FName = 'DataFlow16415'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp  From t_DataFlowTimeStamp Where FName = 'DataFlow16415'
go
select t1.FTopClassID,t1.FTopClassName as FTopClassName_CHS, t1.FTopClassName_CHT, t1.FTopClassName_EN
,t1.FTopClassName As FTopClassName
,t1.FIndex,t1.FAcctType,t1.FVisible
 from t_UserTopClass t1 inner join (
    select FTopClassID,max(FuserID) FuserID from t_UserTopClass
    where FuserID in(16415,0) group by FTopClassID
) t2 on t1.FTopClassID=t2.FTopClassID and  t1.FuserID=t2.FuserID Order by t1.FIndex
go
select t1.FSubSysID,t1.FName as FName_CHS, t1.FName_CHT, t1.FName_EN
,t1.FName As FName
,t1.FTopClassID,t1.FIndex,t1.FAcctType,t1.FVisible
 from t_UserSubSystem t1 inner join (
    select FSubSysID,max(FuserID) FuserID from t_UserSubSystem
    where FuserID in(16415,0) group by FSubSysID
) t2 on t1.FSubSysID=t2.FSubSysID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FSubSysID
go
select t1.FSubFuncID,t1.FFuncName as FFuncName_CHS, FFuncName_CHT, FFuncName_EN
,t1.FFuncName As FFuncName
,t1.FSubSysID,t1.FIndex,t1.FVisible
 from t_UserSubFunc t1 inner join (
    select FSubFuncID,max(FuserID) FuserID from t_UserSubFunc
    where FuserID in(16415,0) group by FSubFuncID
) t2 on t1.FSubFuncID=t2.FSubFuncID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FSubFuncID
go
select t1.FDetailFuncID,t1.FFuncName as FFuncName_CHS, t1.FFuncName_CHT, t1.FFuncName_EN
,t1.FFuncName As FFuncName
,t1.FSubFuncID,t1.FIndex,t1.FClassName,t1.FClassParam,t1.FVisible,t1.FHelpCode,t1.FEnable
 from t_UserDetailFunc t1 inner join (
    select FdetailFuncID,max(FuserID) FuserID from t_UserDetailFunc
    where FuserID in(16415,0) group by FdetailFuncID
) t2 on t1.FdetailFuncID=t2.FdetailFuncID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FDetailFuncID
go
Select * From t_UserDataFlowProfile Where FUserID = 16415
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM t_DataFlowDetailFunc WHERE FSubFuncID = 600201
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM t_ItemClass WHERE FItemClassID <> 0 And FItemClassID<>11 And FItemClassID<>12 AND FType=1  ORDER BY FNumber
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Update t_UserDetailFunc SET FDetailFuncID = -FDetailFuncID WHERE FSubFuncID = 600201 AND FDetailFuncID < 1000000000 AND FUserID = 16415
go
Update t_NormalFunc Set FDetailFuncID=-FDetailFuncID where FUserID = 16415
go
delete from  t_UserDetailFunc where FDetailFuncID=60020108
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020108,600201,16415,'客户',' ',' ','BaseSys.Application','1',1,8,'49008')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '1' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020109
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020109,600201,16415,'部门',' ',' ','BaseSys.Application','2',1,9,'49009')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020110
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020110,600201,16415,'职员',' ',' ','BaseSys.Application','3',1,10,'49010')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020111
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020111,600201,16415,'物料',' ',' ','BaseSys.Application','4',1,11,'49011')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '4' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020112
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020112,600201,16415,'仓库',' ',' ','BaseSys.Application','5',1,12,'49012')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '5' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020113
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020113,600201,16415,'供应商',' ',' ','BaseSys.Application','8',1,13,'49013')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '8' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020114
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020114,600201,16415,'成本对象',' ',' ','BaseSys.Application','2001',1,14,'49014')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2001' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020116
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020116,600201,16415,'劳务',' ',' ','BaseSys.Application','2002',1,15,'49015')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2002' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020117
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020117,600201,16415,'成本项目',' ',' ','BaseSys.Application','2003',1,16,'49016')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2003' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020118
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020118,600201,16415,'要素费用',' ',' ','BaseSys.Application','2004',1,17,'49017')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2004' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020132
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020132,600201,16415,'基建',' ',' ','BaseSys.Application','3001',1,18,'I3001')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3001' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020142
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020142,600201,16415,'研发项目',' ',' ','BaseSys.Application','3009',1,19,'I3009')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3009' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020119
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020119,600201,16415,'费用',' ',' ','BaseSys.Application','2014',1,20,'49018')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2014' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020120
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020120,600201,16415,'计划项目',' ',' ','BaseSys.Application','2021',1,21,'49019')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2021' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020115
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020115,600201,16415,'成本对象组',' ',' ','BaseSys.Application','2023',1,22,'49020')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2023' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020123
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020123,600201,16415,'银行账号',' ',' ','BaseSys.Application','2024',1,23,'49021')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2024' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020127
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020127,600201,16415,'国别地区',' ',' ','BaseSys.Application','2026',1,24,'49022')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2026' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020128
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020128,600201,16415,'城市港口',' ',' ','BaseSys.Application','2027',1,25,'49023')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2027' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020129
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020129,600201,16415,'HS编码',' ',' ','BaseSys.Application','2028',1,26,'49024')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2028' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020130
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020130,600201,16415,'保险险种',' ',' ','BaseSys.Application','2029',1,27,'49025')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2029' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020131
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020131,600201,16415,'成本中心',' ',' ','BaseSys.Application','2030',1,28,'49026')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2030' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020134
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020134,600201,16415,'要素项目',' ',' ','BaseSys.Application','2035',1,29,'')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2035' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020135
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020135,600201,16415,'金融机构',' ',' ','BaseSys.Application','2036',1,30,'')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '2036' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020133
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020133,600201,16415,'出库用途',' ',' ','BaseSys.Application','3002',1,31,'I3002')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3002' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020121
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020121,600201,16415,'分支机构',' ',' ','BaseSys.Application','10',1,32,'49027')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '10' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020122
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020122,600201,16415,'工作中心',' ',' ','BaseSys.Application','14',1,33,'49028')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '14' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020140
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020140,600201,16415,'世界各国及地区区域划分标准',' ',' ','BaseSys.Application','3007',1,34,'I3007')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3007' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020124
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020124,600201,16415,'现金流量项目',' ',' ','BaseSys.Application','9',1,35,'49029')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '9' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020137
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020137,600201,16415,'单独权限设置',' ',' ','BaseSys.Application','3004',1,36,'I3004')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3004' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020136
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020136,600201,16415,'工序基本单价',' ',' ','BaseSys.Application','3003',1,37,'I3003')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3003' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020138
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020138,600201,16415,'工序顺序表',' ',' ','BaseSys.Application','3005',1,38,'I3005')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3005' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020139
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020139,600201,16415,'采购申请金额控制',' ',' ','BaseSys.Application','3006',1,39,'I3006')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3006' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020141
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020141,600201,16415,'交货地点对应价格类型',' ',' ','BaseSys.Application','3008',1,40,'I3008')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '3008' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
delete from  t_UserDetailFunc where FDetailFuncID=60020199
 Insert Into t_UserDetailFunc(FDetailFuncID,FSubFuncID,FUserID,FFuncName,FFuncName_CHT,FFuncName_EN,FClassName,FClassParam,FVisible,FIndex,FHelpCode) 
 Values(60020199,600201,16415,'辅助资料管理',' ',' ','BaseSys.Application','500',1,41,'49030')
Update t1 SET t1.FFuncName=t2.FFuncName,t1.FFuncName_CHT=t2.FFuncName_CHT,t1.FFuncName_EN=t2.FFuncName_EN 
FROM t_UserDetailFunc t1 INNER JOIN t_DataFlowDetailFunc t2 ON t1.FSubFuncID=t2.FSubFuncID AND t1.FClassParam=t2.FClassParam 
WHERE t1.FSubFuncID = 600201 and t1.FClassParam = '500' AND t1.FUserID=16415

go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
DELETE FROM t_DataFlowDetailFunc WHERE FDetailFuncID<0
DELETE FROM t_UserDetailFunc WHERE FDetailFuncID<0
go
Update t_NormalFunc Set FDetailFuncID=-FDetailFuncID where FDetailFuncID<0 and FUserID = 16415
go
delete t_NormalFunc where FDetailFuncID<0 and FUserID = 16415
go
UPDATE t_DataFlowTimeStamp SET FName = 'DataFlow16415' WHERE FName = 'DataFlow16415'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp as lngTimeStamp From t_DataFlowTimeStamp Where FName = 'DataFlow'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp  From t_DataFlowTimeStamp Where FName = 'DataFlow16415'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FTimeStamp  From t_DataFlowTimeStamp Where FName = 'DataFlow16415'
go
select t1.FTopClassID,t1.FTopClassName as FTopClassName_CHS, t1.FTopClassName_CHT, t1.FTopClassName_EN
,t1.FTopClassName As FTopClassName
,t1.FIndex,t1.FAcctType,t1.FVisible
 from t_UserTopClass t1 inner join (
    select FTopClassID,max(FuserID) FuserID from t_UserTopClass
    where FuserID in(16415,0) group by FTopClassID
) t2 on t1.FTopClassID=t2.FTopClassID and  t1.FuserID=t2.FuserID Order by t1.FIndex
go
select t1.FSubSysID,t1.FName as FName_CHS, t1.FName_CHT, t1.FName_EN
,t1.FName As FName
,t1.FTopClassID,t1.FIndex,t1.FAcctType,t1.FVisible
 from t_UserSubSystem t1 inner join (
    select FSubSysID,max(FuserID) FuserID from t_UserSubSystem
    where FuserID in(16415,0) group by FSubSysID
) t2 on t1.FSubSysID=t2.FSubSysID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FSubSysID
go
select t1.FSubFuncID,t1.FFuncName as FFuncName_CHS, FFuncName_CHT, FFuncName_EN
,t1.FFuncName As FFuncName
,t1.FSubSysID,t1.FIndex,t1.FVisible
 from t_UserSubFunc t1 inner join (
    select FSubFuncID,max(FuserID) FuserID from t_UserSubFunc
    where FuserID in(16415,0) group by FSubFuncID
) t2 on t1.FSubFuncID=t2.FSubFuncID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FSubFuncID
go
select t1.FDetailFuncID,t1.FFuncName as FFuncName_CHS, t1.FFuncName_CHT, t1.FFuncName_EN
,t1.FFuncName As FFuncName
,t1.FSubFuncID,t1.FIndex,t1.FClassName,t1.FClassParam,t1.FVisible,t1.FHelpCode,t1.FEnable
 from t_UserDetailFunc t1 inner join (
    select FdetailFuncID,max(FuserID) FuserID from t_UserDetailFunc
    where FuserID in(16415,0) group by FdetailFuncID
) t2 on t1.FdetailFuncID=t2.FdetailFuncID and  t1.FuserID=t2.FuserID Order by t1.FIndex,t1.FDetailFuncID
go
Select * From t_UserDataFlowProfile Where FUserID = 16415
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT COUNT(*) FROM T_LOG
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select t1.FEntryID,t1.FFileName,t1.FTargetPath,t1.FFileDateTime,t1.FComPackName,t2.FPackName 
 from ICClassPackEntry t1
 left join ICClassPack t2 on t1.FPackID=t2.FPackID
 where t1.FSetupType='SelfRegisted' and t2.FVersion = 'KUE_12.1.0'
 order by t1.ffiledatetime
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select t1.FEntryID,t1.FFileName,t1.FTargetPath,t1.FFileDateTime,t1.FComPackName,t2.FPackName 
 from ICClassPackEntry t1
 left join ICClassPack t2 on t1.FPackID=t2.FPackID
 where t1.FSetupType='VBR' and t2.FVersion = 'KUE_12.1.0'
 order by t1.ffiledatetime
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select t1.FEntryID,t1.FFileName,t1.FTargetPath,t1.FFileDateTime,t1.FComPackName,t2.FPackName 
 from ICClassPackEntry t1
 left join ICClassPack t2 on t1.FPackID=t2.FPackID
 where t1.FSetupType='COM' and t2.FVersion = '12.1.0'
 order by t1.ffiledatetime
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FSubSysID from t_DataFlowSubFunc where FSubFuncID=14510
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FCategory,FKey,FValue From t_SystemProfile Where FCategory In ('IC','Base') And FKey In ('AuditChoice','CurrentYear','CurrentPeriod','ICClosed','WorkCalendarSet','Time') Order By FCategory
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='AutoInPhaseWPDefSelf'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FTimeStamp FROM ICCLassType WHERE FID=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FTimestamp FROM ICClassType WHERE  FID=1002510
go
select FName_CHS as FName, * from ICClassType where FID=1002510
go
select FCanAlterBillNo from ICBillNo where FBillID=1002510
go
 SELECT FDescription_chs as FDescription,* 
 FROM ICClassTypeEntry
 WHERE FParentID=1002510
 ORDER BY FIndex 
go
SELECT t1.FFuncID,t1.FOpareteType,t2.FNumber,t2.FSubSysID 
 FROM ICClassMutex t1 inner join t_SysFunction t2 on t1.FFuncID=t2.FFuncID 
 WHERE t1.FClassTypeID=1002510
 ORDER BY FOpareteType 
go
select t1.FClassTypeID,t1.FLookUpClassID,t1.FMustInput,t1.FTableName,t1.FFieldName,t1.FSrcTableName,t1.FSrcTableNameAs,
t1.FSRCFieldName,t1.FDSPFieldName,t1.FDspColType,t1.FFNDFieldName,t1.FLookUpType 
from ICClassTableInfo t1,ICClassType t2 where t1.FClassTypeID=t2.FID and t2.FModel=0 and FLookUpClassID>0 
 union all 
select t1.FClassTypeID,t1.FLookUpClassID,t1.FMustInput,t1.FTableName,t1.FFieldName,t1.FSrcTableName,t1.FSrcTableNameAs,
t1.FSRCFieldName,t1.FDSPFieldName,t1.FDspColType,t1.FFNDFieldName,t1.FLookUpType 
from ICClassTableInfo_BASE t1,ICClassType_BASE t2 where t1.FClassTypeID=t2.FID and t2.FModel=0 and FLookUpClassID>0 
go
select isnull(t2.FAccessMask,8323072) as FAccessMask, t1.FCaption_CHS as FCaption
, t1.* from ICClassTableInfo as t1 Left Outer Join ICClassFieldRight as t2
 on t1.fkey=t2.fkey and t2.FUID = 16415
and t2.FClassTypeID=1002510where t1.FClassTypeID=1002510 ORDER BY FPage,FTabindex,FListIndex
go
select Distinct FPage from ICClassTableInfo where FClassTypeID=1002510 ORDER BY FPage 
go
SELECT FCaption_CHS as FCaption, *  FROM ICClassCtl WHERE FClassTypeID=1002510 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICCLASSACTIONLIST T1 LEFT OUTER JOIN ICCLASSACTION T2 ON (T1.FCLASSACTIONID=T2.FID) WHERE T1.FCLASSTYPEID=1002510 ORDER BY T1.FORDER
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * , FName_CHS as FName from ICClassLayout where FClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select 0 as FID,FFunctionID,FID as FClassTypeID,FName_CHS,FName_CHT,FName_EN,0 as FIsDefault, FName_CHS as FName from ICClassType where FID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FID,FClassTypeID,FKey,FTop,FLeft,FWidth,FHeight,FCaption_CHS,FCaption_CHT,FCaption_EN,FVisible,FEnable,FLock,FLayer,FFont,FFrameBorder,FFrameBorderColor,FLabelWidth,FLabelColor,FTextColor,FStyle,FPage,FTabIndex,FContainer,FMustInput,FCaption_chs AS FCaption, 0 as FLayoutID  from ICClassTableInfo where FClassTypeID = 1002510
go
select FID,FClassTypeID,FCaption_CHS,FCaption_CHT,FCaption_EN,FKey,FVisible,FEnable,FTop,FLeft,FWidth,FHeight,FTabIndex,FContainer,FBackStyle,FShape,FBorderColor,FBorderWidth,FBorderStyle,FFont,FForeColor,FTabs,FLayer,FBillEntry,FCtlType,FCaption_chs AS FCaption , 0 as FLayoutID from ICClassCtl where FClassTypeID = 1002510
go
select FCaption_chs AS FCaption , * from ICClassEntryEditorLayout where FClassTypeID = 1002510 and FLayoutID = 0
go
select distinct FEditorKey from ICClassEntryEditorLayout where FClassTypeID = 1002510 and FLayoutID = 0
go
select distinct FPage from ICClassTableInfo where FClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FLeft,FTop,FWidth,FHeight,FLayer,FTabIndex,FDescription_CHS,FDescription_CHT,FDescription_EN,FContainer,FDescription_CHS AS FDescription,0 as FLayoutID,FParentID as FClassTypeID,FIndex as FPage,0 as FID from ICClassTypeEntry where FParentID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FIsRun,FMaxLevel from ICClassMCFlowInfo where FID=1002510
go
 SELECT * FROM ICPrintMaxCount WHERE FID = 1002510
go
 SELECT DISTINCT FSRCClassIDKey FROM ICClassLink WHERE FDestClassTypeID = 1002510
go
select FKey, FLookUpClassID,u1.FTableName from ICClassTableInfo v1
 left join ICClassType u1 on v1.FLookUpClassID = u1.FID 
 where FClassTypeID = 1002510 and FLookUPType = 3 AND( ltrim(rtrim(FFilterGroup)) ='1' or ltrim(rtrim(FFilterGroup))='2') 

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT 0 as FStatus,FID,FClassTypeID,FCode,FName_CHS,FName_CHT,FName_EN,FDescriptions_CHS,FDescriptions_CHT,FDescriptions_EN,FEnvironment,FRightMask,FRightUseMask,FRightGroupMask,FRightControl,FAddLog,FIsPredefine,FIsFirst,FShortCut,FIconFile,FListActionCirculation,FOperationType,FName_CHS as FName,FDescriptions_CHS as FDescriptions
 FROM ICClassBillAction
 Where FClassTypeID = 1002510
 ORDER BY FID 
go
Select 0 as FStatus, * from ICClassActionMessage where FClassTypeID = 1002510
go
Select * from ICClassMessage  Where FID in (Select FMessageID from ICClassActionMessage a left join ICClassBillAction b on a.FActionID = b.FID  where b.FClassTypeID = 1002510)
go
Select a.*,b.FName from ICClassMessageUser a left join t_User b on a.FUserID = b.FUserID  Where a.FMessageID in (Select FMessageID from ICClassActionMessage where FClassTypeID = 1002510)
go
Select a.*,b.FCaption_CHS as FName from ICClassMessageUserVar a left join ICClassTableInfo b on a.FUserKey = b.FKey 
 Where (b.FClassTypeID = 1002510 or a.fuserkey like '$$$.%') AND a.FMessageID in (Select FMessageID from ICClassActionMessage Where FClassTypeID = 1002510)
go
Select * from ICClassActionPosition where FClassTypeID = 1002510
go
Select FIcon from ICClassBillAction Where FID = 10352
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICCLASSACTIONLIST T1 LEFT OUTER JOIN ICCLASSACTION T2 ON (T1.FCLASSACTIONID=T2.FID) WHERE T1.FCLASSTYPEID=1002510 ORDER BY T1.FORDER
go
Select FIcon from ICClassBillAction Where FID = 10353
go
Select FIcon from ICClassBillAction Where FID = 10354
go
Select FIcon from ICClassBillAction Where FID = 10355
go
Select FIcon from ICClassBillAction Where FID = 10356
go
Select FIcon from ICClassBillAction Where FID = 10357
go
Select FIcon from ICClassBillAction Where FID = 10358
go
Select FIcon from ICClassBillAction Where FID = 10359
go
Select FIcon from ICClassBillAction Where FID = 10360
go
Select FIcon from ICClassBillAction Where FID = 10361
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * ,FName_CHS as FName,FDescriptions_CHS as FDescriptions
 FROM ICClassPredefineAction
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICCLASSACTIONLIST T1 LEFT OUTER JOIN ICCLASSACTION T2 ON (T1.FCLASSACTIONID=T2.FID) WHERE T1.FCLASSTYPEID=1002510 ORDER BY T1.FORDER
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT *, FCaption_CHS as FCaption
 FROM ICClassConsts
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICBillNo WHERE FBillID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT t1.FSourClassTypeID as FClassID ,t2.FName_CHS as FName,  FAllowCopy,FAllowCheck,FAllowForceCheck, t1.FRemark, t1.FFlowControl,t1.FUseSpec 
 , T3.FKey As FSRCIDKey, T3.FCaption_CHS as FCaption
 FROM ICClassLink t1 left join ICClassType t2 on t1.FSourClassTypeID=t2.FID
 Left Join ICClassTableInfo t3 on t1.FDestClassTypeID = t3.FClassTypeID and t1.FSRCIDKey = t3.FKey
 where t1.FDestClassTypeID=1002510 and t1.FIsUsed=2 And t1.FSourClassTypeID in (Select FSourClassTypeID from ICClassLinkEntry where FDestClassTypeID = 1002510) AND t1.FUnControl & 2 = 2
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='AutoInPhaseWPDefSelf'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FValue FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='SourceBillType1002510' AND FType='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FValue FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='ReportType1002510' AND FType='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select Distinct t1.FID as ClassTypeID,t1.FName as FName,t1.FTemplateID as FBillTemplateID,
 t1.FHeadTable,t1.FEntryTable,t2.FID as FListTemplateID,t2.FLinkPrimary 
 from ICTransactionType t1 inner join ICListTemplate t2 
 on t1.FID = t2.FBillTemplateID where t1.FID = '52'
 Order by FLinkPrimary Desc 
go
Select Distinct t2.FTableName,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52
 and (t2.FTableName = 'SHWorkBill'
 or t2.FTableName = 'SHWorkBillEntry')
go
 SELECT FObjectType, FObjectID FROM ICTransactionType WHERE FID = 52
go
Select Distinct t2.FName,t2.FTableName,t2.FTableAlias,t2.FIsPrimary,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52 and t2.FISPrimary in (1,2,3) order by FISPrimary
go
Select FCtlType,FFieldName from ICTemplate where FCtlType = 4 and FID = 'Z03'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =-52 and FDestClassTypeID=1002510 and FIsUsed=2
go
select distinct FSourPage,FDestPage from ICClassLinkEntry where FSourClassTypeID =-52 and FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex,t3.FTabIndex as FSourTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID  
 inner join ICClassTableInfo t3 ON t1.FSourFKey=t3.FKey AND t1.FSourClassTypeID=t3.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND FSourFKey like '%.%' 

go
select FPage,FKey,FSRCTableName,FSRCTableNameAs,FSRCFieldName,FDspFieldName,FFNDFieldName from ICClassTableInfo where FClasstypeID = -52  and FSRCTableNameAs <>'' and FCtlType = 1 and FSourceType=1 and FKeyWord = ''

go
SELECT * FROM ICClassLinkEntry WHERE FSourClassTypeID = -52 AND FDestClassTypeID = 1002510 AND FAfterFormula <>''
go
 SELECT T1.*, T2.FDestFKey, T2.FRedNeg FROM ICClassLinkCommit T1 
 INNER JOIN ICClassLinkEntry T2 ON 
 T1.FSrcClsTypID = T2.FSourClassTypeID AND T1.FDstClsTypID = T2.FDestClassTypeID  AND T1.FCheckKey = T2.FSourFKey AND T2.FIsCheck >= 0 
 WHERE T1.FSrcClsTypID = -52 AND T1.FDstClsTypID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FObjectType,FObjectID FROM ICTransactionType WHERE FID=52
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select * from t_Components where FComponent='K3List.clsListSheet'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='RefreshAfterAdd'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='StdCost' AND FKey='StdCostStart'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
UPDATE ICChatBillTitle SET FVisible=3,FVisForQuest=1,FVisForOrder=1 WHERE FTypeID=601 AND FColName='FPieceRate'
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FCategory,FKey,FValue FROM t_SystemProfile 
WHERE FCategory='IC' AND FKey IN ('StartBranchSale','ShowRelationSign','AuditChoice','PrecisionOfDiscountRate',
'StartPeriod','ListMaxRows','')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FTemplateID,FName As FName ,FFilter from ICListTemplate Where FID=601
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
Select FID,FName As FName ,FTemplateID,FFontID,FLogicStr,FToolBarVis,FHeadVis,FBottomVis,FSourceType,FSourceSql,FGroupID,FBillTemplateID,FNeedCount,FHeadHeight,FBottomHeight,FType,FGetDataType,FMenuID,FBillCls,FFilter,FRptTemplateID,FMasterTable,FNeedStatistic From ICListtemplate  Where FID in (601)
go
Select FInterID,FTypeID,FColCaption as FColCaption_CHS,FColCaption As FColCaption ,FHeadSecond,FColName,FTableName,FColType, FColWidth,FVisible,FItemClassID,FVisForQuest,FReturnDataType,FCountPriceType, FCtlIndex,Case When FColName = 'FSourceTranType' Then 'FName' Else FName End As FName,FTableAlias,FAction,FNeedCount,FIsPrimary,FLogicAction,FStatistical,FMergeable,FVisForOrder,FControl,FMode,FControlType,FEditable,FFormat,FFormatType,FAlign,FMustSelected
FROM ICChatBillTitle Where FTypeID IN (select FTemplateID From ICListtemplate  Where FID in (601)) order by FInterID
go
Select * from ICTableRelation where  FIndex=0 AND FTypeID IN (select FTemplateID From ICListtemplate Where FID in (601)) order by FInterID
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='StartBranchSale'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ShowRelationSign'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT V2.FValue FROM ICListTemplate U1
INNER  JOIN ICSchemeProfile V1 ON U1.FID = V1.FTranType AND FUserID = 16415
INNER  JOIN ICSchemeProfileEntry V2 ON V1.FSchemeID = V2.FSchemeID AND Fkey = 'HideColumns' WHERE U1.FTemplateID = 601
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FValue From t_SystemProfile Where  FCategory='IC' and FKey='EnableMtoPlanMode'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
select t_User.FUserID from t_Group, t_User 
 where t_Group.FUserID = t_User.FUserID 
 And t_User.FUserID = 16415and t_Group.FGroupID = 1 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
 Select FValue From t_Systemprofile Where FCategory = 'IC' and FKey='CheckUserGroup' 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601' AND FKey='UserLastProfile'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where FSection='QUICKSEARCH_601'AND FKey='DefaultProfile' AND FUserID=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where fSection='QUICKSEARCH_601'  and Fkey='DefaultField' and FuserId=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM ICSystemProfile WHERE FID=0 AND FKey='ShowAllBillHead' AND FCategory='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='PrecisionOfDiscountRate'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SInvoiceDecimal'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FAutoTD as FAutoTDID,u1.FEntryID as FEntryID_Number,u1.FWBInterID as FBillInterID,u1.FWorkBillNo as FBillNo,u1.FStatus as FStatus,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FEntryID as FEntryID,v1.FDate as FDate,v1.FICMOInterID as FICMOInterID, 0 As FBOSCloseFlag from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND  (u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
select t1.*,t2.FName as FFontName,t2.FColor,t2.FBold,t2.FItalic,t2.FSize from ICListTitle t1,ICFont t2 where t1.FFontID=t2.FID AND t1.FID=601 AND FType=0 order by FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FToolID,FName,FCaption,FCaption_CHT,FCaption_EN,FImageName,FToolTip_CHT,FToolTip,FToolTip_EN,FControlType,FBeginGroup,FVisible,FEnable,FChecked,FShortCut,FShortChar,FCBList,FCBList_CHT,FCBList_EN,FCBStyle,FBandID,FSubBandID,FSubBandName,FCBWidth,FBandName,FType,FBandVisible,FBandCaption,FBandCaption_CHT,FBandCaption_EN,FStyle,FComName,FToolCaption,FToolCaption_CHT,FToolCaption_EN from v_tools where FMenuGroupID = 90 order by FBandID,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='DisplayQuickSearch'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='SearchInScheme'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='ViewUnionQuery'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='UnionQueryCtlHeight'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
Select FValue From t_Systemprofile where  FCategory = 'IC' and FKey = 'EnableATP' 
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from t_SubMesType where FTypeID = 62
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FIsNeedOffline FROM T_OfflineInfo  WHERE FUserID = 16415 AND FWorkStation = 'XUYAOYAO'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
SELECT FValue FROM T_SystemProfile  WHERE FKey='NeedOfflineQuery' and FCategory='LX'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT Distinct FTypeID, FName FROM t_SubMesType  ORDER BY FTypeID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT Distinct FTypeID, FName FROM t_SubMesType  ORDER BY FTypeID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT  FTypeID,FInterID FItemID, FID FNumber,FName,FSpec FROM t_SubMessage Where FInterID>0 AND FDeleted=0  And FTypeID=62 ORDER BY FID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT Distinct FTypeID, FName FROM t_SubMesType  ORDER BY FTypeID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT Distinct FTypeID, FName FROM t_SubMesType  ORDER BY FTypeID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT  FTypeID,FInterID FItemID, FID FNumber,FName,FSpec FROM t_SubMessage Where FInterID>0 AND FDeleted=0  And FTypeID=62 ORDER BY FID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=745728 and u1.FEntryID=9) or (u1.FInterID=745728 and u1.FEntryID=10) or (u1.FInterID=836448 and u1.FEntryID=1) or (u1.FInterID=1410892 and u1.FEntryID=6) or (u1.FInterID=1410892 and u1.FEntryID=7) or (u1.FInterID=1410892 and u1.FEntryID=8) or (u1.FInterID=1410892 and u1.FEntryID=9) or (u1.FInterID=1467455 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=2) or (u1.FInterID=1808052 and u1.FEntryID=3) or (u1.FInterID=1808106 and u1.FEntryID=1) or (u1.FInterID=1808106 and u1.FEntryID=2) or (u1.FInterID=1808106 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=1) or (u1.FInterID=2604708 and u1.FEntryID=2) or (u1.FInterID=2604708 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=4) or (u1.FInterID=2604763 and u1.FEntryID=1) or (u1.FInterID=2604763 and u1.FEntryID=2) or (u1.FInterID=2604763 and u1.FEntryID=3) or (u1.FInterID=2604763 and u1.FEntryID=4) or (u1.FInterID=2604818 and u1.FEntryID=1) or (u1.FInterID=2604818 and u1.FEntryID=2) or (u1.FInterID=2604818 and u1.FEntryID=3) or (u1.FInterID=2604818 and u1.FEntryID=4) or (u1.FInterID=2604873 and u1.FEntryID=1) or (u1.FInterID=2604873 and u1.FEntryID=2) or (u1.FInterID=2604873 and u1.FEntryID=3) or (u1.FInterID=2604873 and u1.FEntryID=4) or (u1.FInterID=2655791 and u1.FEntryID=10) or (u1.FInterID=2670010 and u1.FEntryID=1) or (u1.FInterID=2670010 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=1) or (u1.FInterID=2829687 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=3) or (u1.FInterID=2829687 and u1.FEntryID=4) or (u1.FInterID=2829687 and u1.FEntryID=5) or (u1.FInterID=2829743 and u1.FEntryID=1) or (u1.FInterID=2829743 and u1.FEntryID=2) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=2829743 and u1.FEntryID=3) or (u1.FInterID=2829743 and u1.FEntryID=4) or (u1.FInterID=2829743 and u1.FEntryID=5) or (u1.FInterID=2829799 and u1.FEntryID=1) or (u1.FInterID=2829799 and u1.FEntryID=2) or (u1.FInterID=2829799 and u1.FEntryID=3) or (u1.FInterID=2829799 and u1.FEntryID=4) or (u1.FInterID=2829799 and u1.FEntryID=5) or (u1.FInterID=2829855 and u1.FEntryID=1) or (u1.FInterID=2829855 and u1.FEntryID=2) or (u1.FInterID=2829855 and u1.FEntryID=3) or (u1.FInterID=2829855 and u1.FEntryID=4) or (u1.FInterID=2829855 and u1.FEntryID=5) or (u1.FInterID=2829911 and u1.FEntryID=1) or (u1.FInterID=2829911 and u1.FEntryID=2) or (u1.FInterID=2829911 and u1.FEntryID=3) or (u1.FInterID=2829965 and u1.FEntryID=1) or (u1.FInterID=2829965 and u1.FEntryID=2) or (u1.FInterID=2829965 and u1.FEntryID=3) or (u1.FInterID=2830019 and u1.FEntryID=1) or (u1.FInterID=2830019 and u1.FEntryID=2) or (u1.FInterID=2830019 and u1.FEntryID=3) or (u1.FInterID=2830073 and u1.FEntryID=1) or (u1.FInterID=2830073 and u1.FEntryID=2) or (u1.FInterID=2830073 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=2) or (u1.FInterID=2839759 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=4) or (u1.FInterID=2839759 and u1.FEntryID=5) or (u1.FInterID=2839815 and u1.FEntryID=2) or (u1.FInterID=2839815 and u1.FEntryID=3) or (u1.FInterID=2839815 and u1.FEntryID=4) or (u1.FInterID=2839815 and u1.FEntryID=5) or (u1.FInterID=2839983 and u1.FEntryID=2) or (u1.FInterID=2839983 and u1.FEntryID=3) or (u1.FInterID=2839983 and u1.FEntryID=4) or (u1.FInterID=2839983 and u1.FEntryID=5) or (u1.FInterID=2840039 and u1.FEntryID=2) or (u1.FInterID=2840039 and u1.FEntryID=3) or (u1.FInterID=2840039 and u1.FEntryID=4) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SaveListColWidth'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select u1.FWBInterID,
u1.FEntryID,
u1.FWorkBillNo,
v1.FICMONO As FICMONO,
v1.FICMOinterID As FICMOinterID,
v1.FGMPBatchNo As FGMPBatchNo,
v1.FUnitID As FUnitID,
t_Measureunit.FName As FUnitID_DSPName,
t_Measureunit.FNumber As FUnitID_FNDName,
v1.FCoefficient As FCoefficient,
v1.FItemID As FItemID,
t_ICItem.FTrack As FItemID_Track,
t_ICItem.FBatchManager As FItemID_BatchNoManage,
t_ICItem.FQtyDecimal As FItemID_FQtyDecimal,
t_ICItem.FPriceDecimal As FItemID_FPriceDecimal,
t_ICItem.FUnitGroupID As FItemID_UnitGroupID,
t_ICItem.FISKFPeriod As FItemID_FISKFPeriod,
t_ICItem.FNumber As FItemID_DSPName,
t_ICItem.FNumber As FItemID_FNDName,
v1.FOrderBillNo As FOrderBillNo,
v1.FOrderEntryID As FOrderEntryID,
v1.FMTONo As FMTONo,
v1.FOrderInterID As FOrderInterID,
u1.FWorkBillNO As FWorkBillNO,
u1.FWBInterID As FWBInterID,
u1.FTeamID As FTeamID,
t_SubMessage.FName As FTeamID_DSPName,
t_SubMessage.FID As FTeamID_FNDName,
u1.FWorkerID As FWorkerID,
t_Emp.FName As FWorkerID_DSPName,
t_Emp.FNumber As FWorkerID_FNDName,
u1.FDeviceID As FDeviceID,
vw_Device_Resource.FName As FDeviceID_DSPName,
vw_Device_Resource.FNumber As FDeviceID_FNDName,
u1.FConversion As FConversion,
u1.FOperID As FOperID,
u1.FWorkCenterID As FWorkCenterID,
u1.FAutoTD As FAutoTD,
t_SubMessage1.FName As FAutoTD_DSPName,
t_SubMessage1.FID As FAutoTD_FNDName,
u1.FQualityChkID As FQualityChkID,
u1.FAutoOF As FAutoOF,
t_SubMessage2.FName As FAutoOF_DSPName,
t_SubMessage2.FID As FAutoOF_FNDName,
u1.FTimeUnit As FTimeUnit,
t_SubMessage3.FName As FTimeUnit_DSPName,
t_SubMessage3.FID As FTimeUnit_FNDName,
u1.FTimeSetup As FTimeSetup,
u1.FWorkQty As FWorkQty,
u1.FTimeRun As FTimeRun,
u1.FTotalWorkTime As FTotalWorkTime,
u1.FOperSN As FOperSN,
u1.FOperID As FOperID2,
t_SubMessage4.FID As FOperID2_DSPName,
t_SubMessage4.FID As FOperID2_FNDName,
u1.FWorkCenterID As FWorkCenterID2,
t_WorkCenter.FNumber As FWorkCenterID2_DSPName,
t_WorkCenter.FNumber As FWorkCenterID2_FNDName
 From SHWorkBill AS v1 Inner Join SHWorkBillEntry AS u1 On v1.FInterID = u1.FInterID LEFT  JOIN t_Measureunit  ON v1.FUnitID=t_Measureunit.FItemID AND t_Measureunit.FItemID<>0
 LEFT  JOIN t_ICItem  ON v1.FItemID=t_ICItem.FItemID AND t_ICItem.FItemID<>0
 LEFT  JOIN t_SubMessage  ON u1.FTeamID=t_SubMessage.FInterID AND t_SubMessage.FInterID<>0
 LEFT  JOIN t_Emp  ON u1.FWorkerID=t_Emp.FItemID AND t_Emp.FItemID<>0
 LEFT  JOIN vw_Device_Resource  ON u1.FDeviceID=vw_Device_Resource.FID AND vw_Device_Resource.FID<>0
 LEFT  JOIN t_SubMessage t_SubMessage1 ON u1.FAutoTD=t_SubMessage1.FInterID AND t_SubMessage1.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage2 ON u1.FAutoOF=t_SubMessage2.FInterID AND t_SubMessage2.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage3 ON u1.FTimeUnit=t_SubMessage3.FInterID AND t_SubMessage3.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage4 ON u1.FOperID=t_SubMessage4.FInterID AND t_SubMessage4.FInterID<>0
 LEFT  JOIN t_WorkCenter  ON u1.FWorkCenterID=t_WorkCenter.FItemID AND t_WorkCenter.FItemID<>0
 Where  (  ( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  )  )  AND  ( (u1.FWBInterID=745738 AND u1.FEntryID=10) )  ORDER BY u1.FWBInterID, u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_ICItem WHERE  t_ICItem.FItemID = 220520
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_SubMessage WHERE  t_SubMessage.FInterID = 40146
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_WorkCenter WHERE  t_WorkCenter.FItemID = 216915
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT ISNULL(FAuxQtyPlan - FAuxQtyFinish ,0) as FAuxQty,FWBInterID  FROM SHWorkBillEntry  
 WHERE 1=2  OR FWBInterID =745738
 OR FWBInterID =0

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =0 and FDestClassTypeID=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =0 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FCapacityCalType from t_workcenter where FItemID=216915

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill')
 UPDATE  ICClassUserProfile SET FValue='mnuSelectOldBill_52' WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1002510','SelBill','mnuSelectOldBill_52')
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FFieldName,FValueType From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1 and FMustInput=1 and FNeedSave=1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue from t_SystemProfile Where FCategory='SH' and FKey='ShopConversionManage'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FID,FItemID As FOperatorID FROM ICOperGroupEntry
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT 0 FROM PPBOM WHERE FStatus = 0 AND FICMOInterID = 380199 AND 0 = (SELECT FValue FROM t_SystemProfile WHERE FKey = 'AllowSaveProcRptPPBOMNotChcek' AND FCategory = 'SH')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT T1.FKey,T1.FValue
  FROM ICSHOP_SCProfile T1
 WHERE T1.FCategory = 'SH' AND (T1.FValue & 2) > 0 
        AND T1.FKey IN('SH_RptBeginDatePrevICMOReleasingDate'
                      ,'SH_CumulativeProducedQtyOverPlannedProductionQty'
                      ,'SH_CumulativeProducedQtyOverCumulativeReceivedQty'
                      ,'SH_OperRptZeroAllQty'
                      ,'SH_OperRptZeroAllOperTime'
                      ,'SH_CumulativeProducedQtyDifference'
                      )


go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_RuleCheck'))
    DROP TABLE #TEMP_RuleCheck
CREATE TABLE #TEMP_RuleCheck(FInterID INT IDENTITY(1,1),FRptInterID INT DEFAULT 0,FRptBillNo VARCHAR(255),FEntryID INT,FWBInterID INT,FWBBillNo VARCHAR(255),FICMOInterID INT,FICMOBillNo VARCHAR(255)
                            ,FRule1 INT DEFAULT 0,FRptBeginDate DATETIME,FICMOCheckDate DATETIME
                            ,FRule2 INT DEFAULT 0,FRptSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOPlanQty DECIMAL(28,10) DEFAULT 0
                            ,FRule3 INT DEFAULT 0,FOperSN INT,FOperName VARCHAR(255),FWBSumAuxQtyRecive DECIMAL(28,10) DEFAULT 0
                            ,FRule4 INT DEFAULT 0,FRptSumAllZero DECIMAL(28,10)
                            ,FRule5 INT DEFAULT 0,FRptTimeAllZero DECIMAL(28,10)
                            ,FRule6 INT DEFAULT 0,FRptAuxQtyFinishALLRow DECIMAL(28,10) DEFAULT 0,FRptAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FRptSumQtyOther DECIMAL(28,10) DEFAULT 0
                            ,FIsFirst INT DEFAULT 0 ,FIsOut INT DEFAULT 1059)

INSERT INTO #TEMP_RuleCheck(FRptInterID,FRptBillNo,FEntryID,FWBInterID,FWBBillNo,FICMOInterID,FICMOBillNo
                           ,FRptBeginDate,FRptSumAllZero,FRptTimeAllZero
                           ,FRptAuxQtyFinishALLRow,FRptAuxQtyFinish,FRptSumQtyOther)
VALUES(0,'',1,745738,'WB081657',380199,'SC1503-562',
         '2017-01-09 08:55:47',22,0,
         11,11,11
      )

UPDATE T1 set T1.FIsFirst=1,T1.FIsOut=T5.FIsOut from #TEMP_RuleCheck T1 inner join (select t3.FWBInterID ,t3.FISOut as FISOut from SHWorkBillEntry t3
inner join
(select t1.finterid,min(t1.FOperSN) as FMinOperSN from SHWorkBillEntry t1 inner join (select FInterID from SHWorkBillEntry where FWBInterID=745738
) t2 on t1.finterid=t2.finterid group by t1.finterid) t4 on t3.finterid=t4.finterid and t3.FOperSN=t4.FMinOperSN) T5 on T1.FWBInterID=T5.FWBInterID
UPDATE T1
   SET T1.FOperSN = T2.FOperSN
      ,T1.FOperName = T4.FName
      ,T1.FWBSumAuxQtyRecive = T2.FAuxQtyRecive
      ,T1.FRptSumAuxQtyFinish = T1.FRptAuxQtyFinishALLRow + T2.FAuxQtyFinish
      ,T1.FICMOPlanQty = T3.FAuxQty
      ,T1.FICMOCheckDate = T3.FCommitDate
      ,T1.FWBBillNo = T2.FWorkBillNO
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN t_SubMessage T4 ON T2.FOperID = T4.FInterID AND T4.FTypeID = 61
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FRptSumAuxQtyFinish = T1.FRptSumAuxQtyFinish - (SELECT SUM(T3.FAuxQtyfinish) FROM SHProcRpt T3 WHERE T3.FinterID = T1.FRptInterID)
  FROM #TEMP_RuleCheck T1
 WHERE T1.FRptInterID > 0

UPDATE T1
   SET T1.FRule1 = CASE WHEN T1.FRptBeginDate < T1.FICMOCheckDate THEN 1 ELSE T1.FRule1 END
      ,T1.FRule2 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FICMOPlanQty THEN 1 ELSE T1.FRule2 END
      ,T1.FRule3 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FWBSumAuxQtyRecive THEN 1 ELSE T1.FRule3 END
      ,T1.FRule4 = CASE WHEN T1.FRptSumAllZero = 0 THEN 1 ELSE T1.FRule4 END
      ,T1.FRule5 = CASE WHEN T1.FRptTimeAllZero = 0 THEN 1 ELSE T1.FRule5 END
      ,T1.FRule6 = CASE WHEN T1.FRptAuxQtyFinish <> T1.FRptSumQtyOther THEN 1 ELSE 0 END
  FROM #TEMP_RuleCheck T1 

--规则6:只处理免检的工序
UPDATE T1
   SET T1.FRule6 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE T2.FQualityChkID <> 352 AND T1.FRule6 = 1

--返修工序汇报不校验规则3：累计实作数量大于累计接收数量
UPDATE T1
   SET T1.FRule3 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
             INNER JOIN SHWorkBill T3 ON T2.FInterID = T3.FInterID
 WHERE T3.FBillType <> 11620 AND T1.FRule3 = 1

SELECT T1.*
  FROM #TEMP_RuleCheck T1

DROP TABLE #TEMP_RuleCheck

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FQualityChkID INT DEFAULT 0,FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FWBInterID INT,FWBBillNo VARCHAR(255),FIsLastOper INT DEFAULT 0,FWBSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FWBSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOInterID INT,FICMONo VARCHAR(255) DEFAULT '',FICMOAuxInHighLimitQty DECIMAL(28,10) DEFAULT 0)

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FSumAuxQtyFinish,FWBInterID,FICMOInterID)
VALUES(0,'1',11,11,745738,380199)

UPDATE T1
   SET T1.FWBSumAuxQtyPass = T2.FAuxQtyPass + T2.FAuxQualifiedReprocessedQty
      ,T1.FWBSumAuxQtyFinish = T2.FAuxQtyFinish
      ,T1.FWBBillNo = T2.FWorkBillNO
      ,T1.FQualityChkID = T2.FQualityChkID
      ,T1.FICMOAuxInHighLimitQty = T3.FAuxInHighLimitQty
      ,T1.FICMONo = T3.FBillNo
  FROM  #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FIsLastOper = 1
  FROM #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE NOT EXISTS(SELECT 1 FROM SHWorkBillEntry T3 WHERE T3.FinterID = T2.FinterID AND T3.FOperSN > T2.FOperSN)

SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID = 352 AND (T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass ) > T1.FICMOAuxInHighLimitQty
     UNION
SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID <> 352 AND (T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) > T1.FICMOAuxInHighLimitQty

DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FinterID INT,FWBInterID INT,FOperSN INT,FOperID INT,FNumber VARCHAR(30),FName VARCHAR(80))

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FinterID,FWBInterID,FOperSN,FOperID,FNumber,FName)
SELECT 0 AS FRptInterID,'1' AS FRptBillNo,11 AS FSumAuxQtyPass,T2.FinterID,T2.FWBInterID,T2.FOperSN,T2.FOperID,T3.FID AS FNumber,T3.FName
  FROM SHWorkBillEntry T2 INNER JOIN t_SubMessage T3 ON T2.FOperID = T3.FInterID AND T3.FTypeID = 61
 WHERE T2.FQualityChkID = 352 AND T3.FInterID>0 AND T3.FDeleted=0 AND T2.FWBInterID = 745738

IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#RESULT'))
    DROP TABLE #RESULT
CREATE TABLE #RESULT(FInterID INT,FWBInterID INT,FOperSN INT,FSumQty DECIMAL(28,10) DEFAULT 0,FWBInterIDPrev INT,FOperSNPrev INT,FSumQtyPrev DECIMAL(28,10) DEFAULT 0)
INSERT INTO #RESULT(FInterID,FWBInterID,FOperSN,FOperSNPrev)
    SELECT V1.FinterID,V1.FWBInterID,V1.FOperSN,MAX(V2.FOperSN) AS FOperSNPrev
    FROM (SELECT DISTINCT FinterID,FWBInterID,FOperSN FROM #TEMP_WB) V1 LEFT JOIN SHWorkBillEntry V2 ON V1.FinterID = V2.FinterID AND V1.FOperSN > V2.FOperSN
    WHERE V2.FWBInterID IS NOT NULL
    GROUP BY V1.FinterID,V1.FWBInterID,V1.FOperSN

UPDATE V1
   SET V1.FSumQty = V2.FAuxQtyPass + V2.FAuxQualifiedReprocessedQty
      ,V1.FWBInterIDPrev = V3.FWBInterID
      ,V1.FSumQtyPrev = V3.FAuxQtyPass + V3.FAuxQualifiedReprocessedQty
  FROM #RESULT V1 INNER JOIN SHWorkBillEntry V2 ON V1.FInterID = V2.FinterID AND V1.FWBInterID = V2.FWBInterID
                  INNER JOIN SHWorkBillEntry V3 ON V1.FInterID = V3.FinterID AND V1.FOperSNPrev = V3.FOperSN

UPDATE V2
   SET V2.FSumQty = V2.FSumQty + V1.FSumAuxQtyPass
  FROM (SELECT FInterID,FWBInterID,ISNULL(SUM(FSumAuxQtyPass),0) AS FSumAuxQtyPass FROM #TEMP_WB GROUP BY FInterID,FWBInterID) V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID

SELECT V1.FRptInterID,V1.FRptBillNo,V1.FName AS FOperName,V2.FSumQty,V2.FSumQtyPrev
  FROM #TEMP_WB V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID
 WHERE V2.FSumQty > V2.FSumQtyPrev

DROP TABLE #RESULT
DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FFieldName,FValueType From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1 and FMustInput=1 and FNeedSave=1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue from t_SystemProfile Where FCategory='SH' and FKey='ShopConversionManage'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FID,FItemID As FOperatorID FROM ICOperGroupEntry
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT 0 FROM PPBOM WHERE FStatus = 0 AND FICMOInterID = 380199 AND 0 = (SELECT FValue FROM t_SystemProfile WHERE FKey = 'AllowSaveProcRptPPBOMNotChcek' AND FCategory = 'SH')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT T1.FKey,T1.FValue
  FROM ICSHOP_SCProfile T1
 WHERE T1.FCategory = 'SH' AND (T1.FValue & 2) > 0 
        AND T1.FKey IN('SH_RptBeginDatePrevICMOReleasingDate'
                      ,'SH_CumulativeProducedQtyOverPlannedProductionQty'
                      ,'SH_CumulativeProducedQtyOverCumulativeReceivedQty'
                      ,'SH_OperRptZeroAllQty'
                      ,'SH_OperRptZeroAllOperTime'
                      ,'SH_CumulativeProducedQtyDifference'
                      )


go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_RuleCheck'))
    DROP TABLE #TEMP_RuleCheck
CREATE TABLE #TEMP_RuleCheck(FInterID INT IDENTITY(1,1),FRptInterID INT DEFAULT 0,FRptBillNo VARCHAR(255),FEntryID INT,FWBInterID INT,FWBBillNo VARCHAR(255),FICMOInterID INT,FICMOBillNo VARCHAR(255)
                            ,FRule1 INT DEFAULT 0,FRptBeginDate DATETIME,FICMOCheckDate DATETIME
                            ,FRule2 INT DEFAULT 0,FRptSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOPlanQty DECIMAL(28,10) DEFAULT 0
                            ,FRule3 INT DEFAULT 0,FOperSN INT,FOperName VARCHAR(255),FWBSumAuxQtyRecive DECIMAL(28,10) DEFAULT 0
                            ,FRule4 INT DEFAULT 0,FRptSumAllZero DECIMAL(28,10)
                            ,FRule5 INT DEFAULT 0,FRptTimeAllZero DECIMAL(28,10)
                            ,FRule6 INT DEFAULT 0,FRptAuxQtyFinishALLRow DECIMAL(28,10) DEFAULT 0,FRptAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FRptSumQtyOther DECIMAL(28,10) DEFAULT 0
                            ,FIsFirst INT DEFAULT 0 ,FIsOut INT DEFAULT 1059)

INSERT INTO #TEMP_RuleCheck(FRptInterID,FRptBillNo,FEntryID,FWBInterID,FWBBillNo,FICMOInterID,FICMOBillNo
                           ,FRptBeginDate,FRptSumAllZero,FRptTimeAllZero
                           ,FRptAuxQtyFinishALLRow,FRptAuxQtyFinish,FRptSumQtyOther)
VALUES(0,'',1,745738,'WB081657',380199,'SC1503-562',
         '2017-01-09 08:55:47',6,0,
         3,3,3
      )

UPDATE T1 set T1.FIsFirst=1,T1.FIsOut=T5.FIsOut from #TEMP_RuleCheck T1 inner join (select t3.FWBInterID ,t3.FISOut as FISOut from SHWorkBillEntry t3
inner join
(select t1.finterid,min(t1.FOperSN) as FMinOperSN from SHWorkBillEntry t1 inner join (select FInterID from SHWorkBillEntry where FWBInterID=745738
) t2 on t1.finterid=t2.finterid group by t1.finterid) t4 on t3.finterid=t4.finterid and t3.FOperSN=t4.FMinOperSN) T5 on T1.FWBInterID=T5.FWBInterID
UPDATE T1
   SET T1.FOperSN = T2.FOperSN
      ,T1.FOperName = T4.FName
      ,T1.FWBSumAuxQtyRecive = T2.FAuxQtyRecive
      ,T1.FRptSumAuxQtyFinish = T1.FRptAuxQtyFinishALLRow + T2.FAuxQtyFinish
      ,T1.FICMOPlanQty = T3.FAuxQty
      ,T1.FICMOCheckDate = T3.FCommitDate
      ,T1.FWBBillNo = T2.FWorkBillNO
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN t_SubMessage T4 ON T2.FOperID = T4.FInterID AND T4.FTypeID = 61
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FRptSumAuxQtyFinish = T1.FRptSumAuxQtyFinish - (SELECT SUM(T3.FAuxQtyfinish) FROM SHProcRpt T3 WHERE T3.FinterID = T1.FRptInterID)
  FROM #TEMP_RuleCheck T1
 WHERE T1.FRptInterID > 0

UPDATE T1
   SET T1.FRule1 = CASE WHEN T1.FRptBeginDate < T1.FICMOCheckDate THEN 1 ELSE T1.FRule1 END
      ,T1.FRule2 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FICMOPlanQty THEN 1 ELSE T1.FRule2 END
      ,T1.FRule3 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FWBSumAuxQtyRecive THEN 1 ELSE T1.FRule3 END
      ,T1.FRule4 = CASE WHEN T1.FRptSumAllZero = 0 THEN 1 ELSE T1.FRule4 END
      ,T1.FRule5 = CASE WHEN T1.FRptTimeAllZero = 0 THEN 1 ELSE T1.FRule5 END
      ,T1.FRule6 = CASE WHEN T1.FRptAuxQtyFinish <> T1.FRptSumQtyOther THEN 1 ELSE 0 END
  FROM #TEMP_RuleCheck T1 

--规则6:只处理免检的工序
UPDATE T1
   SET T1.FRule6 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE T2.FQualityChkID <> 352 AND T1.FRule6 = 1

--返修工序汇报不校验规则3：累计实作数量大于累计接收数量
UPDATE T1
   SET T1.FRule3 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
             INNER JOIN SHWorkBill T3 ON T2.FInterID = T3.FInterID
 WHERE T3.FBillType <> 11620 AND T1.FRule3 = 1

SELECT T1.*
  FROM #TEMP_RuleCheck T1

DROP TABLE #TEMP_RuleCheck

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FQualityChkID INT DEFAULT 0,FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FWBInterID INT,FWBBillNo VARCHAR(255),FIsLastOper INT DEFAULT 0,FWBSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FWBSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOInterID INT,FICMONo VARCHAR(255) DEFAULT '',FICMOAuxInHighLimitQty DECIMAL(28,10) DEFAULT 0)

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FSumAuxQtyFinish,FWBInterID,FICMOInterID)
VALUES(0,'1',3,3,745738,380199)

UPDATE T1
   SET T1.FWBSumAuxQtyPass = T2.FAuxQtyPass + T2.FAuxQualifiedReprocessedQty
      ,T1.FWBSumAuxQtyFinish = T2.FAuxQtyFinish
      ,T1.FWBBillNo = T2.FWorkBillNO
      ,T1.FQualityChkID = T2.FQualityChkID
      ,T1.FICMOAuxInHighLimitQty = T3.FAuxInHighLimitQty
      ,T1.FICMONo = T3.FBillNo
  FROM  #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FIsLastOper = 1
  FROM #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE NOT EXISTS(SELECT 1 FROM SHWorkBillEntry T3 WHERE T3.FinterID = T2.FinterID AND T3.FOperSN > T2.FOperSN)

SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID = 352 AND (T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass ) > T1.FICMOAuxInHighLimitQty
     UNION
SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID <> 352 AND (T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) > T1.FICMOAuxInHighLimitQty

DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FinterID INT,FWBInterID INT,FOperSN INT,FOperID INT,FNumber VARCHAR(30),FName VARCHAR(80))

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FinterID,FWBInterID,FOperSN,FOperID,FNumber,FName)
SELECT 0 AS FRptInterID,'1' AS FRptBillNo,3 AS FSumAuxQtyPass,T2.FinterID,T2.FWBInterID,T2.FOperSN,T2.FOperID,T3.FID AS FNumber,T3.FName
  FROM SHWorkBillEntry T2 INNER JOIN t_SubMessage T3 ON T2.FOperID = T3.FInterID AND T3.FTypeID = 61
 WHERE T2.FQualityChkID = 352 AND T3.FInterID>0 AND T3.FDeleted=0 AND T2.FWBInterID = 745738

IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#RESULT'))
    DROP TABLE #RESULT
CREATE TABLE #RESULT(FInterID INT,FWBInterID INT,FOperSN INT,FSumQty DECIMAL(28,10) DEFAULT 0,FWBInterIDPrev INT,FOperSNPrev INT,FSumQtyPrev DECIMAL(28,10) DEFAULT 0)
INSERT INTO #RESULT(FInterID,FWBInterID,FOperSN,FOperSNPrev)
    SELECT V1.FinterID,V1.FWBInterID,V1.FOperSN,MAX(V2.FOperSN) AS FOperSNPrev
    FROM (SELECT DISTINCT FinterID,FWBInterID,FOperSN FROM #TEMP_WB) V1 LEFT JOIN SHWorkBillEntry V2 ON V1.FinterID = V2.FinterID AND V1.FOperSN > V2.FOperSN
    WHERE V2.FWBInterID IS NOT NULL
    GROUP BY V1.FinterID,V1.FWBInterID,V1.FOperSN

UPDATE V1
   SET V1.FSumQty = V2.FAuxQtyPass + V2.FAuxQualifiedReprocessedQty
      ,V1.FWBInterIDPrev = V3.FWBInterID
      ,V1.FSumQtyPrev = V3.FAuxQtyPass + V3.FAuxQualifiedReprocessedQty
  FROM #RESULT V1 INNER JOIN SHWorkBillEntry V2 ON V1.FInterID = V2.FinterID AND V1.FWBInterID = V2.FWBInterID
                  INNER JOIN SHWorkBillEntry V3 ON V1.FInterID = V3.FinterID AND V1.FOperSNPrev = V3.FOperSN

UPDATE V2
   SET V2.FSumQty = V2.FSumQty + V1.FSumAuxQtyPass
  FROM (SELECT FInterID,FWBInterID,ISNULL(SUM(FSumAuxQtyPass),0) AS FSumAuxQtyPass FROM #TEMP_WB GROUP BY FInterID,FWBInterID) V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID

SELECT V1.FRptInterID,V1.FRptBillNo,V1.FName AS FOperName,V2.FSumQty,V2.FSumQtyPrev
  FROM #TEMP_WB V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID
 WHERE V2.FSumQty > V2.FSumQtyPrev

DROP TABLE #RESULT
DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
IF EXISTS(SELECT 1 FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='SourceBillType1002510' AND FType='IC')
          UPDATE ICPlanProfile SET FValue='-52' WHERE FUserID=16415 AND FKey='SourceBillType1002510' AND FType='IC'
ELSE 
INSERT INTO ICPlanProfile(FType,FUserID,FKey,FValue) VALUES('IC',16415,'SourceBillType1002510','-52')

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
IF EXISTS(SELECT 1 FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='ReportType1002510' AND FType='IC')
          UPDATE ICPlanProfile SET FValue='-1' WHERE FUserID=16415 AND FKey='ReportType1002510' AND FType='IC'
ELSE 
INSERT INTO ICPlanProfile(FType,FUserID,FKey,FValue) VALUES('IC',16415,'ReportType1002510','-1')

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FSubSysID from t_DataFlowSubFunc where FSubFuncID=14510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='AutoInPhaseWPDefSelf'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FTimeStamp FROM ICCLassType WHERE FID=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT *, FCaption_CHS as FCaption
 FROM ICClassConsts
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT * FROM ICBillNo WHERE FBillID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 select 1 from ICClassMCFlowInfo where fid=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT t1.FSourClassTypeID as FClassID ,t2.FName_CHS as FName,  FAllowCopy,FAllowCheck,FAllowForceCheck, t1.FRemark, t1.FFlowControl,t1.FUseSpec 
 , T3.FKey As FSRCIDKey, T3.FCaption_CHS as FCaption
 FROM ICClassLink t1 left join ICClassType t2 on t1.FSourClassTypeID=t2.FID
 Left Join ICClassTableInfo t3 on t1.FDestClassTypeID = t3.FClassTypeID and t1.FSRCIDKey = t3.FKey
 where t1.FDestClassTypeID=1002510 and t1.FIsUsed=2 And t1.FSourClassTypeID in (Select FSourClassTypeID from ICClassLinkEntry where FDestClassTypeID = 1002510) AND t1.FUnControl & 2 = 2
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='AutoInPhaseWPDefSelf'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FValue FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='SourceBillType1002510' AND FType='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FValue FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='ReportType1002510' AND FType='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select Distinct t1.FID as ClassTypeID,t1.FName as FName,t1.FTemplateID as FBillTemplateID,
 t1.FHeadTable,t1.FEntryTable,t2.FID as FListTemplateID,t2.FLinkPrimary 
 from ICTransactionType t1 inner join ICListTemplate t2 
 on t1.FID = t2.FBillTemplateID where t1.FID = '52'
 Order by FLinkPrimary Desc 
go
Select Distinct t2.FTableName,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52
 and (t2.FTableName = 'SHWorkBill'
 or t2.FTableName = 'SHWorkBillEntry')
go
 SELECT FObjectType, FObjectID FROM ICTransactionType WHERE FID = 52
go
Select Distinct t2.FName,t2.FTableName,t2.FTableAlias,t2.FIsPrimary,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52 and t2.FISPrimary in (1,2,3) order by FISPrimary
go
Select FCtlType,FFieldName from ICTemplate where FCtlType = 4 and FID = 'Z03'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =-52 and FDestClassTypeID=1002510 and FIsUsed=2
go
select distinct FSourPage,FDestPage from ICClassLinkEntry where FSourClassTypeID =-52 and FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex,t3.FTabIndex as FSourTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID  
 inner join ICClassTableInfo t3 ON t1.FSourFKey=t3.FKey AND t1.FSourClassTypeID=t3.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND FSourFKey like '%.%' 

go
select FPage,FKey,FSRCTableName,FSRCTableNameAs,FSRCFieldName,FDspFieldName,FFNDFieldName from ICClassTableInfo where FClasstypeID = -52  and FSRCTableNameAs <>'' and FCtlType = 1 and FSourceType=1 and FKeyWord = ''

go
SELECT * FROM ICClassLinkEntry WHERE FSourClassTypeID = -52 AND FDestClassTypeID = 1002510 AND FAfterFormula <>''
go
 SELECT T1.*, T2.FDestFKey, T2.FRedNeg FROM ICClassLinkCommit T1 
 INNER JOIN ICClassLinkEntry T2 ON 
 T1.FSrcClsTypID = T2.FSourClassTypeID AND T1.FDstClsTypID = T2.FDestClassTypeID  AND T1.FCheckKey = T2.FSourFKey AND T2.FIsCheck >= 0 
 WHERE T1.FSrcClsTypID = -52 AND T1.FDstClsTypID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FObjectType,FObjectID FROM ICTransactionType WHERE FID=52
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select * from t_Components where FComponent='K3List.clsListSheet'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='RefreshAfterAdd'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='StdCost' AND FKey='StdCostStart'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
UPDATE ICChatBillTitle SET FVisible=3,FVisForQuest=1,FVisForOrder=1 WHERE FTypeID=601 AND FColName='FPieceRate'
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FCategory,FKey,FValue FROM t_SystemProfile 
WHERE FCategory='IC' AND FKey IN ('StartBranchSale','ShowRelationSign','AuditChoice','PrecisionOfDiscountRate',
'StartPeriod','ListMaxRows','')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FTemplateID,FName As FName ,FFilter from ICListTemplate Where FID=601
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
Select FID,FName As FName ,FTemplateID,FFontID,FLogicStr,FToolBarVis,FHeadVis,FBottomVis,FSourceType,FSourceSql,FGroupID,FBillTemplateID,FNeedCount,FHeadHeight,FBottomHeight,FType,FGetDataType,FMenuID,FBillCls,FFilter,FRptTemplateID,FMasterTable,FNeedStatistic From ICListtemplate  Where FID in (601)
go
Select FInterID,FTypeID,FColCaption as FColCaption_CHS,FColCaption As FColCaption ,FHeadSecond,FColName,FTableName,FColType, FColWidth,FVisible,FItemClassID,FVisForQuest,FReturnDataType,FCountPriceType, FCtlIndex,Case When FColName = 'FSourceTranType' Then 'FName' Else FName End As FName,FTableAlias,FAction,FNeedCount,FIsPrimary,FLogicAction,FStatistical,FMergeable,FVisForOrder,FControl,FMode,FControlType,FEditable,FFormat,FFormatType,FAlign,FMustSelected
FROM ICChatBillTitle Where FTypeID IN (select FTemplateID From ICListtemplate  Where FID in (601)) order by FInterID
go
Select * from ICTableRelation where  FIndex=0 AND FTypeID IN (select FTemplateID From ICListtemplate Where FID in (601)) order by FInterID
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='StartBranchSale'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ShowRelationSign'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT V2.FValue FROM ICListTemplate U1
INNER  JOIN ICSchemeProfile V1 ON U1.FID = V1.FTranType AND FUserID = 16415
INNER  JOIN ICSchemeProfileEntry V2 ON V1.FSchemeID = V2.FSchemeID AND Fkey = 'HideColumns' WHERE U1.FTemplateID = 601
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FValue From t_SystemProfile Where  FCategory='IC' and FKey='EnableMtoPlanMode'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
select t_User.FUserID from t_Group, t_User 
 where t_Group.FUserID = t_User.FUserID 
 And t_User.FUserID = 16415and t_Group.FGroupID = 1 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
 Select FValue From t_Systemprofile Where FCategory = 'IC' and FKey='CheckUserGroup' 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601' AND FKey='UserLastProfile'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where FSection='QUICKSEARCH_601'AND FKey='DefaultProfile' AND FUserID=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where fSection='QUICKSEARCH_601'  and Fkey='DefaultField' and FuserId=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM ICSystemProfile WHERE FID=0 AND FKey='ShowAllBillHead' AND FCategory='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='PrecisionOfDiscountRate'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SInvoiceDecimal'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FAutoTD as FAutoTDID,u1.FEntryID as FEntryID_Number,u1.FWBInterID as FBillInterID,u1.FWorkBillNo as FBillNo,u1.FStatus as FStatus,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FEntryID as FEntryID,v1.FDate as FDate,v1.FICMOInterID as FICMOInterID, 0 As FBOSCloseFlag from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND  (u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
select t1.*,t2.FName as FFontName,t2.FColor,t2.FBold,t2.FItalic,t2.FSize from ICListTitle t1,ICFont t2 where t1.FFontID=t2.FID AND t1.FID=601 AND FType=0 order by FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FToolID,FName,FCaption,FCaption_CHT,FCaption_EN,FImageName,FToolTip_CHT,FToolTip,FToolTip_EN,FControlType,FBeginGroup,FVisible,FEnable,FChecked,FShortCut,FShortChar,FCBList,FCBList_CHT,FCBList_EN,FCBStyle,FBandID,FSubBandID,FSubBandName,FCBWidth,FBandName,FType,FBandVisible,FBandCaption,FBandCaption_CHT,FBandCaption_EN,FStyle,FComName,FToolCaption,FToolCaption_CHT,FToolCaption_EN from v_tools where FMenuGroupID = 90 order by FBandID,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='DisplayQuickSearch'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='SearchInScheme'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='ViewUnionQuery'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='UnionQueryCtlHeight'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
Select FValue From t_Systemprofile where  FCategory = 'IC' and FKey = 'EnableATP' 
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=745728 and u1.FEntryID=9) or (u1.FInterID=745728 and u1.FEntryID=10) or (u1.FInterID=836448 and u1.FEntryID=1) or (u1.FInterID=1410892 and u1.FEntryID=6) or (u1.FInterID=1410892 and u1.FEntryID=7) or (u1.FInterID=1410892 and u1.FEntryID=8) or (u1.FInterID=1410892 and u1.FEntryID=9) or (u1.FInterID=1467455 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=2) or (u1.FInterID=1808052 and u1.FEntryID=3) or (u1.FInterID=1808106 and u1.FEntryID=1) or (u1.FInterID=1808106 and u1.FEntryID=2) or (u1.FInterID=1808106 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=1) or (u1.FInterID=2604708 and u1.FEntryID=2) or (u1.FInterID=2604708 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=4) or (u1.FInterID=2604763 and u1.FEntryID=1) or (u1.FInterID=2604763 and u1.FEntryID=2) or (u1.FInterID=2604763 and u1.FEntryID=3) or (u1.FInterID=2604763 and u1.FEntryID=4) or (u1.FInterID=2604818 and u1.FEntryID=1) or (u1.FInterID=2604818 and u1.FEntryID=2) or (u1.FInterID=2604818 and u1.FEntryID=3) or (u1.FInterID=2604818 and u1.FEntryID=4) or (u1.FInterID=2604873 and u1.FEntryID=1) or (u1.FInterID=2604873 and u1.FEntryID=2) or (u1.FInterID=2604873 and u1.FEntryID=3) or (u1.FInterID=2604873 and u1.FEntryID=4) or (u1.FInterID=2655791 and u1.FEntryID=10) or (u1.FInterID=2670010 and u1.FEntryID=1) or (u1.FInterID=2670010 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=1) or (u1.FInterID=2829687 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=3) or (u1.FInterID=2829687 and u1.FEntryID=4) or (u1.FInterID=2829687 and u1.FEntryID=5) or (u1.FInterID=2829743 and u1.FEntryID=1) or (u1.FInterID=2829743 and u1.FEntryID=2) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=2829743 and u1.FEntryID=3) or (u1.FInterID=2829743 and u1.FEntryID=4) or (u1.FInterID=2829743 and u1.FEntryID=5) or (u1.FInterID=2829799 and u1.FEntryID=1) or (u1.FInterID=2829799 and u1.FEntryID=2) or (u1.FInterID=2829799 and u1.FEntryID=3) or (u1.FInterID=2829799 and u1.FEntryID=4) or (u1.FInterID=2829799 and u1.FEntryID=5) or (u1.FInterID=2829855 and u1.FEntryID=1) or (u1.FInterID=2829855 and u1.FEntryID=2) or (u1.FInterID=2829855 and u1.FEntryID=3) or (u1.FInterID=2829855 and u1.FEntryID=4) or (u1.FInterID=2829855 and u1.FEntryID=5) or (u1.FInterID=2829911 and u1.FEntryID=1) or (u1.FInterID=2829911 and u1.FEntryID=2) or (u1.FInterID=2829911 and u1.FEntryID=3) or (u1.FInterID=2829965 and u1.FEntryID=1) or (u1.FInterID=2829965 and u1.FEntryID=2) or (u1.FInterID=2829965 and u1.FEntryID=3) or (u1.FInterID=2830019 and u1.FEntryID=1) or (u1.FInterID=2830019 and u1.FEntryID=2) or (u1.FInterID=2830019 and u1.FEntryID=3) or (u1.FInterID=2830073 and u1.FEntryID=1) or (u1.FInterID=2830073 and u1.FEntryID=2) or (u1.FInterID=2830073 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=2) or (u1.FInterID=2839759 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=4) or (u1.FInterID=2839759 and u1.FEntryID=5) or (u1.FInterID=2839815 and u1.FEntryID=2) or (u1.FInterID=2839815 and u1.FEntryID=3) or (u1.FInterID=2839815 and u1.FEntryID=4) or (u1.FInterID=2839815 and u1.FEntryID=5) or (u1.FInterID=2839983 and u1.FEntryID=2) or (u1.FInterID=2839983 and u1.FEntryID=3) or (u1.FInterID=2839983 and u1.FEntryID=4) or (u1.FInterID=2839983 and u1.FEntryID=5) or (u1.FInterID=2840039 and u1.FEntryID=2) or (u1.FInterID=2840039 and u1.FEntryID=3) or (u1.FInterID=2840039 and u1.FEntryID=4) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SaveListColWidth'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select u1.FWBInterID,
u1.FEntryID,
u1.FWorkBillNo,
v1.FICMONO As FICMONO,
v1.FICMOinterID As FICMOinterID,
v1.FGMPBatchNo As FGMPBatchNo,
v1.FUnitID As FUnitID,
t_Measureunit.FName As FUnitID_DSPName,
t_Measureunit.FNumber As FUnitID_FNDName,
v1.FCoefficient As FCoefficient,
v1.FItemID As FItemID,
t_ICItem.FTrack As FItemID_Track,
t_ICItem.FBatchManager As FItemID_BatchNoManage,
t_ICItem.FQtyDecimal As FItemID_FQtyDecimal,
t_ICItem.FPriceDecimal As FItemID_FPriceDecimal,
t_ICItem.FUnitGroupID As FItemID_UnitGroupID,
t_ICItem.FISKFPeriod As FItemID_FISKFPeriod,
t_ICItem.FNumber As FItemID_DSPName,
t_ICItem.FNumber As FItemID_FNDName,
v1.FOrderBillNo As FOrderBillNo,
v1.FOrderEntryID As FOrderEntryID,
v1.FMTONo As FMTONo,
v1.FOrderInterID As FOrderInterID,
u1.FWorkBillNO As FWorkBillNO,
u1.FWBInterID As FWBInterID,
u1.FTeamID As FTeamID,
t_SubMessage.FName As FTeamID_DSPName,
t_SubMessage.FID As FTeamID_FNDName,
u1.FWorkerID As FWorkerID,
t_Emp.FName As FWorkerID_DSPName,
t_Emp.FNumber As FWorkerID_FNDName,
u1.FDeviceID As FDeviceID,
vw_Device_Resource.FName As FDeviceID_DSPName,
vw_Device_Resource.FNumber As FDeviceID_FNDName,
u1.FConversion As FConversion,
u1.FOperID As FOperID,
u1.FWorkCenterID As FWorkCenterID,
u1.FAutoTD As FAutoTD,
t_SubMessage1.FName As FAutoTD_DSPName,
t_SubMessage1.FID As FAutoTD_FNDName,
u1.FQualityChkID As FQualityChkID,
u1.FAutoOF As FAutoOF,
t_SubMessage2.FName As FAutoOF_DSPName,
t_SubMessage2.FID As FAutoOF_FNDName,
u1.FTimeUnit As FTimeUnit,
t_SubMessage3.FName As FTimeUnit_DSPName,
t_SubMessage3.FID As FTimeUnit_FNDName,
u1.FTimeSetup As FTimeSetup,
u1.FWorkQty As FWorkQty,
u1.FTimeRun As FTimeRun,
u1.FTotalWorkTime As FTotalWorkTime,
u1.FOperSN As FOperSN,
u1.FOperID As FOperID2,
t_SubMessage4.FID As FOperID2_DSPName,
t_SubMessage4.FID As FOperID2_FNDName,
u1.FWorkCenterID As FWorkCenterID2,
t_WorkCenter.FNumber As FWorkCenterID2_DSPName,
t_WorkCenter.FNumber As FWorkCenterID2_FNDName
 From SHWorkBill AS v1 Inner Join SHWorkBillEntry AS u1 On v1.FInterID = u1.FInterID LEFT  JOIN t_Measureunit  ON v1.FUnitID=t_Measureunit.FItemID AND t_Measureunit.FItemID<>0
 LEFT  JOIN t_ICItem  ON v1.FItemID=t_ICItem.FItemID AND t_ICItem.FItemID<>0
 LEFT  JOIN t_SubMessage  ON u1.FTeamID=t_SubMessage.FInterID AND t_SubMessage.FInterID<>0
 LEFT  JOIN t_Emp  ON u1.FWorkerID=t_Emp.FItemID AND t_Emp.FItemID<>0
 LEFT  JOIN vw_Device_Resource  ON u1.FDeviceID=vw_Device_Resource.FID AND vw_Device_Resource.FID<>0
 LEFT  JOIN t_SubMessage t_SubMessage1 ON u1.FAutoTD=t_SubMessage1.FInterID AND t_SubMessage1.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage2 ON u1.FAutoOF=t_SubMessage2.FInterID AND t_SubMessage2.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage3 ON u1.FTimeUnit=t_SubMessage3.FInterID AND t_SubMessage3.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage4 ON u1.FOperID=t_SubMessage4.FInterID AND t_SubMessage4.FInterID<>0
 LEFT  JOIN t_WorkCenter  ON u1.FWorkCenterID=t_WorkCenter.FItemID AND t_WorkCenter.FItemID<>0
 Where  (  ( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  )  )  AND  ( (u1.FWBInterID=2604765 AND u1.FEntryID=2) )  ORDER BY u1.FWBInterID, u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_ICItem WHERE  t_ICItem.FItemID = 265752
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_SubMessage WHERE  t_SubMessage.FInterID = 40120
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_WorkCenter WHERE  t_WorkCenter.FItemID = 235714
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT ISNULL(FAuxQtyPlan - FAuxQtyFinish ,0) as FAuxQty,FWBInterID  FROM SHWorkBillEntry  
 WHERE 1=2  OR FWBInterID =2604765
 OR FWBInterID =0

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =0 and FDestClassTypeID=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =0 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FCapacityCalType from t_workcenter where FItemID=235714

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill')
 UPDATE  ICClassUserProfile SET FValue='mnuSelectOldBill_52' WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1002510','SelBill','mnuSelectOldBill_52')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FEntryID2_ColWidth=1800|FID2_ColWidth=1800|FIndex2_ColWidth=1800|FICMONO_ColWidth=2505|FICMOInterID_ColWidth=2500|FWBNO_ColWidth=2500|FWBInterID_ColWidth=2500|FTaskDispBillNo_ColWidth=2500|FTaskDispBillID_ColWidth=2500|FGMPBatchNo_ColWidth=2500|FOperMoveNo_ColWidth=2500|FTeamID_ColWidth=2500|FOperGroupID_ColWidth=1000|FWorkerID_ColWidth=2500|FDeviceID_ColWidth=2500|FTeamtimeID_ColWidth=2500|FStartWorkDate_ColWidth=2500|FEndWorkDate_ColWidth=2500|FUnitID_ColWidth=2500|FAuxQtyfinish_ColWidth=2500|FAuxQtyPass_ColWidth=2500|FAuxQtyScrap_ColWidth=2500|FAuxQtyForItem_ColWidth=2500|FAuxReprocessedQty_ColWidth=2500|FConversion_ColWidth=2500|FCoefficient_ColWidth=2500|FOperAuxQtyFinish_ColWidth=2500|FOperAuxQtyPass_ColWidth=2500|FOperAuxQtyScrap_ColWidth=2500|FOperAuxQtyForItem_ColWidth=2500|FOperAuxReprocessedQty_ColWidth=2500|FFinishTime_ColWidth=2500|FReadyTime_ColWidth=2500|FFixTime_ColWidth=2500|FMemo_ColWidth=2505|FOperID_ColWidth=2500|FWorkCenterID_ColWidth=2500|FPlanStartDate_ColWidth=2500|FPlanEndDate_ColWidth=2500|FAutoTD_ColWidth=2500|FAuxQtyPlan_ColWidth=2500|FOperAuxQtyPlan_ColWidth=2500|FQualityChkID_ColWidth=2500|FAutoOF_ColWidth=2500|FItemID_ColWidth=2500|FItemName_ColWidth=1080|FTimeUnit_ColWidth=2500|FTimeSetup_ColWidth=2500|FWorkQty_ColWidth=2500|FTimeRun_ColWidth=2500|FTimeMachine_ColWidth=2500|FOperSN_ColWidth=2500|FOperNumber_ColWidth=2500|FOperName_ColWidth=2500|FWorkCenterNumber_ColWidth=2500|FWorkCenterName_ColWidth=2500|FOrderBillNo_ColWidth=2500|FOrderEntryID_ColWidth=2500|FMTONo_ColWidth=2500|FOrderInterID_ColWidth=2500|FHRReadyTime_ColWidth=2500|GridColsFrozen=0|' WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1002510','GridProfile0','GridRowHeight=210|FEntryID2_ColWidth=1800|FID2_ColWidth=1800|FIndex2_ColWidth=1800|FICMONO_ColWidth=2505|FICMOInterID_ColWidth=2500|FWBNO_ColWidth=2500|FWBInterID_ColWidth=2500|FTaskDispBillNo_ColWidth=2500|FTaskDispBillID_ColWidth=2500|FGMPBatchNo_ColWidth=2500|FOperMoveNo_ColWidth=2500|FTeamID_ColWidth=2500|FOperGroupID_ColWidth=1000|FWorkerID_ColWidth=2500|FDeviceID_ColWidth=2500|FTeamtimeID_ColWidth=2500|FStartWorkDate_ColWidth=2500|FEndWorkDate_ColWidth=2500|FUnitID_ColWidth=2500|FAuxQtyfinish_ColWidth=2500|FAuxQtyPass_ColWidth=2500|FAuxQtyScrap_ColWidth=2500|FAuxQtyForItem_ColWidth=2500|FAuxReprocessedQty_ColWidth=2500|FConversion_ColWidth=2500|FCoefficient_ColWidth=2500|FOperAuxQtyFinish_ColWidth=2500|FOperAuxQtyPass_ColWidth=2500|FOperAuxQtyScrap_ColWidth=2500|FOperAuxQtyForItem_ColWidth=2500|FOperAuxReprocessedQty_ColWidth=2500|FFinishTime_ColWidth=2500|FReadyTime_ColWidth=2500|FFixTime_ColWidth=2500|FMemo_ColWidth=2505|FOperID_ColWidth=2500|FWorkCenterID_ColWidth=2500|FPlanStartDate_ColWidth=2500|FPlanEndDate_ColWidth=2500|FAutoTD_ColWidth=2500|FAuxQtyPlan_ColWidth=2500|FOperAuxQtyPlan_ColWidth=2500|FQualityChkID_ColWidth=2500|FAutoOF_ColWidth=2500|FItemID_ColWidth=2500|FItemName_ColWidth=1080|FTimeUnit_ColWidth=2500|FTimeSetup_ColWidth=2500|FWorkQty_ColWidth=2500|FTimeRun_ColWidth=2500|FTimeMachine_ColWidth=2500|FOperSN_ColWidth=2500|FOperNumber_ColWidth=2500|FOperName_ColWidth=2500|FWorkCenterNumber_ColWidth=2500|FWorkCenterName_ColWidth=2500|FOrderBillNo_ColWidth=2500|FOrderEntryID_ColWidth=2500|FMTONo_ColWidth=2500|FOrderInterID_ColWidth=2500|FHRReadyTime_ColWidth=2500|GridColsFrozen=0|')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='GridProfile0')
 UPDATE  ICClassUserProfile SET FValue='GridRowHeight=210|FEntryID2_ColWidth=1800|FID2_ColWidth=1800|FIndex2_ColWidth=1800|FICMONO_ColWidth=2505|FICMOInterID_ColWidth=2500|FWBNO_ColWidth=2500|FWBInterID_ColWidth=2500|FTaskDispBillNo_ColWidth=2500|FTaskDispBillID_ColWidth=2500|FGMPBatchNo_ColWidth=2500|FOperMoveNo_ColWidth=2500|FTeamID_ColWidth=2500|FOperGroupID_ColWidth=1000|FWorkerID_ColWidth=2500|FDeviceID_ColWidth=2500|FTeamtimeID_ColWidth=2500|FStartWorkDate_ColWidth=2500|FEndWorkDate_ColWidth=2500|FUnitID_ColWidth=2500|FAuxQtyfinish_ColWidth=2500|FAuxQtyPass_ColWidth=2500|FAuxQtyScrap_ColWidth=2500|FAuxQtyForItem_ColWidth=2500|FAuxReprocessedQty_ColWidth=2500|FConversion_ColWidth=2500|FCoefficient_ColWidth=2500|FOperAuxQtyFinish_ColWidth=2500|FOperAuxQtyPass_ColWidth=2500|FOperAuxQtyScrap_ColWidth=2500|FOperAuxQtyForItem_ColWidth=2500|FOperAuxReprocessedQty_ColWidth=2500|FFinishTime_ColWidth=2500|FReadyTime_ColWidth=2500|FFixTime_ColWidth=2500|FMemo_ColWidth=2505|FOperID_ColWidth=2500|FWorkCenterID_ColWidth=2500|FPlanStartDate_ColWidth=2500|FPlanEndDate_ColWidth=2500|FAutoTD_ColWidth=2505|FAuxQtyPlan_ColWidth=2500|FOperAuxQtyPlan_ColWidth=2500|FQualityChkID_ColWidth=2500|FAutoOF_ColWidth=2500|FItemID_ColWidth=2500|FItemName_ColWidth=1080|FTimeUnit_ColWidth=2500|FTimeSetup_ColWidth=2500|FWorkQty_ColWidth=2500|FTimeRun_ColWidth=2500|FTimeMachine_ColWidth=2500|FOperSN_ColWidth=2500|FOperNumber_ColWidth=2500|FOperName_ColWidth=2500|FWorkCenterNumber_ColWidth=2500|FWorkCenterName_ColWidth=2500|FOrderBillNo_ColWidth=2500|FOrderEntryID_ColWidth=2500|FMTONo_ColWidth=2500|FOrderInterID_ColWidth=2500|FHRReadyTime_ColWidth=2500|GridColsFrozen=0|' WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='GridProfile0' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1002510','GridProfile0','GridRowHeight=210|FEntryID2_ColWidth=1800|FID2_ColWidth=1800|FIndex2_ColWidth=1800|FICMONO_ColWidth=2505|FICMOInterID_ColWidth=2500|FWBNO_ColWidth=2500|FWBInterID_ColWidth=2500|FTaskDispBillNo_ColWidth=2500|FTaskDispBillID_ColWidth=2500|FGMPBatchNo_ColWidth=2500|FOperMoveNo_ColWidth=2500|FTeamID_ColWidth=2500|FOperGroupID_ColWidth=1000|FWorkerID_ColWidth=2500|FDeviceID_ColWidth=2500|FTeamtimeID_ColWidth=2500|FStartWorkDate_ColWidth=2500|FEndWorkDate_ColWidth=2500|FUnitID_ColWidth=2500|FAuxQtyfinish_ColWidth=2500|FAuxQtyPass_ColWidth=2500|FAuxQtyScrap_ColWidth=2500|FAuxQtyForItem_ColWidth=2500|FAuxReprocessedQty_ColWidth=2500|FConversion_ColWidth=2500|FCoefficient_ColWidth=2500|FOperAuxQtyFinish_ColWidth=2500|FOperAuxQtyPass_ColWidth=2500|FOperAuxQtyScrap_ColWidth=2500|FOperAuxQtyForItem_ColWidth=2500|FOperAuxReprocessedQty_ColWidth=2500|FFinishTime_ColWidth=2500|FReadyTime_ColWidth=2500|FFixTime_ColWidth=2500|FMemo_ColWidth=2505|FOperID_ColWidth=2500|FWorkCenterID_ColWidth=2500|FPlanStartDate_ColWidth=2500|FPlanEndDate_ColWidth=2500|FAutoTD_ColWidth=2505|FAuxQtyPlan_ColWidth=2500|FOperAuxQtyPlan_ColWidth=2500|FQualityChkID_ColWidth=2500|FAutoOF_ColWidth=2500|FItemID_ColWidth=2500|FItemName_ColWidth=1080|FTimeUnit_ColWidth=2500|FTimeSetup_ColWidth=2500|FWorkQty_ColWidth=2500|FTimeRun_ColWidth=2500|FTimeMachine_ColWidth=2500|FOperSN_ColWidth=2500|FOperNumber_ColWidth=2500|FOperName_ColWidth=2500|FWorkCenterNumber_ColWidth=2500|FWorkCenterName_ColWidth=2500|FOrderBillNo_ColWidth=2500|FOrderEntryID_ColWidth=2500|FMTONo_ColWidth=2500|FOrderInterID_ColWidth=2500|FHRReadyTime_ColWidth=2500|GridColsFrozen=0|')
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FFieldName,FValueType From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1 and FMustInput=1 and FNeedSave=1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue from t_SystemProfile Where FCategory='SH' and FKey='ShopConversionManage'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FID,FItemID As FOperatorID FROM ICOperGroupEntry
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT 0 FROM PPBOM WHERE FStatus = 0 AND FICMOInterID = 479538 AND 0 = (SELECT FValue FROM t_SystemProfile WHERE FKey = 'AllowSaveProcRptPPBOMNotChcek' AND FCategory = 'SH')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT T1.FKey,T1.FValue
  FROM ICSHOP_SCProfile T1
 WHERE T1.FCategory = 'SH' AND (T1.FValue & 2) > 0 
        AND T1.FKey IN('SH_RptBeginDatePrevICMOReleasingDate'
                      ,'SH_CumulativeProducedQtyOverPlannedProductionQty'
                      ,'SH_CumulativeProducedQtyOverCumulativeReceivedQty'
                      ,'SH_OperRptZeroAllQty'
                      ,'SH_OperRptZeroAllOperTime'
                      ,'SH_CumulativeProducedQtyDifference'
                      )


go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_RuleCheck'))
    DROP TABLE #TEMP_RuleCheck
CREATE TABLE #TEMP_RuleCheck(FInterID INT IDENTITY(1,1),FRptInterID INT DEFAULT 0,FRptBillNo VARCHAR(255),FEntryID INT,FWBInterID INT,FWBBillNo VARCHAR(255),FICMOInterID INT,FICMOBillNo VARCHAR(255)
                            ,FRule1 INT DEFAULT 0,FRptBeginDate DATETIME,FICMOCheckDate DATETIME
                            ,FRule2 INT DEFAULT 0,FRptSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOPlanQty DECIMAL(28,10) DEFAULT 0
                            ,FRule3 INT DEFAULT 0,FOperSN INT,FOperName VARCHAR(255),FWBSumAuxQtyRecive DECIMAL(28,10) DEFAULT 0
                            ,FRule4 INT DEFAULT 0,FRptSumAllZero DECIMAL(28,10)
                            ,FRule5 INT DEFAULT 0,FRptTimeAllZero DECIMAL(28,10)
                            ,FRule6 INT DEFAULT 0,FRptAuxQtyFinishALLRow DECIMAL(28,10) DEFAULT 0,FRptAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FRptSumQtyOther DECIMAL(28,10) DEFAULT 0
                            ,FIsFirst INT DEFAULT 0 ,FIsOut INT DEFAULT 1059)

INSERT INTO #TEMP_RuleCheck(FRptInterID,FRptBillNo,FEntryID,FWBInterID,FWBBillNo,FICMOInterID,FICMOBillNo
                           ,FRptBeginDate,FRptSumAllZero,FRptTimeAllZero
                           ,FRptAuxQtyFinishALLRow,FRptAuxQtyFinish,FRptSumQtyOther)
VALUES(0,'',1,2604765,'WB222218',479538,'Y1602-352_006',
         '2017-01-09 08:57:30',4,0,
         2,2,2
      )

UPDATE T1 set T1.FIsFirst=1,T1.FIsOut=T5.FIsOut from #TEMP_RuleCheck T1 inner join (select t3.FWBInterID ,t3.FISOut as FISOut from SHWorkBillEntry t3
inner join
(select t1.finterid,min(t1.FOperSN) as FMinOperSN from SHWorkBillEntry t1 inner join (select FInterID from SHWorkBillEntry where FWBInterID=2604765
) t2 on t1.finterid=t2.finterid group by t1.finterid) t4 on t3.finterid=t4.finterid and t3.FOperSN=t4.FMinOperSN) T5 on T1.FWBInterID=T5.FWBInterID
UPDATE T1
   SET T1.FOperSN = T2.FOperSN
      ,T1.FOperName = T4.FName
      ,T1.FWBSumAuxQtyRecive = T2.FAuxQtyRecive
      ,T1.FRptSumAuxQtyFinish = T1.FRptAuxQtyFinishALLRow + T2.FAuxQtyFinish
      ,T1.FICMOPlanQty = T3.FAuxQty
      ,T1.FICMOCheckDate = T3.FCommitDate
      ,T1.FWBBillNo = T2.FWorkBillNO
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN t_SubMessage T4 ON T2.FOperID = T4.FInterID AND T4.FTypeID = 61
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FRptSumAuxQtyFinish = T1.FRptSumAuxQtyFinish - (SELECT SUM(T3.FAuxQtyfinish) FROM SHProcRpt T3 WHERE T3.FinterID = T1.FRptInterID)
  FROM #TEMP_RuleCheck T1
 WHERE T1.FRptInterID > 0

UPDATE T1
   SET T1.FRule1 = CASE WHEN T1.FRptBeginDate < T1.FICMOCheckDate THEN 1 ELSE T1.FRule1 END
      ,T1.FRule2 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FICMOPlanQty THEN 1 ELSE T1.FRule2 END
      ,T1.FRule3 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FWBSumAuxQtyRecive THEN 1 ELSE T1.FRule3 END
      ,T1.FRule4 = CASE WHEN T1.FRptSumAllZero = 0 THEN 1 ELSE T1.FRule4 END
      ,T1.FRule5 = CASE WHEN T1.FRptTimeAllZero = 0 THEN 1 ELSE T1.FRule5 END
      ,T1.FRule6 = CASE WHEN T1.FRptAuxQtyFinish <> T1.FRptSumQtyOther THEN 1 ELSE 0 END
  FROM #TEMP_RuleCheck T1 

--规则6:只处理免检的工序
UPDATE T1
   SET T1.FRule6 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE T2.FQualityChkID <> 352 AND T1.FRule6 = 1

--返修工序汇报不校验规则3：累计实作数量大于累计接收数量
UPDATE T1
   SET T1.FRule3 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
             INNER JOIN SHWorkBill T3 ON T2.FInterID = T3.FInterID
 WHERE T3.FBillType <> 11620 AND T1.FRule3 = 1

SELECT T1.*
  FROM #TEMP_RuleCheck T1

DROP TABLE #TEMP_RuleCheck

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FQualityChkID INT DEFAULT 0,FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FWBInterID INT,FWBBillNo VARCHAR(255),FIsLastOper INT DEFAULT 0,FWBSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FWBSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOInterID INT,FICMONo VARCHAR(255) DEFAULT '',FICMOAuxInHighLimitQty DECIMAL(28,10) DEFAULT 0)

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FSumAuxQtyFinish,FWBInterID,FICMOInterID)
VALUES(0,'1',2,2,2604765,479538)

UPDATE T1
   SET T1.FWBSumAuxQtyPass = T2.FAuxQtyPass + T2.FAuxQualifiedReprocessedQty
      ,T1.FWBSumAuxQtyFinish = T2.FAuxQtyFinish
      ,T1.FWBBillNo = T2.FWorkBillNO
      ,T1.FQualityChkID = T2.FQualityChkID
      ,T1.FICMOAuxInHighLimitQty = T3.FAuxInHighLimitQty
      ,T1.FICMONo = T3.FBillNo
  FROM  #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FIsLastOper = 1
  FROM #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE NOT EXISTS(SELECT 1 FROM SHWorkBillEntry T3 WHERE T3.FinterID = T2.FinterID AND T3.FOperSN > T2.FOperSN)

SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID = 352 AND (T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass ) > T1.FICMOAuxInHighLimitQty
     UNION
SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID <> 352 AND (T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) > T1.FICMOAuxInHighLimitQty

DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FinterID INT,FWBInterID INT,FOperSN INT,FOperID INT,FNumber VARCHAR(30),FName VARCHAR(80))

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FinterID,FWBInterID,FOperSN,FOperID,FNumber,FName)
SELECT 0 AS FRptInterID,'1' AS FRptBillNo,2 AS FSumAuxQtyPass,T2.FinterID,T2.FWBInterID,T2.FOperSN,T2.FOperID,T3.FID AS FNumber,T3.FName
  FROM SHWorkBillEntry T2 INNER JOIN t_SubMessage T3 ON T2.FOperID = T3.FInterID AND T3.FTypeID = 61
 WHERE T2.FQualityChkID = 352 AND T3.FInterID>0 AND T3.FDeleted=0 AND T2.FWBInterID = 2604765

IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#RESULT'))
    DROP TABLE #RESULT
CREATE TABLE #RESULT(FInterID INT,FWBInterID INT,FOperSN INT,FSumQty DECIMAL(28,10) DEFAULT 0,FWBInterIDPrev INT,FOperSNPrev INT,FSumQtyPrev DECIMAL(28,10) DEFAULT 0)
INSERT INTO #RESULT(FInterID,FWBInterID,FOperSN,FOperSNPrev)
    SELECT V1.FinterID,V1.FWBInterID,V1.FOperSN,MAX(V2.FOperSN) AS FOperSNPrev
    FROM (SELECT DISTINCT FinterID,FWBInterID,FOperSN FROM #TEMP_WB) V1 LEFT JOIN SHWorkBillEntry V2 ON V1.FinterID = V2.FinterID AND V1.FOperSN > V2.FOperSN
    WHERE V2.FWBInterID IS NOT NULL
    GROUP BY V1.FinterID,V1.FWBInterID,V1.FOperSN

UPDATE V1
   SET V1.FSumQty = V2.FAuxQtyPass + V2.FAuxQualifiedReprocessedQty
      ,V1.FWBInterIDPrev = V3.FWBInterID
      ,V1.FSumQtyPrev = V3.FAuxQtyPass + V3.FAuxQualifiedReprocessedQty
  FROM #RESULT V1 INNER JOIN SHWorkBillEntry V2 ON V1.FInterID = V2.FinterID AND V1.FWBInterID = V2.FWBInterID
                  INNER JOIN SHWorkBillEntry V3 ON V1.FInterID = V3.FinterID AND V1.FOperSNPrev = V3.FOperSN

UPDATE V2
   SET V2.FSumQty = V2.FSumQty + V1.FSumAuxQtyPass
  FROM (SELECT FInterID,FWBInterID,ISNULL(SUM(FSumAuxQtyPass),0) AS FSumAuxQtyPass FROM #TEMP_WB GROUP BY FInterID,FWBInterID) V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID

SELECT V1.FRptInterID,V1.FRptBillNo,V1.FName AS FOperName,V2.FSumQty,V2.FSumQtyPrev
  FROM #TEMP_WB V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID
 WHERE V2.FSumQty > V2.FSumQtyPrev

DROP TABLE #RESULT
DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select Distinct t1.FID as ClassTypeID,t1.FName as FName,t1.FTemplateID as FBillTemplateID,
 t1.FHeadTable,t1.FEntryTable,t2.FID as FListTemplateID,t2.FLinkPrimary 
 from ICTransactionType t1 inner join ICListTemplate t2 
 on t1.FID = t2.FBillTemplateID where t1.FID = '52'
 Order by FLinkPrimary Desc 
go
Select Distinct t2.FTableName,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52
 and (t2.FTableName = 'SHWorkBill'
 or t2.FTableName = 'SHWorkBillEntry')
go
 SELECT FObjectType, FObjectID FROM ICTransactionType WHERE FID = 52
go
Select Distinct t2.FName,t2.FTableName,t2.FTableAlias,t2.FIsPrimary,t2.FTableAlias 
 from ICListTemplate t1 inner join ICChatBillTitle t2 on t1.FTemplateID = t2.FTypeID 
 where t1.FBillTemplateID = 52 and t2.FISPrimary in (1,2,3) order by FISPrimary
go
Select FCtlType,FFieldName from ICTemplate where FCtlType = 4 and FID = 'Z03'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =-52 and FDestClassTypeID=1002510 and FIsUsed=2
go
select distinct FSourPage,FDestPage from ICClassLinkEntry where FSourClassTypeID =-52 and FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex,t3.FTabIndex as FSourTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID  
 inner join ICClassTableInfo t3 ON t1.FSourFKey=t3.FKey AND t1.FSourClassTypeID=t3.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND FSourFKey like '%.%' 

go
select FPage,FKey,FSRCTableName,FSRCTableNameAs,FSRCFieldName,FDspFieldName,FFNDFieldName from ICClassTableInfo where FClasstypeID = -52  and FSRCTableNameAs <>'' and FCtlType = 1 and FSourceType=1 and FKeyWord = ''

go
SELECT * FROM ICClassLinkEntry WHERE FSourClassTypeID = -52 AND FDestClassTypeID = 1002510 AND FAfterFormula <>''
go
 SELECT T1.*, T2.FDestFKey, T2.FRedNeg FROM ICClassLinkCommit T1 
 INNER JOIN ICClassLinkEntry T2 ON 
 T1.FSrcClsTypID = T2.FSourClassTypeID AND T1.FDstClsTypID = T2.FDestClassTypeID  AND T1.FCheckKey = T2.FSourFKey AND T2.FIsCheck >= 0 
 WHERE T1.FSrcClsTypID = -52 AND T1.FDstClsTypID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =-52 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FObjectType,FObjectID FROM ICTransactionType WHERE FID=52
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select * from t_Components where FComponent='K3List.clsListSheet'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='RefreshAfterAdd'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='StdCost' AND FKey='StdCostStart'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
UPDATE ICChatBillTitle SET FVisible=3,FVisForQuest=1,FVisForOrder=1 WHERE FTypeID=601 AND FColName='FPieceRate'
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FCategory,FKey,FValue FROM t_SystemProfile 
WHERE FCategory='IC' AND FKey IN ('StartBranchSale','ShowRelationSign','AuditChoice','PrecisionOfDiscountRate',
'StartPeriod','ListMaxRows','')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FTemplateID,FName As FName ,FFilter from ICListTemplate Where FID=601
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
Select FID,FName As FName ,FTemplateID,FFontID,FLogicStr,FToolBarVis,FHeadVis,FBottomVis,FSourceType,FSourceSql,FGroupID,FBillTemplateID,FNeedCount,FHeadHeight,FBottomHeight,FType,FGetDataType,FMenuID,FBillCls,FFilter,FRptTemplateID,FMasterTable,FNeedStatistic From ICListtemplate  Where FID in (601)
go
Select FInterID,FTypeID,FColCaption as FColCaption_CHS,FColCaption As FColCaption ,FHeadSecond,FColName,FTableName,FColType, FColWidth,FVisible,FItemClassID,FVisForQuest,FReturnDataType,FCountPriceType, FCtlIndex,Case When FColName = 'FSourceTranType' Then 'FName' Else FName End As FName,FTableAlias,FAction,FNeedCount,FIsPrimary,FLogicAction,FStatistical,FMergeable,FVisForOrder,FControl,FMode,FControlType,FEditable,FFormat,FFormatType,FAlign,FMustSelected
FROM ICChatBillTitle Where FTypeID IN (select FTemplateID From ICListtemplate  Where FID in (601)) order by FInterID
go
Select * from ICTableRelation where  FIndex=0 AND FTypeID IN (select FTemplateID From ICListtemplate Where FID in (601)) order by FInterID
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='StartBranchSale'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ShowRelationSign'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT V2.FValue FROM ICListTemplate U1
INNER  JOIN ICSchemeProfile V1 ON U1.FID = V1.FTranType AND FUserID = 16415
INNER  JOIN ICSchemeProfileEntry V2 ON V1.FSchemeID = V2.FSchemeID AND Fkey = 'HideColumns' WHERE U1.FTemplateID = 601
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FValue From t_SystemProfile Where  FCategory='IC' and FKey='EnableMtoPlanMode'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
select t_User.FUserID from t_Group, t_User 
 where t_Group.FUserID = t_User.FUserID 
 And t_User.FUserID = 16415and t_Group.FGroupID = 1 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
 Select FValue From t_Systemprofile Where FCategory = 'IC' and FKey='CheckUserGroup' 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601' AND FKey='UserLastProfile'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where FSection='QUICKSEARCH_601'AND FKey='DefaultProfile' AND FUserID=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where fSection='QUICKSEARCH_601'  and Fkey='DefaultField' and FuserId=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM ICSystemProfile WHERE FID=0 AND FKey='ShowAllBillHead' AND FCategory='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='PrecisionOfDiscountRate'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SInvoiceDecimal'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FAutoTD as FAutoTDID,u1.FEntryID as FEntryID_Number,u1.FWBInterID as FBillInterID,u1.FWorkBillNo as FBillNo,u1.FStatus as FStatus,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FEntryID as FEntryID,v1.FDate as FDate,v1.FICMOInterID as FICMOInterID, 0 As FBOSCloseFlag from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND  (u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
select t1.*,t2.FName as FFontName,t2.FColor,t2.FBold,t2.FItalic,t2.FSize from ICListTitle t1,ICFont t2 where t1.FFontID=t2.FID AND t1.FID=601 AND FType=0 order by FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FToolID,FName,FCaption,FCaption_CHT,FCaption_EN,FImageName,FToolTip_CHT,FToolTip,FToolTip_EN,FControlType,FBeginGroup,FVisible,FEnable,FChecked,FShortCut,FShortChar,FCBList,FCBList_CHT,FCBList_EN,FCBStyle,FBandID,FSubBandID,FSubBandName,FCBWidth,FBandName,FType,FBandVisible,FBandCaption,FBandCaption_CHT,FBandCaption_EN,FStyle,FComName,FToolCaption,FToolCaption_CHT,FToolCaption_EN from v_tools where FMenuGroupID = 90 order by FBandID,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='DisplayQuickSearch'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='SearchInScheme'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='ViewUnionQuery'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='List601' AND FKey='UnionQueryCtlHeight'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
Select FValue From t_Systemprofile where  FCategory = 'IC' and FKey = 'EnableATP' 
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=745728 and u1.FEntryID=9) or (u1.FInterID=745728 and u1.FEntryID=10) or (u1.FInterID=836448 and u1.FEntryID=1) or (u1.FInterID=1410892 and u1.FEntryID=6) or (u1.FInterID=1410892 and u1.FEntryID=7) or (u1.FInterID=1410892 and u1.FEntryID=8) or (u1.FInterID=1410892 and u1.FEntryID=9) or (u1.FInterID=1467455 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=1) or (u1.FInterID=1808052 and u1.FEntryID=2) or (u1.FInterID=1808052 and u1.FEntryID=3) or (u1.FInterID=1808106 and u1.FEntryID=1) or (u1.FInterID=1808106 and u1.FEntryID=2) or (u1.FInterID=1808106 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=1) or (u1.FInterID=2604708 and u1.FEntryID=2) or (u1.FInterID=2604708 and u1.FEntryID=3) or (u1.FInterID=2604708 and u1.FEntryID=4) or (u1.FInterID=2604763 and u1.FEntryID=1) or (u1.FInterID=2604763 and u1.FEntryID=2) or (u1.FInterID=2604763 and u1.FEntryID=3) or (u1.FInterID=2604763 and u1.FEntryID=4) or (u1.FInterID=2604818 and u1.FEntryID=1) or (u1.FInterID=2604818 and u1.FEntryID=2) or (u1.FInterID=2604818 and u1.FEntryID=3) or (u1.FInterID=2604818 and u1.FEntryID=4) or (u1.FInterID=2604873 and u1.FEntryID=1) or (u1.FInterID=2604873 and u1.FEntryID=2) or (u1.FInterID=2604873 and u1.FEntryID=3) or (u1.FInterID=2604873 and u1.FEntryID=4) or (u1.FInterID=2655791 and u1.FEntryID=10) or (u1.FInterID=2670010 and u1.FEntryID=1) or (u1.FInterID=2670010 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=1) or (u1.FInterID=2829687 and u1.FEntryID=2) or (u1.FInterID=2829687 and u1.FEntryID=3) or (u1.FInterID=2829687 and u1.FEntryID=4) or (u1.FInterID=2829687 and u1.FEntryID=5) or (u1.FInterID=2829743 and u1.FEntryID=1) or (u1.FInterID=2829743 and u1.FEntryID=2) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=2829743 and u1.FEntryID=3) or (u1.FInterID=2829743 and u1.FEntryID=4) or (u1.FInterID=2829743 and u1.FEntryID=5) or (u1.FInterID=2829799 and u1.FEntryID=1) or (u1.FInterID=2829799 and u1.FEntryID=2) or (u1.FInterID=2829799 and u1.FEntryID=3) or (u1.FInterID=2829799 and u1.FEntryID=4) or (u1.FInterID=2829799 and u1.FEntryID=5) or (u1.FInterID=2829855 and u1.FEntryID=1) or (u1.FInterID=2829855 and u1.FEntryID=2) or (u1.FInterID=2829855 and u1.FEntryID=3) or (u1.FInterID=2829855 and u1.FEntryID=4) or (u1.FInterID=2829855 and u1.FEntryID=5) or (u1.FInterID=2829911 and u1.FEntryID=1) or (u1.FInterID=2829911 and u1.FEntryID=2) or (u1.FInterID=2829911 and u1.FEntryID=3) or (u1.FInterID=2829965 and u1.FEntryID=1) or (u1.FInterID=2829965 and u1.FEntryID=2) or (u1.FInterID=2829965 and u1.FEntryID=3) or (u1.FInterID=2830019 and u1.FEntryID=1) or (u1.FInterID=2830019 and u1.FEntryID=2) or (u1.FInterID=2830019 and u1.FEntryID=3) or (u1.FInterID=2830073 and u1.FEntryID=1) or (u1.FInterID=2830073 and u1.FEntryID=2) or (u1.FInterID=2830073 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=2) or (u1.FInterID=2839759 and u1.FEntryID=3) or (u1.FInterID=2839759 and u1.FEntryID=4) or (u1.FInterID=2839759 and u1.FEntryID=5) or (u1.FInterID=2839815 and u1.FEntryID=2) or (u1.FInterID=2839815 and u1.FEntryID=3) or (u1.FInterID=2839815 and u1.FEntryID=4) or (u1.FInterID=2839815 and u1.FEntryID=5) or (u1.FInterID=2839983 and u1.FEntryID=2) or (u1.FInterID=2839983 and u1.FEntryID=3) or (u1.FInterID=2839983 and u1.FEntryID=4) or (u1.FInterID=2839983 and u1.FEntryID=5) or (u1.FInterID=2840039 and u1.FEntryID=2) or (u1.FInterID=2840039 and u1.FEntryID=3) or (u1.FInterID=2840039 and u1.FEntryID=4) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4734333 and u1.FEntryID=1) or (u1.FInterID=4734333 and u1.FEntryID=2) or (u1.FInterID=4734333 and u1.FEntryID=3) or (u1.FInterID=4734333 and u1.FEntryID=4) or (u1.FInterID=4734333 and u1.FEntryID=5) or (u1.FInterID=4734389 and u1.FEntryID=1) or (u1.FInterID=4734389 and u1.FEntryID=2) or (u1.FInterID=4734389 and u1.FEntryID=3) or (u1.FInterID=4734389 and u1.FEntryID=4) or (u1.FInterID=4734444 and u1.FEntryID=1) or (u1.FInterID=4734444 and u1.FEntryID=2) or (u1.FInterID=4734444 and u1.FEntryID=3) or (u1.FInterID=4734444 and u1.FEntryID=4) or (u1.FInterID=4734499 and u1.FEntryID=1) or (u1.FInterID=4734499 and u1.FEntryID=2) or (u1.FInterID=4734499 and u1.FEntryID=3) or (u1.FInterID=4734499 and u1.FEntryID=4) or (u1.FInterID=4734554 and u1.FEntryID=1) or (u1.FInterID=4734554 and u1.FEntryID=2) or (u1.FInterID=4734554 and u1.FEntryID=3) or (u1.FInterID=4734554 and u1.FEntryID=4) or (u1.FInterID=4734609 and u1.FEntryID=1) or (u1.FInterID=4734609 and u1.FEntryID=2) or (u1.FInterID=4734609 and u1.FEntryID=3) or (u1.FInterID=4734663 and u1.FEntryID=1) or (u1.FInterID=4734663 and u1.FEntryID=2) or (u1.FInterID=4734663 and u1.FEntryID=3) or (u1.FInterID=4734717 and u1.FEntryID=1) or (u1.FInterID=4734717 and u1.FEntryID=2) or (u1.FInterID=4734717 and u1.FEntryID=3) or (u1.FInterID=4734771 and u1.FEntryID=1) or (u1.FInterID=4734771 and u1.FEntryID=2) or (u1.FInterID=4734824 and u1.FEntryID=1) or (u1.FInterID=4734824 and u1.FEntryID=2) or (u1.FInterID=4734877 and u1.FEntryID=1) or (u1.FInterID=4734877 and u1.FEntryID=2) or (u1.FInterID=4734930 and u1.FEntryID=1) or (u1.FInterID=4734930 and u1.FEntryID=2) or (u1.FInterID=4734983 and u1.FEntryID=1) or (u1.FInterID=4734983 and u1.FEntryID=2) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4734983 and u1.FEntryID=3) or (u1.FInterID=4734983 and u1.FEntryID=4) or (u1.FInterID=4734983 and u1.FEntryID=5) or (u1.FInterID=4735039 and u1.FEntryID=1) or (u1.FInterID=4735039 and u1.FEntryID=2) or (u1.FInterID=4735039 and u1.FEntryID=3) or (u1.FInterID=4735039 and u1.FEntryID=4) or (u1.FInterID=4735094 and u1.FEntryID=1) or (u1.FInterID=4735094 and u1.FEntryID=2) or (u1.FInterID=4735147 and u1.FEntryID=1) or (u1.FInterID=4735147 and u1.FEntryID=2) or (u1.FInterID=4735200 and u1.FEntryID=1) or (u1.FInterID=4735200 and u1.FEntryID=2) or (u1.FInterID=4735200 and u1.FEntryID=3) or (u1.FInterID=4735200 and u1.FEntryID=4) or (u1.FInterID=4735411 and u1.FEntryID=1) or (u1.FInterID=4735411 and u1.FEntryID=2) or (u1.FInterID=4735411 and u1.FEntryID=3) or (u1.FInterID=4735411 and u1.FEntryID=4) or (u1.FInterID=4735466 and u1.FEntryID=1) or (u1.FInterID=4735466 and u1.FEntryID=2) or (u1.FInterID=4735466 and u1.FEntryID=3) or (u1.FInterID=4735466 and u1.FEntryID=4) or (u1.FInterID=4735466 and u1.FEntryID=5) or (u1.FInterID=4735982 and u1.FEntryID=1) or (u1.FInterID=4735982 and u1.FEntryID=2) or (u1.FInterID=4736035 and u1.FEntryID=1) or (u1.FInterID=4736035 and u1.FEntryID=2) or (u1.FInterID=4736035 and u1.FEntryID=3) or (u1.FInterID=4736035 and u1.FEntryID=4) or (u1.FInterID=4736035 and u1.FEntryID=5) or (u1.FInterID=4736091 and u1.FEntryID=1) or (u1.FInterID=4736091 and u1.FEntryID=2) or (u1.FInterID=4736196 and u1.FEntryID=1) or (u1.FInterID=4736196 and u1.FEntryID=2) or (u1.FInterID=4736196 and u1.FEntryID=3) or (u1.FInterID=4736250 and u1.FEntryID=1) or (u1.FInterID=4736250 and u1.FEntryID=2) or (u1.FInterID=4736303 and u1.FEntryID=1) or (u1.FInterID=4736303 and u1.FEntryID=2) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4749496 and u1.FEntryID=3) or (u1.FInterID=4749496 and u1.FEntryID=4) or (u1.FInterID=4749496 and u1.FEntryID=5) or (u1.FInterID=4749552 and u1.FEntryID=1) or (u1.FInterID=4749552 and u1.FEntryID=2) or (u1.FInterID=4749605 and u1.FEntryID=1) or (u1.FInterID=4749605 and u1.FEntryID=2) or (u1.FInterID=4749605 and u1.FEntryID=3) or (u1.FInterID=4749605 and u1.FEntryID=4) or (u1.FInterID=4749605 and u1.FEntryID=5) or (u1.FInterID=4749605 and u1.FEntryID=6) or (u1.FInterID=4749662 and u1.FEntryID=1) or (u1.FInterID=4749662 and u1.FEntryID=2) or (u1.FInterID=4749662 and u1.FEntryID=3) or (u1.FInterID=4749662 and u1.FEntryID=4) or (u1.FInterID=4749662 and u1.FEntryID=5) or (u1.FInterID=4749718 and u1.FEntryID=1) or (u1.FInterID=4749718 and u1.FEntryID=2) or (u1.FInterID=4749718 and u1.FEntryID=3) or (u1.FInterID=4749718 and u1.FEntryID=4) or (u1.FInterID=4749718 and u1.FEntryID=5) or (u1.FInterID=4749774 and u1.FEntryID=1) or (u1.FInterID=4749774 and u1.FEntryID=2) or (u1.FInterID=4749774 and u1.FEntryID=3) or (u1.FInterID=4749774 and u1.FEntryID=4) or (u1.FInterID=4749774 and u1.FEntryID=5) or (u1.FInterID=4749830 and u1.FEntryID=1) or (u1.FInterID=4749830 and u1.FEntryID=2) or (u1.FInterID=4749830 and u1.FEntryID=3) or (u1.FInterID=4749830 and u1.FEntryID=4) or (u1.FInterID=4749830 and u1.FEntryID=5) or (u1.FInterID=4749886 and u1.FEntryID=1) or (u1.FInterID=4749886 and u1.FEntryID=2) or (u1.FInterID=4749886 and u1.FEntryID=3) or (u1.FInterID=4750595 and u1.FEntryID=1) or (u1.FInterID=4753991 and u1.FEntryID=1) or (u1.FInterID=4754043 and u1.FEntryID=1) or (u1.FInterID=4754095 and u1.FEntryID=1) or (u1.FInterID=4754199 and u1.FEntryID=1) or (u1.FInterID=4754303 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t4.FShortNumber AS FShortNumber,
t4.FModel AS FItemModel,
 Case when v1.FBillType=11621 then t30.FAuxQtyShift else t3.FAuxQty end  AS FAuxQty,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
u1.Fpriority AS Fpriority,
v1.FDate AS FDate,
u1.FCheckDate AS FCheckDate,
t7.FName AS FBillerID,
t8.FName AS FCheckerIDName,
u1.FOperNote AS FOperNote,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t10.FName AS FWorkName,
t50.FName AS FDeptName,
t25.FName AS FDeviceName,
t11.FName AS FTimeName,
u1.FLeadTime AS FLeadTime,
u1.FTimeSetup AS FTimeSetup,
u1.FWorkQty AS FWorkQty,
u1.FTimeRun AS FTimeRun,
u1.FTotalWorkTime AS FTotalTimeRun,
u1.FMoveQty AS FMoveQty,
u1.FMoveTime AS FMoveTime,
u1.FAuxQtyReceiveSel AS FAuxQtyReceiveSel,
u1.FStartWorkDate AS FStartWorkDate,
u1.FEndWorkDate AS FEndWorkDate,
u1.FAuxqtyScrap AS FAuxqtyScrap,
u1.FAuxqtyForItem AS FAuxqtyForItem,
u1.FAuxQtyHandOverSel AS FAuxQtyHandOverSel,
u1.FFinishTime AS FFinishTime,
u1.FReadyTime AS FReadyTime,
u1.FFixTime AS FFixTime,
u1.FNote AS FNote,
t20.FName AS FFare,
t22.FName AS FSupplier,
u1.FFee AS FFee,
u1.FFee*u1.FQtyPlan AS FTotalFee,
CASE u1.FBackFlushed WHEN 1 THEN '*' ELSE '' END AS FBackFlushed,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
t26.FName AS FQualityChk,
t27.FSchemeName AS FQualityScheme,
t28.FName AS FManager,
u1.FPieceRate AS FPieceRate,
u1.FAuxQtyTaskDispSel AS FAuxQtyTaskDispSel,
u1.FAuxQtyTaskDispAck AS FAuxQtyTaskDispAck,
u1.FResourceCount AS FResourceCount,
t29.FName AS FBillType,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
u1.FAuxQualifiedReprocessedQty AS FAuxQualifiedReprocessedQty,
u1.FAuxReprocessedMoveQty AS FAuxReprocessedMoveQty,
u1.FAuxReprocessedMoveSelQty AS FAuxReprocessedMoveSelQty,
u1.FAuxRepReceiveQty AS FAuxRepReceiveQty,
u1.FAuxRepReceiveSelQty AS FAuxRepReceiveSelQty,
t3.fgmpbatchno AS fgmpbatchno,
u1.FAuxQtyLost AS FAuxQtyLost,
u1.FAuxQtyLostSel AS FAuxQtyLostSel,
u1.FAuxQtyGain AS FAuxQtyGain,
u1.FAuxQtyGainSel AS FAuxQtyGainSel,
u1.FAuxConvertQtyHandover AS FAuxConvertQtyHandover,
u1.FAuxConvertQtyRecive AS FAuxConvertQtyRecive,
u1.FChangeTimes AS FChangeTimes,
v1.FICMOInterID AS FICMOInterID,
v1.FOrderBillNo AS FOrderBillNo,
v1.FOrderEntryID AS FOrderEntryID,
u1.FHRReadyTime AS FHRReadyTime,
v1.FPrintCount AS FPrintCount,
u1.FEntrySelfz0374 AS FEntrySelfz0374,
u1.FEntrySelfz0375 AS FEntrySelfz0375,
u1.FEntrySelfz0376 AS FEntrySelfz0376 from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4754355 and u1.FEntryID=1) or (u1.FInterID=4754407 and u1.FEntryID=1) or (u1.FInterID=4754459 and u1.FEntryID=1) or (u1.FInterID=4754563 and u1.FEntryID=1) or (u1.FInterID=4754667 and u1.FEntryID=1) or (u1.FInterID=4754719 and u1.FEntryID=1) or (u1.FInterID=4754771 and u1.FEntryID=1) or (u1.FInterID=4754875 and u1.FEntryID=1) or (u1.FInterID=4754927 and u1.FEntryID=1) or (u1.FInterID=4754979 and u1.FEntryID=1) or (u1.FInterID=4755031 and u1.FEntryID=1) or (u1.FInterID=4755379 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FEntryID as FEntryID_Number,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FAuxQtyPlan as FAuxQtyPlan,u1.FAuxQtyrecive as FAuxQtyrecive,u1.FAuxQtyFinish as FAuxQtyFinish,u1.FAuxQtyPass as FAuxQtyPass,u1.FAuxqtyHandOver as FAuxqtyHandOver,u1.FAuxReprocessedQty as FAuxReprocessedQty,u1.FEntryID as FEntryID,u1.FLeadTime as FLeadTime,u1.FTimeSetup as FTimeSetup,u1.FWorkQty as FWorkQty,u1.FTimeRun as FTimeRun,u1.FTotalWorkTime as FTotalTimeRun,u1.FMoveQty as FMoveQty,u1.FMoveTime as FMoveTime,u1.FAuxQtyReceiveSel as FAuxQtyReceiveSel,u1.FAuxqtyScrap as FAuxqtyScrap,u1.FAuxqtyForItem as FAuxqtyForItem,u1.FAuxQtyHandOverSel as FAuxQtyHandOverSel,u1.FFinishTime as FFinishTime,u1.FReadyTime as FReadyTime,u1.FFixTime as FFixTime,t4.FQtyDecimal as FQtyDecimal,t4.FQtyDecimal as FPriceDecimal,u1.FAuxQtyTaskDispSel as FAuxQtyTaskDispSel,u1.FAuxQtyTaskDispAck as FAuxQtyTaskDispAck,u1.FAuxQualifiedReprocessedQty as FAuxQualifiedReprocessedQty,u1.FAuxReprocessedMoveQty as FAuxReprocessedMoveQty,u1.FAuxReprocessedMoveSelQty as FAuxReprocessedMoveSelQty,u1.FAuxRepReceiveQty as FAuxRepReceiveQty,u1.FAuxRepReceiveSelQty as FAuxRepReceiveSelQty,u1.FAuxQtyLost as FAuxQtyLost,u1.FAuxQtyLostSel as FAuxQtyLostSel,u1.FAuxQtyGain as FAuxQtyGain,u1.FAuxQtyGainSel as FAuxQtyGainSel,u1.FAuxConvertQtyHandover as FAuxConvertQtyHandover,u1.FAuxConvertQtyRecive as FAuxConvertQtyRecive,u1.FHRReadyTime as FHRReadyTime from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 LEFT OUTER JOIN t_subMessage t11 ON   u1.FTimeUnit = t11.FInterID  AND t11.FInterID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_User t7 ON   v1.FBillerID = t7.FUserID  AND t7.FUserID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_department t50 ON   t10.FDeptID = t50.FItemID  AND t50.FItemID<>0 
 LEFT OUTER JOIN t_submessage t20 ON   u1.FFare = t20.FInterID  AND t20.FInterID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_Supplier t22 ON   u1.FSupplyID = t22.FItemID  AND t22.FItemID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN t_resource t25 ON   u1.FDeviceID = t25.FInterId  AND t25.FInterId<>0 
 LEFT OUTER JOIN t_submessage t26 ON   u1.FQualityChkID = t26.FInterId  AND t26.FInterId<>0 
 LEFT OUTER JOIN icqcscheme t27 ON   u1.FQualitySHcemeID = t27.FInterId  AND t27.FInterId<>0 
 LEFT OUTER JOIN t_emp t28 ON   u1.FFManagerID = t28.FItemID  AND t28.FItemID<>0 
 LEFT OUTER JOIN t_submessage t29 ON   v1.FBillType = t29.FInterId  AND t29.FInterId<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND  (u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0)
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SaveListColWidth'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FValue FROM ICSchemeProfileEntry WHERE FSchemeID=0 AND FKey='HideColumns'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
UPDATE ICChatBillTitle SET FVisible=3,FVisForQuest=1,FVisForOrder=1 WHERE FTypeID=601 AND FColName='FPieceRate'
go
 Drop Table #DATA 
go
 Drop Table #DATA1 
go
 Drop Table #DATA2 
go
 Drop Table #DATA3 
go
 Drop Table #DATA4 
go
 Drop Table #DATA5 
go
 Drop Table #DataIcmo 
go
 Drop Table #Repdata 
go
 Drop Table #DATAPPBOM 
go
 Drop table #Temp_WorkCalAbility 
go
 Drop table #TepICMOAllId 
go
 Drop table #UpdateItemReplace 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT FCategory,FKey,FValue FROM t_SystemProfile 
WHERE FCategory='IC' AND FKey IN ('StartBranchSale','ShowRelationSign','AuditChoice','PrecisionOfDiscountRate',
'StartPeriod','ListMaxRows','')
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
Select FID,FName As FName ,FTemplateID,FFontID,FLogicStr,FToolBarVis,FHeadVis,FBottomVis,FSourceType,FSourceSql,FGroupID,FBillTemplateID,FNeedCount,FHeadHeight,FBottomHeight,FType,FGetDataType,FMenuID,FBillCls,FFilter,FRptTemplateID,FMasterTable,FNeedStatistic From ICListtemplate  Where FID=601
go
Select FInterID,FTypeID,FColCaption as FColCaption_CHS,FColCaption As FColCaption ,FHeadSecond,FColName,FTableName,FColType, FColWidth,FVisible,FItemClassID,FVisForQuest,FReturnDataType,FCountPriceType, FCtlIndex,Case When FColName = 'FSourceTranType' Then 'FName' Else FName End As FName,FTableAlias,FAction,FNeedCount,FIsPrimary,FLogicAction,FStatistical,FMergeable,FVisForOrder,FControl,FMode,FControlType,FEditable,FFormat,FFormatType,FAlign,FMustSelected
FROM ICChatBillTitle Where FTypeID IN (select FTemplateID From ICListtemplate  Where FID=601) order by FInterID
go
Select * from ICTableRelation where  FIndex=0 AND FTypeID IN (select FTemplateID From ICListtemplate Where FID=601) order by FInterID
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT * FROM ICSchemeProfile WHERE FUserID=16415
 AND FSysName='(601)' AND FTranType IN (601) AND  FListShowStatus = 2

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select t1.FROB From ICTransactionType t1,ICListTemplate t2  Where t1.FID=t2.FBillTemplateID and t2.FTemplateID=601
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select t1.FROB From ICTransactionType t1,ICListTemplate t2  Where t1.FID=t2.FBillTemplateID and t2.FTemplateID=601
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FInterID From ICChatBillTitle where FTypeID = 601 And FColName = 'FCancellation'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FInterID From ICChatBillTitle where FTypeID = 601 And FColName = 'FCancellation'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT MAX(FSchemeID) AS MAXID FROM ICSchemeProfile
go
SET NO_BROWSETABLE ON
go
SELECT FStatus From ICSchemeProfile WHERE FSysName='(601)' AND FUserID=16415 AND FStatus in (1,2)
 AND FListShowStatus = 2
go
SET NO_BROWSETABLE OFF
go
INSERT INTO ICSchemeProfile( 
 FSchemeID , FSchemeName , FUserID , 
 FTranType , FSysName , FStatus , FListShowStatus 
 ) VALUES(
6412,'默认方案',16415,
601,'(601)',2 , 2
)
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboTransType','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboTime','2')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboICMO','3')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboKickBack','2')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'OrderBy','')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'Relation','')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'HideColumns','1##<&1418##<&1##<&FWorkBillNo##<&0||1##<&908##<&2##<&FStatusName##<&0||1##<&1872##<&3##<&FLongNumber##<&0||1##<&1418##<&4##<&FItemName##<&0||1##<&1872##<&5##<&FOperID##<&0||1##<&1418##<&6##<&FOperName##<&0||1##<&567##<&7##<&FOperSN##<&0||1##<&567##<&8##<&FUnitName##<&0||1##<&964##<&9##<&FAuxQtyPlan##<&0||1##<&964##<&10##<&FAuxQtyrecive##<&0||1##<&964##<&11##<&FAuxQtyFinish##<&0||1##<&964##<&12##<&FAuxQtyPass##<&0||1##<&964##<&13##<&FAuxqtyHandOver##<&0||1##<&964##<&14##<&FAuxReprocessedQty##<&0||1##<&1021##<&15##<&FPlanStartDate##<&0||1##<&1021##<&16##<&FPlanEndDate##<&0||1##<&964##<&17##<&FTeamName##<&0||1##<&794##<&18##<&FWoerkerName##<&0||1##<&567##<&19##<&FIsOut##<&0||1##<&567##<&20##<&FAutoTD##<&0||1##<&567##<&21##<&FAutoOF##<&0||0##<&1000##<&22##<&FICMOBillNo##<&0||0##<&1000##<&23##<&FShortNumber##<&0||0##<&1000##<&24##<&FItemModel##<&0||0##<&1000##<&25##<&FAuxQty##<&0||0##<&1000##<&26##<&FBaseUnitID##<&0||0##<&1196##<&27##<&FPlanCommitDate##<&0||0##<&1196##<&28##<&FPlanFinishDate##<&0||0##<&1000##<&29##<&Fpriority##<&0||0##<&1196##<&30##<&FDate##<&0||0##<&1196##<&31##<&FCheckDate##<&0||0##<&1196##<&32##<&FBillerID##<&0||0##<&1196##<&33##<&FCheckerIDName##<&0||0##<&1000##<&34##<&FOperNote##<&0||0##<&1000##<&35##<&FWorkNumber##<&0||0##<&1000##<&36##<&FWorkShortNumber##<&0||0##<&1000##<&37##<&FWorkName##<&0||0##<&1000##<&38##<&FDeptName##<&0||0##<&1000##<&39##<&FDeviceName##<&0||0##<&1000##<&40##<&FTimeName##<&0||0##<&1000##<&41##<&FLeadTime##<&0||0##<&1000##<&42##<&FTimeSetup##<&0||0##<&1000##<&43##<&FWorkQty##<&0||0##<&1000##<&44##<&FTimeRun##<&0||0##<&1000##<&45##<&FTotalTimeRun##<&0||0##<&1000##<&46##<&FMoveQty##<&0||0##<&1000##<&47##<&FMoveTime##<&0||0##<&1000##<&48##<&FAuxQtyReceiveSel##<&0||0##<&1196##<&49##<&FStartWorkDate##<&0||0##<&1196##<&50##<&FEndWorkDate##<&0||0##<&1000##<&51##<&FAuxqtyScrap##<&0||0##<&1000##<&52##<&FAuxqtyForItem##<&0||0##<&1000##<&53##<&FAuxQtyHandOverSel##<&0||0##<&1000##<&54##<&FFinishTime##<&0||0##<&1000##<&55##<&FReadyTime##<&0||0##<&1000##<&56##<&FFixTime##<&0||0##<&1000##<&57##<&FNote##<&0||0##<&1000##<&58##<&FFare##<&0||0##<&1000##<&59##<&FSupplier##<&0||0##<&1000##<&60##<&FFee##<&0||0##<&1000##<&61##<&FTotalFee##<&0||0##<&1000##<&62##<&FBackFlushed##<&0||0##<&1000##<&63##<&FQualityChk##<&0||0##<&1000##<&64##<&FQualityScheme##<&0||0##<&1000##<&65##<&FManager##<&0||1##<&1000##<&66##<&FPieceRate##<&0||0##<&1000##<&67##<&FAuxQtyTaskDispSel##<&0||0##<&1000##<&68##<&FAuxQtyTaskDispAck##<&0||0##<&1000##<&69##<&FResourceCount##<&0||0##<&1000##<&70##<&FBillType##<&0||0##<&1000##<&71##<&FOperShiftBillID##<&0||0##<&1000##<&72##<&FOriginWBID##<&0||0##<&1000##<&73##<&FAuxQualifiedReprocessedQty##<&0||0##<&1000##<&74##<&FAuxReprocessedMoveQty##<&0||0##<&1000##<&75##<&FAuxReprocessedMoveSelQty##<&0||0##<&1000##<&76##<&FAuxRepReceiveQty##<&0||0##<&1000##<&77##<&FAuxRepReceiveSelQty##<&0||0##<&1000##<&78##<&fgmpbatchno##<&0||0##<&1000##<&79##<&FAuxQtyLost##<&0||0##<&1000##<&80##<&FAuxQtyLostSel##<&0||0##<&1000##<&81##<&FAuxQtyGain##<&0||0##<&1000##<&82##<&FAuxQtyGainSel##<&0||0##<&1000##<&83##<&FAuxConvertQtyHandover##<&0||0##<&1000##<&84##<&FAuxConvertQtyRecive##<&0||0##<&1000##<&85##<&FChangeTimes##<&0||0##<&1000##<&86##<&FOrderBillNo##<&0||0##<&1000##<&87##<&FOrderEntryID##<&0||0##<&1000##<&88##<&FHRReadyTime##<&0||1##<&1000##<&89##<&FPrintCount##<&0||0##<&1000##<&90##<&FEntrySelfz0374##<&0||0##<&1000##<&91##<&FEntrySelfz0375##<&0||0##<&1000##<&92##<&FEntrySelfz0376##<&0||')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'FrezCol','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(0)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboConditions(0)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(1)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboConditions(1)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(2)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'AdvancedQuery','')

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT * FROM ICListFilter 
WHERE FListID = 601 And FListShowStatus = 2
 AND FDestBillTranType=1002510 AND FBillROB=0
 AND FCheckSwitch=0
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT * FROM ICSchemeProfile WHERE FSchemeID=6412
SELECT * FROM ICSchemeProfileEntry WHERE FSchemeID=6412

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
select FKey,FValue from t_SystemProfile where FCategory='IC' and  (FKey='CurrentPeriod' or FKey = 'CurrentYear')
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select getdate() 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select t1.FROB From ICTransactionType t1,ICListTemplate t2  Where t1.FID=t2.FBillTemplateID and t2.FTemplateID=601
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FBillTemplateID FROM ICListTemplate WHERE FID =  601
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT FDeBCondition FROM ICClassLink WHERE FSourClassTypeID = -52 and FDestClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='StartBranchSale'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ShowRelationSign'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
select t_User.FUserID from t_Group, t_User 
 where t_Group.FUserID = t_User.FUserID 
 And t_User.FUserID = 16415and t_Group.FGroupID = 1 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
 Select FValue From t_Systemprofile Where FCategory = 'IC' and FKey='CheckUserGroup' 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT * FROM ICTableRelation WHERE FTypeID=601 ORDER BY FInterID,FTableNameAlias,FFieldName,FTableNameAlias11,FFieldName11,FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select FValue from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT COUNT(FID) FROM t_UserProfile WHERE FUserID = 16415 AND FCategory = 'FilterSet601' AND FKey = 'SelBillFilterOption'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='NeedShowColumnPrompt'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
DELETE FROM ICSchemeProfile WHERE FSchemeID=6412
DELETE FROM ICSchemeProfileEntry WHERE FSchemeID=6412

go
SET NO_BROWSETABLE ON
go
SELECT FStatus From ICSchemeProfile WHERE FSysName='(601)' AND FUserID=16415 AND FStatus in (1,2)
 AND FListShowStatus = 2
go
SET NO_BROWSETABLE OFF
go
INSERT INTO ICSchemeProfile( 
 FSchemeID , FSchemeName , FUserID , 
 FTranType , FSysName , FStatus , FListShowStatus 
 ) VALUES(
6412,'默认方案',16415,
601,'(601)',2 , 2
)
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboTransType','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboTime','2')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboICMO','3')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'OrderBy','')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'Relation','##<&工序计划开工日期##<&3##<&4##<&2016-08-01##<&2016-08-01##<&15##<&##<&##<&##<&##<&||')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'HideColumns','1##<&1418##<&1##<&FWorkBillNo##<&0||1##<&908##<&2##<&FStatusName##<&0||1##<&1872##<&3##<&FLongNumber##<&0||1##<&1418##<&4##<&FItemName##<&0||1##<&1872##<&5##<&FOperID##<&0||1##<&1418##<&6##<&FOperName##<&0||1##<&567##<&7##<&FOperSN##<&0||1##<&567##<&8##<&FUnitName##<&0||1##<&964##<&9##<&FAuxQtyPlan##<&0||1##<&964##<&10##<&FAuxQtyrecive##<&0||1##<&964##<&11##<&FAuxQtyFinish##<&0||1##<&964##<&12##<&FAuxQtyPass##<&0||1##<&964##<&13##<&FAuxqtyHandOver##<&0||1##<&964##<&14##<&FAuxReprocessedQty##<&0||1##<&1021##<&15##<&FPlanStartDate##<&0||1##<&1021##<&16##<&FPlanEndDate##<&0||1##<&964##<&17##<&FTeamName##<&0||1##<&794##<&18##<&FWoerkerName##<&0||1##<&567##<&19##<&FIsOut##<&0||1##<&567##<&20##<&FAutoTD##<&0||1##<&567##<&21##<&FAutoOF##<&0||0##<&1000##<&22##<&FICMOBillNo##<&0||0##<&1000##<&23##<&FShortNumber##<&0||0##<&1000##<&24##<&FItemModel##<&0||0##<&1000##<&25##<&FAuxQty##<&0||0##<&1000##<&26##<&FBaseUnitID##<&0||0##<&1196##<&27##<&FPlanCommitDate##<&0||0##<&1196##<&28##<&FPlanFinishDate##<&0||0##<&1000##<&29##<&Fpriority##<&0||0##<&1196##<&30##<&FDate##<&0||0##<&1196##<&31##<&FCheckDate##<&0||0##<&1196##<&32##<&FBillerID##<&0||0##<&1196##<&33##<&FCheckerIDName##<&0||0##<&1000##<&34##<&FOperNote##<&0||0##<&1000##<&35##<&FWorkNumber##<&0||0##<&1000##<&36##<&FWorkShortNumber##<&0||0##<&1000##<&37##<&FWorkName##<&0||0##<&1000##<&38##<&FDeptName##<&0||0##<&1000##<&39##<&FDeviceName##<&0||0##<&1000##<&40##<&FTimeName##<&0||0##<&1000##<&41##<&FLeadTime##<&0||0##<&1000##<&42##<&FTimeSetup##<&0||0##<&1000##<&43##<&FWorkQty##<&0||0##<&1000##<&44##<&FTimeRun##<&0||0##<&1000##<&45##<&FTotalTimeRun##<&0||0##<&1000##<&46##<&FMoveQty##<&0||0##<&1000##<&47##<&FMoveTime##<&0||0##<&1000##<&48##<&FAuxQtyReceiveSel##<&0||0##<&1196##<&49##<&FStartWorkDate##<&0||0##<&1196##<&50##<&FEndWorkDate##<&0||0##<&1000##<&51##<&FAuxqtyScrap##<&0||0##<&1000##<&52##<&FAuxqtyForItem##<&0||0##<&1000##<&53##<&FAuxQtyHandOverSel##<&0||0##<&1000##<&54##<&FFinishTime##<&0||0##<&1000##<&55##<&FReadyTime##<&0||0##<&1000##<&56##<&FFixTime##<&0||0##<&1000##<&57##<&FNote##<&0||0##<&1000##<&58##<&FFare##<&0||0##<&1000##<&59##<&FSupplier##<&0||0##<&1000##<&60##<&FFee##<&0||0##<&1000##<&61##<&FTotalFee##<&0||0##<&1000##<&62##<&FBackFlushed##<&0||0##<&1000##<&63##<&FQualityChk##<&0||0##<&1000##<&64##<&FQualityScheme##<&0||0##<&1000##<&65##<&FManager##<&0||1##<&1000##<&66##<&FPieceRate##<&0||0##<&1000##<&67##<&FAuxQtyTaskDispSel##<&0||0##<&1000##<&68##<&FAuxQtyTaskDispAck##<&0||0##<&1000##<&69##<&FResourceCount##<&0||0##<&1000##<&70##<&FBillType##<&0||0##<&1000##<&71##<&FOperShiftBillID##<&0||0##<&1000##<&72##<&FOriginWBID##<&0||0##<&1000##<&73##<&FAuxQualifiedReprocessedQty##<&0||0##<&1000##<&74##<&FAuxReprocessedMoveQty##<&0||0##<&1000##<&75##<&FAuxReprocessedMoveSelQty##<&0||0##<&1000##<&76##<&FAuxRepReceiveQty##<&0||0##<&1000##<&77##<&FAuxRepReceiveSelQty##<&0||0##<&1000##<&78##<&fgmpbatchno##<&0||0##<&1000##<&79##<&FAuxQtyLost##<&0||0##<&1000##<&80##<&FAuxQtyLostSel##<&0||0##<&1000##<&81##<&FAuxQtyGain##<&0||0##<&1000##<&82##<&FAuxQtyGainSel##<&0||0##<&1000##<&83##<&FAuxConvertQtyHandover##<&0||0##<&1000##<&84##<&FAuxConvertQtyRecive##<&0||0##<&1000##<&85##<&FChangeTimes##<&0||0##<&1000##<&86##<&FOrderBillNo##<&0||0##<&1000##<&87##<&FOrderEntryID##<&0||0##<&1000##<&88##<&FHRReadyTime##<&0||1##<&1000##<&89##<&FPrintCount##<&0||0##<&1000##<&90##<&FEntrySelfz0374##<&0||0##<&1000##<&91##<&FEntrySelfz0375##<&0||0##<&1000##<&92##<&FEntrySelfz0376##<&0||')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'FrezCol','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(0)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboConditions(0)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(1)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboConditions(1)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'cboItem(2)','0')
INSERT INTO ICSchemeProfileEntry(FSchemeID,FType,FKey,FValue) VALUES(6412,0,'AdvancedQuery','')

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='QUICKSEARCH_601' AND FKey='UserLastProfile'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where FSection='QUICKSEARCH_601'AND FKey='DefaultProfile' AND FUserID=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FValue from icClassUserProfile where fSection='QUICKSEARCH_601'  and Fkey='DefaultField' and FuserId=-16394
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM ICSystemProfile WHERE FID=0 AND FKey='ShowAllBillHead' AND FCategory='IC'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FUserID from t_Group where FUserID = 16415 and FGroupID = 1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='PrecisionOfDiscountRate'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SInvoiceDecimal'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FAutoTD as FAutoTDID,u1.FEntryID as FEntryID_Number,u1.FWBInterID as FBillInterID,u1.FWorkBillNo as FBillNo,u1.FStatus as FStatus,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FEntryID as FEntryID,v1.FDate as FDate,v1.FICMOInterID as FICMOInterID, 0 As FBOSCloseFlag from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND (     
u1.FPlanStartDate >=  '2016-08-01' 
)  AND (( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  ) AND (((u1.FStatus=0 OR u1.FStatus=1 OR u1.FStatus=2 OR u1.FStatus=3))  AND (v1.FDate>='2016-06-01' AND  v1.FDate<'2016-07-01'))) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='ListMaxRows'
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
select t1.*,t2.FName as FFontName,t2.FColor,t2.FBold,t2.FItalic,t2.FSize from ICListTitle t1,ICFont t2 where t1.FFontID=t2.FID AND t1.FID=601 AND FType=0 order by FIndex
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
Select FValue From t_Systemprofile where  FCategory = 'IC' and FKey = 'EnableATP' 
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
SELECT FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='BrID'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
v1.FDate AS FDate,
t8.FName AS FCheckerIDName,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
u1.FPieceRate AS FPieceRate,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
v1.FICMOInterID AS FICMOInterID,
v1.FPrintCount AS FPrintCount from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4743492 and u1.FEntryID=1) or (u1.FInterID=4743544 and u1.FEntryID=1) or (u1.FInterID=4743596 and u1.FEntryID=1) or (u1.FInterID=4743700 and u1.FEntryID=1) or (u1.FInterID=4743752 and u1.FEntryID=1) or (u1.FInterID=4743804 and u1.FEntryID=1) or (u1.FInterID=4743856 and u1.FEntryID=1) or (u1.FInterID=4743908 and u1.FEntryID=1) or (u1.FInterID=4744012 and u1.FEntryID=1) or (u1.FInterID=4744064 and u1.FEntryID=1) or (u1.FInterID=4744116 and u1.FEntryID=1) or (u1.FInterID=4744168 and u1.FEntryID=1) or (u1.FInterID=4744220 and u1.FEntryID=1) or (u1.FInterID=4744272 and u1.FEntryID=1) or (u1.FInterID=4744324 and u1.FEntryID=1) or (u1.FInterID=4744376 and u1.FEntryID=1) or (u1.FInterID=4744428 and u1.FEntryID=1) or (u1.FInterID=4744480 and u1.FEntryID=1) or (u1.FInterID=4744532 and u1.FEntryID=1) or (u1.FInterID=4744584 and u1.FEntryID=1) or (u1.FInterID=4744636 and u1.FEntryID=1) or (u1.FInterID=4744688 and u1.FEntryID=1) or (u1.FInterID=4744792 and u1.FEntryID=1) or (u1.FInterID=4744896 and u1.FEntryID=1) or (u1.FInterID=4744948 and u1.FEntryID=1) or (u1.FInterID=4745000 and u1.FEntryID=1) or (u1.FInterID=4745052 and u1.FEntryID=1) or (u1.FInterID=4745104 and u1.FEntryID=1) or (u1.FInterID=4745208 and u1.FEntryID=1) or (u1.FInterID=4745260 and u1.FEntryID=1) or (u1.FInterID=4745312 and u1.FEntryID=1) or (u1.FInterID=4745416 and u1.FEntryID=1) or (u1.FInterID=4745468 and u1.FEntryID=1) or (u1.FInterID=4745520 and u1.FEntryID=1) or (u1.FInterID=4745572 and u1.FEntryID=1) or (u1.FInterID=4745624 and u1.FEntryID=1) or (u1.FInterID=4745676 and u1.FEntryID=1) or (u1.FInterID=4745728 and u1.FEntryID=1) or (u1.FInterID=4745780 and u1.FEntryID=1) or (u1.FInterID=4745832 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
v1.FDate AS FDate,
t8.FName AS FCheckerIDName,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
u1.FPieceRate AS FPieceRate,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
v1.FICMOInterID AS FICMOInterID,
v1.FPrintCount AS FPrintCount from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4745884 and u1.FEntryID=1) or (u1.FInterID=4745936 and u1.FEntryID=1) or (u1.FInterID=4746040 and u1.FEntryID=1) or (u1.FInterID=4746092 and u1.FEntryID=1) or (u1.FInterID=4750595 and u1.FEntryID=1) or (u1.FInterID=4753991 and u1.FEntryID=1) or (u1.FInterID=4754043 and u1.FEntryID=1) or (u1.FInterID=4754095 and u1.FEntryID=1) or (u1.FInterID=4754199 and u1.FEntryID=1) or (u1.FInterID=4754303 and u1.FEntryID=1) or (u1.FInterID=4754355 and u1.FEntryID=1) or (u1.FInterID=4754407 and u1.FEntryID=1) or (u1.FInterID=4754459 and u1.FEntryID=1) or (u1.FInterID=4754563 and u1.FEntryID=1) or (u1.FInterID=4754667 and u1.FEntryID=1) or (u1.FInterID=4754719 and u1.FEntryID=1) or (u1.FInterID=4754771 and u1.FEntryID=1) or (u1.FInterID=4754875 and u1.FEntryID=1) or (u1.FInterID=4754927 and u1.FEntryID=1) or (u1.FInterID=4754979 and u1.FEntryID=1) or (u1.FInterID=4755031 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FEntryID as FEntryID_Number,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FAuxQtyPlan as FAuxQtyPlan,u1.FAuxQtyrecive as FAuxQtyrecive,u1.FAuxQtyFinish as FAuxQtyFinish,u1.FAuxQtyPass as FAuxQtyPass,u1.FAuxqtyHandOver as FAuxqtyHandOver,u1.FAuxReprocessedQty as FAuxReprocessedQty,u1.FEntryID as FEntryID,t4.FQtyDecimal as FQtyDecimal,t4.FQtyDecimal as FPriceDecimal from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND (     
u1.FPlanStartDate >=  '2016-08-01' 
)  AND (( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  ) AND (((u1.FStatus=0 OR u1.FStatus=1 OR u1.FStatus=2 OR u1.FStatus=3))  AND (v1.FDate>='2016-06-01' AND  v1.FDate<'2016-07-01')))
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select top 50000 u1.FEntryID as FEntryID_Number,v1.FTranType as FTranType,u1.FInterID as FInterID,u1.FAuxQtyPlan as FAuxQtyPlan,u1.FAuxQtyrecive as FAuxQtyrecive,u1.FAuxQtyFinish as FAuxQtyFinish,u1.FAuxQtyPass as FAuxQtyPass,u1.FAuxqtyHandOver as FAuxqtyHandOver,u1.FAuxReprocessedQty as FAuxReprocessedQty,u1.FEntryID as FEntryID,t4.FQtyDecimal as FQtyDecimal,t4.FQtyDecimal as FPriceDecimal from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where 1=1 AND (     
u1.FPlanStartDate >=  '2016-08-01' 
)  AND (( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  ) AND (((u1.FStatus=0 OR u1.FStatus=1 OR u1.FStatus=2 OR u1.FStatus=3))  AND (v1.FDate>='2016-06-01' AND  v1.FDate<'2016-07-01')))
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED  SELECT FScale FROM t_Currency Where FCurrencyID=1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
v1.FDate AS FDate,
t8.FName AS FCheckerIDName,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
u1.FPieceRate AS FPieceRate,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
v1.FICMOInterID AS FICMOInterID,
v1.FPrintCount AS FPrintCount from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4601527 and u1.FEntryID=1) or (u1.FInterID=4601579 and u1.FEntryID=1) or (u1.FInterID=4601683 and u1.FEntryID=1) or (u1.FInterID=4601735 and u1.FEntryID=1) or (u1.FInterID=4601787 and u1.FEntryID=1) or (u1.FInterID=4601839 and u1.FEntryID=1) or (u1.FInterID=4601943 and u1.FEntryID=1) or (u1.FInterID=4602047 and u1.FEntryID=1) or (u1.FInterID=4602099 and u1.FEntryID=1) or (u1.FInterID=4602203 and u1.FEntryID=1) or (u1.FInterID=4602307 and u1.FEntryID=1) or (u1.FInterID=4602359 and u1.FEntryID=1) or (u1.FInterID=4602463 and u1.FEntryID=1) or (u1.FInterID=4602567 and u1.FEntryID=1) or (u1.FInterID=4602671 and u1.FEntryID=1) or (u1.FInterID=4602775 and u1.FEntryID=1) or (u1.FInterID=4602879 and u1.FEntryID=1) or (u1.FInterID=4602931 and u1.FEntryID=1) or (u1.FInterID=4603087 and u1.FEntryID=1) or (u1.FInterID=4603139 and u1.FEntryID=1) or (u1.FInterID=4603191 and u1.FEntryID=1) or (u1.FInterID=4603243 and u1.FEntryID=1) or (u1.FInterID=4603295 and u1.FEntryID=1) or (u1.FInterID=4603347 and u1.FEntryID=1) or (u1.FInterID=4603399 and u1.FEntryID=1) or (u1.FInterID=4603451 and u1.FEntryID=1) or (u1.FInterID=4603555 and u1.FEntryID=1) or (u1.FInterID=4603659 and u1.FEntryID=1) or (u1.FInterID=4603711 and u1.FEntryID=1) or (u1.FInterID=4603763 and u1.FEntryID=1) or (u1.FInterID=4603815 and u1.FEntryID=1) or (u1.FInterID=4603867 and u1.FEntryID=1) or (u1.FInterID=4603919 and u1.FEntryID=1) or (u1.FInterID=4604023 and u1.FEntryID=1) or (u1.FInterID=4604127 and u1.FEntryID=1) or (u1.FInterID=4604231 and u1.FEntryID=1) or (u1.FInterID=4604335 and u1.FEntryID=1) or (u1.FInterID=4604387 and u1.FEntryID=1) or (u1.FInterID=4604439 and u1.FEntryID=1) or (u1.FInterID=4604595 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select top 40 
t3.FStatus AS FICMOStatus,
t3.FSuspend AS FICMOSuspend,
u1.FAutoTD AS FAutoTDID,
u1.FEntryID AS FEntryID_Number,
u1.FWBInterID AS FBillInterID,
u1.FWorkBillNo AS FBillNo,
t4.FItemID AS FItemID,
u1.FStatus AS FStatus,
v1.FTranType AS FTranType,
u1.FInterID AS FInterID,
u1.FWorkBillNo AS FWorkBillNo,
CASE u1.FStatus WHEN 0 THEN '计划' WHEN 3 THEN '关闭' ELSE '审核' END AS FStatusName,
t4.FNumber AS FLongNumber,
t4.FName AS FItemName,
t9.FID AS FOperID,
t9.FName AS FOperName,
u1.FOperSN AS FOperSN,
t5.FName AS FUnitName,
u1.FAuxQtyPlan AS FAuxQtyPlan,
u1.FAuxQtyrecive AS FAuxQtyrecive,
u1.FAuxQtyFinish AS FAuxQtyFinish,
u1.FAuxQtyPass AS FAuxQtyPass,
u1.FAuxqtyHandOver AS FAuxqtyHandOver,
u1.FAuxReprocessedQty AS FAuxReprocessedQty,
u1.FPlanStartDate AS FPlanStartDate,
u1.FPlanEndDate AS FPlanEndDate,
t23.FName AS FTeamName,
t24.FName AS FWoerkerName,
t21.FName AS FIsOut,
t91.FName AS FAutoTD,
t92.FName AS FAutoOF,
t3.FBillNo AS FICMOBillNo,
t16.FName AS FBaseUnitID,
t3.FPlanCommitDate AS FPlanCommitDate,
t3.FPlanFinishDate AS FPlanFinishDate,
u1.FEntryID AS FEntryID,
v1.FDate AS FDate,
t8.FName AS FCheckerIDName,
t10.FNumber AS FWorkNumber,
t10.FShortNumber AS FWorkShortNumber,
t4.FQtyDecimal AS FQtyDecimal,
t4.FQtyDecimal AS FPriceDecimal,
u1.FPieceRate AS FPieceRate,
t30.FBillNo AS FOperShiftBillID,
t31.FWorkBillNo AS FOriginWBID,
v1.FICMOInterID AS FICMOInterID,
v1.FPrintCount AS FPrintCount from SHWorkBill v1 INNER JOIN SHWorkBillEntry u1 ON   v1.FInterID = u1.FInterID  AND u1.FInterID<>0 
 LEFT OUTER JOIN t_User t8 ON   u1.FCheckerID = t8.FUserID  AND t8.FUserID<>0 
 LEFT OUTER JOIN t_subMessage t9 ON   u1.FOperID = t9.FInterID  AND t9.FInterID<>0 
 INNER JOIN t_WorkCenter t10 ON   u1.FWorkCenterID = t10.FItemID  AND t10.FItemID<>0 
 INNER JOIN ICMO t3 ON   v1.FICMOInterID = t3.FInterID  AND t3.FInterID<>0 
 INNER JOIN t_ICItem t4 ON   t3.FItemID = t4.FItemID  AND t4.FItemID<>0 
 LEFT OUTER JOIN t_measureunit t5 ON   t3.FUnitID = t5.FMeasureUnitID  AND t5.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_measureunit t16 ON   t4.FUnitID = t16.FMeasureUnitID  AND t16.FMeasureUnitID<>0 
 LEFT OUTER JOIN t_submessage t21 ON   u1.FIsOut = t21.FInterID  AND t21.FInterID<>0 
 LEFT OUTER JOIN t_submessage t23 ON   u1.FTeamID = t23.FInterID  AND t23.FInterID<>0 
 LEFT OUTER JOIN t_emp t24 ON   u1.FWorkerID = t24.FItemID  AND t24.FItemID<>0 
 LEFT OUTER JOIN ICOperShift t30 ON   v1.FOperShiftBillID = t30.FInterId  AND t30.FInterId<>0 
 LEFT OUTER JOIN SHWorkBillEntry t31 ON   v1.FOriginWBID = t31.FWBInterId  AND t31.FWBInterId<>0 
 LEFT OUTER JOIN t_subMessage t91 ON   u1.FAutoTD = t91.FInterID  AND t91.FInterID<>0 
 LEFT OUTER JOIN t_subMessage t92 ON   u1.FAutoOF = t92.FInterID  AND t92.FInterID<>0 
 where  (u1.FInterID=4604699 and u1.FEntryID=1) or (u1.FInterID=4604803 and u1.FEntryID=1) or (u1.FInterID=4604907 and u1.FEntryID=1) or (u1.FInterID=4604959 and u1.FEntryID=1) or (u1.FInterID=4605011 and u1.FEntryID=1) or (u1.FInterID=4605115 and u1.FEntryID=1) or (u1.FInterID=4605167 and u1.FEntryID=1) or (u1.FInterID=4605219 and u1.FEntryID=1) or (u1.FInterID=4605271 and u1.FEntryID=1) or (u1.FInterID=4605323 and u1.FEntryID=1) or (u1.FInterID=4605427 and u1.FEntryID=1) or (u1.FInterID=4605479 and u1.FEntryID=1) or (u1.FInterID=4605531 and u1.FEntryID=1) or (u1.FInterID=4654405 and u1.FEntryID=1) or (u1.FInterID=4654509 and u1.FEntryID=1) or (u1.FInterID=4654613 and u1.FEntryID=1) or (u1.FInterID=4654665 and u1.FEntryID=1) or (u1.FInterID=4654717 and u1.FEntryID=1) or (u1.FInterID=4654769 and u1.FEntryID=1) or (u1.FInterID=4654821 and u1.FEntryID=1) or (u1.FInterID=4654925 and u1.FEntryID=1) or (u1.FInterID=4654977 and u1.FEntryID=1) or (u1.FInterID=4655029 and u1.FEntryID=1) or (u1.FInterID=4655081 and u1.FEntryID=1) or (u1.FInterID=4655185 and u1.FEntryID=1) or (u1.FInterID=4655237 and u1.FEntryID=1) or (u1.FInterID=4655289 and u1.FEntryID=1) or (u1.FInterID=4655341 and u1.FEntryID=1) or (u1.FInterID=4655393 and u1.FEntryID=1) or (u1.FInterID=4655497 and u1.FEntryID=1) or (u1.FInterID=4655549 and u1.FEntryID=1) or (u1.FInterID=4655601 and u1.FEntryID=1) or (u1.FInterID=4655653 and u1.FEntryID=1) or (u1.FInterID=4655705 and u1.FEntryID=1) or (u1.FInterID=4655757 and u1.FEntryID=1) or (u1.FInterID=4655809 and u1.FEntryID=1) or (u1.FInterID=4655861 and u1.FEntryID=1) or (u1.FInterID=4655913 and u1.FEntryID=1) or (u1.FInterID=4655965 and u1.FEntryID=1) or (u1.FInterID=4656017 and u1.FEntryID=1) order by  u1.FInterID,u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NO_BROWSETABLE ON
go
SELECT ISNULL(FValue,0) AS FValue FROM t_SystemProfile WHERE FCategory='IC' AND FKey='SaveListColWidth'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select u1.FWBInterID,
u1.FEntryID,
u1.FWorkBillNo,
v1.FICMONO As FICMONO,
v1.FICMOinterID As FICMOinterID,
v1.FGMPBatchNo As FGMPBatchNo,
v1.FUnitID As FUnitID,
t_Measureunit.FName As FUnitID_DSPName,
t_Measureunit.FNumber As FUnitID_FNDName,
v1.FCoefficient As FCoefficient,
v1.FItemID As FItemID,
t_ICItem.FTrack As FItemID_Track,
t_ICItem.FBatchManager As FItemID_BatchNoManage,
t_ICItem.FQtyDecimal As FItemID_FQtyDecimal,
t_ICItem.FPriceDecimal As FItemID_FPriceDecimal,
t_ICItem.FUnitGroupID As FItemID_UnitGroupID,
t_ICItem.FISKFPeriod As FItemID_FISKFPeriod,
t_ICItem.FNumber As FItemID_DSPName,
t_ICItem.FNumber As FItemID_FNDName,
v1.FOrderBillNo As FOrderBillNo,
v1.FOrderEntryID As FOrderEntryID,
v1.FMTONo As FMTONo,
v1.FOrderInterID As FOrderInterID,
u1.FWorkBillNO As FWorkBillNO,
u1.FWBInterID As FWBInterID,
u1.FTeamID As FTeamID,
t_SubMessage.FName As FTeamID_DSPName,
t_SubMessage.FID As FTeamID_FNDName,
u1.FWorkerID As FWorkerID,
t_Emp.FName As FWorkerID_DSPName,
t_Emp.FNumber As FWorkerID_FNDName,
u1.FDeviceID As FDeviceID,
vw_Device_Resource.FName As FDeviceID_DSPName,
vw_Device_Resource.FNumber As FDeviceID_FNDName,
u1.FConversion As FConversion,
u1.FOperID As FOperID,
u1.FWorkCenterID As FWorkCenterID,
u1.FAutoTD As FAutoTD,
t_SubMessage1.FName As FAutoTD_DSPName,
t_SubMessage1.FID As FAutoTD_FNDName,
u1.FQualityChkID As FQualityChkID,
u1.FAutoOF As FAutoOF,
t_SubMessage2.FName As FAutoOF_DSPName,
t_SubMessage2.FID As FAutoOF_FNDName,
u1.FTimeUnit As FTimeUnit,
t_SubMessage3.FName As FTimeUnit_DSPName,
t_SubMessage3.FID As FTimeUnit_FNDName,
u1.FTimeSetup As FTimeSetup,
u1.FWorkQty As FWorkQty,
u1.FTimeRun As FTimeRun,
u1.FTotalWorkTime As FTotalWorkTime,
u1.FOperSN As FOperSN,
u1.FOperID As FOperID2,
t_SubMessage4.FID As FOperID2_DSPName,
t_SubMessage4.FID As FOperID2_FNDName,
u1.FWorkCenterID As FWorkCenterID2,
t_WorkCenter.FNumber As FWorkCenterID2_DSPName,
t_WorkCenter.FNumber As FWorkCenterID2_FNDName
 From SHWorkBill AS v1 Inner Join SHWorkBillEntry AS u1 On v1.FInterID = u1.FInterID LEFT  JOIN t_Measureunit  ON v1.FUnitID=t_Measureunit.FItemID AND t_Measureunit.FItemID<>0
 LEFT  JOIN t_ICItem  ON v1.FItemID=t_ICItem.FItemID AND t_ICItem.FItemID<>0
 LEFT  JOIN t_SubMessage  ON u1.FTeamID=t_SubMessage.FInterID AND t_SubMessage.FInterID<>0
 LEFT  JOIN t_Emp  ON u1.FWorkerID=t_Emp.FItemID AND t_Emp.FItemID<>0
 LEFT  JOIN vw_Device_Resource  ON u1.FDeviceID=vw_Device_Resource.FID AND vw_Device_Resource.FID<>0
 LEFT  JOIN t_SubMessage t_SubMessage1 ON u1.FAutoTD=t_SubMessage1.FInterID AND t_SubMessage1.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage2 ON u1.FAutoOF=t_SubMessage2.FInterID AND t_SubMessage2.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage3 ON u1.FTimeUnit=t_SubMessage3.FInterID AND t_SubMessage3.FInterID<>0
 LEFT  JOIN t_SubMessage t_SubMessage4 ON u1.FOperID=t_SubMessage4.FInterID AND t_SubMessage4.FInterID<>0
 LEFT  JOIN t_WorkCenter  ON u1.FWorkCenterID=t_WorkCenter.FItemID AND t_WorkCenter.FItemID<>0
 Where  (  ( u1.FStatus=1 and u1.FAutoTD=1058 and (select fstatus from icmo where finterid=v1.ficmointerid) in(1,2) and (select fsuspend from icmo where finterid=v1.ficmointerid) =0  )  )  AND  ( (u1.FWBInterID=4754980 AND u1.FEntryID=1) )  ORDER BY u1.FWBInterID, u1.FEntryID
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_ICItem WHERE  t_ICItem.FItemID = 80346
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_SubMessage WHERE  t_SubMessage.FInterID = 40005
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FName FROM t_WorkCenter WHERE  t_WorkCenter.FItemID = 216916
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT ISNULL(FAuxQtyPlan - FAuxQtyFinish ,0) as FAuxQty,FWBInterID  FROM SHWorkBillEntry  
 WHERE 1=2  OR FWBInterID =4754980
 OR FWBInterID =0

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select * from ICClassLink where FSourClassTypeID =0 and FDestClassTypeID=1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select t1.*,t2.FTabIndex as FDestTabIndex from ICClassLinkEntry t1 
 inner join ICClassTableInfo t2 ON t1.FDestFKey=t2.FKey AND t1.FDestClassTypeID=t2.FClassTypeID 
 where t1.FSourClassTypeID =0 and t1.FDestClassTypeID=1002510 AND t1.FSourFkey not like '%.%'  AND t1.FSourFkey <> ''
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FCapacityCalType from t_workcenter where FItemID=216916

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 IF EXISTS(SELECT * FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill')
 UPDATE  ICClassUserProfile SET FValue='mnuSelectOldBill_52' WHERE FUserID=16415
 AND FSection='BillSet1002510' AND FKey='SelBill' ELSE 
  INSERT INTO ICClassUserProfile(FUserID,FSection,FKey,FValue )  
  VALUES(16415,'BillSet1002510','SelBill','mnuSelectOldBill_52')
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FFieldName,FValueType From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1 and FMustInput=1 and FNeedSave=1
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select FValue from t_SystemProfile Where FCategory='SH' and FKey='ShopConversionManage'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FID,FItemID As FOperatorID FROM ICOperGroupEntry
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT 0 FROM PPBOM WHERE FStatus = 0 AND FICMOInterID = 533395 AND 0 = (SELECT FValue FROM t_SystemProfile WHERE FKey = 'AllowSaveProcRptPPBOMNotChcek' AND FCategory = 'SH')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT T1.FKey,T1.FValue
  FROM ICSHOP_SCProfile T1
 WHERE T1.FCategory = 'SH' AND (T1.FValue & 2) > 0 
        AND T1.FKey IN('SH_RptBeginDatePrevICMOReleasingDate'
                      ,'SH_CumulativeProducedQtyOverPlannedProductionQty'
                      ,'SH_CumulativeProducedQtyOverCumulativeReceivedQty'
                      ,'SH_OperRptZeroAllQty'
                      ,'SH_OperRptZeroAllOperTime'
                      ,'SH_CumulativeProducedQtyDifference'
                      )


go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_RuleCheck'))
    DROP TABLE #TEMP_RuleCheck
CREATE TABLE #TEMP_RuleCheck(FInterID INT IDENTITY(1,1),FRptInterID INT DEFAULT 0,FRptBillNo VARCHAR(255),FEntryID INT,FWBInterID INT,FWBBillNo VARCHAR(255),FICMOInterID INT,FICMOBillNo VARCHAR(255)
                            ,FRule1 INT DEFAULT 0,FRptBeginDate DATETIME,FICMOCheckDate DATETIME
                            ,FRule2 INT DEFAULT 0,FRptSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOPlanQty DECIMAL(28,10) DEFAULT 0
                            ,FRule3 INT DEFAULT 0,FOperSN INT,FOperName VARCHAR(255),FWBSumAuxQtyRecive DECIMAL(28,10) DEFAULT 0
                            ,FRule4 INT DEFAULT 0,FRptSumAllZero DECIMAL(28,10)
                            ,FRule5 INT DEFAULT 0,FRptTimeAllZero DECIMAL(28,10)
                            ,FRule6 INT DEFAULT 0,FRptAuxQtyFinishALLRow DECIMAL(28,10) DEFAULT 0,FRptAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FRptSumQtyOther DECIMAL(28,10) DEFAULT 0
                            ,FIsFirst INT DEFAULT 0 ,FIsOut INT DEFAULT 1059)

INSERT INTO #TEMP_RuleCheck(FRptInterID,FRptBillNo,FEntryID,FWBInterID,FWBBillNo,FICMOInterID,FICMOBillNo
                           ,FRptBeginDate,FRptSumAllZero,FRptTimeAllZero
                           ,FRptAuxQtyFinishALLRow,FRptAuxQtyFinish,FRptSumQtyOther)
VALUES(0,'',1,4754980,'WB363462',533395,'D-1606-2009',
         '2017-01-09 08:59:28',60,0,
         30,30,30
      )

UPDATE T1 set T1.FIsFirst=1,T1.FIsOut=T5.FIsOut from #TEMP_RuleCheck T1 inner join (select t3.FWBInterID ,t3.FISOut as FISOut from SHWorkBillEntry t3
inner join
(select t1.finterid,min(t1.FOperSN) as FMinOperSN from SHWorkBillEntry t1 inner join (select FInterID from SHWorkBillEntry where FWBInterID=4754980
) t2 on t1.finterid=t2.finterid group by t1.finterid) t4 on t3.finterid=t4.finterid and t3.FOperSN=t4.FMinOperSN) T5 on T1.FWBInterID=T5.FWBInterID
UPDATE T1
   SET T1.FOperSN = T2.FOperSN
      ,T1.FOperName = T4.FName
      ,T1.FWBSumAuxQtyRecive = T2.FAuxQtyRecive
      ,T1.FRptSumAuxQtyFinish = T1.FRptAuxQtyFinishALLRow + T2.FAuxQtyFinish
      ,T1.FICMOPlanQty = T3.FAuxQty
      ,T1.FICMOCheckDate = T3.FCommitDate
      ,T1.FWBBillNo = T2.FWorkBillNO
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN t_SubMessage T4 ON T2.FOperID = T4.FInterID AND T4.FTypeID = 61
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FRptSumAuxQtyFinish = T1.FRptSumAuxQtyFinish - (SELECT SUM(T3.FAuxQtyfinish) FROM SHProcRpt T3 WHERE T3.FinterID = T1.FRptInterID)
  FROM #TEMP_RuleCheck T1
 WHERE T1.FRptInterID > 0

UPDATE T1
   SET T1.FRule1 = CASE WHEN T1.FRptBeginDate < T1.FICMOCheckDate THEN 1 ELSE T1.FRule1 END
      ,T1.FRule2 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FICMOPlanQty THEN 1 ELSE T1.FRule2 END
      ,T1.FRule3 = CASE WHEN T1.FRptSumAuxQtyFinish > T1.FWBSumAuxQtyRecive THEN 1 ELSE T1.FRule3 END
      ,T1.FRule4 = CASE WHEN T1.FRptSumAllZero = 0 THEN 1 ELSE T1.FRule4 END
      ,T1.FRule5 = CASE WHEN T1.FRptTimeAllZero = 0 THEN 1 ELSE T1.FRule5 END
      ,T1.FRule6 = CASE WHEN T1.FRptAuxQtyFinish <> T1.FRptSumQtyOther THEN 1 ELSE 0 END
  FROM #TEMP_RuleCheck T1 

--规则6:只处理免检的工序
UPDATE T1
   SET T1.FRule6 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE T2.FQualityChkID <> 352 AND T1.FRule6 = 1

--返修工序汇报不校验规则3：累计实作数量大于累计接收数量
UPDATE T1
   SET T1.FRule3 = 0
  FROM #TEMP_RuleCheck T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
             INNER JOIN SHWorkBill T3 ON T2.FInterID = T3.FInterID
 WHERE T3.FBillType <> 11620 AND T1.FRule3 = 1

SELECT T1.*
  FROM #TEMP_RuleCheck T1

DROP TABLE #TEMP_RuleCheck

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FQualityChkID INT DEFAULT 0,FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FWBInterID INT,FWBBillNo VARCHAR(255),FIsLastOper INT DEFAULT 0,FWBSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FWBSumAuxQtyFinish DECIMAL(28,10) DEFAULT 0,FICMOInterID INT,FICMONo VARCHAR(255) DEFAULT '',FICMOAuxInHighLimitQty DECIMAL(28,10) DEFAULT 0)

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FSumAuxQtyFinish,FWBInterID,FICMOInterID)
VALUES(0,'1',30,30,4754980,533395)

UPDATE T1
   SET T1.FWBSumAuxQtyPass = T2.FAuxQtyPass + T2.FAuxQualifiedReprocessedQty
      ,T1.FWBSumAuxQtyFinish = T2.FAuxQtyFinish
      ,T1.FWBBillNo = T2.FWorkBillNO
      ,T1.FQualityChkID = T2.FQualityChkID
      ,T1.FICMOAuxInHighLimitQty = T3.FAuxInHighLimitQty
      ,T1.FICMONo = T3.FBillNo
  FROM  #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
            INNER JOIN ICMO T3 ON T1.FICMOInterID = T3.FInterID

UPDATE T1
   SET T1.FIsLastOper = 1
  FROM #TEMP_WB T1 INNER JOIN SHWorkBillEntry T2 ON T1.FWBInterID = T2.FWBInterID
 WHERE NOT EXISTS(SELECT 1 FROM SHWorkBillEntry T3 WHERE T3.FinterID = T2.FinterID AND T3.FOperSN > T2.FOperSN)

SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID = 352 AND (T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass ) > T1.FICMOAuxInHighLimitQty
     UNION
SELECT T1.FRptInterID,T1.FRptBillNo,T1.FWBBillNo,T1.FIsLastOper,T1.FICMONo,(T1.FSumAuxQtyPass + T1.FWBSumAuxQtyPass) AS FSumAuxQtyPass,(T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) AS FSumAuxQtyFinish,T1.FICMOAuxInHighLimitQty,T1.FQualityChkID
  FROM #TEMP_WB T1
 WHERE T1.FQualityChkID <> 352 AND (T1.FSumAuxQtyFinish + T1.FWBSumAuxQtyFinish ) > T1.FICMOAuxInHighLimitQty

DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UnCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SET NOCOUNT ON
IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#TEMP_WB'))
    DROP TABLE #TEMP_WB
CREATE TABLE #TEMP_WB(FRptInterID INT,FRptBillNo VARCHAR(255),FSumAuxQtyPass DECIMAL(28,10) DEFAULT 0,FinterID INT,FWBInterID INT,FOperSN INT,FOperID INT,FNumber VARCHAR(30),FName VARCHAR(80))

INSERT INTO #TEMP_WB(FRptInterID,FRptBillNo,FSumAuxQtyPass,FinterID,FWBInterID,FOperSN,FOperID,FNumber,FName)
SELECT 0 AS FRptInterID,'1' AS FRptBillNo,30 AS FSumAuxQtyPass,T2.FinterID,T2.FWBInterID,T2.FOperSN,T2.FOperID,T3.FID AS FNumber,T3.FName
  FROM SHWorkBillEntry T2 INNER JOIN t_SubMessage T3 ON T2.FOperID = T3.FInterID AND T3.FTypeID = 61
 WHERE T2.FQualityChkID = 352 AND T3.FInterID>0 AND T3.FDeleted=0 AND T2.FWBInterID = 4754980

IF EXISTS(SELECT 1 FROM SysObjects WHERE ID = OBJECT_ID('TEMPDB..#RESULT'))
    DROP TABLE #RESULT
CREATE TABLE #RESULT(FInterID INT,FWBInterID INT,FOperSN INT,FSumQty DECIMAL(28,10) DEFAULT 0,FWBInterIDPrev INT,FOperSNPrev INT,FSumQtyPrev DECIMAL(28,10) DEFAULT 0)
INSERT INTO #RESULT(FInterID,FWBInterID,FOperSN,FOperSNPrev)
    SELECT V1.FinterID,V1.FWBInterID,V1.FOperSN,MAX(V2.FOperSN) AS FOperSNPrev
    FROM (SELECT DISTINCT FinterID,FWBInterID,FOperSN FROM #TEMP_WB) V1 LEFT JOIN SHWorkBillEntry V2 ON V1.FinterID = V2.FinterID AND V1.FOperSN > V2.FOperSN
    WHERE V2.FWBInterID IS NOT NULL
    GROUP BY V1.FinterID,V1.FWBInterID,V1.FOperSN

UPDATE V1
   SET V1.FSumQty = V2.FAuxQtyPass + V2.FAuxQualifiedReprocessedQty
      ,V1.FWBInterIDPrev = V3.FWBInterID
      ,V1.FSumQtyPrev = V3.FAuxQtyPass + V3.FAuxQualifiedReprocessedQty
  FROM #RESULT V1 INNER JOIN SHWorkBillEntry V2 ON V1.FInterID = V2.FinterID AND V1.FWBInterID = V2.FWBInterID
                  INNER JOIN SHWorkBillEntry V3 ON V1.FInterID = V3.FinterID AND V1.FOperSNPrev = V3.FOperSN

UPDATE V2
   SET V2.FSumQty = V2.FSumQty + V1.FSumAuxQtyPass
  FROM (SELECT FInterID,FWBInterID,ISNULL(SUM(FSumAuxQtyPass),0) AS FSumAuxQtyPass FROM #TEMP_WB GROUP BY FInterID,FWBInterID) V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID

SELECT V1.FRptInterID,V1.FRptBillNo,V1.FName AS FOperName,V2.FSumQty,V2.FSumQtyPrev
  FROM #TEMP_WB V1 INNER JOIN #RESULT V2 ON V1.FinterID = V2.FInterID AND V1.FWBInterID = V2.FWBInterID
 WHERE V2.FSumQty > V2.FSumQtyPrev

DROP TABLE #RESULT
DROP TABLE #TEMP_WB

go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select FKey,FFieldName,FValueType From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Update t_BillCodeRule Set FReChar = FReChar Where FBillTypeID = '582'
go
Update t_BillCodeBy Set FProjectVal = FProjectVal Where FBillTypeID = '582'
go
select a.*,isnull(b.ftable,'') as ftable,isnull(e.ffieldname,'') as FieldName from t_billcoderule a
 left join t_option e on a.fprojectid=e.fprojectid and a.fformatindex=e.fid
 Left OUter join t_checkproject b on a.fbilltype=b.fbilltypeid and a.fprojectval=b.ffield
 where a.fbilltypeid = '582' order by a.FClassIndex
go
select FBillTypeID,FProjectID,FProjectVal from t_billcoderule where FBillTypeID = '582' and FIsBy=1
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 Declare @TmpID INT 
 SET @TmpID = (SELECT FID FROM t_BillCodeRule WITH(READUNCOMMITTED) WHERE FBillTypeID = '582' And FProjectID = 3)
 Update t_BillCodeRule Set FProjectVal = 252368,
 FLength = case when FLength <= IsNull(Len(252368),0) then IsNull(Len(252368),0)
 else FLength end Where FID = @TmpID 
 Update ICBillNo Set FCurNo = 252368 where fbillid = 582
go
SELECT FTemplateID FROM ICTransactionType WHERE FID=582
go
Select * From t_BillCodeRule Where FBillTypeID = '582' Order By FClassIndex
go
Update ICBillNo Set FDesc = 'GXHB+252368' Where FBillID = '582'
go
SELECT FComponentSrv FROM t_ThirdPartyComponent WHERE FTypeID=4 AND FTypeDetailID=582 ORDER BY FIndex
go
Select FMaxNum From ICMaxNum  Where FTableName= 'SHProcRptMain'
go
Update ICMaxNum set FMaxNum=FMaxNum+1 where FTableName= 'SHProcRptMain'
go
INSERT INTO shProcRptMain (
FBrNo, FInterID, FBillNo, FTranType, FDate, FBillerID,FStatus, FICMOInterID, FCancellation, FItemID, FUnitID, FQtyPlan, FAuxQtyPlan, FPlanStartDate, FPlanEndDate, FOperID, FWorkCenterID,FWBInterID, FTaskDispBillID, FQualityChkID, FWBNO, FICMONO, FGMPBatchNo, FCoefficient, FConversion, FOperAuxQtyPlan,FAutoTD, FAutoOF, FOperMoveNo,FOrderInterID,FOrderBillNo,FOrderEntryID,FMTONo ) 
VALUES ('0',253384,'GXHB252367',582,'2017-01-09',16415,0,533395, 0 , 80346, 60422, 0, 0, Null, Null, 40005, 216916, 4754980, 0, 352, 'WB363462','D-1606-2009','', 1, 1, 0, 1058, 1058, '', 7617, 'SEORD005960',22,'')
INSERT INTO shProcRpt (
FinterID, FEntryID, FBRNO, FworkerID, FdeviceID, FteamID, FstartWorkDate, FEndWorkDate,Fqtyfinish, FAuxQtyfinish,FQtypass, FAuxQtyPass, FQtyscrap, FAuxQtyscrap, FqtyForItem, FAuxQtyForItem,  FTimeUnit, FTimeRun, FWorkQty, FTimeMachine, FTimeSetUp, FfinishTime, FreadyTime,  FfixTime,FMemo, FReprocessedQty, FAuxReprocessedQty, FTeamtimeID, FOperAuxQtyFinish, FOperAuxQtyPass, FOperAuxQtyScrap, FOperAuxQtyForItem, FOperAuxReprocessedQty, FHRReadyTime, FOperGroupID  ) 
VALUES (253384,1,0,0, 1006, 40350,'2017-01-09 08:59','2017-01-09 08:59', 30, 30, 30, 30, 0, 0, 0, 0, 11082, 1, 100, 1, 0, 0, 0, 0,'this is a test by renbo', 0, 0, 0, 30, 30, 0, 0, 0, 0, 0)

go
 UPDATE ICOperGroup SET FUsed= 1 
 WHERE FID IN (SELECT FOperGroupID FROM SHProcRpt 
               WHERE FOperGroupID > 0 AND FinterID >=253384 AND FinterID <=253384              ) 
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
declare @ICMOInterID int
declare @WBInterID int
declare @TaskDispBillID int
select @ICMOInterID=isnull(FICMOInterID,-1),@WBInterID=isnull(FWBInterID,-1),@TaskDispBillID=isnull(FTaskDispBillID,-1) from SHProcRptMain where FInterID=253384
update icmo set FHRReadyTime=t4.FHRReadyTime from icmo t1
inner join(select t2.FICMOInterID,IsNull(sum(Case t3.FTimeUnit When 11081 then IsNull(t3.FHRReadyTime,0.0) / 60.0  when 11083 then IsNull(t3.FHRReadyTime,0) * 24.0 else IsNull(t3.FHRReadyTime,0.0)end),0.0) as FHRReadyTime
from SHProcRpt t3 inner join (select FICMOInterID,FInterID from SHProcRptMain where FICMOInterID=@ICMOInterID) t2 on t3.FInterID=t2.FInterID
group by t2.FICMOInterID)t4 on t1.FInterID=t4.FICMOInterID
update SHWorkBillEntry set FHRReadyTime=(case t1.FTimeUnit when 11081 then t4.FHRReadyTime*60.0 when 11083 then t4.FHRReadyTime/24.0 else t4.FHRReadyTime end) from SHWorkBillEntry t1 
inner join(select t2.FWBInterID, IsNull(sum(Case t3.FTimeUnit When 11081 then IsNull(t3.FHRReadyTime,0.0) / 60.0  when 11083 then IsNull(t3.FHRReadyTime,0) * 24.0 else IsNull(t3.FHRReadyTime,0.0)end),0.0) as FHRReadyTime 
from SHProcRpt t3 inner join (select FWBInterID,FInterID from SHProcRptMain where FWBInterID=@WBInterID) t2 on t3.FInterID=t2.FInterID 
group by t2.FWBInterID) t4 on t1.FWBInterID=t4.FWBInterID
update ICTaskDispBillEntry set FHRReadyTime=(case t1.FTimeUnit when 11081 then t4.FHRReadyTime*60.0 when 11083 then t4.FHRReadyTime/24.0 else t4.FHRReadyTime end) from ICTaskDispBillEntry t1 
inner join(select t2.FTaskDispBillID,IsNull(sum(Case t3.FTimeUnit When 11081 then IsNull(t3.FHRReadyTime,0.0) / 60.0  when 11083 then IsNull(t3.FHRReadyTime,0) * 24.0 else IsNull(t3.FHRReadyTime,0.0)end),0.0) as FHRReadyTime 
from SHProcRpt t3 inner join (select FTaskDispBillID,FInterID from SHProcRptMain where FTaskDispBillID=@TaskDispBillID) t2 on t3.FInterID=t2.FInterID 
group by t2.FTaskDispBillID) t4 on t1.FTaskDispInterID=t4.FTaskDispBillID 

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
 Declare @FWBinterID int declare @FInterID int
 declare @FTaskDispID int
 declare @FICMOinterID int
 declare @FQualityChkID int
 declare @FMaxEntryID int
 declare @FEntryID int
 declare @FCount int
 declare @FOperMoveNo varchar(255)
 select @FInterID=t1.FInterID,@FEntryID=t2.FEntryID,@FTaskDispID=t1.FTaskDispBillID , @FWBinterid=t1.FWBinterID , 
 @FICMOinterid =t1.FICMOInterID,@FQualityChkID=t1.FQualityChkID ,@FOperMoveNo=t1.FOperMoveNo 
 from  SHProcRptMain t1 join SHWorkBillEntry t2 on t1.FWBinterID=t2.FWBinterID 
 where t1.Finterid=253384
  update s1 set                                                           
  FWorkStartDate= t2.FWorkStartDate,        
  FWorkEndDate=t2.FWorkEndDate,              
  FAuxQtyFinish=t2.FAuxQtyFinish,           
  FAuxQtyPass=(case @FQualityChkID when 352 then t2.FAuxQtyPass else s1.FAuxQtyPass end),      
  FAuxQtyForItem=(case @FQualityChkID when 352 then t2.FAuxQtyForItem else s1.FAuxQtyForItem end ),     
  FAuxQtyScrap=(case @FQualityChkID when 352 then t2.FAuxQtyScrap else s1.FAuxQtyScrap end ),          
  FTimeHrWork=t2.FTimeHrWork,           
  FTimeEngPrepare=t2.FTimeEngPrepare,   
  FAuxReprocessedQty=(case @FQualityChkID when 352 then t2.FAuxReprocessedQty else s1.FAuxReprocessedQty end),   
  FTimeEngWork=t2.FTimeEngWork               
  from ictaskdispbillentry s1                                             
   join                                                                   
  (select FInterID=s2.FTaskDispBIllID,                                                       
  FWorkStartDate=isnull(min(t1.FStartWorkDate),getdate()) ,               
  FWorkEndDate=isnull(max(t1.FEndWorkDate),getdate()),                    
  FAuxQtyFinish=isnull(sum(t1.FAuxQtyFinish),0),                          
  FAuxQtyPass= isnull(sum(t1.FAuxQtyPass),0)  ,   
  FAuxQtyForItem=isnull(sum(t1.FAuxQtyForItem),0) ,                        
  FAuxQtyScrap=isnull(sum(t1.FAuxQtyScrap),0) ,                            
  FTimeHrWork=isnull(sum(t1.FfinishTime),0),                              
  FTimeEngPrepare=isnull(sum(t1.FReadyTime),0),                           
  FAuxReprocessedQty=isnull(sum(t1.FAuxReprocessedQty),0),                           
  FTimeEngWork=isnull(sum(t1.FFixTime),0)                                 
  From shprocrpt t1 join  shprocrptMain s2 on t1.Finterid=s2.Finterid     
  where s2.FTaskDispBillID=@FTaskDispID and s2.Fstatus>=0 
  group by s2.FTaskDispBIllID)                                    
  t2                                                                      
  on s1.FTaskDispInterID=t2.finterid  
  Update ICTaskDispBillEntry set FStatus =(case When FAuxQtyFinish-FAuxQtyPlan<0 then 1 else FStatus end)   where FTaskDispInteriD=@FTaskDispID  
 Update s1 set                        
  FStartWorkDate= t2.FStartWorkDate,        
  FEndWorkDate=t2.FEndWorkDate,              
  FAuxQtyFinish=t2.FAuxQtyFinish,           
  FAuxQtyPass=(case @FQualityChkID when 352 then  t2.FAuxQtyPass else s1.FAuxQtyPass end ),      
  FAuxQtyForItem=(case @FQualityChkID when 352 then t2.FAuxQtyForItem else s1.FAuxQtyForItem end),     
  FAuxQtyScrap=(case @FQualityChkID when 352 then t2.FAuxQtyScrap else s1.FAuxQtyScrap end),          
  FfinishTime=t2.FfinishTime,           
  FReadyTime=t2.FReadyTime,   
  FAuxReprocessedQty=(case @FQualityChkID when 352 then t2.FAuxReprocessedQty else s1.FAuxReprocessedQty end),   
  FFixTime=t2.FFixTime               
  from SHWorkBillEntry s1                                             
   join                                                                   
  (select FinterID=s2.FWBInterID ,                                                       
  FStartWorkDate=isnull(min(t1.FStartWorkDate),getdate()) ,               
  FEndWorkDate=isnull(max(t1.FEndWorkDate),getdate()),                    
  FAuxQtyFinish=isnull(sum(t1.FAuxQtyFinish),0),                          
  FAuxQtyPass=isnull(sum(t1.FAuxQtyPass),0)  ,   
  FAuxQtyForItem=isnull(sum(t1.FAuxQtyForItem),0) ,                        
  FAuxQtyScrap= isnull(sum(t1.FAuxQtyScrap),0) ,                            
  FfinishTime=isnull(sum(t1.FfinishTime),0),                              
  FReadyTime=isnull(sum(t1.FReadyTime),0),                           
  FAuxReprocessedQty=isnull(sum(t1.FAuxReprocessedQty),0),                           
  FFixTime=isnull(sum(t1.FFixTime),0)                                 
  From SHProcRpt t1 join  SHProcRptMain s2 on t1.Finterid=s2.Finterid     
  where s2.FWBInterID=@FWBinterID  and t1.FStatus>=0 
  group by s2.FWBInterID)                                    
  t2                                                                      
  on s1.FWBinterID=t2.finterid   
 Begin 
 Update t1 set 
 t1.FAuxQtyFinish=case when (@FEntryID=1 and isnull(t2.FBillType,11620)=11620) then t3.FAuxQtyFinish else t1.FAuxQtyFinish end --modified by lihonghua 2005-01-04 返修工序计划单的工序汇报不反写对应任务单的实作数
 from ICMO t1 join SHWorkBill t2
 on t1.Finterid=t2.FICMOInterid join SHWorkBillEntry t3 on t2.Finterid=t3.FinterID 
 where  t3.FWBInterID=@FWBInterID
  Update s1 set                        
  FStartDate=t2.FStartDate,      
  FFinishDate=t2.FFinishDate,      
  FfinishTime=t2.FfinishTime,           
  FReadyTime=t2.FReadyTime,   
  FFixTime=t2.FFixTime               
  from ICMO S1                                            
   join                                                                   
  (Select FInterID=s2.FICMOInterID, 
  FStartDate=isnull(min(t3.FStartWorkDate),getdate()) ,               
  FFinishDate=isnull(max(t3.FEndWorkDate),getdate()),                    
  FfinishTime=isnull(sum(case t3.FTimeUnit when 11081 then t3.FFinishTime/60 else t3.FFinishTime end),0) ,
  FReadyTime=isnull(sum(case t3.FTimeUnit when 11081 then t3.FReadyTime/60 else t3.FReadyTime end),0) ,
  FFixTime=isnull(sum (case t3.FTimeUnit when 11081 then t3.FFixTime/60 else t3.FFixTime end),0) 
  from  SHWorkBillEntry t3 join SHWorkBill s2 on t3.FInterID=s2.FinterID 
  where  s2.FICMOinterID=@FICMOInterID  
  group by s2.FICMOinterID ) t2    
  on S1.Finterid=t2.FinterID 
 End 
--更新流转号中间表SHMoveNoManage
 Delete From SHMoveNoManage Where FTransType = 582 and FWBInterID = @FWBinterID and FOperMoveNo = ''+@FOperMoveNo+'' 
 Insert into SHMoveNoManage(FOperMoveNo,FWBInterID,FICMOInterID,FTransType,FStatus,FQty) 
 select u.FOperMoveNo,u.FWBInterID as FWBInterID,u.FICMOInterID,582 as FTransType,1 as FStatus,sum(v.FAuxQtyPass) as FQty 
 From SHProcRptMain u Inner join SHProcRpt v on u.FInterID =v.FInterID 
 Where u.FStatus>=0 and u.FWBInterID = @FWBInterID and FOperMoveNo = ''+@FOperMoveNo+'' and FOperMoveNo<> '' 
 Group By u.FICMOInterID,u.FWBInterID,u.FOperMOveNo 

  Update ICTaskDispBillEntry set FStatus =(case When FAuxQtyPass-FAuxQtyPlan>=0 then 3 else FStatus end)   where FTaskDispInteriD=@FTaskDispID  
 EXEC prc_SHUpdateBillDoubleQty -502, @FTaskDispID
 EXEC prc_SHUpdateBillDoubleQty -52, @FWBInterID
 EXEC prc_SHUpdateBillDoubleQty 582, @FInterID

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select FWBInterID from SHProcRptmain where FInterID= 253384
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
Select u1.*,v1.FBillType from SHWorkBill v1,SHWorkBillEntry u1 Where u1.FWBInterID = 4754980 and u1.FInterID=v1.FInterID 
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
select getdate() as 'Date'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
 SELECT FValue,FKey FROM ICClassUserProfile WHERE FUserID=16415
 AND FSection='BillSet1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
Select * from ICClassLink where FSourClassTypeID = 1002510
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
go
SELECT FValue,FKey FROM ICClassUserProfile 
 WHERE FUserId = 16415
 AND FSection = N'UserDefineOperation_1002510'
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
IF EXISTS(SELECT 1 FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='SourceBillType1002510' AND FType='IC')
          UPDATE ICPlanProfile SET FValue='-52' WHERE FUserID=16415 AND FKey='SourceBillType1002510' AND FType='IC'
ELSE 
INSERT INTO ICPlanProfile(FType,FUserID,FKey,FValue) VALUES('IC',16415,'SourceBillType1002510','-52')

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
IF EXISTS(SELECT 1 FROM ICPlanProfile WHERE FUserID= 16415 AND FKey='ReportType1002510' AND FType='IC')
          UPDATE ICPlanProfile SET FValue='-1' WHERE FUserID=16415 AND FKey='ReportType1002510' AND FType='IC'
ELSE 
INSERT INTO ICPlanProfile(FType,FUserID,FKey,FValue) VALUES('IC',16415,'ReportType1002510','-1')

go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
select count(1) as recordcount  from syscolumns where id=(select id from sysobjects where name='t_log')
go
INSERT INTO t_Log (FDate,FUserID,FFunctionID,FStatement,FDescription,FMachineName,FIPAddress) VALUES (getdate(),16415,'MAIN00001',5,'用户:kingdee退出K/3主控台','XUYAOYAO','192.168.1.99')
go
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
SELECT COUNT(FID) FROM t_UserProfile WHERE FUserID = 16415 AND FCategory = 'Base_Main' AND FKey = 'Setting'
go
SELECT FValue FROM t_SystemProfile WHERE FCategory ='Base' AND FKey ='SMSUUID'
go

 ;
