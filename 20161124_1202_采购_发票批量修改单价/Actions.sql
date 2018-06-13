--ACTION
select a.ftemplateid,a.fname,a.FEntryTable,c.ffieldname,c.fheadcaption,c.frelationid,c.FAction,
c.fctlindex ,c.fctltype,c.ffilter,a.ftype,a.fheadtable,a.fentrytable,a.fcheckpro ,a.fid
 from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID
where a.fname like '购货发票(专用)' and  c.Frelationid like '%fauxprice%'
order by  c.fctlindex;
select a.ftemplateid,a.fname,a.FEntryTable,c.ffieldname,c.fheadcaption,c.frelationid,c.FAction,
c.fctlindex ,c.fctltype,c.ffilter,a.ftype,a.fheadtable,a.fentrytable,a.fcheckpro ,a.fid
 from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID
where a.fname like '购货发票(专用)' and  c.Frelationid like '%FStdAllAmount%'
order by  c.fctlindex;
select *
 from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID
where a.fname like '购货发票(专用)' and  c.Ffieldname like '%fauxprice%'
order by  c.fctlindex;
