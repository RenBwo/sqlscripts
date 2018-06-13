select top 2 * from icmobatchentry;
select * from icclasstableinfo where fclasstypeid = 1002511 and fcaption_chs like '%工作令%';
select * from ICTRANSACTIONTYPE where fname like '生产任务单%';--85
select * from icclasstype where fname_chs like '生产任务单%';
select * from icclasstypeentry where fparentid = 1002511;
select  top 10 * from icselbills where fid = 1002511;
select * from icclasslink where fdestclasstypeid = 1002511 and fsourclasstypeid = -85;
select * from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -85 and fdestfkey like 'fbillno';
insert  into icclasslinkentry(fsourclasstypeid,fdestclasstypeid,fsourpage,fsourfkey,fdestpage,fdestfkey,
fischeck,fisgroup,fisfilter,fdoaction,fallowmodified,fisuserdefine,fcontrol,fredneg,fsourtypeid,fdesttypeid)
select fsourclasstypeid,fdestclasstypeid,fsourpage,'fheadselfj0184',fdestpage,'ftext',fischeck,
fisgroup,fisfilter,fdoaction,1,1,fcontrol,fredneg,fsourtypeid,fdesttypeid
from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -85 and fdestfkey like 'fbillno'
--delete from icclasslinkentry where  fdestclasstypeid = 1002511 and fsourclasstypeid = -85 and fsourfkey='fheadselfj0184'
--

select * from icclasstype where fname_chs like '销售订单%'; --fid -81

select * from icclasslink where fdestclasstypeid = 1002511 and fsourclasstypeid = -81;
select * from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81 and fsourfkey like 'fbillno';
--delete from icclasslinkentry where  fdestclasstypeid = 1002511 and fsourclasstypeid = -81 and fsourfkey='fentryselfs0160'
insert  into icclasslinkentry(fsourclasstypeid,fdestclasstypeid,fsourpage,fsourfkey,fdestpage,fdestfkey,
fischeck,fisgroup,fisfilter,fdoaction,fallowmodified,fisuserdefine,fcontrol,fredneg,fsourtypeid,fdesttypeid)
select fsourclasstypeid,fdestclasstypeid,2,'fentryselfs0160',fdestpage,'ftext',fischeck,
fisgroup,fisfilter,fdoaction,1,1,fcontrol,fredneg,fsourtypeid,fdesttypeid
from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81 and fsourfkey like 'fbillno';
