/******************************************************************************
 * FUNCTION NAME: ExpandBOMForTask                                            *
 * CREATED BY:    N/A                                                         *
 * CREATION DATE: 2005-05-31                                                  *
 * DESCRIPTION:                                                               *
 * PARAMETERS:    @BrNo                                                       *
 *                @ICWorkID                                                   *
 *                @ConsiderStock                                              *
 *                @Retstr                                                     *
 ******************************************************************************/
CREATE PROCEDURE ExpandBOMForTask
    @BrNo          VARCHAR (10),
    @ICWorkID      INT,
    @ConsiderStock INT,
    @Retstr        VARCHAR (255) OUTPUT
AS
    SET NOCOUNT ON
    
    DECLARE @InterID INT
    DECLARE @level   INT
    DECLARE @Dp      INT
    DECLARE @Qty     FLOAT
    
    CREATE TABLE #ICItem
    (  
        FInterID  int,
        FItemID   int,
        FParentID int,
        FQty      float,
        FLevel    int null default 0
    )
    
    CREATE TABLE #ICItem_1
    (   
        FItemID int ,
        FQty    float
    )
    
    if @ConsiderStock = 0
    begin
        DECLARE CurGet SCROLL CURSOR FOR
                SELECT FItemID, FQty
                  FROM ICMO
                 WHERE FInterID = @ICWorkID AND FBrNo = @BrNo
    END
    ELSE
    BEGIN
        --考虑现有库存和安全库存的生产数量
        DECLARE CurGet SCROLL CURSOR FOR
                SELECT ICMO.FItemID,
                       FQty = CASE WHEN (FQty + ISNULL((SELECT FSecInv
                                                          FROM t_ICItem
                                                         WHERE FItemID = ICMO.FItemID),
                                                        0) - ISNULL((SELECT SUM(FQty)
                                                                       FROM ICInventory
                                                                      WHERE FItemID = ICMO.FItemID),
                                                                     0)) < 0 THEN 0
                                   ELSE FQty + ISNULL((SELECT FSecInv
                                                         FROM t_ICItem
                                                        WHERE FItemID = ICMO.FItemID),
                                                       0) - ISNULL((SELECT SUM(FQty)
                                                                      FROM ICInventory
                                                                     WHERE FItemID = ICMO.FItemID),
                                                                    0)
                              END
                  FROM ICMO
                 WHERE FInterID = @ICWorkID AND FBrNo = @BrNo
    END
    
    OPEN CurGet
    FETCH CurGet INTO @InterID, @Qty
    
    WHILE @@FETCH_STATUS <> -1
    BEGIN
        IF @InterID IS NULL
        BEGIN
            SELECT @Retstr = '不存在BOM单！'
            RETURN
        END
        ELSE
        BEGIN
            SELECT @level=0
            IF (SELECT COUNT(*) FROM ICBOM WHERE FBrNo = @BrNo AND FItemID = @InterID AND FStatus = 0) = 0
            BEGIN
                SELECT @Retstr = '该物料没有建立BOM。'
                GOTO NEXT
            END
            
            INSERT INTO #ICItem (FInterID, FItemID, FQty, FParentID, FLevel)
                          SELECT FInterID, FItemID, @Qty/FQty, FParentID, @Level
                            FROM ICBOM
                           WHERE FBrNo = @BrNo AND FItemID = @InterID AND FStatus = 0
            SELECT @Dp = 0
            
            WHILE EXISTS(SELECT 1 FROM #ICItem WHERE FLevel = @Level)
            BEGIN
                SELECT @Dp = @Dp + 1
                
                INSERT INTO #ICItem (FInterID, FItemID, FQty, FParentID, FLevel)
                              SELECT 0, FItemID, FQty, FParentID, @Level+1
                                FROM ICBOMChild
                               WHERE FParentID IN (SELECT FInterID FROM #ICItem WHERE FLevel = @Level)
                
                UPDATE t0
                   SET t0.FQty = t1.FQty * t0.FQty
                  FROM #ICItem t0, #ICItem t1
                 WHERE t0.FParentID = t1.FInterID AND t1.FLevel = @Level AND t0.FLevel = @Level + 1
                
                UPDATE t0
                   SET t0.FInterID = t1.FInterID
                  FROM #ICItem t0, ICBOM t1, t_ICItem t2
                 WHERE t0.FLevel = @Level + 1 AND t0.FItemID = t1.FItemID AND t1.FStatus = 0
                   AND t0.FItemID = t2.FItemID AND t2.FErpClsID <> 1
                
                SELECT @Level = @Level + 1
                IF @Dp = 20
                BEGIN
                    SELECT @Retstr = '数据可能有嵌套！'
                    BREAK
                END
            END
            
            /*删除所有有BOM单物料，因为他们是由其他物料组成*/
            DELETE FROM #ICItem WHERE FInterID<>0
            /*汇总所有相同物料*/
            INSERT INTO #ICItem_1(FItemID, FQty)
                           SELECT FItemID, SUM(FQty)
                             FROM #ICItem
                         GROUP BY FItemID
            
            DELETE FROM #ICItem
        END
    
    NEXT:
    
        FETCH CurGet INTO @InterID, @Qty
    END
    
    CREATE TABLE #ICItem_2
    (   
        FItemID INT,
        FQty    FLOAT
    )
    
    INSERT INTO #ICItem_2(FItemID, FQty)
                   SELECT FItemID, SUM(FQty)
                     FROM #ICItem_1
                 GROUP BY FItemID
    
    CLOSE CurGet
    DEALLOCATE CurGet
    
    SELECT t0.*, t1.FName, t1.FModel, t1.FShortNumber AS FNumber, t1.FErpClsID, t1.FTrack, t1.FUnitID,
           t2.FName AS FUnitName, t2.FShortNumber AS FUnitNumber, t0.FItemID, t0.FItemID AS FInterID,
           t0.FItemID AS FEntryID, t1.FPlanPrice, t1.FQtyDecimal, t1.FPriceDecimal
      FROM #ICItem_2 t0,t_ICItem t1,t_MeasureUnit t2
     WHERE t0.FItemID=t1.FItemID
       AND t1.FUnitID*=t2.FItemID
    
    DROP TABLE #ICItem
    DROP TABLE #ICItem_1
    RETURN