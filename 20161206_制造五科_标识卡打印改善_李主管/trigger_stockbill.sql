
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
alter TRIGGER [dbo].[icstockbill_RenBwo_update] 
   ON  [dbo].[ICStockBill] 
   for UPDATE
AS 
SET NOCOUNT ON 
declare  @fstatusIn int
		,@fstatusDel int
		,@m int
		,@N INT
		,@j int

 select @fstatusIn 	= fstatus from inserted
 select @fstatusDel = fstatus from deleted
 select @m=0,@n=0,@j=0
 
if update(fstatus) 
begin 
	if  @fstatusIn = 1
    	begin
    --20170621
		select @m =  count(*)																				 --20170621
		from inserted  a  
		join icstockbillentry		b	on a.finterid = b.finterid  and a.ftrantype = 24
		join t_BOS200000011Entry2	c	on b.fitemid = c.fbase1 and c.fbase2 <> b.fscstockid
		join t_bos200000011			d	on c.fid = d.fid 
		join icmo					e	on e.finterid = b.ficmointerid 
		join t_organization			f	on f.fitemid = d.fbase and f.fnumber = e.fheadselfj0188
		if @m > 0
		begin		
	   	raiserror(N'对应的材料仓库不正确',18,18) 
		ROLLBACK transaction 
		return 
		end
		
	--20161215
		select @j=count(*) from inserted  where ftrantype = 21 	and fheadselfb0157 
		not in (select fitemid from t_item where fitemclassid = 3012)    
		if @j > 0
		BEGIN
          RAISERROR('销售状态不正确，请检查单据!',18,18)													--20161215
          ROLLBACK transaction
		  return		  
		end
	--20160809	
		/*select @n=count(*) from inserted x
		join icstockbillentry a on a.finterid = x.finterid and x.ftrantype = 24
		join icmo b  on a.ficmointerid = b.finterid 
		join t_icitem c on a.fitemid = c.fitemid and (c.fnumber like '01.%' or c.fnumber like '13.%')
		where b.fstockflag = 14216       /*部分领料*/
		if @n > 0
		begin		
	    raiserror('部分领料的生产任务单，不允许入库',18,18) 
		ROLLBACK transaction 
		return 
		end*/
		
	--20161206
		update ppbomentry set 	fentryselfy0269  = b.fqty					--最近一次的出库数量
		,			 			fentryselfy0270	= a.fdate					--最近一次的出库日期
		,			 			fentryselfy0271	= c.FPlanFinishDate			--计划完工日期
		,			 			fentryselfy0272	= f.f_163					--内衬刀模号
		from inserted			a 
		join icstockbillentry	b	on a.finterid	  = b.finterid	  	and a.ftrantype = 24	and fdeptid = 69836	
		join icmo				c	on c.finterid	  = b.ficmointerid
		join ppbom				d	on d.ficmointerid = b.ficmointerid	and d.fworkshop = 69836 
		join ppbomentry			e	on d.finterid	  = e.finterid		and e.fitemid	= b.fitemid 
		join t_icitemcustom		f	on f.fitemid	  = c.fitemid
	   
	--20170628
		update c set c.fheadselfj0185 = a.fdate
		from inserted  a 
		inner join icstockbillentry b on  a.finterid=b.finterid and a.ftrantype=2
		inner join icmo c on c.finterid=b.ficmointerid
		where  c.fheadselfj0185 is null or c.fheadselfj0185  < a.fdate
 end
    
 
if   @fstatusDel = 1 and @fstatusIn = 0  							
    --20161215
		begin
		update icstockbill set fheadselfb0157 = null
		from icstockbill a join inserted b on a.finterid = b.finterid and b.ftrantype = 21
	
		update ppbomentry set 	fentryselfy0269 = null				--最近一次的出库数量
		,			 			fentryselfy0270	= null				--最近一次的出库日期
		,			 			fentryselfy0271	= null				--计划完工日期
		,			 			fentryselfy0272	= null				--内衬刀模号
		from inserted			a 
		join icstockbillentry	b	on a.finterid		= b.finterid		and a.ftrantype = 24	and fdeptid = 	69836	
		join icmo				c	on c.finterid		= b.ficmointerid
		join ppbom				d	on d.ficmointerid	= b.ficmointerid	and d.fworkshop = 69836 
		join ppbomentry			e	on d.finterid		= e.finterid		and e.fitemid	= b.fitemid 
		join t_icitemcustom		f	on f.fitemid		= c.fitemid
 		end
end


