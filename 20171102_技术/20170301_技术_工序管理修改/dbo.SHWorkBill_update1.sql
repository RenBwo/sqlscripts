-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [dbo].[SHWorkBill_update1]
	  @fqufen			varchar(1),
	  @fconqf			VARCHAR(1),
	  @fgzl				varchar(255),
	  @fnumber			varchar(255),
	  @M_MESSAGE		VARCHAR(1000) output		--错误信息
AS
BEGIN

	SET NOCOUNT ON;
/*	if  @fnumber = '' 
	begin 
	select @fnumber = '%'
	end
	*/
	--查询 工序计划单中工资系数、工件数量、单位计件工资
	-- @fqufen='A'  工序计划单    @fconqf='A'： 与工艺路线不一致的数据
	IF @fqufen='A' AND @fconqf='A'
	BEGIN 
	SELECT A.FEntrySelfz0374 as 工作令号
	    ,  G.FNumber AS  产品长代码, G.FName as 产品名称
		,  e.FEntrySelfZ0236 as 工艺路线工资系数
		,  e.FEntrySelfZ0237 as 工艺路线工件数量
		,  e.FPieceRate		 as 工艺路线单位计件工资
		,  a.FEntrySelfz0375 as 工序计划单工资系数
		,  a.FEntrySelfz0376 as 工序计划单工件数量
		,  a.FPieceRate   as  工序计划单单位计件工资
		,  a.FWorkBillNO as 工序计划单号 
		,  F.FName as 工序计划单工序名称, A.FOperSN as 工序计划单中工序号
		,  e2.FBillNo as 工艺路线编号, e.FOperSN as 工艺路线工序号
	
	FROM SHWorkBillEntry A
	INNER JOIN SHWorkBill B ON A.FinterID =B.FInterID 
	INNER JOIN ICMO C ON C.FInterID =B.FICMOInterID 
	INNER JOIN ICBOM D ON D.FInterID =C.FBomInterID and D.FUseStatus=1072 and D.FStatus =1 
	INNER JOIN T_RoutingOper e on e.FInterID =d.FRoutingID AND E.FOperID =A.FOperID
	INNER JOIN T_routing e2 on e.FInterID =e2.FInterID 
	left outer JOIN t_SubMessage F ON F.FInterID =A.FOperID and f.FParentID =61
	INNER JOIN t_ICItem G ON G.FItemID = B.FitemID 
	WHERE a.FEntrySelfz0374 like @fgzl and g.fnumber like @fnumber
	  AND (isnull(a.FEntrySelfz0375,0)<>isnull(e.FEntrySelfZ0236,0) or isnull(a.FEntrySelfz0376,0)<>isnull(e.FEntrySelfZ0237,0)
	       or ISNULL(e.FPieceRate,0)<>ISNULL(a.FPieceRate,0) )
	order by a.FinterID , A.FOperSN
	END 	
	
	-- @fqufen='A'  工序计划单    @fconqf='B'： 所有的都显示
	IF @fqufen='A' AND @fconqf='B'
	BEGIN 
	SELECT A.FEntrySelfz0374 as 工作令号
	    ,  G.FNumber AS  产品长代码, G.FName as 产品名称
		,  e.FEntrySelfZ0236 as 工艺路线工资系数
		,  e.FEntrySelfZ0237 as 工艺路线工件数量
		,  e.FPieceRate		 as 工艺路线单位计件工资
		,  a.FEntrySelfz0375 as 工序计划单工资系数
		,  a.FEntrySelfz0376 as 工序计划单工件数量
		,  a.FPieceRate   as  工序计划单单位计件工资
		,  a.FWorkBillNO as 工序计划单号 
		,  F.FName as 工序计划单工序名称, A.FOperSN as 工序计划单中工序号
		,  e2.FBillNo as 工艺路线编号, e.FOperSN as 工艺路线工序号	
	FROM SHWorkBillEntry A
	INNER JOIN SHWorkBill B ON A.FinterID =B.FInterID 
	INNER JOIN ICMO C ON C.FInterID =B.FICMOInterID 
	INNER JOIN ICBOM D ON D.FInterID =C.FBomInterID and D.FUseStatus=1072 and D.FStatus =1 
	INNER JOIN T_RoutingOper e on e.FInterID =d.FRoutingID AND E.FOperID =A.FOperID
	INNER JOIN T_routing e2 on e.FInterID =e2.FInterID 
	left outer JOIN t_SubMessage F ON F.FInterID =A.FOperID and f.FParentID =61
	INNER JOIN t_ICItem G ON G.FItemID = B.FitemID 
	WHERE a.FEntrySelfz0374 like @fgzl  and g.fnumber like @fnumber 
	order by a.FinterID , A.FOperSN
	END 	
	
	--更新工序计划单工件数量、工资系数 
	-- @fqufen='A'  工序计划单    @fconqf='C'：更新(与工艺路线中内容一致)
	
	IF @fqufen='A' AND @fconqf='C'
	BEGIN 
		
		update SHWorkBillEntry 
		   set FEntrySelfz0375=a.FEntrySelfZ0236,FEntrySelfz0376=a.FEntrySelfZ0237
		  from (
				SELECT a.FWBInterID ,e.FEntrySelfZ0236,e.FEntrySelfZ0237,  A.FOperSN
				  FROM SHWorkBillEntry A
				 INNER JOIN SHWorkBill B ON A.FinterID =B.FInterID 
				 INNER JOIN ICMO C ON C.FInterID =B.FICMOInterID 
				 INNER JOIN ICBOM D ON D.FInterID =C.FBomInterID 
				 INNER JOIN T_RoutingOper e on e.FInterID =d.FRoutingID AND E.FOperID =A.FOperID
				 left outer JOIN t_SubMessage F ON F.FInterID =A.FOperID and f.FParentID =61
				 INNER JOIN t_ICItem G ON G.FItemID = B.FitemID 
				WHERE a.FEntrySelfz0374 like @fgzl  and g.fnumber like @fnumber 
				  and (isnull(a.FEntrySelfz0375,0)<>isnull(e.FEntrySelfZ0236,0) or isnull(a.FEntrySelfz0376,0)<>isnull(e.FEntrySelfZ0237,0))
				) a
		 inner join SHWorkBillEntry b on a.FWBInterID =b.FWBInterID

	END 
	
	---查询工序汇报中的工资系数和工件数量 
	-- @fqufen='B'  工序汇报单    @fconqf='A'： 与工序汇报不一致的数据
	IF @fqufen='B' AND @fconqf='A'
	BEGIN
		select b.FBillNo 工序汇报编号 ,a.FEntrySelfY5235 as 工作令号
		 ,  G.FNumber AS  产品长代码, G.FName as 产品名称
		     , c.FEntrySelfz0375 as 工序计划单工资系数 
			 , c.FEntrySelfz0376 AS 工序计划单工件数量
		     , a.FEntrySelfY5236 as 工序汇报工资系数
			 , a.FEntrySelfY5238 AS 工序汇报工件数量			 
			 , f.FName as 工序名称
		 from SHProcRpt a
		inner join SHProcRptMain b on a.FinterID =b.FInterID 
		inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  
		inner JOIN t_SubMessage F ON F.FInterID =c.FOperID and f.FParentID =61
		inner join shworkbill d on d.finterid = c.finterid
		INNER JOIN t_ICItem G ON G.FItemID = d.FitemID 
		where a.FEntrySelfY5235 like @fgzl and g.fnumber like @fnumber
		  and (isnull(a.FEntrySelfY5236,0)<>isnull(c.FEntrySelfz0375,0) 
		       or isnull(a.FEntrySelfY5238,0)<>isnull(c.FEntrySelfz0376,0))
		order by a.FEntryIndex
	
	END
	
	-- @fqufen='B'  工序汇报单    @fconqf='B'： 所有的都显示
	IF @fqufen='B' AND @fconqf='B'
	BEGIN
		select b.FBillNo 工序汇报编号 ,a.FEntrySelfY5235 as 工作令号
		     ,  G.FNumber AS  产品长代码, G.FName as 产品名称
			 , c.FEntrySelfz0375 as 工序计划单工资系数 
			 , c.FEntrySelfz0376 AS 工序计划单工件数量
		     , a.FEntrySelfY5236 as 工序汇报工资系数
			 , a.FEntrySelfY5238 AS 工序汇报工件数量			 
			 , f.FName as 工序名称
		 from SHProcRpt a
		inner join SHProcRptMain b on a.FinterID =b.FInterID 
		inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  
		inner JOIN t_SubMessage F ON F.FInterID =c.FOperID and f.FParentID =61
		inner join shworkbill d on d.finterid = c.finterid
		INNER JOIN t_ICItem G ON G.FItemID = d.FitemID 

		where a.FEntrySelfY5235 like @fgzl	and g.fnumber like @fnumber  
		order by a.FEntryIndex
	
	END

	--更新工序汇报中的工资系数和工件数量
	-- @fqufen='B'  工序汇报单    @fconqf='C'：更新(与工序计划中内容一致)
	IF @fqufen='B' AND @fconqf='C'
	BEGIN
		update SHProcRpt 
		set FEntrySelfY5236=a.FEntrySelfz0375,FEntrySelfY5238=a.FEntrySelfz0376
		from (select a.FEntryIndex,c.FEntrySelfz0375,c.FEntrySelfz0376
			    from SHProcRpt a
			   inner join SHProcRptMain b on a.FinterID =b.FInterID 
			   inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  			   
		       inner join shworkbill d on d.finterid = c.finterid
		       INNER JOIN t_ICItem G ON G.FItemID = d.FitemID 
			   where a.FEntrySelfY5235 like @fgzl  and g.fnumber like @fnumber
			    and (isnull(a.FEntrySelfY5236,0)<>isnull(c.FEntrySelfz0375,0) 
			         or isnull(a.FEntrySelfY5238,0)<>isnull(c.FEntrySelfz0376,0))
			  ) a
		inner join SHProcRpt  b on a.FEntryIndex =b.FEntryIndex
	END
	
	---查询计件工资中的工资系数和工件数量 
	-- @fqufen='C'  计件工资单    @fconqf='A'： 与工序汇报不一致的数据
	IF @fqufen='C' AND @fconqf='A'
	BEGIN

		select c.FBillNo as 计件工资单据编号 ,a.FEntrySelfR0134 as 工作令号
		     ,  G.FNumber AS  产品长代码, G.FName as 产品名称
		     , b.FEntrySelfY5236 as 工序汇报中工资系数, B.FEntrySelfY5238 AS 工序汇报中工件数量
			 , a.FEntrySelfR0133 as 计件工资中工资系数, a.FEntrySelfR0135 AS 计件工资中的工件数量
			 , d.FBillNo as 工序汇报单据编号, a.FWorkAuxQty as 加工数量, A.FAuxPieceRate as 单位计件工资
			 , a.FJobPay as 计件工资合计
			 , A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty as 实际计件工资合计
			 , a.FAmount as 计件工资清单中总工资
			 , A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty +A.FHourPay as 实际总工资
			 , e.FName as 工序名称 , a.FDate as 日期 , a.FWBNO as 工序计划单编号
	     from ICJobPayEntry a
	    inner join ICJobPay c on a.FInterID =c.FInterID 
		inner join SHProcRpt b on a.FProcRptInterID=b.FinterID AND B.FEntryID=A.FProcRptEntryID
		inner join SHProcRptMain d on b.FinterID =d.FInterID 
		inner join t_SubMessage e ON e.FInterID =A.FOperID and e.FParentID =61
		inner join t_icitem g on g.fitemid = a.fitemid
		
		where (isnull(a.FEntrySelfR0133,0)<>isnull(b.FEntrySelfY5236,0) or isnull(a.FEntrySelfR0135,0)<>isnull(b.FEntrySelfY5238,0))
		  and a.FEntrySelfR0134 like @fgzl and g.fnumber like @fnumber
		order by a.fdate,a.FEntrySelfR0134,a.FOperSN
	END

	-- @fqufen='C'  计件工资单    @fconqf='B'： 所有的都显示
	IF @fqufen='C' AND @fconqf='B'
	BEGIN
		select  c.FBillNo as 计件工资单据编号 ,a.FEntrySelfR0134 as 工作令号
		     ,  G.FNumber AS  产品长代码, G.FName as 产品名称
		     , b.FEntrySelfY5236 as 工序汇报中工资系数, B.FEntrySelfY5238 AS 工序汇报中工件数量
			 , a.FEntrySelfR0133 as 计件工资中工资系数, a.FEntrySelfR0135 AS 计件工资中的工件数量
			 , d.FBillNo as 工序汇报单据编号, a.FWorkAuxQty as 加工数量, A.FAuxPieceRate as 单位计件工资
			 , a.FJobPay as 计件工资合计
			 , A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty as 实际计件工资合计
			 , a.FAmount as 计件工资清单中总工资
			 , A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty +A.FHourPay as 实际总工资
			 , e.FName as 工序名称 , a.FDate as 日期 , a.FWBNO as 工序计划单编号 
	     from ICJobPayEntry a
	    inner join ICJobPay c on a.FInterID =c.FInterID 
		inner join SHProcRpt b on a.FProcRptInterID=b.FinterID AND B.FEntryID=A.FProcRptEntryID
		inner join SHProcRptMain d on b.FinterID =d.FInterID 
		inner join t_SubMessage e ON e.FInterID =A.FOperID and e.FParentID =61
		inner join t_icitem g on g.fitemid = a.fitemid
		where a.FEntrySelfR0134 like @fgzl  and g.fnumber like @fnumber
		order by a.fdate,a.FEntrySelfR0134,a.FOperSN
	END

	--更新计件工资中的工资系数和工件数量
	-- @fqufen='C'  计件工资单    @fconqf='C'：更新(与工序汇报中内容一致)
	IF @fqufen='C' AND @fconqf='C'
	BEGIN
		update ICJobPayEntry
		set FEntrySelfR0133=FEntrySelfY5236,FEntrySelfR0135=FEntrySelfY5238
		  , FJobPay=FAuxPieceRate * a.FEntrySelfY5236 * a.FEntrySelfY5238 * FWorkAuxQty
		  , FAmount=FAuxPieceRate * a.FEntrySelfY5236 * a.FEntrySelfY5238 * FWorkAuxQty +FHourPay
		from (
			select a.FInterID,a.FEntryID, b.FEntrySelfY5235, b.FEntrySelfY5236 , B.FEntrySelfY5238 
			  from ICJobPayEntry a
			  inner join ICJobPay c on a.FInterID =c.FInterID 
			  inner join SHProcRpt b on a.FProcRptInterID=b.FinterID  AND B.FEntryID=A.FProcRptEntryID
			  inner join t_icitem g on g.fitemid = a.fitemid
			  where (isnull(a.FEntrySelfR0133,0)<>isnull(b.FEntrySelfY5236,0) or isnull(a.FEntrySelfR0135,0)<>isnull(b.FEntrySelfY5238,0))
			   and a.FEntrySelfR0134 like @fgzl and g.fnumber like @fnumber
			) a
		inner join ICJobPayEntry b on a.FInterID =b.FInterID and a.FEntryID=b.FEntryID 
	END

	
END