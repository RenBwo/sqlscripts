CREATE VIEW t_ICItem AS 
    SELECT 
t0.FItemID,t0.FModel,t0.FName,t0.FHelpCode,t0.FDeleted,t0.FShortNumber
,t0.FNumber,t0.FModifyTime,t0.FParentID,t0.FBrNo,t0.FTopID,t0.FRP
,t0.FOmortize,t0.FOmortizeScale,t0.FForSale,t0.FStaCost
,t0.FOrderPrice,t0.FOrderMethod,t0.FPriceFixingType
,t0.FSalePriceFixingType,t0.FPerWastage,t0.FARAcctID
,t0.FPlanPriceMethod,t0.FPlanClass,t0.FjsPrice,t0.FcbPrice,
t1.FErpClsID,t1.FUnitID,t1.FUnitGroupID,t1.FDefaultLoc
,t1.FSPID,t1.FSource,t1.FQtyDecimal,t1.FLowLimit,t1.FHighLimit
,t1.FSecInv,t1.FUseState,t1.FIsEquipment,t1.FEquipmentNum
,t1.FIsSparePart,t1.FFullName,t1.FSecUnitID,t1.FSecCoefficient
,t1.FSecUnitDecimal,t1.FAlias,t1.FOrderUnitID,t1.FSaleUnitID
,t1.FStoreUnitID,t1.FProductUnitID,t1.FApproveNo,t1.FAuxClassID
,t1.FTypeID,t1.FPreDeadLine,t1.FSerialClassID,t2.FOrderRector
,t2.FPOHghPrcMnyType,t2.FPOHighPrice,t2.FWWHghPrc,t2.FWWHghPrcMnyType
,t2.FSOLowPrc,t2.FSOLowPrcMnyType,t2.FIsSale,t2.FProfitRate
,t2.FSalePrice,t2.FBatchManager,t2.FISKFPeriod,t2.FKFPeriod
,t2.FTrack,t2.FPlanPrice,t2.FPriceDecimal,t2.FAcctID,t2.FSaleAcctID
,t2.FCostAcctID,t2.FAPAcctID,t2.FGoodSpec,t2.FCostProject
,t2.FIsSnManage,t2.FStockTime,t2.FBookPlan,t2.FBeforeExpire
,t2.FTaxRate,t2.FAdminAcctID,t2.FNote,t2.FIsSpecialTax
,t2.FSOHighLimit,t2.FSOLowLimit,t2.FOIHighLimit,t2.FOILowLimit
,t2.FDaysPer,t2.FLastCheckDate,t2.FCheckCycle,t2.FCheckCycUnit
,t2.FStockPrice,t2.FABCCls,t2.FBatchQty,t2.FClass,t2.FCostDiffRate
,t2.FDepartment,t2.FSaleTaxAcctID,t2.FCBBmStandardID,t2.FCBRestore
,t2.FPickHighLimit,t2.FPickLowLimit,t3.FPlanTrategy,t3.FOrderTrategy
,t3.FLeadTime,t3.FFixLeadTime,t3.FTotalTQQ,t3.FQtyMin,t3.FQtyMax
,t3.FCUUnitID,t3.FOrderInterVal,t3.FBatchAppendQty,t3.FOrderPoint
,t3.FBatFixEconomy,t3.FBatChangeEconomy,t3.FRequirePoint
,t3.FPlanPoint,t3.FDefaultRoutingID,t3.FDefaultWorkTypeID
,t3.FProductPrincipal,t3.FDailyConsume,t3.FMRPCon,t3.FPlanner
,t3.FPutInteger,t3.FInHighLimit,t3.FInLowLimit,t3.FLowestBomCode
,t3.FMRPOrder,t3.FIsCharSourceItem,t3.FCharSourceItemID
,t3.FPlanMode,t3.FCtrlType,t3.FCtrlStraregy,t3.FContainerName
,t3.FKanBanCapability,t3.FIsBackFlush,t3.FBackFlushStockID
,t3.FBackFlushSPID,t7.F_102,t7.F_103,t7.F_105,t7.F_106
,t7.F_107,t7.F_108,t7.F_109,t7.F_111,t7.F_112,t7.F_113,t7.F_114
,t7.F_115,t7.F_117,t7.F_118,t7.F_122,t7.F_123,t7.F_124,t7.F_125
,t7.F_126,t7.F_127,t7.F_128,t7.F_129,t7.F_131,t7.F_132,t7.F_134
,t7.F_135,t7.F_136,t7.F_138,t7.F_139,t7.F_140,t7.F_141,t7.F_142
,t7.F_143,t7.F_144,t7.F_145,t7.F_146,t7.F_148,t7.F_149,t7.F_150
,t7.F_151,t7.F_152,t7.F_153,t7.F_154,t7.F_158,t7.F_159,t7.F_160
,t7.F_161,t7.F_162,t7.F_163,t7.F_164,t7.F_165,t7.F_166,t7.F_167
,t7.F_168,t7.F_169,t7.F_171,t7.F_172,t7.F_173,t7.F_174,t7.F_175
,t7.F_177,t7.F_178,t7.F_179,t7.F_180,t7.F_181,t4.FChartNumber
,t4.FIsKeyItem,t4.FMaund,t4.FGrossWeight,t4.FNetWeight
,t4.FCubicMeasure,t4.FLength,t4.FWidth,t4.FHeight,t4.FSize
,t4.FVersion,t5.FStandardCost,t5.FStandardManHour,t5.FStdPayRate
,t5.FChgFeeRate,t5.FStdFixFeeRate,t5.FOutMachFee,t5.FPieceRate
,t5.FStdBatchQty,t5.FPOVAcctID,t5.FPIVAcctID,t5.FMCVAcctID
,t5.FPCVAcctID,t5.FSLAcctID,t5.FCAVAcctID,t5.FCBAppendRate
,t5.FCBAppendProject,t5.FCostBomID,t5.FCBRouting
,t5.FOutMachFeeProject,t6.FInspectionLevel,t6.FInspectionProject
,t6.FIsListControl,t6.FProChkMde,t6.FWWChkMde,t6.FSOChkMde
,t6.FWthDrwChkMde,t6.FStkChkMde,t6.FOtherChkMde,t6.FStkChkPrd
,t6.FStkChkAlrm,t6.FIdentifier,t8.FNameEn,t8.FModelEn
,t8.FHSNumber,t8.FFirstUnit,t8.FSecondUnit,t8.FFirstUnitRate
,t8.FSecondUnitRate,t8.FIsManage,t8.FPackType,t8.FLenDecimal
,t8.FCubageDecimal,t8.FWeightDecimal,t8.FImpostTaxRate
,t8.FConsumeTaxRate,t8.FManageType,t8.FExportRate 
FROM t_ICItemCore 				t0 with(nolock) 
LEFT JOIN t_ICItemBase 			t1 with(nolock) ON t0.FItemID=t1.FItemID
LEFT JOIN t_ICItemMaterial 		t2 with(nolock) ON t0.FItemID=t2.FItemID
LEFT JOIN t_ICItemPlan 			t3 with(nolock) ON t0.FItemID=t3.FItemID 
LEFT JOIN t_ICItemDesign 		t4 with(nolock) ON t0.FItemID=t4.FItemID 
LEFT JOIN t_ICItemStandard 		t5 with(nolock) ON t0.FItemID=t5.FItemID  
LEFT JOIN t_ICItemQuality 		t6 with(nolock) ON t0.FItemID=t6.FItemID 
LEFT JOIN t_ICItemCustom 		t7 with(nolock) ON t0.FItemID=t7.FItemID 
LEFT JOIN T_BASE_ICItemEntrance t8 with(nolock) ON t0.FItemID=t8.FItemID

