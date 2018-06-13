create procedure MRPDiscover13(@flag varchar)
as 
begin
if @flag = 'y' 
begin
update a set a.fplantrategy = 321 
from t_icitemplan a 
join t_icitemcore b on a.fitemid = b.fitemid and  a.fplantrategy = 324  and b.fnumber like '13.%'
where b.fnumber like '13.%' and a.fplantrategy = 324 and b.fdeleted = 0;
end
if @flag = 'n' 
begin
update a set a.fplantrategy = 324
from t_icitemplan a 
join t_icitemcore b on a.fitemid = b.fitemid and  a.fplantrategy = 321 and b.fnumber like '13.%'
where b.fnumber like '13.%' and a.fplantrategy = 321 and b.fdeleted = 0 ;
end
end