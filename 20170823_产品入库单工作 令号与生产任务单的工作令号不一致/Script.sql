

-- =============================================    
-- Author:  <YangYuan>    
-- Create date: <2014-04-02)    
-- Description: < 调拨单保存时检查库存量是否充足，不足时，不允许保存！ FTranType=41 表示调拨单>    
   ---  增加 保存时有保存的小时和分钟，审核时有审核的小时和分钟，反审核后保存状态的小时分钟不变，审核时的小时分钟清空  2014-7-30    
-- =============================================    
/*CREATE TRIGGER [dbo].[ICStockBill_Insert]     
   ON  [dbo].[ICStockBill]    
   for UPDATE    
AS     
BEGIN */   
 DECLARE  @QTY     DECIMAL(28,10),   -- 调拨数量    
    @INV_QTY    DECIMAL(28,10),   -- 库存量         
    @X_ADD     INT,     -- 多行物料时错误数    
    @M_MESSAGE    VARCHAR(2000),   -- 报错信息    
    @FITEMID    INT,     -- 物料内码    
    @FSCStockID    INT,     -- 调发仓库    
    @FDCStockID    INT,     -- 调入仓库    
    @FSCSPID    INT,     -- 调出仓位    
    @FBatchNo    VARCHAR(200),   -- 批次      
    @FENTRYID    INT,     -- 表体行号      
    @FTranType    INT,     -- 表头单据类型     
    @FEntryID_item   INT,     -- 多行物料对应表体的行号    
    @X_ADD_line    INT,     --单行物料时错误数    
    @FStatus    smallint,    
    @FINTERID2    INT,    
    @FStatus2    smallint    
     
 SET NOCOUNT ON        
        
    SET  @QTY=0    
    SET  @INV_QTY=0    
    SET  @X_ADD=0    
    SET  @M_MESSAGE=''    
    SET  @X_ADD_line=0    
          
       
    select @FTranType= FTranType from icstockbill     where finterid = 785159
    select @FStatus= FStatus from icstockbill      where finterid = 785159
     
 ----出入库单据表头增加保存时间（24小时格式）审核时间(2014-08-01 16:20:33)    
 DECLARE seu_cur_2 CURSOR    
 FOR    
  SELECT FinterID, FStatus as FQTY FROM icstockbill       where finterid = 785159
                               
 OPEN seu_cur_2         
 FETCH NEXT FROM seu_cur_2 into @FINTERID2, @FStatus2        
 WHILE @@FETCH_STATUS=0    
 BEGIN    
      
  IF (SELECT FStatus  FROM deleted where FInterID =@FINTERID2)=0 AND @FStatus2 =0   --保存    
  BEGIN     
   UPDATE ICStockBill     
   SET FHeadSelfA0230=GETDATE(), FHeadSelfA0231=NULL    
   WHERE FInterID =@FINTERID2   and @FTranType<>41 
   --调拨单增加供应商对应名称和代码    
      
   update t2 set t2.FEntrySelfd0156=t3.FMapNumber,t2.FEntrySelfd0157=t3.FMapName    
   from ICStockBill t1    
inner join ICStockBillEntry t2 on t1.FInterID=t2.FInterID     
inner join ICItemMapping t3 on t2.FItemID=t3.FItemID     
where  t1.FTranType=41 and t1.FInterID =@FINTERID2    
       
       
  END    
  ELSE IF (SELECT FStatus  FROM deleted where FInterID =@FINTERID2 )=0 AND @FStatus2 =1    --审核    
  BEGIN    
   UPDATE ICStockBill     
   SET FHeadSelfA0231=GETDATE()    
   WHERE FInterID =@FINTERID2    
  END    
  ELSE IF (SELECT FStatus  FROM deleted where FInterID =@FINTERID2)=1 AND @FStatus2 =0    --反审核    
  BEGIN    
   UPDATE ICStockBill     
   SET FHeadSelfA0231=NULL    
   WHERE FInterID =@FINTERID2    
  END    
       
    FETCH NEXT FROM seu_cur_2 into  @FINTERID2, @FStatus2     
 END    
 CLOSE seu_cur_2    
 DEALLOCATE seu_cur_2    
  ----- 保存时间 审核时间 结束    
      
    IF @FTranType=41  and @FStatus=0  -- 仓库调拨单 时检查库存充足与否 并且是保存的状态时 未审核之前    
    BEGIN    
      
  ----====================================================================================    
  ----同一物品 同一仓库 同一仓位 同一批次 多行调拨 >=两行记录  2015-03-25 by YangYuan    
  DECLARE seu_cur CURSOR    
  FOR    
  SELECT b.FITEMID, b.FSCStockID, b.FSCSPID, b.FBatchNo,sum(b.FQTY) as FQTY FROM icstockbill a    
  left outer join ICStockBillEntry  b on a.FBrNo = b.FBrNo and a.FInterID = b.FInterID   and  a.finterid = 785159  
     group by b.FITEMID, b.FSCStockID,b.FSCSPID,b.FBatchNo    
     having count(*)>1    
                               
  OPEN seu_cur    
         
  FETCH NEXT FROM seu_cur into @FITEMID, @FSCStockID, @FSCSPID, @FBatchNo, @QTY    
        
  WHILE @@FETCH_STATUS=0    
         
  BEGIN    
   IF EXISTS ( SELECT 1 FROM ICInventory WHERE FITEMID=@FITEMID AND FSTOCKID=@FSCStockID and FStockPlaceID =@FSCSPID and FBatchNo=@FBatchNo )    
   BEGIN    
    SELECT @INV_QTY=isnull(Fqty,0) from ICInventory WHERE FITEMID=@FITEMID AND FSTOCKID=@FSCStockID and FStockPlaceID =@FSCSPID and FBatchNo=@FBatchNo    
   END     
   ELSE     
     SET @INV_QTY=0    
       
   ----库存量充足判断    
       
   IF (@INV_QTY=0 OR @INV_QTY<@QTY )    
   BEGIN        
    SET @X_ADD=@X_ADD+1     
    ---得到同一物料  同一仓库 同一仓位 同一批次 在表体中不同的行号，错误信息时使用     
       
    DECLARE cur_item_entry CURSOR    
    FOR    
    SELECT b.FENTRYID FROM icstockbill a    
    left outer join ICStockBillEntry  b on a.FBrNo = b.FBrNo and a.FInterID = b.FInterID    
    where b.FITEMID=@FITEMID and b.FSCStockID= @FSCStockID and b.FSCSPID=@FSCSPID and b.FBatchNo=@FBatchNo  
    and  a.finterid = 785159
        
    OPEN cur_item_entry    
          
    FETCH NEXT FROM cur_item_entry into @FEntryID_item         
    WHILE @@FETCH_STATUS=0          
    BEGIN       
     SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FEntryID_item,0) as char(3))+'行,'        
    FETCH NEXT FROM cur_item_entry into @FEntryID_item    
    END    
        
    CLOSE cur_item_entry    
    DEALLOCATE cur_item_entry     
     SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'物料代码重复；'      
   END    
       
   FETCH NEXT FROM seu_cur into @FITEMID, @FSCStockID,  @FSCSPID, @FBatchNo, @QTY    
  END    
  CLOSE seu_cur    
  DEALLOCATE seu_cur            
      
  --- ================================================================================    
  ---- 物品只有一行的调拨    
  DECLARE seu_cur1 CURSOR    
  FOR    
  SELECT b.FENTRYID,b.FITEMID, b.FSCStockID, b.FSCSPID, b.FBatchNo, b.FQTY FROM icstockbill a    
  left outer join ICStockBillEntry  b on a.FBrNo = b.FBrNo and a.FInterID = b.FInterID  and a.finterid = 785159   
     -- --因有仓位管理所以调整了同一物料同仓库同仓位同批次多行调拨问题  2015-03-25  BY YangYuan------    
     where not exists (    
        select 1 from (    
        SELECT b.FInterID,b.FITEMID, b.FSCStockID, b.FSCSPID, b.FBatchNo  FROM icstockbill a    
        left outer join ICStockBillEntry  b on a.FBrNo = b.FBrNo and a.FInterID = b.FInterID and a.finterid = 785159     
        group by b.FInterID, b.FITEMID, b.FSCStockID,b.FSCSPID, b.FBatchNo    
        having count(*)>1    
        ) s     
        where s.FInterID=b.FInterID and s.FITEMID=b.FITEMID and s.FSCStockID=b.FSCStockID and s.FSCSPID=b.FSCSPID and s.FBatchNo=b.FBatchNo    
       )    
         
         
     /*  --因有仓位管理所以调整了同一物料同仓库同仓位多行调拨问题  2015-03-25  BY YangYuan------    
     SELECT c.FItemID FROM ICStockBillEntry c    
         WHERE c.FInterID=a.FInterID     
         GROUP BY  c.FItemID, c.FSCStockID, c.FSCSPID     
         HAVING COUNT(*)>1)    
  */    
  OPEN seu_cur1    
         
  FETCH NEXT FROM seu_cur1 into @FENTRYID, @FITEMID, @FSCStockID, @FSCSPID, @FBatchNo, @QTY    
        
  WHILE @@FETCH_STATUS=0    
         
  BEGIN    
       
   IF EXISTS ( SELECT 1 FROM ICInventory WHERE FITEMID=@FITEMID AND FSTOCKID=@FSCStockID and FStockPlaceID =@FSCSPID and FBatchNo=@FBatchNo )    
   BEGIN    
    SELECT @INV_QTY=isnull(Fqty,0) from ICInventory WHERE FITEMID=@FITEMID AND FSTOCKID=@FSCStockID and FStockPlaceID =@FSCSPID and FBatchNo=@FBatchNo     
    --print(@INV_QTY)    
   END     
   ELSE     
     SET @INV_QTY=0    
       
   IF (@INV_QTY=0 OR @INV_QTY<@QTY )    
   BEGIN    
    SET @X_ADD_line=@X_ADD_line+1    
    SET @M_MESSAGE=isnull(@M_MESSAGE,' ')+'第'+cast(isnull(@FENTRYID,0) as char(3))+'行；'     
   END    
       
   FETCH NEXT FROM seu_cur1 into @FENTRYID, @FITEMID, @FSCStockID, @FSCSPID, @FBatchNo, @QTY    
  END    
  CLOSE seu_cur1    
  DEALLOCATE seu_cur1        
           
  --print(@X_ADD_line)       
  IF (@X_ADD>0 or @X_ADD_line>0)    
  BEGIN    
   SET @M_MESSAGE='库存量不足，不允许保存!'+ @M_MESSAGE    
   RAISERROR(@M_MESSAGE,18,18)    
   ROLLBACK TRANSACTION    
  return    
  END    
      
   END    
      
  -----------------------change by YANGYUAN  2014-08-11  -------------------------------------------------------    
   -----------------------完成品 入库时并且是保存的状态时 未审核之前  -----------------------------------------    
   ---------------------- 检查入库的仓库只能是销售订单对应客户的仓库或裸包库，其他仓库不允许保存和审核------------    
   DECLARE @FINTERID5  INT,    
   @FENTERID5  INT,    
   @F_103   INT,    
   @FDCSTOCKID5 INT,    
   @F_CN5   INT,    
   @M_MESSAGE2  VARCHAR(2000)     
       
 SET @F_CN5 =0    
 SET @M_MESSAGE2 =''    
     
   IF @FTranType=2 and @FStatus=0      
   BEGIN    
 DECLARE seu_cur5 CURSOR    
 FOR      
     select B.FInterID, B.FEntryID, F.F_103, B.FDCStockID    
    from icstockbill a    
  inner join ICStockBillEntry b on a.FInterID =b.FInterID   and a.finterid = 785159   
  inner join t_ICItem C ON C.FItemID =B.FItemID     
  INNER JOIN ICMO D ON D.FInterID =B.FICMOInterID    
  INNER JOIN SEOrderEntry E ON E.FInterID =D.FOrderInterID AND E.FEntryID =D.FSourceEntryID    
  INNER JOIN SEOrder E1 ON E1.FInterID =E.FInterID     
  INNER JOIN t_Organization F ON F.FItemID =E1.FCustID    
  INNER JOIN t_Stock G ON G.FItemID =F.F_103    
  INNER JOIN t_SubMessage C2 ON C2.FInterID =C.FTypeID     
  where a.FTranType=2 --AND C.FTypeID=40252      
        AND C2.FID LIKE 'CPL%'   --因为价格体系变更了，把成品类的细化了    
                               
 OPEN seu_cur5         
 FETCH NEXT FROM seu_cur5 into @FINTERID5, @FENTERID5, @F_103, @FDCSTOCKID5        
 WHILE @@FETCH_STATUS=0         
 BEGIN    
        
  IF @F_103<> @FDCSTOCKID5 AND @FDCSTOCKID5 <>58859      
  BEGIN    
   SET @F_CN5=@F_CN5+1    
   SET @M_MESSAGE2=isnull(@M_MESSAGE2,' ')+'第'+cast(isnull(@FENTERID5,0) as char(3))+'行；'     
  END    
 FETCH NEXT FROM seu_cur5 into @FINTERID5, @FENTERID5, @F_103, @FDCSTOCKID5    
 END    
 CLOSE seu_cur5    
 DEALLOCATE seu_cur5        
     
 IF (@F_CN5>0)    
  BEGIN    
   SET @M_MESSAGE2='入库仓库与客户对应仓库不一致!'+ @M_MESSAGE2    
   RAISERROR(@M_MESSAGE2,18,18)    
  -- ROLLBACK TRANSACTION    
   return    
  END    
      
   END    
      
  -----------------------change by YANGYUAN  2015-01-26  -------------------------------------------------------    
   -----------------------生产领料单 ERP系统已经处理了，不需要再做了---------------------------------------------    
   -----------------------产品入库单 保存/审核时  ---------------------------------------------------------------    
   ----------------------  检查领料单位/交货单位是否与生产任务单一致 不一致，系统自动修改------------------------    
   DECLARE @FDeptID1  INT,    
   @FDeptID2  INT,    
   @F_CN6   INT,    
   @F_CN8   INT,    
   @FStatus_old INT,    
   @M_MESSAGE3  VARCHAR(2000)     
       
 SET @F_CN8 =0    
 SET @F_CN6=0    
 SET @M_MESSAGE3 =''    
     
 select @FStatus_old=isnull(FStatus,0)  from deleted  ---保存变更前的数据     
    --新产品入库单添加时，deleted表中没有数据的，所以给这个旧状态赋予一个初值 0    
    if @FStatus_old is null     
    set @FStatus_old=0    
     
  --产品入库单  新增(新状态：0, 原来状态：0)、保存(新状态：0, 原来状态：0)、审核状态(新状态：1, 原来状态：0) 判断 库存是否充足     
  --反审核时不考虑库存量(新状态：0, 原来状态：1)    
      
 ----产品入库单新增时，判断选择的生产任务单中是否存在不同的生产部门     
 select @F_CN6=COUNT(distinct d.FWorkShop)    
   from icstockbill a    
   inner join ICStockBillEntry b on a.FInterID =b.FInterID     
   inner join t_ICItem C ON C.FItemID =B.FItemID     
   INNER JOIN ICMO D ON D.FInterID =B.FICMOInterID    
   WHERE A.FTranType=2   and a.finterid = 785159        
     
   IF  @FTranType =2 AND @F_CN6>1  AND @FStatus_old=0    ----产品入库单 未审核之前不包括反审核    
   BEGIN    
  SET @F_CN8 = 10    
   END    
   ELSE     
   BEGIN    
  SET @F_CN8=0    
   END    
        
   IF @FTranType =2  AND @F_CN6=1  AND @FStatus_old=0  ----产品入库单 未审核之前不包括反审核    
   BEGIN    
   select DISTINCT @FDeptID1=a.FDeptID, @FDeptID2=d.FWorkShop    
   from icstockbill a    
   inner join ICStockBillEntry b on a.FInterID =b.FInterID     
   inner join t_ICItem C ON C.FItemID =B.FItemID     
   INNER JOIN ICMO D ON D.FInterID =B.FICMOInterID    
   WHERE  A.FTranType=2 and a.finterid = 785159    
        
   IF @FDeptID1<> @FDeptID2      
   BEGIN    
   UPDATE ICStockBill     
   SET FDeptID=@FDeptID2    
   FROM icstockbill A    
   INNER JOIN ICStockBill B ON A.FInterID =B.FInterID     and a.finterid = 785159 
   END    
 END     
     
 IF (@F_CN8>0)    
 BEGIN    
  SET @M_MESSAGE3='产品入库单中只能选择同部门的生产任务单!'    
  RAISERROR(@M_MESSAGE3,18,18)    
  ROLLBACK TRANSACTION    
  --return    
 END    
 ------------------------结束---------------------------------    
     
 ----------------------------------2015-01-26 -----------------------------------------------------    
 -----------------------销售出库单保存时 检查库存；库存不足不允许保存和审核------------------------    
 -----------------------销售出库单单价取自发货通知单,不允许修改 若与发货通知单不一致则系统自动更改-------------    
     
 /*DECLARE  @QTY9   DECIMAL(28,10),     
    @INV_QTY9  DECIMAL(28,10),          
    @X_ADD9   INT,    
    @FCN_09   INT,    
    @M_MESSAGE4  VARCHAR(1000),        
    @FITEMID9  INT,     
   @FSTOCKNO9  INT,    
    @FENTRYID9  INT,        
    @FTranType9  INT,    
    @FStatus_old9   INT, --变动前原来的状态    
    @FStatus_new9   INT  --变动后新的状态    
  ---不好用，系统写的乱      
     
 SET NOCOUNT ON        
        
    SET  @QTY9=0    
    SET  @INV_QTY9 = 0    
    SET  @X_ADD9 = 0    
    SET  @FCN_09 = 0    
    SET  @M_MESSAGE4=''    
          
       
    select @FTranType9= FTranType, @FStatus_new9=FStatus from icstockbill    ---保存变更后的数据    
    select @FStatus_old9=isnull(FStatus,0)  from deleted  ---保存变更前的数据     
    --新销售出库单添加时，deleted表中没有数据的，所以给这个旧状态赋予一个初值 0    
    if @FStatus_old9 is null     
    set @FStatus_old9=0    
     
  --销售出库单  新增(新状态：0, 原来状态：0)、保存(新状态：0, 原来状态：0)、审核状态(新状态：1, 原来状态：0) 判断 库存是否充足     
  --反审核时不考虑库存量(新状态：0, 原来状态：1)    
 IF @FTranType9= 21 AND @FStatus_old9=0     
 BEGIN    
        
  DECLARE cur_9 CURSOR    
  FOR    
  SELECT b.FITEMID, b.FDCStockID, SUM(b.FQTY) AS FQTY, MIN(b.FENTRYID) AS FENTRYID FROM icstockbill a    
  left outer join ICStockBillEntry B on a.FInterID =b.FInterID     
     GROUP BY b.FITEMID, b.FDCStockID    
         
  OPEN cur_9    
         
  FETCH NEXT FROM cur_9 into @FITEMID9, @FSTOCKNO9, @QTY9, @FENTRYID9    
        
  WHILE @@FETCH_STATUS=0    
         
  BEGIN    
         
   IF EXISTS ( SELECT 1 FROM ICInventory WHERE FITEMID=@FITEMID9 AND FSTOCKID=@FSTOCKNO9)    
   BEGIN    
    SELECT @INV_QTY9=isnull(sum(Fqty),0) from ICInventory WHERE FITEMID=@FITEMID9 AND FSTOCKID=@FSTOCKNO9    
   END     
   ELSE     
     SET @INV_QTY9=0    
    
   IF (@INV_QTY9=0 OR @INV_QTY9<@QTY9 )     
   BEGIN    
    SET @X_ADD9=@X_ADD9+1    
    SET @M_MESSAGE4=isnull(@M_MESSAGE4,' ')+'第'+cast(isnull(@FENTRYID9,0) as char(3))+'行；'     
   END    
       
   FETCH NEXT FROM cur_9 into @FITEMID9,@FSTOCKNO9,@QTY9, @FENTRYID9    
  END    
  CLOSE cur_9    
  DEALLOCATE cur_9        
         
  --print(@X_ADD)    
  IF @X_ADD9>0    
  BEGIN    
   SET @M_MESSAGE4='库存量不足，不允许保存!'+ @M_MESSAGE4    
   RAISERROR(@M_MESSAGE4,18,18)    
   ROLLBACK TRANSACTION    
  END    
    END       
    */    
        
    DECLARE @FCN_09   INT     
    SET @FCN_09=0    
        
    ----销售出库单中存在与发货通知单单价不一致的判断    
    SELECT @FCN_09=COUNT(*)    
  FROM icstockbill  A    
 INNER JOIN ICStockBillEntry B on a.FInterID =b.FInterID   and a.finterid = 785159   
 INNER JOIN SEOutStockEntry D ON D.FInterID =B.FSourceInterId AND D.FEntryID=B.FSourceEntryID    
 INNER JOIN SEOutStock E ON E.FInterID =D.FInterID     
 WHERE A.FTranType=21     
   AND (B.FEntrySelfB0160<>D.FPrice OR B.FConsignPrice<>ROUND(D.FPrice * ISNULL(E.FExchangeRate,1),8))    
   AND B.FSourceBillNo  LIKE 'SEOUT%'    
     
 ----销售出库单 且单价与发货通知单不一致的修改    
 IF @FTranType= 21 AND @FCN_09>0     
 BEGIN    
  UPDATE ICStockBillEntry    
  SET FConsignPrice= ROUND(D.FPrice * E.FExchangeRate,8), FConsignAmount =ROUND(ROUND(D.FPrice * E.FExchangeRate,8)*B.FQty,2)    
    , FEntrySelfB0160=D.FPrice, FEntrySelfB0161=ROUND(D.FPrice * B.FQty,2)     
  FROM icstockbill A    
  INNER JOIN ICStockBillEntry B on a.FInterID =b.FInterID   and a.finterid = 785159   
  INNER JOIN SEOutStockEntry D ON D.FInterID =B.FSourceInterId AND D.FEntryID=B.FSourceEntryID    
  INNER JOIN SEOutStock E ON E.FInterID =D.FInterID     
  WHERE A.FTranType=21     
    AND (B.FEntrySelfB0160<>D.FPrice OR B.FConsignPrice<>ROUND(D.FPrice * ISNULL(E.FExchangeRate,1),8))    
    AND B.FSourceBillNo  LIKE 'SEOUT%'    
      
 END    
     
 -----------------------------END------------------------------------------------------     
     
 ---产品入库单新增及修改时若应收数量为零，实收数量大于零则不允许保存    
 -- 吴迪提出  2015-06-15    
     
 DECLARE @FINTERID12  INT,    
   @FENTERID12  INT,       
   @F_CN12   INT,    
   @M_MESSAGE12  VARCHAR(2000)     
       
 SET @F_CN12 =0    
 SET @M_MESSAGE12 =''    
     
    IF @FTranType=2 and @FStatus=0      
 BEGIN    
  DECLARE seu_cur12 CURSOR    
  FOR      
   SELECT A.FInterID,A.FEntryID FROM ICStockBillEntry A    
   INNER JOIN ICStockBill B ON A.FInterID =B.FInterID    
   INNER JOIN icstockbill C ON C.FInterID =B.FInterID  and C.finterid = 785159     
   WHERE A.FAuxQtyMust=0 AND A.FAuxQty >0    
     AND (A.FSourceInterId>0 OR A.FICMOInterID>0)  ---制造部五科 的产品入库单是没有生产任务单的，所以不能这样控制    
  OPEN seu_cur12         
  FETCH NEXT FROM seu_cur12 into @FINTERID12, @FENTERID12        
  WHILE @@FETCH_STATUS=0         
  BEGIN    
   SET @F_CN12=@F_CN12+1    
   SET @M_MESSAGE12=isnull(@M_MESSAGE12,' ')+'第'+cast(isnull(@FENTERID12,0) as char(3))+'行；'     
      
  FETCH NEXT FROM seu_cur12 into @FINTERID12, @FENTERID12    
  END    
  CLOSE seu_cur12    
  DEALLOCATE seu_cur12        
     
  IF (@F_CN12>0)    
  BEGIN    
   SET @M_MESSAGE12='不允许应收数量为零，实收数量大于零!'+ @M_MESSAGE12    
   RAISERROR(@M_MESSAGE12,18,18)    
   ROLLBACK TRANSACTION    
   --return    
  END    
      
   END    
       
   ---------------------END---------------------      
--END

