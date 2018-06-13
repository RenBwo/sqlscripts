update a_paperbox set parentcode = (select fitemid from t_ICItem where FNumber = parfnum),
subitemid = (select fitemid from t_ICItem where FNumber = sufnum),
newitemid = (select fitemid from t_ICItem where FNumber = newfnum)

;
select * from ais20161026113020.dbo.a_paperbox;
select a.FBOMNumber,b.FItemID,c.subitemid,c.newitemid from AIS20091217151735.dbo.icbom a join AIS20091217151735.dbo.icbomchild b 
on a.FInterID = b.FInterID join a_paperbox c on a.FItemID = c.parentcode and b.FItemID = c.subitemid;
update b set b.fitemid = c.newitemid
from   AIS20091217151735.dbo.icbom a join AIS20091217151735.dbo.icbomchild b  on a.FInterID = b.FInterID 
join a_paperbox c on a.FItemID = c.parentcode and b.FItemID = c.subitemid;

select a.FBOMNumber,b.FItemID,c.subitemid,c.newitemid from  AIS20091217151735.dbo.icbom a join AIS20091217151735.dbo.icbomchild b  on a.FInterID = b.FInterID 
join a_paperbox c on a.FItemID = c.parentcode and b.FItemID = c.newitemid;
