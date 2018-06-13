/*
* @buexrate--budget exchange rate 
* @addtaxrate
* @norstd--normal alert standard
* @rowcount --the numbers of rows
* t_organization f_108 质量赔偿金% ,返点% f_115 ,标准利润率f_116
 */
-----------客户价格体系----------
SET NOCOUNT ON
declare @buexrate  		decimal(10,4)
		,@norStd 		decimal(10,4)
		,@rowcount 		int
		,@addtaxrate 	decimal(10,2)
/*增值税率*/
set @addtaxrate = 0.16
/*预算汇率*/
select @buexrate=fexchangerate from t_exchangerateentry where fexchangeratetype = 4 
				 and fcyfor = 1 and fcyto = 1000 and fbegdate < getdate()  and fenddate > getdate()
				and isnull(fchkuserid,0)<>0 and isnull(fchkdate,'1999-01-01') <> '1999-01-01' 
				 order by fentryid desc 
/* 通用预警标准 */
select @norStd=isnull(b.f_101,0) from t_item a join t_item_3030 b on a.fitemid = b.fitemid 
where  a.fitemclassid = 3030 and a.funused = 0 and fdeleted = 0 and isnull(a.fchkuserid,0) > 0
/* 个别预警标准*/
select b.fitemid as alter_id,b.f_104 as itemid ,b.f_105 as custid,b.f_101 as alter_level 
into #alter_individual
from t_item a 
join t_item_3023 b on a.fitemid = b.fitemid 
and  a.fitemclassid = 3023 and a.funused = 0 and fdeleted = 0 and isnull(a.fchkuserid,0) > 0

/*国内运费标准*/
select b.fitemid as tran_id,b.f_107 as trantype,b.f_105 as messure
,b.f_103 as price,b.f_106 as taxrate,b.f_108 as supid,b.fname 
into #stdTranPri
from t_item a 
join t_item_3029 b on a.fitemid = b.fitemid and  a.fitemclassid = 3029
 and a.funused = 0 and fdeleted = 0 and isnull(a.fchkuserid,0) > 0
 
select ww.* into #temp
from (
SELECT C.FNumber AS 客户代码, c.FName as 客户名称, I.FMapNumber as 客户对应物料代码
	 , I.FMapName AS 客户对应物料名称, B.FNumber AS 物料代码
	 , B.FName AS 物料名称, B.FModel AS 规格型号, B.F_161 AS 适用车型,B.F_146 AS 适用车型英文, d.FName as 辅助属性
	 , E.FNumber AS 计量单位代码, E.FName as 计量单位
    , B.F_131 AS 'OE代码', B.F_132 AS 'DPI代码',B.F_158 AS 'NISSENS代码', J.FName AS '产品结构形式' 
    , J2.FName AS '芯体颜色标准', A.FBegQty AS '销货量(从)', A.FEndQty AS '销货量(到)'
    , F.FNumber AS 币别代码, f.FName as 币别
    , G.FID AS 价格类型代码 , g.FName as 价格类型
    , A.FPrice as 报价, '   '+F2.FName as 最低限价币别, A2.FLowPrice as 最低限价金额
	
	,isnull(c.f_108,0)*100 as '质量赔偿金%批量事故除外' 
	,isnull(c.f_115,0)*100 as '返点%' 
	,(case a.FcuryID when 1 then isnull(rb01.fcoststandInland,0) else 0 end ) as 标准成本出厂价
	,(case when a.FcuryID = 1 and isnull(rb03.messure,0) = 125  
				then isnull(B.FSIZE,0)*1000000/12000*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))
		  when a.FcuryID = 1 and isnull(rb03.messure,0) = 207266 
		  		then isnull(B.FSIZE,0)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))
		  when a.FcuryID = 1 and isnull(rb03.messure,0) <> 207266 and isnull(rb03.messure,0) <> 125 
		  		then -1	
	 else 0 end )as '运费(不含税)'
	,(case a.FcuryID when 1000 then isnull(rb01.fcoststandfobqd,0) else 0 end ) as '标准成本FOB青岛'
	,@buexrate as '预算汇率'
	,(case a.FcuryID 
		when 1000 	then round(A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						*@buexrate - isnull(rb01.fcoststandfobqd,0),2) 
		when 1 		then round(A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						/(1+@addtaxrate)- isnull(rb01.fcoststandInland,0) 
						- (case isnull(rb03.messure,0) when 125 then isnull(B.FSIZE,0)*1000000/12000  
						when 207266 then isnull(B.FSIZE,0) 
						else 0 end)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))  ,2)
	 	else 0 end ) as  '利润总额'
	,(case a.FcuryID 
		when 1000 	then round((A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						*@buexrate - isnull(rb01.fcoststandfobqd,0))/(A.FPrice*@buexrate),4) 
		when 1 		then round((A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						/(1+@addtaxrate)- isnull(rb01.fcoststandInland ,0)
						- (case isnull(rb03.messure,0) when 125 then isnull(B.FSIZE,0)*1000000/12000  
						when 207266 then isnull(B.FSIZE,0)
						else 0 end)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0)))/A.FPrice ,4)
	 	else 0 end)*100 as '利润率%'
	
	,rb02.alter_level*100 as '预警利润率%'
	
    ,  '   '+CONVERT(CHAR(10),A.FBegDate,120) AS 生效日期,  '   '+CONVERT(CHAR(10),a.FEndDate,120) as 失效日期
    , A.FLeadTime as 销售提前期, A.FNote AS 备注
    , (CASE WHEN A.FChecked=1 THEN '   是' else '   否' END) AS 审核标志
    , (CASE WHEN A2.FCanSell=1 THEN  '   是' else '   否' END) AS 允许销售
    , (CASE WHEN A2.FLPriceCtrl=1 THEN '   是' else '   否' END) AS 最低价格控制
    , H.FName AS 维护人, CONVERT(CHAR(10),A.FMaintDate,120) AS 维护日期, H2.FName AS 审核人
    , (CASE WHEN CONVERT(DATETIME, a.FCheckDate) = '1900-01-01' THEN NULL ELSE CONVERT(CHAR(10),a.FCheckDate,120)  END) AS 审核日期
    , B.FSIZE AS 体积
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FLENGTH end) as 长度
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FWIDTH END) as 宽度
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FHEIGHT END) as 高度
    , B.FGrossWeight AS 毛重
  FROM ICPrcPlyEntry A
 INNER JOIN ICPrcPlyEntrySpec A2 ON A.FInterID = A2.FInterID AND A.FItemID = A2.FItemID AND A.FRelatedID = A2.FRelatedID
 INNER JOIN ICPrcPly A3 ON A3.FInterID =A.FInterID and a.FInterID=4  
 INNER JOIN t_ICItem B ON A.FItemID =B.FItemID AND B.FDeleted=0
 JOIN t_Organization C ON a.FRelatedID=C.FItemID AND C.FItemID<>0
 join #alter_individual	rb02 on rb02.itemid=a.fitemid and rb02.custid=a.FRelatedID
 left join t_bdStandCostRPT rb01 on rb01.fproditemid = a.fitemid
 left join #stdTranPri rb03 on rb03.trantype = a.fpricetype
	
  LEFT JOIN t_AuxItem D ON A.FAuxPropID=D.FItemID AND D.FItemID<>0							--辅助属性
  LEFT JOIN t_Measureunit E ON A.FUnitID=E.FItemID AND E.FItemID<>0							--单位
  LEFT JOIN t_Currency F ON A.FCuryID=F.FCurrencyID AND F.FCurrencyID<>0					--币别
  LEFT JOIN t_Currency F2 ON A2.FLPriceCuryID=F2.FCurrencyID AND F2.FCurrencyID<>0			--最低限价币别
  LEFT JOIN t_SubMessage G ON A.FPriceType=G.FInterID AND G.FInterID<>0						--价格类型
  LEFT JOIN t_User H ON A.FMainterID=H.FUserID AND H.FUserID<>0								--维护人
  LEFT JOIN t_User H2 ON A.FCheckerID=H2.FUserID AND H2.FUserID<>0
  LEFT OUTER JOIN ICItemMapping I ON B.FItemID = I.FItemID AND I.FPropertyID = 1 AND A.FRelatedID = I.FCompanyID
  LEFT OUTER JOIN t_SubMessage J ON J.FParentID =10007 AND J.FInterID =B.F_134
  LEFT OUTER JOIN t_SubMessage J2 ON J2.FParentID=10008 AND J2.FInterID = B.F_135

   union all

 SELECT  C.FNumber AS 客户代码, c.FName as 客户名称, I.FMapNumber as 客户对应物料代码
	 , I.FMapName AS 客户对应物料名称, B.FNumber AS 物料代码
	 , B.FName AS 物料名称, B.FModel AS 规格型号, B.F_161 AS 适用车型,B.F_146 AS 适用车型英文, d.FName as 辅助属性
	 , E.FNumber AS 计量单位代码, E.FName as 计量单位
    , B.F_131 AS 'OE代码', B.F_132 AS 'DPI代码',B.F_158 AS 'NISSENS代码', J.FName AS '产品结构形式' 
    , J2.FName AS '芯体颜色标准', A.FBegQty AS '销货量(从)', A.FEndQty AS '销货量(到)'
    , F.FNumber AS 币别代码, f.FName as 币别
    , G.FID AS 价格类型代码 , g.FName as 价格类型
    , A.FPrice as 报价, '   '+ F2.FName as 最低限价币别, A2.FLowPrice as 最低限价金额
	
	,isnull(c.f_108,0)*100 as '质量赔偿金%批量事故除外' 
	,isnull(c.f_115,0)*100 as '返点%' 
	,(case a.FcuryID when 1 then isnull(rb01.fcoststandInland,0) else 0 end ) as 标准成本出厂价
	,(case when a.FcuryID = 1 and isnull(rb03.messure,0) = 125  
				then isnull(B.FSIZE,0)*1000000/12000*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))
		  when a.FcuryID = 1 and isnull(rb03.messure,0) = 207266 
		  		then isnull(B.FSIZE,0)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))
		  when a.FcuryID = 1 and isnull(rb03.messure,0) <> 207266 and isnull(rb03.messure,0) <> 125 
		  		then -1	
	 else 0 end )as '运费(不含税)'
	,(case a.FcuryID when 1000 then isnull(rb01.fcoststandfobqd,0) else 0 end ) as '标准成本FOB青岛'
	,@buexrate as '预算汇率'
	,(case a.FcuryID 
		when 1000 	then round(A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						*@buexrate - isnull(rb01.fcoststandfobqd,0),2) 
		when 1 		then round(A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						/(1+@addtaxrate)- isnull(rb01.fcoststandInland,0) 
						- (case isnull(rb03.messure,0) when 125 then isnull(B.FSIZE,0)*1000000/12000  
						when 207266 then isnull(B.FSIZE,0) 
						else 0 end)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0))  ,2)
	 	else 0 end ) as  '利润总额'
	,(case a.FcuryID 
		when 1000 	then round((A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						*@buexrate - isnull(rb01.fcoststandfobqd,0))/(A.FPrice*@buexrate),4) 
		when 1 		then round((A.FPrice*(1-isnull(c.f_115,0)-isnull(c.f_108,0))
						/(1+@addtaxrate)- isnull(rb01.fcoststandInland ,0)
						- (case isnull(rb03.messure,0) when 125 then isnull(B.FSIZE,0)*1000000/12000  
						when 207266 then isnull(B.FSIZE,0)
						else 0 end)*isnull(rb03.price,0)/(1+isnull(rb03.taxrate,0)))/A.FPrice ,4)
	 	else 0 end)*100 as '利润率%'
		 	
	,@norStd*100 as '预警利润率%'	
    ,  '   '+CONVERT(CHAR(10),A.FBegDate,120) AS 生效日期,  '   '+CONVERT(CHAR(10),a.FEndDate,120) as 失效日期
    , A.FLeadTime as 销售提前期, A.FNote AS 备注
    , (CASE WHEN A.FChecked=1 THEN '   是' else '   否' END) AS 审核标志
    , (CASE WHEN A2.FCanSell=1 THEN  '   是' else '   否' END) AS 允许销售
    , (CASE WHEN A2.FLPriceCtrl=1 THEN '   是' else '   否' END) AS 最低价格控制
    , H.FName AS 维护人, CONVERT(CHAR(10),A.FMaintDate,120) AS 维护日期, H2.FName AS 审核人
    , (CASE WHEN CONVERT(DATETIME, a.FCheckDate) = '1900-01-01' THEN NULL ELSE CONVERT(CHAR(10),a.FCheckDate,120)  END) AS 审核日期
    , B.FSIZE AS 体积
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FLENGTH end) as 长度
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FWIDTH END) as 宽度
    , (CASE WHEN B.FNote='吴总临时使用纸箱外箱数据20150107' then 0 else B.FHEIGHT END) as 高度
    , B.FGrossWeight AS 毛重
  FROM ICPrcPlyEntry A
 INNER JOIN ICPrcPlyEntrySpec A2 ON A.FInterID = A2.FInterID AND A.FItemID = A2.FItemID AND A.FRelatedID = A2.FRelatedID
 INNER JOIN ICPrcPly A3 ON A3.FInterID =A.FInterID and a.FInterID=4  
 INNER JOIN t_ICItem B ON A.FItemID =B.FItemID  AND B.FDeleted=0
 left JOIN t_Organization C ON a.FRelatedID=C.FItemID AND C.FItemID<>0 
 
 left join t_bdStandCostRPT rb01 on rb01.fproditemid = b.fitemid
 left join #stdTranPri rb03 on rb03.trantype = a.fpricetype
 
  LEFT JOIN t_AuxItem D ON A.FAuxPropID=D.FItemID AND D.FItemID<>0							--辅助属性
  LEFT JOIN t_Measureunit E ON A.FUnitID=E.FItemID AND E.FItemID<>0							--单位
  LEFT JOIN t_Currency F ON A.FCuryID=F.FCurrencyID AND F.FCurrencyID<>0					--币别
  LEFT JOIN t_Currency F2 ON A2.FLPriceCuryID=F2.FCurrencyID AND F2.FCurrencyID<>0			--最低限价币别
  LEFT JOIN t_SubMessage G ON A.FPriceType=G.FInterID AND G.FInterID<>0						--价格类型
  LEFT JOIN t_User H ON A.FMainterID=H.FUserID AND H.FUserID<>0								--维护人
  LEFT JOIN t_User H2 ON A.FCheckerID=H2.FUserID AND H2.FUserID<>0
  LEFT OUTER JOIN ICItemMapping I ON B.FItemID = I.FItemID AND I.FPropertyID = 1 AND A.FRelatedID = I.FCompanyID
  LEFT OUTER JOIN t_SubMessage J ON J.FParentID =10007 AND J.FInterID =B.F_134
  LEFT OUTER JOIN t_SubMessage J2 ON J2.FParentID=10008 AND J2.FInterID = B.F_135
  WHERE 
	not exists( select * from #alter_individual	where  itemid=a.fitemid and custid=a.FRelatedID ) 
	) ww
   
   select row_number() over (order by 客户代码 ) as sn
   ,客户代码, 客户名称, 客户对应物料代码,客户对应物料名称, 物料代码
	, 物料名称,规格型号, 币别 ,价格类型 , 报价  
	, "返点%"
	,"利润率%"
	,"预警利润率%"
	from #temp where "利润率%" < "预警利润率%"
	
   drop table #temp, #alter_individual, #stdTranPri

    
   
   
   
   
   
   
   