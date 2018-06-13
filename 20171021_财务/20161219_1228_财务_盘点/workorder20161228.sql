select top 10 b.fentryid,b.foperid,b.fopersn,* from shworkbill a join shworkbillentry b on a.finterid = b.finterid
join icopershift c on c.finwbinterid ;
;select top 10 * from ICOperShift
;--生产任务单 icmo; fheadselfj0184:work order
;select * from icmo where fbillno = '1612-061-1';
--生产投料单 ppbom ppbomentry related filed:ficmointerid
; select  b.ficmointerid,* from ppbom a join ppbomentry b on a.finterid = b.finterid where b.ficmointerid = '602693';
--生产领料单（出库单) icstockbill icstockbillentry ;related fields with icmo:ficmointerid
;select * from icstockbill a join icstockbillentry b on a.finterid = b.finterid where b.ficmointerid = '602693'
--入库单
--工序计划单 shworkbill shworkbillentry
;select a.fstatus,B.FSTATUS,a.ficmointerid,b.fentryid,a.ftrantype,b.foperid, * 
from shworkbill a join shworkbillentry b on a.finterid = b.finterid
 where a.ficmointerid = '602693'
 select c.fentryid, b.fentryid ,d.fentryid,c.foperid,b.foperid,d.foperid,a.ficmointerid
 from SHWorkBill a
inner join SHWorkBillEntry b on b.FInterID=a.FinterID
left join shworkbillentry c on c.finterid = a.finterid and c.fentryid = (b.fentryid -1) /*prevous node*/
left join shworkbillentry d on d.finterid = a.finterid and d.fentryid = (b.fentryid + 1)
where   a.ficmointerid = '584866'
order by a.ficmointerid,b.fentryid

--工序移转单 icopershift; from foutoperid to finoperid; finoperid is itselfoperid;foutoperid is previous operatorprocess
;select foutoperid,finoperid,FShiftTypeID,* from icopershift where ficmointerid = '602693' order by finterid
 --上下道工序，the last finoperid is the finale opernode?
;select distinct  a.foutoperid as ffromoperid,
(select fname from  t_SubMessage c where c.finterid = a.foutoperid) as ffromname,
a.finoperid as fselfoperid,b.finoperid as fgooperid,
(select fname from  t_SubMessage c where c.finterid = b.finoperid) as fgoname,
a.ficmointerid as ficmointerid 
from icopershift a join icopershift b on a.finoperid = b.foutoperid and a.ficmointerid = b.ficmointerid 
and a.ftrantype = 581 and b.ftrantype = 581
where a.ficmointerid  = '602693' order by a.finterid
--ftrantype
;select * from v_ictranstype where fname like '%移转%';
;select top 20 * from ictransactiontype  where finterid = 11300;
select * from icclasstype where fname_chs like '%投料单%'
select top 20 * from ictransactiontype where fname like '%投料单%'
select top 10 * from ictemplate  where fid = 'y02'