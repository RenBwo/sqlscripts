	declare @abd varchar(30) 
	select @abd = '1702-990'
	select max(b.工作令号) from (
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
	WHERE  a.FEntrySelfz0374 like @abd and (isnull(a.FEntrySelfz0375,0)<>isnull(e.FEntrySelfZ0236,0) or isnull(a.FEntrySelfz0376,0)<>isnull(e.FEntrySelfZ0237,0)
	       or ISNULL(e.FPieceRate,0)<>ISNULL(a.FPieceRate,0) )
	 ) b 
	where b.工作令号 like '1%';--1702-990 1608-1740
	;select * from icclasstype where fname_chs like '%工序计划%'

	select a.fitemid,b.fitemid,* from shworkbill a join shworkbillentry b on a.finterid = b.finterid and b.FEntrySelfz0374 = '1702-990';
	-- b 
			select max(c.工作令号) from (	select b.FBillNo 工序汇报编号 ,a.FEntrySelfY5235 as 工作令号
		     , c.FEntrySelfz0375 as 工序计划单工资系数 
			 , c.FEntrySelfz0376 AS 工序计划单工件数量
		     , a.FEntrySelfY5236 as 工序汇报工资系数
			 , a.FEntrySelfY5238 AS 工序汇报工件数量			 
			 , f.FName as 工序名称
		 from SHProcRpt a
		inner join SHProcRptMain b on a.FinterID =b.FInterID 
		inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  
		inner JOIN t_SubMessage F ON F.FInterID =c.FOperID and f.FParentID =61
		join shworkbill d on d.finterid = c.finterid
		INNER JOIN t_ICItem G ON G.FItemID = d.FitemID 
		where --a.FEntrySelfY5235 like @fgzl and
		      (isnull(a.FEntrySelfY5236,0)<>isnull(c.FEntrySelfz0375,0) or
		        isnull(a.FEntrySelfY5238,0)<>isnull(c.FEntrySelfz0376,0))
		) c where c.工作令号 like '1%' --1702-952
		;select top 10 *   from SHProcRpt a join shprocrptmain b on a.finterid = b.finterid
		 where b.FEntrySelfR0134 = '1701-1254';
		 ;
--c
select max(c.工作令号) from (
		select c.FBillNo as 计件工资单据编号 ,a.FEntrySelfR0134 as 工作令号
		,g.fname ,g.fnumber
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
		join t_icitem g on g.fitemid = a.fitemid
		where  a.FEntrySelfR0134 like '1701-020'
		) c where c.工作令号 like '1%' --1701-020
		select * FROM icclasstype where ftablename like 'ICJobPay%'; --计时计件工资清单
		select * FROM icclasstypeentry where ftablename like 'ICJobPay%'; 
		select * from ictransactiontype where fname like '计时计件工资清单'
		select * from ICClassTableInfo where fclasstypeid = '-700'
		select * from ictemplate a left join ictemplateentry b on a.fid = b.fid where a.fid = 'R01' and b.fheadcaption like '%物料%'