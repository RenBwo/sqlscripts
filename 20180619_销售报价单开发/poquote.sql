
   select * from icclasstype where fname_chs like '%销售报价%'--1007006 porfq
   select * from icclasstypeentry where fparentid = 1007006
   select  ftabindex,flistindex,* from icclasstableinfo where fclasstypeid = 1007006
   --and fvisible > 0 
   and fpage = 2
   order by fpage,ftabindex,flistindex,fid
   update icclasstableinfo set ffieldname = b.ffieldname
   --select * 
   from icclasstableinfo a join ais20161026113020.dbo.icclasstableinfo b 
   on a.fclasstypeid = b.fclasstypeid and a.fcaption_chs = b.fcaption_chs
   and  a.fclasstypeid = 1007006 and a.fcaption_chs like '返点%'
   
   
   --设置顺序 tabindex listindex
  update icclasstableinfo set flistindex = ftabindex+71 where fclasstypeid = 1007006 and fpage = 2 and ftabindex > 0
   
   update icclasstableinfo set ftabindex = 62 where fid = 26341
   update icclasstableinfo set ftabindex = 63 where fid = 26342
   update icclasstableinfo set ftabindex = 64 where fid = 26343
   update icclasstableinfo set ftabindex = 65 where fid = 26344
   update icclasstableinfo set ftabindex = 70 where fid = 25261
   update icclasstableinfo set ftabindex = 60 where fid = 26336
   update icclasstableinfo set ftabindex = 60 where fid = 26336
   update icclasstableinfo set ftabindex = 60 where fid = 26336
   update icclasstableinfo set ftabindex = 60 where fid = 26336
   --动作列表
   select --substring(faction,1,120),substring(faction,121,120),substring(faction,241,120) ,
   *
   from icclassactionlist 
   where fclasstypeid = 1007006 and faction like '%fdecimal20%'
 
   select * from icclassaction where fid=100007
   --quater季度
   select top 1 fdate,dateadd(ss,-1,dateadd(qq,datediff(qq,0,getdate())+1,0))
   ,dateadd(ss,-1,DATEADD(yy, DATEDIFF(yy,0,getdate())+1, 0)) 	from porfq
    
  --计量单位 125 公斤 207266 立方
   select * from t_measureunit where fname like '%米%' or fnumber like '03'
   
   select * from t_exchangerate a join t_exchangerateentry b 
   on a.fid=b.fid where a.fparentid = 4
   
