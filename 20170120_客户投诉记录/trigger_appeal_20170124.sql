
use AIS20091217151735
go


alter TRIGGER ICSaleQcBill_UPDATE
	ON [dbo].[ICSaleQCBill]
	FOR  UPDATE
	AS
	BEGIN
		SET NOCOUNT ON

--Description:	退货检验单  icsaleqcbill 在单审核后，自动生成客户投诉记录
--Note：		处理人： 退货检验单的检验员
--Note：		默认投诉者身份：客户 25		，可以在客户投诉记录里手动修改
--Note：		默认投诉方式    EMAIL 32		，可以在客户投诉记录里手动修改
--Note：		默认投诉类型    重要 36		，可以在客户投诉记录里手动修改
--Note：		FGeneCusAppeal 生成客户投诉记录标记 ,防止反审核后再审核生成多张投诉单
--WIRTER:		RenBwo
--DATE:			2017/01/24

DECLARE	@fid			int				-- 投诉单ID 
		,@finterid2			int				--icsaleqcbill finterid
		,@BillID			varchar(50)
		,@fbillerid			int
		,@checkstatus		int
		,@FGeneCusAppeal	int				 -- 生成客户投诉记录标记 FGeneCusAppeal

Select	@fbillerid = isnull(fbillerid,0),@Checkstatus = fstatus	,@finterid2 = finterid			from inserted

SELECT  @FGeneCusAppeal = isnull(FGeneCusAppeal,0)	FROM DELETED 

if update(fstatus) and @Checkstatus = 1  and @FGeneCusAppeal = 0 
begin



--generate new bill's Fid
EXEC	[dbo].[GetICMaxNum] 'icclassgroupinfo',@fid OUTPUT,@fbillerid 
--SELECT	@fid 

-- FBILLNO 
 select  @BillID=isnull(FPreLetter,'') + right('000000'+ltrim(convert(VARCHAR (20),isnull(FCurNo+1,1))),6) + isnull(FSufLetter,'')
      from ICBillNo     where FBillId= 1001701;
--select @billid
 update ICBillNo set FCurNo=FCurNo+1 where FBillId = 1001701
 update ICBillNo set fdesc = left(fdesc,len(fdesc)-len(fcurno))+ltrim(convert(varchar(20),isnull(fcurno,0 ))) where FBillId = 1001701
 update a set a.fprojectval = b.fcurno
 from t_billcoderule a join icbillno b
 on a.fbilltypeid = b.fbillid and a.fclassindex = 2  
 where a.fbilltypeid= 1001701 and a.fclassindex = 2
-- GENARATE NEW APPEAL RECORDS
insert into icclassgroupinfo(fid, fparentid,fdetail,flogic,fclasstypeid)  SELECT @fid ,0,1,-1,1001701;
--select * from icclassgroupinfo where fclasstypeid = 1001701 
insert into qmclientservicelog (fid,fbillno,fitemid,funitid,fbatchno,fdealerid,fdepid,
fappealsum,fappealdt,fappealname,fappealstatusid,fappealwayid,fapppealtypeid,fappealcontent,fbillerid,fcreatedt,flogic,fmemo
-- ,fcheckerid,fcheckdate
,fappealaddress,fappealtel,fappealemail,fappealzip,fsimpledeal
)
select @fid,@billid, a.fitemid,a.funitid,'N',a.FfManagerID,136 --品质部
,a.fsendupqty,a.fdatE,isnull((select fname from t_organization where fitemid = a.FHeadSelft0753),' '),25,32,36,isnull(a.fnote,'未填写*'),a.fbillerid,getdate(),-1,'根据退货检验单自动生成; '+a.fnote
,'-','-','-','-','-'
--from icsaleqcbill a where a.fbillno = 'rqc000001';
from inserted a;
--select * from qmclientservicelog 
update icsaleqcbill set FGeneCusAppeal = 1 where finterid = @finterid2
end;
end