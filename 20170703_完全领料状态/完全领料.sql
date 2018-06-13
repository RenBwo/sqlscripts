select newid(),ISNULL(FValue,0) as FValue FROM t_SystemProfile WHERE FKey='MO_CLOSEOPTION' AND FCategory='SH'
--declare temporary table
Declare @#Data88082AAF4EA24C4398494C90A71129D1 table (FICMOInterID int ,FPPBOMEntryID int ,FItemID int ,FStockQty decimal(18,10))
--insert data ,ficmointerid,fppbomentryid,fitemid
Insert into @#Data88082AAF4EA24C4398494C90A71129D1
  SELECT u2.FICMOInterID,u2.FPPBOMEntryID,u2.FItemID,SUM(ISNULL(u2.FQty,0)) AS FStockQty 
 FROM ICStockBillEntry u2     
   WHERE  u2.FSourceTrantype>0 and u2.FInterID= 664917
   GROUP BY u2.FICMOInterID,u2.FPPBOMEntryID,u2.FItemID
 IF (select count(*) from @#Data88082AAF4EA24C4398494C90A71129D1 ) >0 
   UPDATE u1 SET
   u1.FStockQty=ISNULL(u1.FStockQty,0)+ISNULL((CASE WHEN u1.FMaterielType=376 THEN ISNULL(m2.FStockQty,0)*cast(-1 as float) ELSE ISNULL(m2.FStockQty,0) END),0),
   u1.FAuxStockQty=ISNULL(u1.FAuxStockQty,0)+ISNULL(ROUND((CASE WHEN u1.FMaterielType=376 THEN ISNULL(cast(m2.FStockQty as float),0)*cast(-1 as float) 
   ELSE ISNULL(cast(m2.FStockQty as float),0) END)/cast(t2.FCoEfficient as float),t1.FQtyDecimal),0),
   u1.FWIPQty=ISNULL(u1.FWIPQty,0)+ISNULL((CASE WHEN u1.FMaterielType=371 THEN ISNULL(m2.FStockQty,0) ELSE 0 END),0),
   u1.FWIPAuxQty=ISNULL(u1.FWIPAuxQty,0)+ISNULL(ROUND((CASE WHEN u1.FMaterielType=371 
   THEN ISNULL(cast(m2.FStockQty as float),0) else 0 END)/cast(t2.FCoEfficient as float),t1.FQtyDecimal),0)
   FROM PPBOMEntry u1 INNER JOIN @#Data88082AAF4EA24C4398494C90A71129D1 m2 
   ON u1.FItemID=m2.FItemID AND u1.FEntryID=m2.FPPBOMEntryID AND u1.FICMOInterID=m2.FICMOinterID 
   INNER JOIN t_ICItem t1 ON m2.FItemID=t1.FItemID 
   INNER JOIN t_MeasureUnit t2 ON u1.FUnitID=t2.FMeasureUnitID 
   INNER JOIN ICStockBill  t3 ON t3.FInterID=664917
   WHERE (u1.FMaterielType = 371 OR u1.FMaterielType = 376)  --普通件/返还件 
 -- temporary table
 select Distinct FICMOInterID, -1 AS FStatus INTO #ICMO88082AAF4EA24C4398494C90A71129D1 from @#Data88082AAF4EA24C4398494C90A71129D1
--data
UPDATE Temp001 SET FSTATUS=(CASE WHEN ROUND(m1.FAuxStockQty,t1.FQtyDecimal)>=ROUND(m1.FAuxInLowLimitQty,t1.FQtyDecimal)
                            THEN 0 ELSE 1 END)
FROM #ICMO88082AAF4EA24C4398494C90A71129D1 Temp001
INNER JOIN ICMO m1  ON m1.FInterID=Temp001.FICMOInterID
INNER JOIN t_ICItemBase t1 ON m1.FItemID=t1.FItemID
IF EXISTS(SELECT TOP 1 1 FROM PPBOMEntry u1 
          INNER JOIN #ICMO88082AAF4EA24C4398494C90A71129D1 Temp ON u1.FICMOInterID=Temp.FICMOInterID 
          WHERE u1.FMaterielType IN (371)
         )
BEGIN
UPDATE Temp001 SET FStatus=(CASE WHEN FStatus=-1 THEN 0 ELSE FStatus END) +ISNULL(t1.FCount,0)  FROM #ICMO88082AAF4EA24C4398494C90A71129D1 Temp001 
LEFT JOIN (
           SELECT COUNT(1) AS FCount,u1.FICMOInterID 
           FROM PPBOMEntry u1 
           INNER JOIN #ICMO88082AAF4EA24C4398494C90A71129D1 Temp ON u1.FICMOInterID=Temp.FICMOInterID 
           INNER JOIN t_ICItemBase t1 ON u1.FItemID=t1.FItemID
           WHERE u1.FMaterielType IN (371) AND ROUND(u1.FAuxStockQty,t1.FQtyDecimal)<ROUND(u1.FAuxQtyMust,t1.FQtyDecimal)
           GROUP BY u1.FICMOInterID 
          ) t1 ON temp001.FICMOInterID=t1.FICMOInterID
END
DECLARE @StartDate AS DateTime
SELECT @StartDate=FStartDate FROM T_PeriodDate
    WHERE FYear=(SELECT TOP 1 ISNULL(FValue,0) FROM t_SystemProfile WHERE FKey ='CurrentYear' AND FCategory='IC')
      AND FPeriod=(SELECT TOP 1 ISNULL(FValue,0) FROM t_SystemProfile WHERE FKey ='CurrentPeriod' AND FCategory='IC')
Update m1
    SET FStatus=(CASE WHEN Temp001.FStatus=0 THEN 3 ELSE (CASE WHEN FCloseDate>=@StartDate THEN 1 ELSE m1.FStatus END) END)
   ,FCloseDate=(CASE WHEN Temp001.FStatus=0 THEN Convert(varchar(10) ,Getdate(),121) ELSE (CASE WHEN FCloseDate>=@StartDate THEN  Null ELSE m1.FCloseDate END) END)
   ,FCheckerID=(CASE WHEN Temp001.FStatus=0 THEN 16690 ELSE (CASE WHEN FCloseDate>=@StartDate THEN  Null ELSE m1.FCheckerID END) END)
   ,FMrpClosed=(CASE WHEN Temp001.FStatus=0 THEN 1 ELSE (CASE WHEN FCloseDate>=@StartDate THEN 0 ELSE m1.FMrpClosed END) END)
   ,FHandworkClose=(CASE WHEN Temp001.FStatus=0 THEN FHandworkClose ELSE 0 END)
FROM ICMO m1 INNER JOIN #ICMO88082AAF4EA24C4398494C90A71129D1 Temp001 ON m1.FInterID=Temp001.FICMOInterID 
 Update T1 Set T1.FBackFlushed=1 From SHWorkBillEntry T1,ICStockBill T2 
 where T2.FInterID=664917 And T1.FWBInterID=T2.FWBInterID 
 --And (Select count(FInterID) from ICStockBill where FWBInterID=T2.FWBInterID)=1 
 -----------------------------**********************************
create table #PPBOMStock (FInterID int,FICMoInterID int ,FStockFlag int default(14215) ) 
insert into #PPBOMStock (FInterID,FICMoInterID,FStockFlag)
select FInterID,FICMoInterID,sum(FStockFlag) as FStockFlag
From
(
    select distinct u1.FInterID,u1.FICMoInterID,
    case when u1.FStockQty>u1.FQtyMust then 8  --超额领料
        when u1.FStockQty=u1.FQtyMust then 4   --完全领料
        when u1.FStockQty<u1.FQtyMust and u1.FStockQty>0 then 2   --部分领料
        else 1      --未领料
    end As FStockFlag
    from  PPBOMEntry u1
    inner join (select distinct FICMOInterID from @#Data88082AAF4EA24C4398494C90A71129D1) m on u1.FIcmoInterID=m.FICMOInterID
    Where u1.FOrderEntryID = 0/* cause                    */
    and (u1.FMaterielType = 371 OR u1.FMaterielType = 376)
) p2 group by FInterID,FICMoInterID

Update m
SET FStockFlag=
(case p.FStockFlag
    when 8  then 14218  --超额领料
    when 12 then 14218
    when 4 then 14217   --完全领料
    when 1 then 14215   --未领料
    else 14216          --部分领料
    End
)
from ICMO m
INNER JOIN #PPBOMStock p ON m.FInterID=p.FICMoInterID
DROP TABLE #PPBOMStock
