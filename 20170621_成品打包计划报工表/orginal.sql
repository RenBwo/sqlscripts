

declare @str1 varchar(1000)
declare @str2 varchar(1000)
declare @sql1 varchar(3000)

set @str1=''

if '*FSeqno*'='A' set @str2=' ORDER BY a.fgzl, e.FCustID, b.FPlanCommitDate '
if '*FSeqno*'='C' set @str2=' ORDER BY e.FCustID, a.fgzl '
if '*FSeqno*'='B' set @str2=' ORDER BY b.FPlanCommitDate, c.fnumber '
if '*FSeqno*'=''  set @str2=' ORDER BY a.fgzl, e.FCustID '

if '@FSordNO@'<>'' set @str1= ' AND e.FBillNo like '+''''+'%'+'@FSordNO@'+'%'+''''
else set @str1=''
if '*FStartFGZL*'<>'' set @str1=@str1 + ' AND  a.FGZl>='+''''+'*FStartFGZL*'+''''
if  '#FEndFGZL#'<>'' set @str1= @str1+ ' AND  a.FGZl<='+''''+ '#FEndFGZL#'+''''
if '*CustNo*'<>'' set @str1=@str1 + ' AND h.FNumber like '+''''+'%'+'*CustNo*'+'%'+''''
if '********'<>'' set @str1=@str1 + ' AND b.FPlanCommitDate>='+''''+convert(char(8),CAST('********' as datetime),112)+''''
if '########'<>'' set @str1=@str1 + ' AND b.FPlanCommitDate<='+''''+convert(char(8),CAST('########' as datetime),112)+''''


set @sql1='
SELECT  e.FBillNo as 销售订单编号, a.fgzl as 工作令号, c.FNUMBER as 物料长代码
	 , c.FName as 物料名称, c.FModel as 规格型号
     , e.FCustID
     , h.FNumber as 客户
     , CONVERT(varchar(100), b.FPlanCommitDate, 112) as 计划开工日期
     , CONVERT(varchar(100), b.FPlanFinishDate, 112) as 计划完工日期
     , a.fzxwcdate as 纸箱完成日期
     , e.FHeadSelfS0152 as 销售订单特殊要求
     , b.FQty as 投产数量
     , b.FAuxStockQty as 入库数量
     , b.FSaveQty as 入库保存数量
     , b.FSaveDate as 入库保存时间
     , g.fsumqty as 日包装总量
FROM t_ypaichan_cp a 
left outer join (
     SELECT a.FItemID, a.FHeadSelfJ0184, a.FPlanCommitDate, a.FPlanFinishDate
			, SUM(a.FQty) as FQty, SUM(a.FAuxStockQty) as FAuxStockQty
			, sum(b.FQty) as FSaveQty
			, MAX(b.FSaveDate) as FSaveDate
       FROM ICMO  a
       LEFT OUTER join (select  b1.FICMOInterID,b1.FItemID ,sum(b1.FQty) as FQty, max(a1.FHeadSelfA0230) as FSaveDate
						from ICStockBill a1
						left outer join ICStockBillEntry b1 on a1.FInterID =b1.FInterID 
						where a1.FTranType=2 and a1.FStatus in (0,1) 
						group by  b1.FICMOInterID,b1.FItemID
						) b on  a.FInterID =b.FICMOInterID and a.FItemID =b.FItemID 
		 WHERE a.FWorkShop =227394		
       GROUP BY a.FItemID, a.FHeadSelfJ0184, a.FPlanCommitDate, a.FPlanFinishDate
     ) b ON b.FHeadSelfJ0184=a.fgzl 
 left outer join t_ICItem c ON b.FItemID = c.FItemID 
 left outer join SEOrderEntry d ON d.FEntrySelfS0160=a.fgzl  
 left outer join SEOrder e ON d.FInterID =e.FInterID and e.FCancellation =0 and e.FChangeMark=0 
 left outer join (SELECT FPlanCommitDate, SUM(n.fqty) as fsumqty
					FROM t_ypaichan_cp m 
					inner join ICMO n ON m.fgzl =n.FHeadSelfJ0184
					WHERE m.fqty>0 and n.FWorkShop =227394
					GROUP BY FPlanCommitDate ) g ON b.FPlanCommitDate=g.FPlanCommitDate  
 left outer join t_Organization h ON h.FItemID = e.FCustID
 WHERE a.fstatus=1 AND a.fqty>0 
 and e.FBillNo is NOT null '+ @str1+ @str2

exec(@sql1)