-- =============================================
-- Author:		<YANGYUAN >
-- Create date: <2014-08-04>
-- Description:	<工序计划单增加工作令号--上工序时需要使用工作令号  -- 工序系数添加 --工件数量添加>
-- < Update by xuyaoyao  2016-06-08>
-- < 生产任务单下达时，自动变更工序单的计划开工日，计划完工日>
-- < 针对对象 :  七科总装工序；生产任务状态确认未下达；总装周期 为5天>
-- =============================================
CREATE TRIGGER [dbo].[ICMO_SHWORKBILL_GZL_UPDATE]  ON [dbo].[ICMO]
AFTER Update
AS 
BEGIN
   IF UPDATE(FSTATUS) 
   BEGIN 
	DECLARE @FGZL		VARCHAR(255),
			@FINTERID	INT,
			@FBILLNO	VARCHAR(255),
			@FSTATUS	INT,
			@FDIFF		INT,		-- 计划日程周期
			@FWorkShop  INT,			-- 生产车间
			@FINTERID2	INT,
			@FINTERID3	INT,
			@fitemid int
			
	
	SELECT @FGZL=FHeadSelfJ0184, @FINTERID =FINTERID, @FBILLNO =FBILLNO, @FSTATUS =FStatus,@fitemid=FItemID
		  ,@FDIFF =DATEDIFF(d, FPlanCommitDate, FPlanFinishDate), @FWorkShop=FWorkShop
	FROM inserted
	 
	IF @FSTATUS=5 
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
		 
	END  --@FSTATUS=5 
	
	
	-- update by xuyaoyao 
	IF @FSTATUS=1
	BEGIN
		-- 针对七科总装工序；总装周期 5天
		IF @FDIFF>=4 and @FWorkShop=135     
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
			
		END  --@FDIFF>=4
	END  --@FSTATUS=1 
	
	select @FGZL=FHeadSelfJ0184,@fitemid=FItemID,@FINTERID3=min(FInterID) from ICMO 

where FCancellation=0 and FHeadSelfJ0184=@FGZL and FItemID=@fitemid
group by FHeadSelfJ0184,FItemID

	update t1 set t1.FHeadSelfJ0196=t2.F_160
			from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
where 

 t1.FInterID =@FINTERID3
 
 	update t1 set t1.FHeadSelfJ0196=0
			from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
where 
t1.FInterID <>@FINTERID3 and t1.FItemID=@fitemid and t1.FCancellation=0 and t1.FHeadSelfJ0184=@FGZL
IF @FSTATUS=1
begin
--writer: RenBwo
--Date: 2017/02/06
--Description: 生产任务单增加“是否有火焰焊接”字段
declare @itemidBD int
declare @opernamebd varchar(30)
declare @opername2bd varchar(30)
select @itemidBD = fitemid from inserted 
select @opernamebd=e.fname,@opername2bd=g.fname 
from icbom b  
left join t_routing c on c.finterid = b.froutingid
left join t_routingoper d on d.finterid = c.finterid and d.foperid =40004 
left join t_submessage e on e.finterid = d.foperid
left join t_routingoper f on f.finterid = c.finterid and f.foperid =40359
left join t_submessage g on g.finterid = f.foperid
where  b.fitemid = @itemidbd and  b.FinterID=@FINTERID
if isnull(@opernamebd,'abc') <> 'abc' or isnull(@opername2bd,'abcd') <> 'abcd'
begin
update icmo set fheadselfj0198 =isnull(@opernamebd,'') ,fheadselfj0199 = isnull(@opername2bd ,'')
where FinterID=@FINTERID
end 
 end
	
   END

END