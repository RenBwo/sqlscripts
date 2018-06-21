
   select * from icclasstype where fname_chs like '%销售报价%'--1007006 porfq
   select * from icclasstypeentry where fparentid = 1007006
   select  * from icclasstableinfo where fclasstypeid = 1007006 order by fid desc
   
    
  