create trigger trig_mulcheck_20000008 on icclassmcrecord200000008 for update
as 
begin
	
update t_bos200000008 set fchecker1 = b.fcheckerid,fcheckdate1 = b.fcheckdate
from t_bos200000008 a join inserted b on a.fid = b.fbillid and b.fcheckfrom = 0 and b.ftemplateid = 16

end 