-- ========================================================================================
/*
 * DESCRIPTION:		计算工资时没有吴琼，原因：人员职务调整成主管，本程序有效范围：内贸专员职务，外贸专员职务。
 * DESCRIPTION：		通知人事调整职员职务。
 * DATE：			20170802
 * AUTHOR：			RENBO
 */
-- Author:			BY YangYuan
-- Create date:		<2015-08-13>
-- Description:		营销业务员每月工资  基本工资 + 提成 <吴总 张云峰Z 盛红春B 要求>
-- Description:		营销人员工资=销售情况（基本工资 +　提成） + 回款情况 （基本工资 +　提成）
-- Description:		销售情况计算依据：已经审核的销售出库单
-- Description:		回款情况计算依据：销售发票核销日志

-- updated date:	2017/01/18
-- Modifier:		RENBO
-- Description:		销售情况计算依据：销售发票 <营销主管-张云峰要求>

-- updated date:	2017/02/07
-- writer:			RENBO
-- Description:		内贸标准由25万调整为15万 〈张云峰Z 要求〉
-- Description:		重写 @FPlanFDate 计算公式 <孙兴华Z 要求>

-- updated date:	2017/06/06
-- writer:			RENBO
-- Description:		销售金额取数字段调整 〈财务部 王东芹部长 要求〉
-- Description:		变更前：专用发票（内贸）取含税价格 FstdAmountIncludeTax；普通发票（外贸）取未税价格 FstdAmountIncludeTax
-- Description:		变更前：但是在2017年05月发现，有内贸客户开具普通发票，即存在普通发票（内贸）的情况和外贸内贸取含税价格 FstdAmount
-- Description:		变更后：专用发票（内贸）取含税价格 when icsale.ftrantype = 80 then icsaleentry.FstdAmountIncludeTax ；
-- Description:		变更后：普通发票（内贸 外贸）取含税价格 when icsale.ftrantype = 86 then icsaleentry.FstdAmount
-- ==========================================================================================================


CREATE PROCEDURE [dbo].[SalerPay_manager] 
	@FDateFrom       nvarchar(8),
	@FDateTo		 nvarchar(8),
	@FYear			 nvarchar(4),
	@FMonth			 nvarchar(2),
	@FQUFEN			 nvarchar(1),
	@M_MESSAGE		VARCHAR(1000) output		--错误信息
AS
BEGIN

	SET NOCOUNT ON 
	
	DECLARE @FDATE1		DATETIME,
	        @FDATE2		DATETIME 
	SET @FDATE1 = CAST(@FDateFrom AS DATETIME) 
	SET @FDATE2 = CAST(@FDateTo   AS DATETIME) 
	SET @FYear=LEFT(@FDateFrom,4) 
	
	-- 新增 修改  时 执行以下内容
	IF @FQUFEN ='U'
	BEGIN
		--1. (销售工资 + 销售提成)  计算
		-- 1.1 销售临时表 按业务员先笼统的进行汇总
		 Create Table #SalerAmount1(      
		 FItemID					int,									--业务员内码
		 FNumber					varchar(255),							--业务员代码
		 FName						varchar(255),							--业务员名称
		 FAmount1					decimal(20,2) default(0),				--销售额
		 FXiShu						int,									--区分， 0 为 不包括新开发客户的 销售额
		 FZhiWuCd					int,									--业务员职务区分（外贸 内贸)
		 FAmount2					decimal(20,2) default(0),				--新开发客户的销售额 对应正常业务员
		 FAmount3					decimal(20,2) default(0),				--新开发客户的销售额 对应开发人员
		 FPlanAmount				decimal(20,2) default(0))				--业务员销售计划
	     
		 -- 1.1 销售结果表  根据要求进行详细分解最终结果表
		Create Table #SalerAmount2(      
		 FItemID					int,									--业务员内码
		 FNumber					varchar(255),							--业务员代码
		 FName						varchar(255),							--业务员名称
		 FAmount1					decimal(20,2) default(0),				--销售额（不包括新开发客户指定业务员)
		 FAmount2					decimal(20,2) default(0),				--新开发客户 销售额 对应正常业务员
		 FPlanAmount				decimal(20,2) default(0),				--业务员销售计划
		 FAmount3					decimal(20,2) default(0),				--新开发客户的销售额 对应开发人员
		 FSaleRatio					decimal(28,10) default(0),				--提成系数
		 FSaleBaseAmount			decimal(20,2) default(0),				--销售基本工资
		 FDrawPercentage			decimal(20,2) default(0)				--销售提成金额
		 )
	    
		-- 1.2  --创建表#SalerAmount1 的数据
		--说明： 1. 内贸销售员把所有内贸销售金额合计后平均分配；外贸销售员吴琼和丁娇娇按 70%、 30% 分割；其余外贸人员就是各自自己的销售业绩
		-- 2. 新开发的客户在开发有效期内的销售额给开发人员100%，给业务员100%(一份按两份进行计算)
		--    开发人员只拿提成为开发客户所有销售额*0.01；业务员按照正常的计算方式计算；
		-- 3. 内贸 基准为25万元；外贸基准为35万元
		-- 4. 日期以销售出库单审核日期进行判断
		-- 5. 详细说明：
		-- 5.1 A 销售额：	销售出库单制单日期（1-31日)且是审核状态: 销售本位币
		-- 5.2 B 当月销售任务额(RMB):	销售计划单中业务员每月计划
		-- 5.3 C 实际完成情况	= A/B
		-- 5.4 D 提成计算系数:	实际完成情况百分比>=90 then 100%  >=80% and <90%  then 80%   >=70% and <80%  then 60%  <70%  then 0 end
		-- 5.5 E 销售基本工资:	外贸以35万为基础；内贸以15万为基础；当半月销售额>=35万 then 2000元；<35万 then 销售额/35万*2000元
		-- 5.6 F 销售提成金额:	外贸以35万为基础；内贸以15万为基础；若销售额<350000 then 0  销售额>=350000 THEN (销售额-350000)*0.13*提成计算系数/100；
		-- 5.7 G 开发客户业务员特殊： 该客户销售出库单审核日期在本期内的所有本位币金额*0.01
		
		 INSERT INTO #SalerAmount1
		 select a.FItemID ,a.FNumber,a.FName
		 , case when a.FItemID =255669 then b1.Amount_cnt *0.7		--吴琼   0.7*（吴琼+丁娇娇)销售开票额
				when a.FItemID=203160 then b2.Amount_cnt*0.3		--丁娇娇 0.3*（吴琼+丁娇娇)销售开票额
				when a.FItemID =256 then b1.Amount_cnt*1
				--when a.FItemID =256 then b1.Amount_cnt*0.5
				--when a.FItemID= 200152 then b2.Amount_cnt*0.5
				else b1.Amount_cnt end as Amount_cnt1				--销售开票额
		, case when a.FItemID =255669 then b1.xishu
				when a.FItemID=203160 then b2.xishu
				when a.FItemID =256 then b1.xishu
				--when a.FItemID= 200152 then b2.xishu
				else b1.xishu end as fxishu
		, case when a.FItemID =255669 then b1.zhiwucd
				when a.FItemID=203160 then b2.zhiwucd
				when a.FItemID =256 then b1.zhiwucd
				--when a.FItemID= 200152 then b2.zhiwucd
				else b1.zhiwucd end as  fzhiwucd
		, b3.Amount_cnt2											--新客户销售开票额-业务员部分
		, c.Amount_cnt3												--新客户销售开票额-开发人员部分
		, (case when a.fitemid = 255669 then						--吴琼 0.7*吴琼销售计划
					(case	when MONTH(@FDATE1)=1 then d.FJanAmount when MONTH(@FDATE1)=2 then d.FFebAmount 
							when MONTH(@FDATE1)=3 then d.FMarAmount when MONTH(@FDATE1)=4 then d.FAprAmount 
							when MONTH(@FDATE1)=5 then d.FMayAmount when MONTH(@FDATE1)=6 then d.FJunAmount 
							when MONTH(@FDATE1)=7 then d.FJulAmount when MONTH(@FDATE1)=8 then d.FAugAmount 
							when MONTH(@FDATE1)=9 then d.FSepAmount when MONTH(@FDATE1)=10 then d.FOctAmount 
							when MONTH(@FDATE1)=11 then d.FNovAmount when MONTH(@FDATE1)=12 then d.FDecAmount 
							else 0 end)*0.7
				when  a.FItemID=203160 then							--丁娇娇 0.3*吴琼销售计划
					(case	when MONTH(@FDATE1)=1 then e.FJanAmount when MONTH(@FDATE1)=2 then e.FFebAmount 
							when MONTH(@FDATE1)=3 then e.FMarAmount when MONTH(@FDATE1)=4 then e.FAprAmount 
							when MONTH(@FDATE1)=5 then e.FMayAmount when MONTH(@FDATE1)=6 then e.FJunAmount 
							when MONTH(@FDATE1)=7 then e.FJulAmount when MONTH(@FDATE1)=8 then e.FAugAmount 
							when MONTH(@FDATE1)=9 then e.FSepAmount when MONTH(@FDATE1)=10 then e.FOctAmount 
							when MONTH(@FDATE1)=11 then e.FNovAmount when MONTH(@FDATE1)=12 then e.FDecAmount 
							else 0 end)*0.3
				else												--其他人  1*销售计划
					(case	when MONTH(@FDATE1)=1 then d.FJanAmount when MONTH(@FDATE1)=2 then d.FFebAmount 
							when MONTH(@FDATE1)=3 then d.FMarAmount when MONTH(@FDATE1)=4 then d.FAprAmount 
							when MONTH(@FDATE1)=5 then d.FMayAmount when MONTH(@FDATE1)=6 then d.FJunAmount 
							when MONTH(@FDATE1)=7 then d.FJulAmount when MONTH(@FDATE1)=8 then d.FAugAmount 
							when MONTH(@FDATE1)=9 then d.FSepAmount when MONTH(@FDATE1)=10 then d.FOctAmount 
							when MONTH(@FDATE1)=11 then d.FNovAmount when MONTH(@FDATE1)=12 then d.FDecAmount 
							else 0 end)
			end)*10000 as plan_amount					--销售计划金额
		from
			(select a.FItemID ,a.FNumber ,a.FName  from t_Emp a
			   left outer JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =a.FDuty
			  where e.FInterID in(1045,41254) and a.FDeleted=0
			  and (a.FLeaveDate is  null or a.FLeaveDate>GETDATE())  -- 不包括离职人员
			) a
		left outer join 
			(	
			
			select FEmpID ,SUM(fstdamountincludetax) AS Amount_cnt,0 as xishu, MAX(FInterID ) as zhiwucd
				from(	
					SELECT (case when A.FEmpID IN(200152,256) then 256  when A.FEmpID IN(203160,255669) then 255669 else a.FEmpID end) as FEmpID , 
					( case a.ftrantype when 86  then b.fstdamount when 80  then b.fstdamountincludetax  end)  as fstdamountincludetax,	--含税金额
					e.FInterID 
					FROM ICsale A										--销售发票
					INNER JOIN ICsaleEntry B ON A.FInterID =B.FInterID  --销售发票
					INNER JOIN t_Emp C ON C.FItemID=A.FEmpID 
					INNER JOIN t_Department D ON C.FDepartmentID=D.FItemID
					INNER JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =C.FDuty
					INNER JOIN t_Organization F ON F.FItemID = A.FcustID 
					WHERE( A.FTranType=80 or a.ftrantype = 86 )and 1=(case when f.F_105 >0 and a.FDate between f.f_106 and f.f_107 then 0 else 1 end)
					  AND A.FDate  BETWEEN @FDATE1 AND @FDATE2  
					  /*modified by RENBO on 2017-01-18*/
					   ) a
				group by FEmpID		
			) b1 on a.FItemID =b1.FEmpID
		left outer join 
			(	select FEmpID ,SUM(fstdamountincludetax) AS Amount_cnt,0 as xishu, MAX(FInterID ) as zhiwucd
				from(
       					SELECT (case --when A.FEmpID IN(200152,256) then 200152  
								 when A.FEmpID IN(203160,255669) then 203160 else a.FEmpID end) as FEmpID , 
								 ( case a.ftrantype when 86  then b.fstdamount when 80  then b.fstdamountincludetax  end)  as fstdamountincludetax,--含税金额
								 e.FInterID 
					 FROM ICsale A													/*销售发票*/
					INNER JOIN ICsaleEntry B ON A.FInterID =B.FInterID				/*销售发票*/
					INNER JOIN t_Emp C ON C.FItemID=A.FEmpID 
					INNER JOIN t_Department D ON C.FDepartmentID=D.FItemID
					INNER JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =C.FDuty
					INNER JOIN t_Organization F ON F.FItemID = A.FcustID 
					WHERE( A.FTranType=80 or a.ftrantype = 86 )and 1=(case when f.F_105 >0 and a.FDate between f.f_106 and f.f_107 then 0 else 1 end)
					  AND A.FDate  BETWEEN @FDATE1 AND @FDATE2 and a.fempid IN(200152,256,203160,255669)  
					  /*modified by RENBO on 2017-01-18*/
					   ) a
				group by FEmpID		
			) b2 on a.FItemID =b2.FEmpID
		left outer join 
			(select FEmpID ,SUM(fstdamountincludetax) AS Amount_cnt2
				from(
		
					SELECT c.FItemID as FEmpID , 
					( case a.ftrantype when 86  then b.fstdamount when 80  then b.fstdamountincludetax  end)  as fstdamountincludetax,	--含税金额
					a.Finterid
					 FROM ICsale A										/*销售发票*/
					INNER JOIN ICsaleEntry B ON A.FInterID =B.FInterID	/*销售发票*/
					INNER JOIN t_Organization F ON F.FItemID = A.FcustID 
					INNER JOIN t_Emp C ON C.FItemID=f.Femployee			/*业务员*/
					WHERE( A.FTranType=80 or a.ftrantype = 86 )and 1=(case when f.F_105 >0 and a.FDate between f.f_106 and f.f_107 then 1 else 0 end)
					 AND A.FDate  BETWEEN @FDATE1 AND @FDATE2
					   /*modified by RENBO on 2017-01-18 */
				) a
				group by FEmpID		
			) b3 on a.FItemID =b3.FEmpID
		left outer join (
			SELECT c.FItemID AS FEmpID,SUM(( case a.ftrantype when 86  then b.fstdamount when 80  then b.fstdamountincludetax  end) ) AS Amount_cnt3
			 FROM ICsale A											/*销售发票*/
			INNER JOIN ICSaleEntry B ON A.FInterID =B.FInterID 		/*销售发票*/
			INNER JOIN t_Organization F ON F.FItemID = A.FcustID 
			INNER JOIN t_Emp C ON C.FItemID=f.F_105					/*开发人员*/
			WHERE( A.FTranType=80 or a.ftrantype = 86 )and 1=(case when f.F_105 >0 and a.FDate between f.f_106 and f.f_107 then 1 else 0 end)
			 AND A.FDate  BETWEEN @FDATE1 AND @FDATE2 
			 AND A.FDate  BETWEEN F.F_106 AND F.F_107
			group by C.FItemID 
			  /***************modified by RENBO on 2017-01-18************************/
		) c on c.FEmpID =a.FItemID
		left outer join (
			select a.FYear ,b.FBizRepID, c.FNumber ,c.FName 
				 , b.FJanAmount, b.FFebAmount ,b.FMarAmount ,b.FAprAmount ,b.FMayAmount ,b.FJunAmount
				 , b.FJulAmount, b.FAugAmount , b.FSepAmount , b.FOctAmount ,b.FNovAmount ,b.FDecAmount  
				 , b.FTotal 
			from SOP_BizRepSalesPlan a
			inner join SOP_BizRepSalesPlanEntry b on a.FID =b.FID 
			INNER JOIN t_Emp C ON C.FItemID=b.FBizRepID 
			where a.FYear =@FYear ) d on a.FItemID  =d.FBizRepID 
		left outer join (
			select a.FYear ,b.FBizRepID 
				 , b.FJanAmount, b.FFebAmount ,b.FMarAmount ,b.FAprAmount ,b.FMayAmount ,b.FJunAmount
				 , b.FJulAmount, b.FAugAmount , b.FSepAmount , b.FOctAmount ,b.FNovAmount ,b.FDecAmount  
				 , b.FTotal 
			from SOP_BizRepSalesPlan a
			inner join SOP_BizRepSalesPlanEntry b on a.FID =b.FID 
			where a.FYear =@FYear and b.FBizRepID = 255669 ) e on a.FItemID  = (case e.FBizRepID when 255669 then 203160 else e.fbizrepid end)  

		/*
		 * 1.3 创建表#SalerAmount2 的数据
		 */
		insert into #SalerAmount2
		select FItemID ,FNumber ,FName ,isnull(FAmount1,0) as FAmount1, 
		isnull(FAmount2,0) as FAmount2, 
		isnull(FPlanAmount,0) as FPlanAmount ,
		isnull(FAmount3,0) as famount3
			  , (case when isnull(FPlanAmount,0)=0 then 0 
					  else case when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.9 then 1 
						  when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.8 and (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount<0.9 then 0.8
						  when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.7 and (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount<0.8 then 0.6
						  when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount <0.7 then 0
						  else 0 end
					   end ) as FSaleRatio
			  , (case when FXiShu=0 then case when (isnull(FAmount1,0)+isnull(FAmount2,0))>= (case when FZhiWuCd= 1045 then 350000 
																								   else 150000 end) 
											  then 2000 
											  else (isnull(FAmount1,0)+isnull(FAmount2,0))/(case when FZhiWuCd= 1045 then 350000 
																								 else 150000 end)*2000 
											  end
					 else 0 end) as FSaleBaseAmount
			  , (case when (isnull(FAmount1,0)+isnull(FAmount2,0))<(case when FZhiWuCd = 1045	then 350000 else 150000 end) then 0
					  else ((isnull(FAmount1,0)+isnull(FAmount2,0))-(case when FZhiWuCd = 1045  then 350000 else 150000 end))*0.13
						 * (case when isnull(FPlanAmount,0)=0  then 0 
						         else	case	when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.9 then 1 
												when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.8 and (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount<0.9 then 0.8
												when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount >=0.7 and (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount<0.8 then 0.6
												when (isnull(FAmount1,0)+isnull(FAmount2,0))/FPlanAmount <0.7 then 0
												else 0 
										end
							end )/100
				end)+ isnull(FAmount3,0)*0.01 as FDrawPercentage
		 from #SalerAmount1
		 
		 
		/*
		 * 2 收款单			
		 *  详细说明
		 *  1.1 A 回款额本位币:	收款单制单日期(1-31日)	
		 *	 1.1.1 计划回款日期： 销售出库单日期+付款条件对应天数
		 *	 1.2 B 超期十天内回款金额(RMB):	收款单制单日期-(销售出库单日期+付款条件对应天数)<=10 的收款单金额
		 *	 1.3 C 超期20天内回款金额(RMB):	收款单制单日期-(销售出库单日期+付款条件对应天数)>10 and <=20 的收款单金额
		 *	 1.4 D 超期30天内回款金额(RMB):	收款单制单日期-(销售出库单日期+付款条件对应天数)>20 and <=30 的收款单金额
		 *	 1.5 E 超过30天外回款金额(RMB):	收款单制单日期-(销售出库单日期+付款条件对应天数)>30 的收款单金额
		 *	 1.6 F 实际回款金额(RMB)	=B*1+C*0.8+D*0.6+E*0
		 *	 1.7 G 基本工资(RMB):	外贸以35万为基础；内贸以15万为基础；当实际回款金额>=350000 then 2000元；<35万 then 实际回款金额/350000*2000元
		 *	 1.8 H 提成金额(RMB):	外贸以35万为基础；内贸以15万为基础；若实际回款金额<350000 then 0  >=350000 THEN (实际回款金额-350000)*0.13/100；
		 *	 2. 回款额分为正常回款额和在开发期内的开发客户的回款额 开发客户的回款额一份为开发人员，一份为业务员(一份数据按两个数据计算)
		 *	    开发人员只有提成，且提成金额为回款的总金额*0.01；业务员的则按照正常的计算方式计算
		*/	
		/*
		 * 2.1 业务员按照核算日期的当月总回款额表 创建
		 */
		 Create Table #RceiveAmount1(      
			 FItemID					int,									--业务员内码
			 FProceedsAmount1			decimal(20,2) default(0),				--实际收款额 排除开发客户
			 FProceedsAmount2			decimal(20,2) default(0),				--实际收款额 开发客户的  对应业务员
			 FProceedsAmount3			decimal(20,2) default(0))				--实际收款额 开发客户的  对应开发人员
		
		/*
		 * 2.2  #RceiveAmount1 数据生成
		 */
		insert into #RceiveAmount1
		select Femployee,SUM(FProceedsAmount1) as FProceedsAmount1, SUM(FProceedsAmount2) as FProceedsAmount2
			 , SUM(FProceedsAmount3) as FProceedsAmount3
		from(
		select a.Femployee,SUM(FProceedsAmount) as FProceedsAmount1,0 as FProceedsAmount2,0 as FProceedsAmount3
		from(
			select (case when b.Femployee IN(256,200152) then 256 else b.Femployee end) as Femployee
				 , a.FCheckAmount as FProceedsAmount,b.FNumber 
			 from t_RP_NewCheckInfo a 
			inner join t_Organization b on a.FCustomer=b.FItemID
			inner join t_Emp c on c.FItemID=b.Femployee 
			INNER JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =C.FDuty
			where a.FType =5 and a.FCheckDate between @FDATE1 and @FDATE2
			and 1=(case when b.F_105 >0 and a.FCheckDate between b.F_106 and b.f_107 then 0 else 1 end)
			) a
		group by a.Femployee 
		union all
		select a.Femployee,0 as FProceedsAmount1,SUM(FProceedsAmount) as FProceedsAmount2,0 as FProceedsAmount3
		from(
			select (case when b.Femployee IN(256,200152) then 256 else b.Femployee end) as Femployee
				 , a.FCheckAmount as FProceedsAmount
			 from t_RP_NewCheckInfo a 
			inner join t_Organization b on a.FCustomer=b.FItemID
			inner join t_Emp c on c.FItemID=b.Femployee 
			INNER JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =C.FDuty
			where a.FType =5 and a.FCheckDate between @FDATE1 and @FDATE2
			and 1=(case when b.F_105 >0 and a.FCheckDate between b.F_106 and b.f_107 then 1 else 0 end)
			) a
		group by a.Femployee 
		union all
		select a.Femployee,0 as FProceedsAmount1,0 as FProceedsAmount2,SUM(FProceedsAmount) as FProceedsAmount3
		from(
			select  b.F_105 as Femployee, a.FCheckAmount as FProceedsAmount
			 from t_RP_NewCheckInfo a 
			inner join t_Organization b on a.FCustomer=b.FItemID
			inner join t_Emp c on c.FItemID=b.F_105 
			where a.FType =5 and a.FCheckDate between @FDATE1 and @FDATE2
			and 1=(case when b.F_105 >0 and a.FCheckDate between b.F_106 and b.f_107 then 1 else 0 end)
			) a
		group by a.Femployee 
		) a
		group by Femployee 		 


		/*
		 * 2.3 计算汇款金额的超期天数
		 */
		DECLARE @FID					INT,
				@FInterID				INT,
				@FBillID				INT,
				@FPayCondition			INT,
				@FCustomer				INT,
				@FCheckDate				DATETIME,
				@FDATE					DATETIME,
				@FPlanFDate				DATETIME,
				@FCheckAmount			decimal(20,2),			
				@FCAmount_1				decimal(20,2),
				@FAmount_1				decimal(20,2),
				@FInterID_1				INT,
				@FPayDate_1				DATETIME,
				@FPayAmount10_1			decimal(20,2),
				@FPayAmount20_1			decimal(20,2),
				@FPayAmount30_1			decimal(20,2),
				@FPayAmount40_1			decimal(20,2) 
				
		 SET @famount_1=0
		 
		  /*2.3.1 临时表-收款list*/
		 Create Table #PayAmount1(      
		 FID						int,									--核销号
		 FInterID					int,									--核销日志内码
		 FBillID					int,									--收款单内码
		 FPayDate					DATETIME,								--收款单日期
		 FCheckAmount1				decimal(20,2) default(0),				--实际核销金额
		 FRemainAmount2				decimal(20,2) default(0))				--对应销售发票剩余额
	    
		 --  计算结果表
		 Create Table #PayAmount2(     
		 FID						int,									--核销号 
		 FCustomerID				int,									--客户内码	
		 FInterID					INT,									--核销日志内码
		 FBillID					INT,									--销售发票内码
		 FPlanFDate					datetime,								--计划付款日期
		 FPayDate_1					datetime,								--实际收款日期
		 FPayAmount10				decimal(20,2) default(0),				--10天内回款金额
		 FPayAmount20				decimal(20,2) default(0),				--11-20天内回款金额
		 FPayAmount30				decimal(20,2) default(0),				--21-30天内回款金额
		 FPayAmount40				decimal(20,2) default(0))				--31天以后回款金额
	     
		 -- 2.3.2 #PayAmount1  核算日志中销售发票 数据 
		Insert into  #PayAmount1
		SELECT a.FID, A.FInterID, A.FBillID, b.FDate, a.FCheckAmount, a.FCheckAmount  
		FROM t_RP_NewCheckInfo A  INNER JOIN t_RP_Contact  b on a.FType =5 and b.FBillID =a.FBillID 
		WHERE a.FCheckDate between @FDATE1 and @FDATE2 and A.FType =5 
		order by a.FID, a.FInterID 
		 
		-- 2.3.3  计算超出天数及金额 	
		DECLARE trp_cur1 CURSOR
		FOR
			select DISTINCT a.FID from t_RP_NewCheckInfo a 
			where a.FCheckDate between @FDATE1 and @FDATE2 and A.FType =5 
		OPEN trp_cur1
		FETCH NEXT FROM trp_cur1 into @FID 
		WHILE @@FETCH_STATUS=0	    
		BEGIN		
			DECLARE trp_cur2 CURSOR
			FOR
				SELECT A.FInterID ,A.FBillID, MAX(A.FCustomer) AS FCustomer, MIN(a.FCheckAmount ) as FCheckAmount
					 , MAX(F.FPayCondition) AS FPayCondition ,MIN(E.FDate) AS FDATE 
				FROM t_RP_NewCheckInfo a 
				INNER JOIN T_Organization F ON F.FItemID =A.FCustomer
				INNER JOIN ICSale B ON A.FBillID =B.FInterID 
				INNER JOIN ICSaleEntry C ON C.FInterID =B.FInterID 
				INNER JOIN ICStockBillEntry D ON D.FInterID =C.FSourceInterId AND D.FEntryID =C.FSourceEntryID
				INNER JOIN ICStockBill E ON E.FInterID =D.FInterID AND E.FTranType=21
				WHERE A.FType =3 AND FID =@FID 
				GROUP BY A.FInterID ,A.FBillID
			OPEN trp_cur2
			FETCH NEXT FROM trp_cur2 into @FInterID,@FBillID,@FCustomer,@FCheckAmount, @FPayCondition,@FDATE
			WHILE @@FETCH_STATUS=0	    
			BEGIN
				SET @FCAmount_1=@FCheckAmount 
				IF @FPayCondition=0 SET @FPlanFDate=@FDATE 		--if 客户的付款条件 null, then 计划回款日期 =销售出库单制单日期
				ELSE   											--if 客户的付款条件有数据, then 根据以下公式计算
				BEGIN
					SELECT 
					@FPlanFDate=(case	when b.FOptMode =0 and FFstStDate =1	--信用天数结算  且 起算日：单据月末日期
										then DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE),'19911231')+FDay	
										when b.FOptMode =0 and FFstStDate =0	--信用天数结算  且 起算日：单据日期
										then DATEADD(day,FDay,@FDATE) 
										when b.FOptMode =1 and b.FSecStDate =1  --月结  且起算日：单据月末日期
										then case	when	datepart(dd,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',
															convert(datetime,convert(char(8),datepart(yy,DATEADD(MONTH,3,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE),'19911231'))) *10000+
															DATEPART(mm,DATEADD(MONTH,3,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE),'19911231'))) *100+1),112)
															),'19911231')) <=FDate
													then	DATEADD(MONTH,DATEDIFF(MONTH,'19911231',DATEADD(MONTH,FDayMon,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE ),'19911231'))),'19911231')
													else	CONVERT(DATETIME,CONVERT(CHAR(8), DATEPART(yy,DATEADD(MONTH,FDayMon,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE ),'19911231')))*10000
																	 + DATEPART(mm,DATEADD(MONTH,FDayMon,DATEADD(MONTH,DATEDIFF(MONTH,'19911231',@FDATE),'19911231')))*100
																	 + FDate
															  ),112)
											end 
										/*when b.FOptMode =1 and b.FSecStDate =0		then b.FDayMon --FDate	--月结  且起算日：单据日期	
										*/
			/* -----------------------------   REWRITE DATE:2017/02/07--WRITER: RENBO ------the following------------------------------
			*/
			
				/* when b.FOptMode =1 and b.FSecStDate =1  --月结  且起算日：单据月末日期
				then  case b.flstday  when 1 then dateadd(day,b.fdate-day(dateadd(DAY,b.FDayMon,dateadd(day,-day(@fdate),dateadd(month,1,@fdate)))),dateadd(DAY,b.FDayMon,dateadd(day,-day(@fdate),dateadd(month,1,@fdate))))
										else  	dateadd(day,b.fdate-day(dateadd(month,b.FDayMon,dateadd(day,-day(@fdate),dateadd(month,1,@fdate)))),dateadd(month,b.FDayMon,dateadd(day,-day(@fdate),dateadd(month,1,@fdate)))) end 
				*/
				when b.FOptMode =1 and b.FSecStDate =0	 --月结  且起算日：单据日期
				then case b.flstday  when 1 then dateadd(day,b.fdate-day(@fdate),dateadd(DAY,b.FDayMon,@fdate))
										else  	dateadd(day,b.fdate-day(@fdate),dateadd(month,b.FDayMon,@fdate)) end 
				
			/* -----------------------------   REWRITE DATE:2017/02/07--WRITER: RENBO ------THE ABOVE-------------------- 
			*/
					else 0 end)
					FROM t_PayColCondition  a
					 INNER JOIN  t_PayColConditionEntry  b ON a.FID=b.FID
					 WHERE a.FParentID=0 AND a.FDetail<>0  AND a.FClassTypeID=1007737 AND a.FDiscontinued=0  
					   AND A.FID =@FPayCondition 
				END
				 
				WHILE @FCAmount_1<>0 
				BEGIN
					IF (SELECT COUNT(*) FROM #PayAmount1 WHERE FID =@FID and FRemainAmount2 <>0)=0 BREAK    --跳出WHILE循环
					    
					SELECT TOP 1 @FAmount_1=FRemainAmount2, @FInterID_1=FInterID, @FPayDate_1=FPayDate 
					  FROM #PayAmount1 
					  WHERE FID =@FID and FRemainAmount2 <>0
					
					IF @FCAmount_1>=@FAmount_1 
					BEGIN 
						UPDATE #PayAmount1
						SET FRemainAmount2=0
						WHERE FInterID =@FInterID_1
						
						IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1)<=10  
						BEGIN 
							SET @FPayAmount10_1=@FAmount_1
							SET @FPayAmount20_1=0
							SET @FPayAmount30_1=0
							SET @FPayAmount40_1=0
						END 
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) BETWEEN 11 AND 20 
						BEGIN
							SET @FPayAmount20_1=@FAmount_1
							SET @FPayAmount10_1=0
							SET @FPayAmount30_1=0
							SET @FPayAmount40_1=0
						END
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) BETWEEN 21 AND 30 
						BEGIN
							SET @FPayAmount30_1=@FAmount_1	
							SET @FPayAmount10_1=0
							SET @FPayAmount20_1=0
							SET @FPayAmount40_1=0
						END
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) >30 
						BEGIN
							SET @FPayAmount40_1=@FAmount_1
							SET @FPayAmount10_1=0
							SET @FPayAmount20_1=0
							SET @FPayAmount30_1=0
						END
						
						INSERT INTO #PayAmount2
						VALUES(@FID ,@FCustomer,@FInterID,@FBillID,@FPlanFDate,@FPayDate_1,@FPayAmount10_1,@FPayAmount20_1,@FPayAmount30_1,@FPayAmount40_1)
						SET @FCAmount_1=@FCAmount_1-@FAmount_1
					END
					ELSE IF @FCAmount_1<@FAmount_1 
					BEGIN
						UPDATE #PayAmount1
						SET FRemainAmount2=@FAmount_1 -@FCAmount_1
						WHERE FInterID =@FInterID_1
						
						IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1)<=10 
						BEGIN 
						 SET @FPayAmount10_1=@FCAmount_1
						 SET @FPayAmount20_1=0
						 SET @FPayAmount30_1=0
						 SET @FPayAmount40_1=0
						END 					 
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) BETWEEN 11 AND 20 
						BEGIN
							SET @FPayAmount20_1=@FCAmount_1
							SET @FPayAmount10_1=0
							SET @FPayAmount30_1=0
							SET @FPayAmount40_1=0
						END
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) BETWEEN 21 AND 30 
						BEGIN
							SET @FPayAmount30_1=@FCAmount_1
							SET @FPayAmount10_1=0
							SET @FPayAmount20_1=0
							SET @FPayAmount40_1=0
						END
						ELSE IF DATEDIFF(dd,@FPlanFDate,@FPayDate_1) >30 
						BEGIN
							SET @FPayAmount40_1=@FCAmount_1
							SET @FPayAmount10_1=0
							SET @FPayAmount20_1=0
							SET @FPayAmount30_1=0
						END
						
						INSERT INTO #PayAmount2
						VALUES(@FID ,@FCustomer,@FInterID,@FBillID,@FPlanFDate,@FPayDate_1,@FPayAmount10_1,@FPayAmount20_1,@FPayAmount30_1,@FPayAmount40_1)
						SET @FCAmount_1=0				
					END  -- IF END
				
				END   -- WHILE  END
	 
			FETCH NEXT FROM trp_cur2 into @FInterID,@FBillID,@FCustomer,@FCheckAmount, @FPayCondition,@FDATE
			END
			CLOSE trp_cur2
			DEALLOCATE trp_cur2
		
		
		FETCH NEXT FROM trp_cur1 into @FID 
		END
		CLOSE trp_cur1
		DEALLOCATE trp_cur1
		
		---2.3.4   回款临时表
		Create Table #RceiveAmount2(      
		 FItemID					int,									--业务员内码
		 FProceedsAmount1			decimal(20,2) default(0),				--实际收款额 排除开发客户
		 FProceedsAmount2			decimal(20,2) default(0),				--实际收款额 开发客户的  对应业务员
		 FProceedsAmount3			decimal(20,2) default(0),				--实际收款额 开发客户的  对应开发人员
		 FPayAmount10				decimal(20,2) default(0),				--10天内回款金额
		 FPayAmount20				decimal(20,2) default(0),				--11-20天内回款金额
		 FPayAmount30				decimal(20,2) default(0),				--21-30天内回款金额
		 FPayAmount40				decimal(20,2) default(0))				--31天以后回款金额
		--- 回款最终结果表
		 Create Table #RceiveAmount3(      
			 FItemID					int,									--业务员内码
			 FNumber					varchar(255),							--业务员代码
			 FName						varchar(255),							--业务员名称
			 FZhiWu						int,									--业务员对应的职务（外贸 内贸)
			 FProceedsAmount1			decimal(20,2) default(0),				--实际收款额 排除开发客户
			 FProceedsAmount2			decimal(20,2) default(0),				--实际收款额 开发客户的  对应业务员
			 FProceedsAmount3			decimal(20,2) default(0),				--实际收款额 开发客户的  对应开发人员
			 FPayAmount10				decimal(20,2) default(0),				--10天内回款金额
			 FPayAmount20				decimal(20,2) default(0),				--11-20天内回款金额
			 FPayAmount30				decimal(20,2) default(0),				--21-30天内回款金额
			 FPayAmount40				decimal(20,2) default(0),				--31天以后回款金额
			 FActAmount					decimal(20,2) default(0),				--实际回款金额
			 FPayBaseAmount				decimal(20,2) default(0),				--回款基本工资
			 FPayPercentage		        decimal(20,2) default(0))				--回款提成金额
		
		  ---2.3.5  回款临时表数据生成
			INSERT INTO #RceiveAmount2
			SELECT A.FItemID ,A.FProceedsAmount1 ,A.FProceedsAmount2, A.FProceedsAmount3
				 , B.FPayAmount10,B.FPayAmount20,B.FPayAmount30,B.FPayAmount40 
			FROM #RceiveAmount1 A
			LEFT OUTER JOIN (
			select (CASE WHEN C.FItemID IN(256,200152) THEN 256 ELSE C.FItemID END ) AS FItemID 
				 , SUM(a.FPayAmount10) as FPayAmount10, SUM(a.FPayAmount20) as FPayAmount20
				 , SUM(a.FPayAmount30) as FPayAmount30, SUM(a.FPayAmount40) as FPayAmount40 
			from #PayAmount2 a
			inner join t_Organization b on a.FCustomerID =b.FItemID 
			left outer join t_Emp c on c.FItemID =b.Femployee
			group by (CASE WHEN C.FItemID IN(256,200152) THEN 256 ELSE C.FItemID END )
			) B ON A.FItemID =B.FItemID 
			ORDER BY A.FItemID 
	    
		--2.3.6  回款最终结果表  数据生成
		INSERT INTO #RceiveAmount3 
		SELECT A.FItemID ,A.FNumber ,A.FName, a.FDuty
			 , (CASE WHEN A.FItemID =256    THEN B.FProceedsAmount1*1 
					-- WHEN A.FItemID =256    THEN B.FProceedsAmount1*0.5 
					-- WHEN A.FItemID =200152 THEN C.FProceedsAmount1*0.5
					 WHEN A.FItemID =255669 THEN B.FProceedsAmount1*0.7
					 WHEN A.FItemID =203160 THEN C.FProceedsAmount1*0.3
					 ELSE B.FProceedsAmount1 END) AS FProceedsAmount1
			 , (CASE WHEN A.FItemID =256    THEN B.FProceedsAmount2*1 
					-- WHEN A.FItemID =256    THEN B.FProceedsAmount2*0.5  
					-- WHEN A.FItemID =200152 THEN C.FProceedsAmount2*0.5
					 WHEN A.FItemID =255669 THEN B.FProceedsAmount2*0.7
					 WHEN A.FItemID =203160 THEN C.FProceedsAmount2*0.3
					 ELSE B.FProceedsAmount2 END) AS FProceedsAmount2
			 , (CASE WHEN A.FItemID =256    THEN B.FProceedsAmount3*1
					-- WHEN A.FItemID =256    THEN B.FProceedsAmount3*0.5  
					-- WHEN A.FItemID =200152 THEN C.FProceedsAmount3*0.5
					 WHEN A.FItemID =255669 THEN B.FProceedsAmount3*0.7
					 WHEN A.FItemID =203160 THEN C.FProceedsAmount3*0.3
					 ELSE B.FProceedsAmount3 END) AS FProceedsAmount3
			 , (CASE WHEN A.FItemID =256    THEN B.FPayAmount10*1
					-- WHEN A.FItemID =256    THEN B.FPayAmount10*0.5
					-- WHEN A.FItemID =200152 THEN C.FPayAmount10*0.5  
					 WHEN A.FItemID =255669 THEN B.FPayAmount10*0.7
					 WHEN A.FItemID =203160 THEN C.FPayAmount10*0.3
					 ELSE B.FPayAmount10 END) AS FPayAmount10
			 , (CASE WHEN A.FItemID =256    THEN B.FPayAmount20*1
					-- WHEN A.FItemID =256    THEN B.FPayAmount20*0.5  
					-- WHEN A.FItemID =200152 THEN C.FPayAmount20*0.5  
					 WHEN A.FItemID =255669 THEN B.FPayAmount20*0.7
					 WHEN A.FItemID =203160 THEN C.FPayAmount20*0.3
					 ELSE B.FPayAmount20 END) AS FPayAmount20
			 , (CASE WHEN A.FItemID =256    THEN B.FPayAmount30*1
					-- WHEN A.FItemID =256    THEN B.FPayAmount30*0.5 
					-- WHEN A.FItemID =200152 THEN C.FPayAmount30*0.5   
					 WHEN A.FItemID =255669 THEN B.FPayAmount30*0.7
					 WHEN A.FItemID =203160 THEN C.FPayAmount30*0.3
					 ELSE B.FPayAmount30 END) AS FPayAmount30
			 , (CASE WHEN A.FItemID =256    THEN B.FPayAmount40*1 
					-- WHEN A.FItemID =256    THEN B.FPayAmount40*0.5
					-- WHEN A.FItemID =200152 THEN C.FPayAmount40*0.5   
					 WHEN A.FItemID =255669 THEN B.FPayAmount40*0.7
					 WHEN A.FItemID =203160 THEN C.FPayAmount40*0.3
					 ELSE B.FPayAmount40 END) AS FPayAmount40
			 , 0 , 0,0
		FROM 
		(select a.FItemID ,a.FNumber ,a.FName, a.FDuty  from t_Emp a
			   left outer JOIN t_SubMessage E ON E.FParentID =29 AND E.FInterID =a.FDuty
			  where e.FInterID in(1045,41254) and a.FDeleted=0
		) AS A	
		LEFT OUTER JOIN #RceiveAmount2 B ON A.FItemID =B.FItemID 
		LEFT OUTER JOIN (SELECT (CASE --WHEN FItemID =256 THEN 200152 
									 WHEN FItemID = 255669 THEN 203160 
									 ELSE FItemID END) AS FItemID
							  , FProceedsAmount1 ,FProceedsAmount2, FProceedsAmount3
							  , FPayAmount10 , FPayAmount20, FPayAmount30, FPayAmount40
						   FROM #RceiveAmount2 
						   WHERE FItemID IN(256,255669)
						   ) C ON C.FItemID =A.FItemID 
		ORDER BY A.FItemID 

		-- 2.3.7 更新实际回款金额(RMB)
		update #RceiveAmount3
		set FActAmount = FPayAmount10*1+FPayAmount20*0.8+FPayAmount30*0.6+FPayAmount40*0

		--2.3.8 更新基本回款工资金额(RMB),回款提成金额 (RMB)
		update #RceiveAmount3
		set FPayBaseAmount = case when FZhiWu =1045 and FActAmount >=350000 then 2000								  
								  when FZhiWu =1045 and FActAmount < 350000 then FActAmount/350000 * 2000								 
								  when FZhiWu =41254 and FActAmount >=150000 then 2000
								  when FZhiWu =41254 and FActAmount < 150000 then FActAmount/150000 * 2000
								  else 0 end
		   ,FPayPercentage = case when FZhiWu =1045 and FActAmount >=350000 then (FActAmount-350000) *0.13/100								  
								  when FZhiWu =41254 and FActAmount >=150000 then (FActAmount-150000) *0.13/100
								  else 0 end

		--2.3.9 更新新开发客户的开发人员的提成						  
		update #RceiveAmount3
		set FPayPercentage=FPayPercentage +FProceedsAmount3*0.01
		where FProceedsAmount3>0

		--2.3.10 存在未审核状态的数据先删除，后新增
		IF (SELECT COUNT(*) FROM SalerPay 
			 WHERE FYEAR=YEAR(@FDATE1) and FMONTH=SUBSTRING(@FDateFrom,5,2)
			  AND  FStatus=0     )>1
		BEGIN
			DELETE FROM SalerPay 
			 WHERE FYEAR=YEAR(@FDATE1) and FMONTH=SUBSTRING(@FDateFrom,5,2)
			  AND  FStatus=0 
		END
		-- 2.3.11 数据生成 添加到 SalerPay 正式表中
		INSERT INTO SalerPay
		SELECT YEAR(@FDATE1),SUBSTRING(@FDateFrom,5,2),0,a.FItemID ,a.FNumber ,a.FName 
			 , isnull(a.FAmount1,0) as FAmount1,isnull(a.FAmount2,0) as FAmount2, isnull(a.FPlanAmount,0) as FPlanAmount
			 , isnull(a.FAmount3,0) as FAmount3, isnull(a.FSaleBaseAmount,0) as FSaleBaseAmount, isnull(a.FDrawPercentage,0) as FDrawPercentage
			 , B.FZhiWu, isnull(b.FProceedsAmount1,0) as FProceedsAmount1, isnull(b.FProceedsAmount2,0) as FProceedsAmount2
			 , isnull(b.FProceedsAmount3,0) as FProceedsAmount3, isnull(b.FPayAmount10,0) as FPayAmount10, isnull(b.FPayAmount20,0) as FPayAmount20
			 , isnull(b.FPayAmount30,0) as FPayAmount30, isnull(b.FPayAmount40,0) as FPayAmount40, isnull(b.FActAmount,0) as FActAmount
			 , isnull(b.FPayBaseAmount,0) as FPayBaseAmount, isnull(b.FPayPercentage,0) as FPayPercentage
			 , isnull(a.FSaleBaseAmount,0)+isnull(b.FPayBaseAmount,0)  as fTotBaseAmount
			 , isnull(a.FDrawPercentage,0) +isnull(b.FPayPercentage,0)  as FTotPercentage
			 , isnull(a.FSaleBaseAmount,0)+isnull(b.FPayBaseAmount,0)+isnull(a.FDrawPercentage,0) +isnull(b.FPayPercentage,0) as FTotAmount
		 FROM #SalerAmount2 A
		JOIN #RceiveAmount3 B ON A.FItemID =B.FItemID 
		order by a.FItemID 
		
		-- 2.3.12 删除不需要的临时表
		DROP TABLE #SalerAmount1
		DROP TABLE #SalerAmount2
		DROP TABLE #RceiveAmount1
		DROP TABLE #PayAmount1
		drop table #PayAmount2
		DROP TABLE #RceiveAmount2
		DROP TABLE #RceiveAmount3
	END
	
	--  查询 
	-- 3 业务员本月工资结果显示
	--SELECT * FROM SalerPay where fyear=YEAR(@FDATE1) and fmonth=SUBSTRING(@FDateFrom,5,2)
	
	-- 审核
	IF @FQUFEN ='S'
	BEGIN
		UPDATE SalerPay 
		SET FStatus =1
		WHERE fyear=@FYear and fmonth=@FMonth 
	END	
END