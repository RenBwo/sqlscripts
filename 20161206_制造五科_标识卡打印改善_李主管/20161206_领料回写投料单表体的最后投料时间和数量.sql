
USE [AIS20091217151735]
--use [AIS20161026113020]
GO
select * from ICTransType where FEntryTable like 'icstockbillentry';
--领料单
select a.FDeptID,b.ficmointerid,b.forderbillno,b.*  from ICStockBill a join ICStockBillentry b on a.FInterID = b.FInterID 
    and a.FTranType = 24 where a.FDeptID = '69836' and a.fbillno = 'SOUT264861';
  
--投料单
select a.fworkshop ,b.FICMOInterID,* from  PPBOM a join PPBOMEntry b on a.FInterID = b.FInterID where a.FBillNo = 'pbom625225' ;
--生产任务单
select a.FItemID,* from ICMO a join PPBOMEntry b on a.FInterID = b.FICMOInterID where a.FInterID = 578783


select top 10 a.FDeptID,a.FDate,b.*  from ICStockBill a join ICStockBillentry b on a.FInterID = b.FInterID and a.FTranType = 24 
join PPBOM d on  d.fworkshop = a.fdeptid join PPBOMEntry c on d.FInterID = c.finterid and c.FItemID = b.fitemid 
where a.FDate >= d.fdate  ;
--dept
select * from t_Department where FName like '%五%';
select * from t_Department where FItemID = 134;
--test 
--select @ldate = fdate,@ldeptid =fdeptid,@lfinterid = finterid  from icstockbill where fdeptid = 69836 and FTranType = 24
;select a.fbillno,a.FDate,a.fdeptid,a.finterid from ICStockBill a  where a.FDeptID = 69836  and FTranType = 24 and  
a.FDate >= cast(GETDATE() - 1 as DATE) ;
--select @lrows = max(b.fentryid) from icstockbillentry b where b.finterid = @lfinterid 
select MAX(b.fentryid) from ICStockBillEntry b where b.FInterID = '590228';
--     select @litemid = b.fitemid,@lqty = b.fqty,@licmoid = b.ficmointerid from icstockbillentry b   where b.finterid = @lfinterid and  b.fentryid = (@li + 1)
;select b.fitemid,b.fqty ,b.ficmointerid  from icstockbillentry b  where b.finterid = '590228' and b.fentryid = (0 + 1)
;--select @ldate0 = FPlanFinishDate,@lpitemid = fitemid from icmo where finterid = @licmoid
;select FPlanFinishDate,fitemid from icmo where finterid = 586122
;select distinct b.FSPID,c.fnumber from t_ICItem a join t_ICItem b on a.FModel like '%ncdm%' 
     and b.FSource = '69836'   and LEFT(a.fmodel,(CHARindex('-NCDM',a.FModel) - 1))  = b.fchartnumber 
     and b.FItemID =  267748   JOIN t_StockPlace c on a.FSPID = c.fspid;
--update d set d.fentryselfy0269 = @lqty,d.fentryselfy0270 = @ldate     from ppbom c join ppbomentry d 
--on c.finterid = d.finterid and  c.fworkshop = '69836' and c.ficmointerid =  @licmoid    and d.fitemid = @litemid 
 update d set d.fentryselfy0269 = 20,
 d.fentryselfy0270 = (select a.FDate from ICStockBill a  where a.FDeptID = 69836  and FTranType = 24 and
   a.fbillno = 'SOUT264861')
 from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' and
c.ficmointerid =  586122   and d.fitemid = 278070 ;


      select *  from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' and
c.ficmointerid =  586122    and d.fitemid = 278070 ;
select FPlanFinishDate,* from icmo where finterid =  589054
;

--纠正
;update PPBOMEntry  set fentryselfy0270 = null,fentryselfy0271 = 0, fentryselfy0272 = 0
where fentryselfy0269 <>0

;
 update d set  d.fentryselfy0270 = cast('2016-12-07' as date)
 from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' 
 where d.FItemID in ( 
 select b.fitemid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date))
  and d.FICMOInterID in ( 
 select b.ficmointerid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date));
  
 update d set  d.fentryselfy0271 = (select fplanfinishdate from icmo where finterid = d.ficmointerid)
 from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' 
 where d.FItemID in ( 
 select b.fitemid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date))
  and d.FICMOInterID in ( 
 select b.ficmointerid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date))
  ;select fentryselfy0272 from ppbomentry;


 ;update d set  d.fentryselfy0272 = ( select distinct c.fnumber from t_ICItem a join t_ICItem b
  on a.FModel like '%ncdm%' and b.FSource = '69836'   and 
  LEFT(a.fmodel,(CHARindex('-NCDM',a.FModel) - 1))  = b.fchartnumber and b.FItemID =  e.FItemID
  JOIN t_StockPlace c on a.FSPID = c.fspid
 )
 from ppbom c join ppbomentry d on c.finterid = d.finterid and  c.fworkshop = '69836' 
 
 and  d.FItemID in ( 
 select b.fitemid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date)
  )   and d.FICMOInterID in ( 
 select b.ficmointerid  from icstockbillentry b join icstockbill a on a.finterid = b.finterid
  where a.FDeptID = 69836  and FTranType = 24 and  a.FDate = cast('2016-12-07' as date)
  )   join icmo e on d.ficmointerid = e.finterid  
  --内衬刀模
  --虚他
  select * from t_stock where FNumber = 'zc.04.0006'
  select  FChartNumber,* from t_Icitem where fnumber = '41.092.35.1007' ;
  select * from t_StockPlace where FSPID = 4336;
  select a.fitemid,a.fname,a.fmodel, a.fsource, a.* from t_Icitem a where a.fnumber = '14.a02.10.00.0000030' or fchartnumber = 'PFA-256 90-02' ;
  
  ;--取型号
  declare @model varchar(120) 
  declare @i integer 
  declare @j integer 
  declare @k integer 
  
  select @model=left(a.fmodel,charindex('*',a.fmodel))  from t_icitem a 
  where a.fnumber = '2.01.902.00.0256';
  select @model
  select @i = LEN(@model)
  select @i 
  select  @j = CHARINDEX(' ',@model,1)
  select @j 
  while @j >0 
  begin 
  select @k = @j + 1 
  select @j = charindex(' ',@model,@k)
  
  end
  select @k
  select LEFT(@model,@k - 1)
  
 
 
 ; select distinct a.fspid ,c.fnumber from t_ICItem a join t_ICItem b on a.FModel like '%ncdm%' and b.FSource = '69836' 
  and LEFT(a.fmodel,(CHARindex('-NCDM',a.FModel) - 1))  = left(b.fmodel,charindex('*',b.fmodel)) and b.FItemID =  292226
  JOIN t_StockPlace c on a.FSPID = c.fspid;
;--物料与仓位对应关系
;select V.FITEMID ,COUNT(V.fspid) AS MA FROM (
select distinct B.FItemID,a.fspid  from t_ICItem a join t_ICItem b on a.FModel like '%ncdm%' and b.FSource = '69836' 
  and LEFT(a.fmodel,(CHARindex('-NCDM',a.FModel) - 1))  = b.fchartnumber ) V
  GROUP BY V.FITEMID
  ORDER BY MA DESC

--测试
--;select a.fbillno,a.FDate,a.fdeptid,a.finterid from ICStockBill a  where a.FDeptID = 69836  and FTranType = 24 and a.FDate >= cast(GETDATE() - 1 as DATE) ;
    
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

	--select values from icstockbill
	select @li = 1 from icstockbill where fdeptid = '69836' and FTranType = 24
	if @li = 1 
	begin
	set @li = 0
 select @ldate = fdate,@ldeptid =fdeptid,@lfinterid = finterid  from icstockbill where fdeptid = 69836 
 	and FTranType = 24  and  FInterID =  590403
	select @lrows = max(b.fentryid) from icstockbillentry b where b.finterid = @lfinterid 
    while @li< @lrows
     begin
     select @litemid = b.fitemid,@lqty = b.fqty,@licmoid = b.ficmointerid from icstockbillentry b 
     where b.finterid = @lfinterid and  b.fentryid = (@li + 1)
     if @licmoid > 0 
     begin
     select @ldate0 = FPlanFinishDate,@lpitemid = fitemid from icmo where finterid = @licmoid 
       
  select @model=left(a.fmodel,charindex('*',a.fmodel))  from t_icitem a   where a.fitemid = @lpitemid;
  select @i = LEN(@model)
  select  @j = CHARINDEX(' ',@model,1)
  while @j >0 
  begin 
  select @k = @j + 1 
  select @j = charindex(' ',@model,@k)
  end
  --select LEFT(@model,@k - 1)
     select distinct @lncdmnu = c.fnumber from t_ICItem a 
     join t_ICItem b on a.FModel like '%ncdm%' 
     and b.FSource = '69836'   and LEFT(a.fmodel,(CHARindex('-NCDM',a.FModel) - 1))  = LEFT(@model,@k - 1) 
     and b.FItemID =  @lpitemid 
     join zpstockbillentry d on d.fitemid = a.fitemid  
     JOIN t_StockPlace c on c.FSPID = d.fdcspid 
     ;
     
     
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


