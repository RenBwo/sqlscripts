/*
date:			2017/06/27
description:	ICMO触发器优化：
description:	1.Merge icmo_update_sxh_gongxu
description:	2.merge icmo_shworkbill_gzl_update
description:	计划状态：0 计划；1 下达 ; 3 结案;5 确认
author:			RenBwo 

date:			2017/02/06
description:	生产任务单增加“是否有火焰焊接”字段
author:			RenBwo 

date:			2016/06/08
description:	生产任务单下达时，自动变更工序单的计划开工日，计划完工日
description:	针对对象 :  七科总装工序；生产任务状态确认未下达；总装周期 为5天
author:			XuYaoYao 


date:			2014/08/04
description:	工序计划单增加工作令号  
description:	上工序时需要使用工作令号;工序系数添加;工件数量添加
author:			YangYuan  

date:			2006/06/20
description:	增加判断，此触发器只有在修改FStatus字段时才需要触发。
author:			Wangdayong  

*/
alter  TRIGGER [dbo].[ICMO_Update] ON [dbo].[ICMO]
FOR Update
AS
if Update(FStatus)																					-- 2006/06/20 Wangdayong
Begin
Declare @insFStatus int
,		@DelFstatus int
,		@FGZL		VARCHAR(255)						-- 2014/08/04 YangYuan
,		@FINTERID	INT
,		@FBILLNO	VARCHAR(255)
,		@FDIFF		INT									-- 计划日程周期
,		@FWorkShop  INT									-- 生产车间
,		@FINTERID3	INT									--  2016/06/08 XuYaoYao

select @InsFstatus=a.FStatus,@FGZL=a.FHeadSelfJ0184, @FINTERID =a.FINTERID, @FBILLNO =a.FBILLNO, @FWorkShop=a.FWorkShop
	,@FDIFF =DATEDIFF(d, a.FPlanCommitDate, a.FPlanFinishDate) ,@FINTERID3=(select min(b.finterid) 
	     from icmo b where b.fheadselfj0184 = a.fheadselfj0184 and b.FCancellation=0 and b.FItemID = a.fitemid)	
							from  INSERTED a 
select @DelFstatus=FStatus	from  DELETED

if  (@InsFstatus=3 and @DelFstatus<>3)						
begin
	Delete t1 
	from t_LockStock  t1  
	join ppbom p1	on (p1.FInterID=t1.FinterID) 
	join Deleted t2 on (p1.Ficmointerid=t2.FinterID) 
	Where t1.FTranType=88
end

------------2017/06/27  merge icmo_shworkbill_gzl_update ----------------start-----------			--  2017/06/27 RenBwo 2
IF (@InsFstatus=5 and @DelFstatus<>5)																--  2014/08/04 YangYuan
	BEGIN		
		UPDATE SHWorkBillEntry 
		 SET FENTRYSELFZ0374=A.FHeadSelfJ0184, FEntrySelfz0375=f.FEntrySelfZ0236 
		   , FEntrySelfz0376=f.FEntrySelfZ0237
		 FROM ICMO A 
		INNER JOIN SHWorkBill B ON A.FInterID =B.FICMOInterID AND A.FBillNo =B.FICMONO
		INNER JOIN SHWorkBillEntry C ON C.FinterID =B.FInterID 
		inner join ICBOM d on d.FInterID =a.FBomInterID 
		inner join t_Routing e on e.FInterID =d.FRoutingID 
		inner join t_RoutingOper f on f.FInterID =e.FInterID  and f.FOperID =c.FOperID
		INNER JOIN t_SubMessage G ON G.FInterID =C.FOperID
		WHERE A.FInterID =@FINTERID 
		
		update icmo set fheadselfj0198 =isnull(f.fname,'') ,fheadselfj0199 = isnull(h.fname ,'')	-- 2017/02/06 RenBwo
		from		icmo			a 
		join		inserted		b on a.finterid = b.finterid 
		join		icbom			c on c.finterid	= b.fbominterid		and c.fusestatus	=1072	and c.fstatus = 1 
		left join	t_routing		d on d.finterid = c.froutingid
		left join	t_routingoper	e on e.finterid = d.finterid	and e.foperid		=40004 
		left join	t_submessage	f on f.finterid = e.foperid
		left join	t_routingoper	g on g.finterid = d.finterid	and g.foperid		=40359
		left join	t_submessage	h on h.finterid = g.foperid		
--- merge whyb_sxh_icmoupdate  start---------------------
update ICMO set FHeadSelfJ01100=c.fversion
from  icmo a
join inserted  b on a.FHeadSelfJ0184 = b.FHeadSelfJ0184 
join	icbom  c on  c.finterid =b.FBomInterID  and c.fversion = '自动装配'
--- merge whyb_sxh_icmoupdate  end -------------------------------


	END  

IF (@InsFstatus=1 and @DelFstatus<>1 and @FDIFF>=4 and @FWorkShop=135	)							--  2016/06/08 XuYaoYao
	BEGIN
			UPDATE C 
			 SET C.FPlanStartDate=
			  CASE WHEN E.FID IN('7ZPXT','7ZPJJ','7DHZJ','7LQJC','7QHLH') THEN A.FPlanCommitDate 
				   WHEN E.FID IN('7DHZ2','7HYH2','7HYHJ','7DMXT','7QMJC','FBUPI','FQMHH','FQMQH','7HGPX') THEN A.FPlanCommitDate+1 
				   WHEN E.FID IN('7AZZJ','7AZCY','7GZJC','7FDJC','7LPFJ','7ZWXT') THEN A.FPlanCommitDate+3 END
			 , C.FPlanEndDate=
			  CASE WHEN E.FID IN('7ZPXT','7ZPJJ','7DHZJ','7LQJC','7QHLH') THEN A.FPlanCommitDate 
				   WHEN E.FID IN('7DHZ2','7HYH2','7HYHJ','7DMXT','7QMJC','FBUPI','FQMHH','FQMQH','7HGPX') THEN A.FPlanCommitDate+2
				   WHEN E.FID IN('7AZZJ','7AZCY','7GZJC','7FDJC','7LPFJ','7ZWXT') THEN A.FPlanFinishDate END
			 FROM ICMO A 
			INNER JOIN SHWorkBill B ON A.FInterID =B.FICMOInterID AND A.FBillNo =B.FICMONO
			INNER JOIN SHWorkBillEntry C ON C.FinterID =B.FInterID 
			INNER JOIN t_ICItem D on A.FItemID =D.FItemID 
			INNER JOIN t_SubMessage E ON E.FParentID =61 AND E.FinterID=C.FOperID
			WHERE A.FInterID =@FINTERID AND SUBSTRING(D.FNUMBER,1,2)='13'
	END  

------------2017/06/27  merge icmo_shworkbill_gzl_update ----------------finish-----------------

update t1 set t1.FHeadSelfJ0191=t1.FQty-t1.FAuxStockQty-t1.FHeadSelfJ0189-t1.FHeadSelfJ0190 
from icmo t1 
inner join inserted t2 on t1.FInterID=t2.FInterID

update t1 set t1.FHeadSelfJ0196= ( case  when t1.finterid =@FINTERID3 then t3.F_160 else 0 end )	--  2017/06/27 RenBwo 2
			from	ICMO		t1
			join	inserted	t2 on t1.fitemid = t2.fitemid and t1.fcancellation = 0 and t1.fheadselfj0184 = t2.fheadselfj0184
			join	t_ICItem	t3 on t1.FItemID=t3.FItemID
------------2017/06/27  merge icmo_update_sxh_gonxu --------------start-----------------			--  2017/06/27 RenBwo 1
UPDATE C 
			  SET C.FPlanStartDate=convert(varchar(19),(A.FPlanCommitDate+' '+convert(varchar(12),'8:00:00.000')),120)  
				, C.FPlanEndDate  =convert(varchar(19),(A.FPlanCommitDate+' '+convert(varchar(12),'23:00:00.000')),120)
			FROM		ICMO			A 
			INNER JOIN SHWorkBill		B ON A.FInterID =B.FICMOInterID AND A.FBillNo =B.FICMONO
			INNER JOIN SHWorkBillEntry	C ON C.FinterID =B.FInterID 
			INNER JOIN t_ICItem			D on A.FItemID =D.FItemID 
			INNER JOIN t_SubMessage		E ON E.FParentID =61    AND E.FinterID=C.FOperID
			inner join inserted		    f on a.finterid = f.finterid
			WHERE  e.FName like '%下料%'
------------2017/06/27  merge icmo_update_sxh_gonxu --------------finish-----------------


End