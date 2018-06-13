

/******************************************************************************
 * TABLE NAME:    PORFQ                                                       *
 * TRIGGER NAME:  PORFQ_Del                                                   *
 * CREATED BY:                                                                *
 * CREATION DATE: 2005/08/01 17:08                                            *
 * DESCRIPTION:                                                               *
 ******************************************************************************/
CREATE TRIGGER PORFQ_Del
            ON PORFQ
FOR DELETE
AS
    SET NOCOUNT ON
    
    IF EXISTS ( SELECT 1 FROM deleted WHERE FCheckerID <> 0)
    BEGIN
        ROLLBACK TRAN
        RAISERROR('不能删除已经审核的单据!',18,18)
    END
    ELSE IF EXISTS ( SELECT 1 FROM deleted WHERE FCancellation = 1)
    BEGIN
        ROLLBACK TRAN
        RAISERROR('不能删除已经作废的单据!',18,18)
    END
    ELSE
        DELETE E
          FROM PORFQEntry E
               INNER JOIN deleted D ON E.FInterID = D.FInterID


