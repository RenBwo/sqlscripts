CREATE TRIGGER [dbo].[ICMO_UPDATE_sxh_gongxu]  ON [dbo].[ICMO]
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
			@FWorkShop  INT			-- 生产车间
	
	SELECT @FGZL=FHeadSelfJ0184, @FINTERID =FINTERID, @FBILLNO =FBILLNO, @FSTATUS =FStatus
		  ,@FDIFF =DATEDIFF(d, FPlanCommitDate, FPlanFinishDate), @FWorkShop=FWorkShop
	FROM inserted
  
	
	

   
		BEGIN
		
			UPDATE C 
			  SET C.FPlanStartDate=convert(varchar(19),(A.FPlanCommitDate+' '+
	  convert(varchar(12),'8:00:00.000')),120)
			    
				  
			 , C.FPlanEndDate=convert(varchar(19),(A.FPlanCommitDate+' '+
	  convert(varchar(12),'23:00:00.000')),120)
			
				 
			 FROM ICMO A 
			INNER JOIN SHWorkBill B ON A.FInterID =B.FICMOInterID AND A.FBillNo =B.FICMONO
			INNER JOIN SHWorkBillEntry C ON C.FinterID =B.FInterID 
			INNER JOIN t_ICItem D on A.FItemID =D.FItemID 
			INNER JOIN t_SubMessage E ON E.FParentID =61    AND E.FinterID=C.FOperID
			WHERE A.FInterID =@FINTERID  and e.FName like '%下料%'
		END  --@FDIFF>=4
		begin
		update a 
set 
  a.FHeadSelfJ0188= d.FNumber

from icmo a 
inner join seorder b on a.forderinterid=b.finterid
inner join seorderentry c on c.finterid=b.finterid and c.fentryid=a.fsourceentryid
left outer join t_Organization d ON d.FItemID = b.FCustID
where  A.FInterID =@FINTERID 
		end
	END  --@FSTATUS=1 
	
   END