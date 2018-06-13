
declare @a varchar(30)
set @a='t_workcenter'
--set @a='ICShopProcBatch'
select * from icclasstype a join icclasstypeentry b on a.fid = b.fparentid where a.ftablename like @a;--Doc Definition Header
--select * from icclasstype_base
--select * from icclasstableinfo_base
select * from icclasstableinfo where ftablename like @a;--Doc Definition
select * from t_tabledescription where ftablename like @a; --万能报表表描述表 Universal Report Tool Sheet Descr
--select * from ictemplate
--select * from ictemplateentry
--select * from t_objecttype
--select * from syscolumns where id = 1002510
go


;Select *			FROM ICClassMutex t1 inner join t_SysFunction t2 on t1.FFuncID=t2.FFuncID
											WHERE t1.foperatename in ('新增','提交')
 ORDER BY FOpareteType ;
 --
 
;Select t1.FClassTypeID,t1.FLookUpClassID,t1.FMustInput,t1.FTableName,t1.FFieldName,t1.FSrcTableName,t1.FSrcTableNameAs,
t1.FSRCFieldName,t1.FDSPFieldName,t1.FDspColType,t1.FFNDFieldName,t1.FLookUpType 
					from ICClassTableInfo t1,ICClassType t2 
											where t1.FClassTypeID=t2.FID and t2.FModel=0 and FLookUpClassID>0 and t1.fclasstypeid = 1002510
 union all 
Select t1.FClassTypeID,t1.FLookUpClassID,t1.FMustInput,t1.FTableName,t1.FFieldName,t1.FSrcTableName,t1.FSrcTableNameAs,
t1.FSRCFieldName,t1.FDSPFieldName,t1.FDspColType,t1.FFNDFieldName,t1.FLookUpType 
					from ICClassTableInfo_BASE t1,ICClassType_BASE t2	
											where t1.FClassTypeID=t2.FID and t2.FModel=0 and FLookUpClassID>0  and t1.fclasstypeid = 1002510
--
;Select isnull(t2.FAccessMask,8323072) as FAccessMask, t1.FCaption_CHS as FCaption
, t1.*				from ICClassTableInfo as t1 Left Outer Join ICClassFieldRight as t2
 on t1.fkey=t2.fkey and t2.FUID = 16415
and t2.FClassTypeID=1002510					where t1.FClassTypeID=1002510 ORDER BY FPage,FTabindex,FListIndex
;select *			from t_sysfunction		where ffuncid = 145
--
Select *			FROM ICClassLink		WHERE FsourClassTypeID = 1002510;
;Select *			from ICClassMessage		Where FID in (Select FMessageID from ICClassActionMessage a left join ICClassBillAction b on a.FActionID = b.FID  where b.FClassTypeID = 1002510)
;;Select *			from ICPlanProfile		where fuserid = 16415;
;Select *			from ICClassLink		where FDESTClassTypeID = 1002510;
;Select *			FROM t_SystemProfile	WHERE FCategory='IC' AND FKey='RefreshAfterAdd'
;Select *			FROM t_SystemProfile	WHERE FCategory='IC' AND FKey='BrID'
;Select *			FROM ICChatBillTitle	WHERE FTypeID=601 AND FColName='FPieceRate'
;Select *			from ICListTemplate		Where FID=601
;Select FInterID,FTypeID,FColCaption as FColCaption_CHS,FColCaption As FColCaption ,FHeadSecond,FColName,FTableName,FColType, FColWidth,FVisible,FItemClassID,FVisForQuest,FReturnDataType,FCountPriceType, FCtlIndex,Case When FColName = 'FSourceTranType' Then 'FName' Else FName End As FName,FTableAlias,FAction,FNeedCount,FIsPrimary,FLogicAction,FStatistical,FMergeable,FVisForOrder,FControl,FMode,FControlType,FEditable,FFormat,FFormatType,FAlign,FMustSelected
					FROM ICChatBillTitle	Where FTypeID IN (Select FTemplateID From ICListtemplate  Where FID in (602)) order by FInterID;
;
;Select *			FROM ICSystemProfile	WHERE FID=0 AND FKey='ShowAllBillHead' AND fcategory='IC';
select fneedsave,*	from icclasstableinfo   where  FClassTypeID=1002510；
;Select *			FROM ICClassUserProfile WHERE FUserID=16415 AND FSection='BillSet1002510' AND FKey='AutoInPhaseWPDefSelf'

;Select *			 From ICClassTableInfo Where FClassTypeID=1002510 and FUserdefine=1
;select *			 from  t_BillCodeRule where  FBillTypeID = '582'
select * from icclasstype where fid = 582
