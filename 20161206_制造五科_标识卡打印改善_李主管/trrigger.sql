USE [AIS20091217151735]
--use [AIS20161026113020]
GO
/****** Object:  Trigger [dbo].[icstockbill_z5]    Script Date: 12/08/2016 10:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,renbo>
-- Create date: <Create Date,,2016-12-06>
-- Description:	<Description,,
--     the lastest out_date and out_qty would be witten to ppbomentry with the same as fdeptid and fitemid >
-- =============================================
ALTER TRIGGER [dbo].[icstockbill_z5] 
   ON  [dbo].[ICStockBill] 
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--declare virables
	declare 
	@lqty	decimal(28,10),
	@ldate   date ,
	@ldate0  date ,
	@litemid int,
	@lpitemid int,
	@ldeptid int,
	@lrows   int,
	@lfinterid int,
	@li      int,
	@licmoid int,
	@lncdmnu varchar(20)
  declare @model varchar(120) 
  declare @i integer 
  declare @j integer 
  declare @k integer 
	--initial virables
	set @lqty = 0
	set @lrows = 0
	set @litemid = 0
	set @lpitemid = 0 
	set @licmoid = 0
	set @li = 0 
	set @ldate = cast('1900-01-01' as date)
	set @lncdmnu = ''

	--select values from inserted
	if exists (select 1 from inserted where fdeptid = '69836' and FTranType = 24 )
	begin
	set @li = 0
	select @ldate = fdate,@ldeptid =fdeptid,@lfinterid = finterid  from inserted where fdeptid = 69836 
	and FTranType = 24
	select @lrows = max(b.fentryid) from icstockbillentry b where b.finterid = @lfinterid 
    while @li< @lrows
     begin
     select @litemid = b.fitemid,@lqty = b.fqty,@licmoid = b.ficmointerid from icstockbillentry b 
     where b.finterid = @lfinterid and  b.fentryid = (@li + 1)
     if @licmoid > 0 
     begin
     select @ldate0 = FPlanFinishDate,@lpitemid = fitemid from icmo where finterid = @licmoid 
     select @lncdmnu = f_163 from t_icitemcustom  where fitemid = @lpitemid
       
     update d set d.fentryselfy0269 = @lqty,d.fentryselfy0270 = @ldate,d.fentryselfy0271 = @ldate0,
     d.fentryselfy0272 = @lncdmnu
     from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' and
       c.ficmointerid =  @licmoid    and d.fitemid = @litemid 
     end
     set @li = @li + 1
     set @litemid = 0
     set @lpitemid = 0
     set @lqty = 0
     set @licmoid = 0  
     set @ldate0 = cast('1900-01-01' as date)  
     set @lncdmnu = ''
     select @model = ''
    end
    end
    END
