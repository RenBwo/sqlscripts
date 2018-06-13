/*
 * use ais20091217151735
 * go
 * 
 * 未结案生产任务单 FSTATUS <> 3
 * 
 * 
 */ 
alter procedure aBangDeCheJianPanDianBiao
as 
select	t8.fname			as 生产部门,
		t1.FHeadSelfJ0184	as 工作令号,
		t1.FBillNo			as 生产任务单号,
		t4.FNumber			as 产品长代码,
		t4.FName			as 产品名称,
		t4.FModel			as 产品规格型号,
		isnull(d.FName,' ')	as 上道工序,
		t5.fname			as 本道工序,
		isnull(e.FName,' ')	as 下道工序,
		t1.FQty				as 计划生产数量,
		case t3.FEntryID when  1 then 0 else t3.FAuxQtyRecive end						as 工序接收数量,
		case t3.FEntryID when  1 then t3.FAuxQtyFinish else t3.FAuxQtyHandOver end		as 工序转出数量,
		case t3.FEntryID when  1 then 0 else t3.FAuxQtyRecive- t3.FAuxQtyHandOver end	as 工序剩余数量, 
		t6.fnumber			as 材料长代码,
		t6.name				as 材料名称,
		t6.fmodel			as 材料规格型号,
		t6.fauxstockqty		as 已领数量,
		t6.FAuxQtySupply	as 补料数量,
		t6.FQtyLoss/t1.FQty*t3.FAuxQtyHandOver											as 损耗数量,
		case t3.FEntryID when  1 then 0 else t3.FAuxQtyRecive-t3.FAuxQtyHandOver end	as 工序在制数量  ,
		case when   (isnull(t6.fauxstockqty,0)-
		(isnull(t3.FAuxQtyHandOver,0)*isnull(t6.FQtyScrap,0))/(1-isnull(t6.FScrap,0)/100)-isnull(t6.FAuxQtySupply,0)) > 0 
		then  (isnull(t6.fauxstockqty,0)-(isnull(t3.FAuxQtyHandOver,0)*isnull(t6.FQtyScrap,0))/(1-isnull(t6.FScrap,0)/100)-isnull(t6.FAuxQtySupply,0))
		else 0 end																		as 材料在制数量,
		t6.fauxqtyscrap																	as 单位用量,
		t6.fauxstockqty*(1-t6.fscrap/100)/t6.fqtyscrap									as 领料套数,
		case when isnull(c.foperid,-900) = -900 then t1.fheadselfj0191 end				as 完工未入库数量
from 		ICMO t1 
join		SHWorkBill			t2	on t1.FInterID=t2.FICMOInterID
join		SHWorkBillEntry		t3	on t2.FInterID=t3.FinterID
left join	shworkbillentry		b	on b.finterid = t2.finterid and b.fentryid = (t3.fentryid -1) /*previous node	*/
left join	shworkbillentry		c	on c.finterid = t2.finterid and c.fentryid = (t3.fentryid + 1) /*next node		*/
join		t_department		t8	ON t8.fitemid = t1.fworkshop
join		t_ICItem			t4	on t1.FItemID=t4.FitemID
join		t_SubMessage		t5	on t3.FOperID=t5.FInterID							/*self node name			*/	
left join	t_submessage		d	on d.finterid = b.foperid							/*previous node name		*/
left join	t_submessage		e	on e.finterid = c.foperid							/*next node name			*/
left join (select t1.FInterID 		as finterid		,t3.FOperID 	as foperid	,t5.FNumber as fnumber
			,t5.FName  as name		,t5.FModel as fmodel  ,t4.FName 		as fname	,t3.FScrap 	as FScrap
			,sum(t3.FAuxQtyPick) 	as fauqtypick	,sum(t3.FAuxStockQty)  	as fauxstockqty
			,sum(t3.FAuxQtySupply)  as FAuxQtySupply,sum(t3.FQtyLoss)  		as FQtyLoss
			,sum(t3.FQtyScrap)  	as FQtyScrap 	,sum(t3.fauxqtyscrap) 	as fauxqtyscrap
		from ICMO t1																/*fheadselfj0191 :uninstock qty	*/
			join PPBOM t2 on t1.FInterID=t2.FICMOInterID
			join PPBOMEntry t3 on t2.FInterID=t3.FInterID
			join t_SubMessage t4 on t3.FOperID=t4.FInterID
			join t_ICItem t5 on t3.FItemID=t5.FItemID
		where   t1.FStatus<>3		/*未结案*/	
				and t3.fauxqtypick>0		/* 投料单应发数量 */	
				and t3.fauxstockqty>0	/* 投料单已领数量 */	
		group by t1.FInterID,t3.FOperID,t5.FNumber,t5.FName,t5.FModel,t4.FName,t3.FScrap
			) t6	on t1.FInterID=t6.finterid and t3.FOperID=t6.foperid
where	t1.FStatus<>3		/*未结案*/	
		
order by T8.FNAME,t1.FBillNo,t4.FNumber,t3.FEntryID