CREATE trigger [dbo].[whyb_sxh_icmoupdate] on [dbo].[ICMO]
after update 
as 
begin
DECLARE 
@FGZL		VARCHAR(255),
@FINTERID	INT,
@fnumber VARCHAR(50),
@Fqty	DECIMAL(28,10),	
@fauxstockqty	DECIMAL(28,10),			
@FOperAuxQtyScrap	DECIMAL(28,10),
@FOperAuxQtyForItem	DECIMAL(28,10)
select @FINTERID=FInterID from inserted
select @FINTERID=t1.FInterID,@fnumber=t2.FNumber,@Fqty=t1.FQty,
@fauxstockqty=t1.FAuxStockQty,@FOperAuxQtyForItem=sum(t4.FOperAuxQtyForItem),
@FOperAuxQtyScrap=sum(t4.FOperAuxQtyScrap)
from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
inner join SHProcRptMain t3 on t3.FICMOInterID=t1.FInterID
inner join SHProcRpt  t4 on t3.FInterID=t4.FinterID
inner join inserted t5 on t5.FInterID=t1.FInterID
group by t2.FNumber,t1.FInterID,t1.FQty,t1.FAuxStockQty
update t1 set t1.FHeadSelfJ0189=@FOperAuxQtyScrap,
t1.FHeadSelfJ0190=@FOperAuxQtyForItem                                                            
from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
inner join SHProcRptMain t3 on t3.FICMOInterID=t1.FInterID
inner join SHProcRpt  t4 on t3.FInterID=t4.FinterID
where t1.FInterID=@FINTERID
select @FGZL=t1.FHeadSelfJ0184 from ICMO t1
inner join icbom t2 on t1.FBomInterID=t2.FInterID
where t2.FVersion='自动装配' and t1.FInterID=@FINTERID
update ICMO set FHeadSelfJ01100='自动装配'
where FHeadSelfJ0184=@FGZL and FCheckDate>='2017-06-05'

end