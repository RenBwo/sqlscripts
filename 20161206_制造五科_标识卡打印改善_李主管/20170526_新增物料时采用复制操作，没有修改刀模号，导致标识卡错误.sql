select c.fnumber,c.f_163,*  from t_icitem c
 where c.FSource =  '69836' and c.fname like '%³Ä%'
and c.f_163 = 450298 order by c.fitemid desc
update t_icitem set f_163 = null where fitemid =  297697
/*450058	2
450427	2
450281	2
450193	2
450157	2
450094	2
450399	2
450388	2
450115	2
450145	2
450386	2
450021	3
450298	3*/