-- =============================================
-- Author:		<sxh>
-- Create date: <2017-07-17>
-- Description:	<璇峰亣鍗曠粓瀹℃椂锛屽搴旀瘡寮犲崟鎹殑璇峰亣鏃堕棿瀹℃牳浜轰笉鑳借秴杩囪嚜宸辩殑瀹℃壒鏃堕棿>
-- =============================================
create TRIGGER [dbo].[t_BOS200000008_time_Contratol]
   ON  [dbo].[t_BOS200000008]
   after update 
AS
SET NOCOUNT ON
DECLARE		    @Ftime				DECIMAL(28,10), 
				@Ftime_con			DECIMAL(28,10), 
				@M_MESSAGE				VARCHAR(1000),				
				@FInterID				INT, 
				@FBrNo					INT,
				@Fuser		            INT,
				@FContraYN				VARCHAR(10),
				@FBillNo				VARCHAR(255),
				@FStatus				INT,
				@FStatus_old2			INT,
				@AUTHOR                  INT
	SET	@M_MESSAGE=''
	set @Ftime_con=0
	set @AUTHOR =0

	SELECT @FInterID=A.FID,@FBillNo=a.FBillNo, @Ftime=ISNULL(a.FDecimal,0)
	     , @FStatus=isnull(a.FMultiCheckStatus,0)	     
	  FROM inserted A
	 set @fuser = ( SELECT top 1 fcheckerid FROM ICClassMCrecord200000008  where fbillid=@FInterID order by fid desc  )
	select @FStatus_old2=isnull(FMultiCheckStatus,0)  from deleted  WHERE FID =@FInterID 
	select @AUTHOR = 1  
			  from t_Item_3018 a
			 inner join t_User b on b.FEmpID =a.F_103
			 WHERE B.FUserID =@fuser  and a.f_104='否'
	IF  UPDATE(FMultiCheckStatus) and @FStatus = 16 and @FStatus_old2 = 4 and  @AUTHOR = 0  AND 72 < @Ftime 
		begin 
		SET @M_MESSAGE='审核权限不足！'
		
		update t_BOS200000008 set FNOTE=isnull(@Ftime_con,0) where FID= @FInterID
		RAISERROR(@M_MESSAGE,18,18)
		ROLLBACK TRANSACTION
		return
		END
GO

SET ANSI_PADDING OFF
GO

