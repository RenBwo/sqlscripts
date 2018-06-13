
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
declare @FDate1	datetime,
	@FDate2	datetime,
	 @dept  nvarchar(50)
	set @fdate1 = '2018-05-01'
	set @fdate2 = '2018-05-31'
	set @dept = ''
 
	select xx.departmentname as 部门,xx.workcode as 工号,xx.lastname as 姓名,xx.field001 as 假别
	,SUM(xx.sjts) as 请假时间 
	from (	
    select t4.departmentname ,t3.workcode ,t3.lastname,t5.field001,t2.jsrq ,t2.sjts  

from   
 openrowset( 'SQLOLEDB ', '192.168.200.20'; 'sa'; 'whyb2009',[ecology].[dbo].[workflow_requestbase]) t1 
 inner join openrowset( 'SQLOLEDB ', '192.168.200.20'; 'sa'; 'whyb2009',[ecology].[dbo].[formtable_main_27])  t2 on t1.requestid=t2.requestId
inner join openrowset( 'SQLOLEDB ', '192.168.200.20'; 'sa'; 'whyb2009',[ecology].[dbo].[HrmResource])  t3 on t2.qjr=t3.id
left join  openrowset( 'SQLOLEDB ', '192.168.200.20'; 'sa'; 'whyb2009',[ecology].[dbo].[HrmDepartment])  t4 on t2.DEPT=t4.id
inner join  openrowset( 'SQLOLEDB ', '192.168.200.20'; 'sa'; 'whyb2009',[ecology].[dbo].[hrmLeaveTypeColor])  t5 on t2.hc1=t5.field004
 where requestname like '%请假%' and t1.currentnodeid=907 
order by t4.departmentname ,t3.workcode ,t3.lastname ,t2.jsrq) xx

where jsrq between convert(char(8),@FDate1,112) and convert(char(8),@FDate2,112)+' 23:59:59' 
and isnull(departmentname,0)  like '%'+@dept+'%'
and lastname like '车常迪'
group by xx.departmentname,xx.workcode,xx.lastname,xx.field001



