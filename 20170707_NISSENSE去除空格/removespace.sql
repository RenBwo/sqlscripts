;select count(*)
from t_icitemcustom where len(f_158) <> len(replace(f_158,' ',''))     
;update t_icitemcustom set f_158=replace(f_158,' ','') where len(f_158) <> len(replace(f_158,' ',''))
/*20170809 '-=k'--change--to-->'-'*/
select count(*) from t_icitemcustom where charindex('k',f_158)>0
select f_158,* from t_icitemcustom where charindex('k',f_158)>0
update t_icitemcustom set f_158='-' where charindex('k',f_158)>0