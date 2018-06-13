/*
 * DATE	:		2017/1102
 * AUTHOR:		任波
 * DESCRIPTION:	工艺变更,B型芯体要全部取消"打磨芯体"工艺. 
 * 
 * */
--use AIS20170714081229
/*
 * BOM排除,BOM里不能有此工序的引用,如果有,需要在ERP里进行修改,BOM里工序不能设置为空
 */
/*SELECT G.FNumber AS  产品长代码, G.FName as 产品名称
		,a.fbomnumber,A.FINTERID AS bominterid,b.fentryid as BOMENTRYID
		,c.FBillNo as 工艺路线编号
		,d.foperid, d.FOperSN as 工艺路线工序号,f.fname as 工序名称 	
	FROM ICBOM a 
	join icbomchild b on a.finterid = b.finterid
	JOIN T_routing c on c.FInterID =a.FRoutingID 
	JOIN T_RoutingOper d on c.FInterID =d.FInterID and d.foperid = b.foperid
	left  JOIN t_SubMessage F ON F.FInterID =d.foperid and f.FParentID =61
	left  JOIN t_ICItem G ON G.FItemID = c.FitemID 
   where f.fname like '打磨芯体'  
  */ 
   /*
    *	上传excel到表TEMP_modoper
    *	select * from a_operate_mod
    *	备份
    *	select c.* from t_routing a join a_operate_mod b on a.fbillno = b.froutno join t_routingoper c on a.finterid = c.finterid
    */
  
   select row_number() over (order by froutno) as fid ,* into #t1 from ais20091217151735.dbo.a_operate_mod
   declare @i int,@j int,@fentryid int,@finterid int 
   select @j = max(fid)+1,@i = 1  from #t1 
   
   while @i < @j 
   begin
   set @fentryid = 10000
   
   select @fentryid = c.fentryid,@finterid = a.finterid  
   from t_routing a join #t1 b on a.fbillno = b.froutno and b.fid = @i 
   join t_routingoper c on c.finterid = a.finterid
   join t_submessage d on d.finterid = c.foperid and d.FParentID =61 and d.fname = '打磨芯体'
   --select @i,@j,@finterid,@fentryid,* from #t1 where fid = @i
   /*
    * 删除工序
    */
   delete t_routingoper  where finterid = @finterid and fentryid = @fentryid
   /* 
   * 修改FENTRYID
   */
   set identity_insert t_routingoper ON --打开显式插入
   update  t_routingoper set fentryid = fentryid - 1 where finterid = @finterid and fentryid > @fentryid
   set identity_insert t_routingoper off --关闭显式插入
   select @i = @i+1 
   end 
   drop table #t1
/*
 * 检测
 */
   /*
    select b.finterid,b.fentryid,c.fnumber, d.fname,b.* 
    from t_routing a left join t_routingoper b on a.finterid = b.finterid and a.fbillno = 'rt002334'
    join t_icitem c on c.fitemid = a.fitemid
    join t_submessage d on d.finterid = b.foperid
    */
   
          /*误删除,恢复
        *  set identity_insert t_routingoper ON --打开显式插入
        * insert into t_routingoper(fentryid,fopersn,foperid,fbrno,fworkcenterid,ftimeunit,ftimerun,finterid,
       fworkqty,fqualitychkid,ffare,fmoveqty,fautotd,fautoof,fisout,fworkerid,fdeviceid,fresourcecount,
       fconversion,fpiecerate,fnewentryid,fmachstdtimesetup,fentryselfz0236,fentryselfz0237)
       values(5,50,40133,0,216911,11082,1.0000000000,3821,
       100.0000000000 ,352,1059,1.0000000000,1058,1058,1059,58287,1018 ,1,
       1.0000000000,0.2300000000,96801 ,1.0000000000 ,1.0000000000 , 1.0000000000)  
       --delete from t_routingoper where finterid = 3339 
       set identity_insert t_routingoper ON --打开显式插入        
       insert into t_routingoper(fentryid,fopersn,foperid,fbrno,fworkcenterid,ftimeunit,ftimerun,finterid,
       fworkqty,fqualitychkid,ffare,fmoveqty,fautotd,fautoof,fisout,fworkerid,fdeviceid,fresourcecount,
       fconversion,fpiecerate,fnewentryid,fmachstdtimesetup,fentryselfz0236,fentryselfz0237)
       select fentryid,fopersn,foperid,fbrno,fworkcenterid,ftimeunit,ftimerun,finterid,
       fworkqty,fqualitychkid,ffare,fmoveqty,fautotd,fautoof,fisout,fworkerid,fdeviceid,fresourcecount,
       fconversion,fpiecerate,fnewentryid,fmachstdtimesetup,fentryselfz0236,fentryselfz0237
       from ais20091217151735.dbo.t_routingoper where finterid = 3339 
       set identity_insert t_routingoper off --关闭显式插入
       */