--***	BOS 单据***********************************
--	单据表头描述			icclasstype 
--	单据分录描述			icclasstypentry 
--	单据模板字段描述		icclasstableinfo 
--	单据编号				icbillno			t_billcoderule
--	选单关联表				icclasslink			icclasslinkentry
--	选单钩稽明细表			icclasslinkcommit
--	单据扩展服务模板数据	icclassactionlist
 

--*******	供应链(transaction) ************************************************
--	供应链(transaction)所有的单据的总体信息 ICTRANSACTIONTYPE
--	单据表头的详细信息		ICTEMPLATE
--	单据表体的信息			ICTEMPLATEENTRY
--	选单服务				icselbills 
--	选单中涉及表间关系		ICTableRelation
--	单据编号				icbillno
--	最大内码号				icmaxnum  IC_MAXNUM

--******	主控台模板	******************************************
--	一级系统模块表			t_DataFlowTopClass          
--	二级系统模块表			t_DataFlowSubSystem
--	系统模块子功能表		t_DataFlowSubFunc 
--	系统模块明细功能表		t_DataFlowDetailFunc
--	时间戳					t_DataFlowTimeStamp
---******************************************************************************
--icchatbilltitle 
select * from icchatbilltitle where fcolname like 'fstatus' and ftablename like 'icmo';
--	t_objecttype
--	ICClassConsts   常量
--	t_group
--	t_SysFunction
--	t_FuncControl
--	t_Mutex					MENU TEXT
--	ICClassMCFlowInfo  
--  ICClassUserProfile  
--  t_SystemProfile 
--*******************************************************************************
select * from icclasstype where fname_chs like '%投诉%';
select * from icclasstableinfo where fclasstypeid=1001701 order by fpage,flistindex;

select * from icclassgroupinfo a join qmclientservicelog b on a.fid = b.fid 
where fclasstypeid = 1001701 and b.fid = 1976;

select * from icmaxnum where ftablename = 'ICClassGroupInfo';
select * from icbillno where fbillid = 1001701;
--*******************************
select * from icclassgroupinfo;
-- flogic 是什么意思？-1  
-- fdetail = 1 
--***********退货检验单*******
select * from icclasstype where fname_chs like '%退货检验单%';
--老单
select * from ictransactiontype where fid= 707;--search templateid,headtable,entrytable,fid
--模板信息
select  * from ictemplate where fid = 'T07' order by fctlindex ,ftabindex;
select * from ictemplateentry where fid = 'T07' order by fctlindex;
--billno ,fid
select * from icbillno where fbillid = '707';
select * from icmaxnum where ftablename like 'icsaleqcbill';
--表数据（时间最近)
select * from icsaleqcbill a join icsaleqcbillentry b on a.finterid = b.finterid where a.fbillno = 'rqc000057';

--*******************************************************************************

select FSubSysID,* from t_DataFlowSubFunc where FSubFuncID=620122;
--SELECT FTimeStamp,* FROM ICCLassType WHERE FID=1001701;
  select * from icclasstableinfo where fclasstypeid=1001701 order by fpage,flistindex
 SELECT *, FCaption_CHS as FCaption FROM ICClassConsts;
 SELECT * FROM ICBillNo WHERE FBillID = 1001701;
 select FUserID from t_Group where FUserID = 16415 and FGroupID = 1;
 select FUserID from t_Group where FUserID = 16415 and FGroupID = 1;
Select FFuncID,FSubSysID,* From t_SysFunction Where FNumber = 'QM0301';
 
SELECT F.*,S.FSubSysID
FROM t_FuncControl F INNER JOIN t_SysFunction S ON F.FFuncID = S.FFuncID
INNER JOIN t_Mutex A ON F.FFuncID = A.FFuncID
WHERE A.FType =  8
 OR (A.FType = 2 AND A.FForbidden = 2)
 OR (A.FType = 4 AND F.FYear = 2017 AND A.FForbidden = 6201)
 OR (A.FType = 9 AND A.FForbidden = 2 AND F.FYear = 2017 AND F.FPeriod = 1)
 OR (A.FType = 10 AND A.FForbidden=6200301 AND F.FRowID = 0 AND F.FBizType='0')
 OR (A.FType = 1 AND A.FForbidden=6200301);
 Select Max(FID) FID from t_FuncControl;
select 1 from ICClassMCFlowInfo where fid=1001701;
SELECT t1.FSourClassTypeID as FClassID ,t2.FName_CHS as FName,  FAllowCopy,FAllowCheck,FAllowForceCheck, 
t1.FRemark, t1.FFlowControl,t1.FUseSpec  , T3.FKey As FSRCIDKey, T3.FCaption_CHS as FCaption
 FROM ICClassLink t1 left join ICClassType t2 on t1.FSourClassTypeID=t2.FID
 Left Join ICClassTableInfo t3 on t1.FDestClassTypeID = t3.FClassTypeID and t1.FSRCIDKey = t3.FKey
 where t1.FDestClassTypeID=1001701 and t1.FIsUsed=2 And t1.FSourClassTypeID in (Select FSourClassTypeID 
 from ICClassLinkEntry where FDestClassTypeID = 1001701) AND t1.FUnControl & 2 = 2;

 Select * from ICClassLink where FSourClassTypeID = 1001701;
 select FSQLTableName from t_ItemClass where FItemClassID = 4;
 Select FValue,* from t_SystemProfile where FCategory='BOS' and FKey='AccessDataUsed';
 select a.*,isnull(b.ftable,'') as ftable,isnull(e.ffieldname,'') as FieldName from t_billcoderule a
 left join t_option e on a.fprojectid=e.fprojectid and a.fformatindex=e.fid
 Left OUter join t_checkproject b on a.fbilltype=b.fbilltypeid and a.fprojectval=b.ffield
 where a.fbilltypeid = '1001701' order by a.FClassIndex;

 select FBillTypeID,FProjectID,FProjectVal,* from t_billcoderule where FBillTypeID = '1001701' and FIsBy=1;
 
--important!!!!!
select ffieldname, FPage from icclasstableinfo where fclasstypeid=1001701 and fkeyword='BILLNO' ;
select ftablename,* from icclasstypeentry where fparentid=1001701 and findex=2;
SELECT COUNT(*) FROM ICClassGroupInfo
 INNER JOIN QMClientServiceLog ON ICClassGroupInfo.FID=QMClientServiceLog.FID
 WHERE QMClientServiceLog.FBillNo='TS000002'
 AND ICClassGroupInfo.FClassTypeID=1001701
 AND ICClassGroupInfo.FID<>1001;
 ;SELECT FCheckAfterSave FROM ICBillNo WHERE FBillID= 1001701




