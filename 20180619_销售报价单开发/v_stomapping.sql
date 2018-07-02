select top 10 b.fname,c.fnumber,c.fname,a.* from icitemmapping a join t_organization b 
on a.fcompanyid = b.fitemid
join t_icitem c on c.fitemid = a.fitemid and c.fnumber like '01.01.%'
where a.fpropertyid = 1 and isnull(a.ModelHstSaleQty,0)>0
use ais20161026113020
alter  VIEW v_CToIMapping
AS
    SELECT 1007103 AS FClassTypeID, FEntryID As FID,t1.FItemID, FEntryID,
           FCompanyID AS FParentID, FMapName As FName, FMapNumber As FNumber
           ,t2.FNumber as FItemNumber,isnull(t1.hissaleqty,0) as saleqty
      FROM ICItemMapping t1 (NOLOCK)
        INNER JOIN t_ICItem t2 (NOLOCK) ON t1.FItemID=t2.FItemID
     WHERE FPropertyID = 1
 --v_CToIMappingGrp   
alter  VIEW v_CToIMappingGrp
AS
    SELECT FEntryID  As FID, FMapName As FName, FMapNumber As FNumber, 0 AS FParentID,
           '' AS FFullNumber, 0 AS FLevels, 1 AS FDetail, 1007103 AS FClassTypeID,
           0 AS FDiscontinued, 0 AS FLogic, FEntryID,isnull(hissaleqty,0) as saleqty
      FROM ICItemMapping (NOLOCK)
     WHERE FPropertyID = 1
     --
   --  alter table icitemmapping ADD ModelHstSaleQty decimal(30,6) default 0
   alter table icitemmapping drop DF__ICItemMap__Model__0F571391
   --alter table icitemmapping drop column ModelHisSaleQty 
   select top 3  * from icitemmapping
   select * from icclasstype where fname_chs like '%物料对应%'
   select * from icclasstypeentry where fparentid = 1007103
   select  * from icclasstableinfo where fclasstypeid = 1007103 order by fid desc
   insert into icclasstableinfo(fclasstypeid,fpage,fcaption_chs,fcaption_cht
   ,fcaption_en,fkey,ffieldname,ftablename,fvisible,fenable)
   select fclasstypeid,fpage,'历史销售数量',fcaption_cht
   ,fcaption_en,'fqty',ffieldname,ftablename,fvisible,fenable from icclasstableinfo 
   where fclasstypeid = 1007103 and fid = 9011
    
   update icclasstableinfo set fvisible = 2047 ,fenable = 1,fmustinput = 0 
   ,fuserdefine = 1 ,fheight = 300,fwidth = 200,fvaluetype = 106 ,fvalueprecision = 13
   ,ffieldname = 'saleqty',flock=24
   where fclasstypeid = 1007103 and fid =26110
   
   
   select top 200 * from icclasstableinfo where fkey like 'fqty%' and ftablename like 'icstockbill%'
   
   

     