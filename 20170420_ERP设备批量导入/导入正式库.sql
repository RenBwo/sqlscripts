
create procedure device_import 
as
begin
DECLARE	@fid			int				--  ID   
		--,@fbillerid		int				--maker
		,@fbillno		varchar(20)
		,@fcurno		int
		,@fbillclasstypeid		int		
		,@max			int
		,@i				int
		
--Select	@fbillerid	=	isnull(fbillerid,0)	from ICDeviceAccount
select	@fbillclasstypeid	=	fid			from icclasstype		where ftablename =	'ICDeviceAccount'
select @i = 0,@max = max(fsn) from ais20161026113020.dbo.bd_device_import
while @i < @max
begin
--generate new bill's Finterid
EXEC	[dbo].[GetICMaxNum] 'ICDeviceAccount',@fid OUTPUT,16551
--SELECT @fbillerid,@fbillclasstypeid,@i,@max,@fid 
-- FBILLNO 
 select  @fbillno=isnull(FPreLetter,'') + right('00000000'+ltrim(convert(VARCHAR (20),isnull(FCurNo+1,1))),8) + isnull(FSufLetter,'')
  ,@fcurno = fcurno from ICBillNo     where FBillId= @fbillclasstypeid;
 --select @fbillno
 update ICBillNo set fdesc = left(fdesc,len(fdesc)-len(fcurno+1))+ltrim(convert(varchar(20),isnull(fcurno+1,0 )))
 ,FCurNo=FCurNo+1 where FBillId = @fbillclasstypeid
 update a set a.fprojectval = b.fcurno
 from t_billcoderule a join icbillno b on a.fbilltypeid = b.fbillid and a.fclassindex = 2  
 where a.fbilltypeid= @fbillclasstypeid and a.fclassindex = 2
--	select * from t_billcoderule a  where a.fbilltypeid=1002100
--	select *  into ais20161026113020.dbo.bd_device_import  from icdeviceaccount where 1=2
--	insert into  icdeviceaccount select *  from ais20091217151735.dbo.icdeviceaccount
--	select *  from dbo.icdeviceaccount
--	select a.*,b.fname_chs from icdevgroupinfo a join  icclasstype b on a.fclasstypeid = b.fid  order by a.fclasstypeid
--	select * from t_submessage where fname like '%生产'
--	select * from t_submessage where finterid = 423
--	select * from t_department order by fname
--	select * from t_tabledescription where fdescription = '%资产%'
--	select fname,* from ais20091217151735.dbo.t_supplier where fitemid =  58505

--	select * from icclasstype where fname_chs like '%资产%'
--	select * from vw_Device_FACardGroup where fid = 772
--	alter table ais20161026113020.dbo.bd_device_import drop column fid,fclasstypeid,fbillid,fbillstatus,FBillerID,	FBillDate,	FCheckerID	,FCheckDate,	FItemNumber,
--	FResourceNumber	,FDrawingNumber,	FTechLevel		,FWorkTime	,FMCoefficient
select @i = @i + 1 
insert into icdeviceaccount(FID,FClassTypeID,FBillID,FPowerCap,FDeviceNumber,FDeviceName
	,FBillStatus,FSpecification,FModel,FAttribute,FStatus,FDeviceType,FABCType,FDeviceClass
	,FPurpose,FBeginUseDate,FDeptNumber,FSettingPlace,FAssetNumber,FSupplier,FManufacturer
	,FCountry,FLeaveFactoryNumber,FLeaveFactoryDate,FNote
	,FBillerID,	FBillDate)
	select @FID,@fbillclasstypeid,@FBillno,FPowerCap,FDeviceNumber,FDeviceName
	,0,FSpecification,FModel,FAttribute,FStatus,FDeviceType,FABCType,FDeviceClass
	,FPurpose,FBeginUseDate,FDeptNumber,FSettingPlace,FAssetNumber,FSupplier,FManufacturer
	,FCountry,FLeaveFactoryNumber,FLeaveFactoryDate,FNote
	,16551,getdate()
	from ais20161026113020.dbo.bd_device_import where fsn = @i 	
end

--	select fsn,* from ais20161026113020.dbo.bd_device_import
--	truncate  table ais20161026113020.dbo.bd_device_import
--  alter table ais20161026113020.dbo.bd_device_import alter column fsn int not null ;
--  alter table ais20161026113020.dbo.bd_device_import ADD PRIMARY KEY (fsn) 
--	select * from  icdeviceaccount
--  truncate  table icdeviceaccount
end

--	execute device_import