
--;select a.fbillno,a.FDate,a.fdeptid,a.finterid from ICStockBill a  where a.FDeptID = 69836  and FTranType = 24 and a.FDate >= cast(GETDATE() - 8 as DATE) ;
declare textinterid cursor for
select a.finterid from ICStockBill a  where a.FDeptID = 69836  and FTranType = 24 and a.FDate >= cast(GETDATE() - 8 as DATE) ;
   

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
	@linterid int,--≤‚ ‘ ±”√
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
--select values from icstockbill
	if exists( select  1 from icstockbill where fdeptid = '69836' and FTranType = 24)
	begin
	open textinterid
	fetch next from textinterid into @linterid	
	while @@fetch_status != 0 
	begin
     select @ldate = fdate,@ldeptid =fdeptid,@lfinterid = finterid  from icstockbill where fdeptid = 69836 
 	and FTranType = 24  and  FInterID = @linterid
	select @lrows = max(b.fentryid) from icstockbillentry b where b.finterid = @linterid 
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
    
	fetch next from textinterid
	end
	close textinterid
	deallocate textinterid
	end