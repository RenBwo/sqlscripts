
CREATE VIEW t_Emp AS 
                  SELECT t1.F_102,t1.FAccountName,t1.FAddress,t1.FAllotPercent,t1.FAllotWeight,t1.FBankAccount
                  ,t1.FBankID,t1.FBirthday,t1.FBrNO,t1.FCreditAmount,t1.FCreditDays,t1.FCreditLevel,t1.FCreditPeriod
                  ,t1.FDegree,t1.FDeleted,t1.FDepartmentID,t1.FDuty,t1.FEmail,t1.FEmpGroup,t1.FEmpGroupID,t1.FGender
                  ,t1.FHireDate,t1.FID,t1.FIsCreditMgr,t1.FItemDepID,t1.FItemID,t1.FJobTypeID,t1.FLeaveDate
                  ,t1.FMobilePhone,t1.FModifyTime,t1.FName,t1.FNote,t1.FNumber,t1.FOperationGroup,t1.FOtherAPAcctID
                  ,t1.FOtherARAcctID,t1.FParentID,t1.FPersonalBank,t1.FPhone,t1.FPreAPAcctID,t1.FPreARAcctID
                  ,t1.FProfessionalGroup,t1.FShortNumber 
                  FROM t_Base_Emp t1 with(nolock) 
                  INNER JOIN HR_Base_Emp t2 with(nolock) ON t1.FItemID=t2.FItemID
                  
                  select * from t_base_emp where fname like '任波'
                  


