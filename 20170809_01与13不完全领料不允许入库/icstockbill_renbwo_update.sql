/*
 * DATE:			2017/08/09
 * AUTHOR:			RENBO
 * DESCRIPITON:		部分领料不允许入库
 * 
 * date:			2017/06/28
 * author:			RenBwo
 * description:		Merge www.icmo_enddate which writes lastInstockdate to icmo.fheadselfj0185
 * 
 * date:			2017/06/21
 * author:			RenBwo
 * description:		三星手册进口与一般贸易区分
 *
 * date:			2016/12/15
 * author:			RenBwo
 * description:     change salestatus deponds on the status of check
 * 
 * date:			2016/12/06
 * author:			RenBwo
 * Description:		It writes the nearest out_date and out_qty to ppbomentry which has the same fdeptid and fitemid
 * Description:		Only for the fifth department
*/
ALTER TRIGGER [dbo].[icstockbill_RenBwo_update] 
   ON  [dbo].[ICStockBill] 
   for UPDATE
AS 
SET NOCOUNT ON 
declare  @fstatusIn int
		,@fstatusDel int
		,@ftrantype int
		,@fdeptid int
		,@m int
		,@FInterID int
		,@N INT

 select @fstatusIn = fstatus,@ftrantype = ftrantype,@fdeptid = fdeptid,@FInterID=FInterID
 from inserted
 select @fstatusDel = fstatus from deleted
 
if update(fstatus) and @fstatusDel <> 1 and @fstatusIn = 1  
  BEGIN
	if  @ftrantype = 24 and @fdeptid = 69836									--20161206
	begin
		update e set e.fentryselfy0269  = b.fqty								--最近一次的出库数量
		,			 e.fentryselfy0270	= a.fdate								--最近一次的出库日期
		,			 e.fentryselfy0271	= c.FPlanFinishDate						--计划完工日期
		,			 e.fentryselfy0272	= f.f_163								--内衬刀模号
		from inserted			a 
		join icstockbillentry	b	on a.finterid		= b.finterid			
		join icmo				c	on c.finterid		= b.ficmointerid
		join ppbom				d	on d.ficmointerid	= b.ficmointerid	and d.fworkshop = 69836 
		join ppbomentry			e	on d.finterid		= e.finterid		and e.fitemid	= b.fitemid 
		join t_icitemcustom		f	on f.fitemid		= c.fitemid
	end
	
	if @ftrantype =21 and not exists (select 1 from inserted where fheadselfb0157 in (select fitemid from t_item where fitemclassid = 3012))
	BEGIN
          RAISERROR('销售状态不正确，请检查单据!',18,18)													--20161215
          ROLLBACK transaction
		  return
		  
	end
 
	
    if @ftrantype =2															--20170628
	begin
		/*select @n=count(*) from icstockbillentry a 
		join icmo b  on a.ficmointerid = b.finterid and a.finterid = @finterid
		join t_icitem c on a.fitemid = c.fitemid and (c.fnumber like '01.%' or c.fnumber like '13.%')
		where b.fstockflag = 14216       /*部分领料*/
		if @n > 0
		begin		
	    raiserror(N'部分领料的生产任务单，不允许入库',18,1) 
		ROLLBACK transaction 
		return 
		end*/
	update c set c.fheadselfj0185 = a.fdate
	from inserted  a 
	inner join icstockbillentry b on  a.finterid=b.finterid and a.ftrantype='2'
	inner join icmo c on c.finterid=b.ficmointerid
	where  c.fheadselfj0185 is null or c.fheadselfj0185  < a.fdate
	end
 END
 
if @fstatusDel = 1 and @fstatusIn = 0 and  @ftrantype =21 and update(fstatus)							--20161215
 begin
	update a set a.fheadselfb0157 = null
	from icstockbill a join inserted b on a.finterid = b.finterid
 end

if @ftrantype = 24 
	begin	
	select @m =  count(*)																					 --20170621
	from inserted  a 
	join icstockbillentry		b	on a.finterid = b.finterid  and a.ftrantype = 24
	join t_BOS200000011Entry2	c	on b.fitemid = c.fbase1 and c.fbase2 <> b.fscstockid
	join t_bos200000011			d	on c.fid = d.fid 
	join icmo					e	on e.finterid = b.fsourceinterid 
	join t_organization			f	on f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188
		if @m > 0
		begin
		
	    raiserror(N'对应的材料仓库不正确',18,1) 
		ROLLBACK transaction 
		return 
		end
	end

  