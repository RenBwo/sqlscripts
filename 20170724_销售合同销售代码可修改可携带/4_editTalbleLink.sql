/*
 * find the source classtypeid and the destination classtypeid
 * destable :icmo
 * sourtable: seorder
 *          BOS 单据***********************************
*	单据表头描述	icclasstype （ftemplateid=0 的是老单）
*	单据分录描述	icclasstypentry 
*	单据模板字段描述	icclasstableinfo 
*	单据编号	icbillno	t_billcoderule
*	选单关联表	icclasslink	icclasslinkentry
*	选单钩稽明细表	icclasslinkcommit
*	单据扩展服务模板数据	icclassactionlist
********	供应链(transaction) ************************************************
*	供应链(transaction)所有的单据的总体信息 ICTRANSACTIONTYPE
*	单据表头的详细信息	ICTEMPLATE
*	单据表体的信息	ICTEMPLATEENTRY
*	选单服务	icselbills 
*	选单中涉及表间关系	ICTableRelation
*	单据编号	icbillno
*	最大内码号	icmaxnum IC_MAXNUM
 */

select * from icclasstype where ftablename = 'icmo' 			/*fid -85   ftemplateid 0-> transaction bill*/
select * from icclasstype where ftablename = 'seorder' 			/*fid -81 	ftemplateid 0-> transaction bill*/
select * from ictransactiontype where fheadtable = 'icmo' 		/* fid 85 templateid J01*/
select * from ictransactiontype where fheadtable = 'seorder' 	/* fid 81 femplateid S01 */
select * from ictemplate where fid in ('j01','s01') order by fid;
select * from ictemplateentry where fid in ('j01','s01') order by fid;
/*
 * select relationship between tables
 */
select FID, FFieldName, FDstCtlField, FSelType, FDK, FColName, FROB,* from icselbills 
where fid = 'j01' and ffieldname ='forderinterid' and fseltype = 2
order by FID, FFieldName, FDstCtlField, FSelType, FDK, FColName, FROB

select ftypeid,finterid,* from ictablerelation where fbillid = 'J01' and ffieldid = 'forderinterid'
order by ftypeid,finterid
select a.fdstctlfield, a.fdstctlfield  +'=(select '+a.fname +' as '+a.fcolname 
+' from '+a.ftablename +' '+a.ftablealias 
+(case b.flogic when '*=' then ' left join ' when '=*' then ' right join ' else ' join ' end) 
+b.ftablename11 +' '+b.ftablenamealias11 +' on '+a.ftablealias+'.'+b.ffieldname +'='
+b.ftablenamealias11+'.'+b.ffieldname11+' )' as sqlstatement,
* from icselbills a join ICTableRelation b on a.ftablename = b.ftablename 
and a.fid = b.fbillid and a.ffieldname = b.ffieldid where fid = 'j01' 
and a.ffieldname = 'forderinterid' 
order by a.fdstctlfield desc;
/*
 * add selection relationship
 */
Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0192',2,0,'FEntrySelfS0180','FEntrySelfS0180',
'seorderentry','u1','u1.fentryselfs0180',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'

Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0192',2,1,'FEntrySelfS0180','FEntrySelfS0180',
'seorderentry','u1','u1.fentryselfs0180',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'

Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0192',2,2,'FEntrySelfS0180','FEntrySelfS0180',
'seorderentry','u1','u1.fentryselfs0180',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'
--ok
Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0193',2,0,'FEntrySelfS0192','FEntrySelfS0192',
'seorderentry','u1','u1.fentryselfs0192',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'
Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0193',2,1,'FEntrySelfS0192','FEntrySelfS0192',
'seorderentry','u1','u1.FEntrySelfS0192',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'
Insert into icselbills select top 1 
fid,ffieldname,'fheadselfj0193',2,2,'FEntrySelfS0192','FEntrySelfS0192',
'seorderentry','u1','u1.FEntrySelfS0192',frob,1
from icselbills where fid = 'j01' and ffieldname = 'forderinterid' and ftablename like 'seorderentry'
/*
 * icmobatch selection bill
 */
select ftablename,fid,ftemplateid,* from icclasstype where fname_chs like '生产任务单%';/*fid 1002511,ftemplateid 1002511 -> new bos bill*/
select ftablename,fid,ftemplateid,* from icclasstype where ftablename like 'seorder%';/*fid -81,ftemplateid 0 -> transaction bos bill*/
select * from icclasstypeentry where fparentid = 1002511;
select  * from icclasstableinfo where fclasstypeid = 1002511/*fdestfkey: ftext1 ,ftext2*/

select * from icclasslink where fdestclasstypeid = 1002511 and fsourclasstypeid = -81;
select * from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81  ;
/*delete from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81 and fdestfkey in ('fcustomgoodsname','FcustGoodsNum') ;
*/
insert  into icclasslinkentry(fsourclasstypeid,fdestclasstypeid,fsourpage,fsourfkey,fdestpage,fdestfkey,
fischeck,fisgroup,fisfilter,fdoaction,fallowmodified,fisuserdefine,fcontrol,fredneg,fsourtypeid,fdesttypeid)
select top 1 fsourclasstypeid,fdestclasstypeid,2,'fentryselfs0180',2,'FText1',fischeck,
fisgroup,fisfilter,fdoaction,1,1,fcontrol,fredneg,fsourtypeid,fdesttypeid
from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81 

insert  into icclasslinkentry(fsourclasstypeid,fdestclasstypeid,fsourpage,fsourfkey,fdestpage,fdestfkey,
fischeck,fisgroup,fisfilter,fdoaction,fallowmodified,fisuserdefine,fcontrol,fredneg,fsourtypeid,fdesttypeid)
select top 1 fsourclasstypeid,fdestclasstypeid,2,'fentryselfs0192',2,'FText2',fischeck,
fisgroup,fisfilter,fdoaction,1,1,fcontrol,fredneg,fsourtypeid,fdesttypeid
from icclasslinkentry where fdestclasstypeid = 1002511 and fsourclasstypeid = -81
