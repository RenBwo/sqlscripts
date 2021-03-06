USE [AIS20091217151735]
GO
/****** Object:  StoredProcedure [dbo].[Make_material_anylize_20161124]    Script Date: 11/25/2016 08:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,renbo>
-- Create date: <Create Date,,2016/11/24>
-- Description:	<Description,,自制物料分析>
-- =============================================
ALTER PROCEDURE [dbo].[Make_material_anylize_20161124] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
--the plan_qty within 90 days
select b.fitemid as itemid ,sum(b.fauxqtymust) as plan_qty_90 
into #w1
 from ppbomentry b  where b.fsenditemdate >= DATEADD(m,-3,GETDATE())
 and b.fsenditemdate <=getdate()
group by b.fitemid;
--plan_qty within 180 days
select b.fitemid as itemid, sum(b.fauxqtymust)  as qty_180
into #w2
from ppbomentry b  where  b.fsenditemdate >= DATEADD(m,-6,GETDATE())
and b.fsenditemdate <=getdate()
group by b.fitemid ;
--plan_qty within 365 days
select b.fitemid as itemid,sum(b.fauxqtymust) as qty_365
into #w3
from ppbomentry b  where  b.fsenditemdate >= DATEADD(year,-1,GETDATE())
and b.fsenditemdate <=getdate()
group by b.fitemid 
--require_times within 90 days
 select w9.itemid ,count(w9.bomcount) as req_90
 into #w4
 from (select distinct  t2.fitemid as itemid , t3.finterid as bomcount
  from  ppbom t1  join ppbomentry t2    on t1.finterid = t2.finterid and 
  t2.fsenditemdate >= DATEADD(m,-3,GETDATE())  and t2.fsenditemdate <= getdate() 
 join    seorderentry t3  on  t3.fentryselfs0160 = t1.fheadselfy0224   ) w9
 group by w9.itemid;
--require_times within 180 days
 select w9.itemid ,count(w9.bomcount) as req_180
 into #w5
   from (select distinct  t2.fitemid as itemid , t3.finterid as bomcount
  from  ppbom t1  join ppbomentry t2    on t1.finterid = t2.finterid and 
  t2.fsenditemdate >= DATEADD(m,-6,GETDATE())  and t2.fsenditemdate <= getdate() 
 join    seorderentry t3  on  t3.fentryselfs0160 = t1.fheadselfy0224   ) w9
 group by w9.itemid;
 --require_times within 365 days
 select w9.itemid ,count(w9.bomcount) as req_365
  into #w6
  from (select distinct  t2.fitemid as itemid , t3.finterid as bomcount
  from  ppbom t1  join ppbomentry t2    on t1.finterid = t2.finterid and 
  t2.fsenditemdate >= DATEADD(year,-1,GETDATE())  and t2.fsenditemdate <= getdate() 
 join    seorderentry t3  on  t3.fentryselfs0160 = t1.fheadselfy0224   ) w9
 group by w9.itemid
 -- common_use_times as common material
 select count(a.fbomnumber) as generalC,b.fitemid  as itemid 
 into #w7 
 from icbom a join icbomchild b on a.finterid = b.finterid
 group by b.fitemid
 
 --result table 
select  t2.fnumber, t2.fmodel,t2.fname,
 (select fname from t_department where fitemid = t2.fsource) as depart,
 (select fname from t_measureunit where fitemid = t2.funitid) as unitname ,
 w1.plan_qty_90,w4.req_90,w2.qty_180,
 w5.req_180,w3.qty_365,w6.req_365,t2.fqtymin,t2.fsecinv,w7.generalC
 from t_icitem t2 
left join  #w1 w1 on t2.fitemid = w1.itemid and t2.ferpclsid = 2 and isnull(w1.plan_qty_90,0) <> 0
left join  #w2 w2 on t2.fitemid = w2.itemid and t2.ferpclsid = 2 and isnull(w2.qty_180,0) <> 0
left join  #w3 w3 on t2.fitemid = w3.itemid and t2.ferpclsid = 2 and isnull(w3.qty_365,0) <> 0
left join  #w4 w4 on t2.fitemid = w4.itemid and t2.ferpclsid = 2 and isnull(w4.req_90,0) <> 0
left join  #w5 w5 on t2.fitemid = w5.itemid and t2.ferpclsid = 2 and isnull(w5.req_180,0) <> 0
left join  #w6 w6 on t2.fitemid = w6.itemid and t2.ferpclsid = 2 and isnull(w6.req_365,0) <> 0
     join  #w7 w7 on t2.fitemid = w7.itemid and t2.ferpclsid = 2
     where isnull(w1.plan_qty_90,0) <> 0 
      or isnull(w2.qty_180,0) <> 0
      or isnull(w3.qty_365,0) <> 0
      or isnull(w4.req_90,0) <> 0
      or isnull(w5.req_180,0) <> 0
      or isnull(w6.req_365,0) <> 0
      
 order by t2.fnumber;
--destroy memory
  drop table #w1;
  drop table #w2;  
  drop table #w3;
  drop table #w4;
  drop table #w5;
  drop table #w6;
  drop table #w7;
 
 
	
	
	

    -- Insert statements for procedure here
	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END
