/*
--   select * from ictransactiontype where FName like '购货发票%';
-- update ICTransactionType set FCheckPRO = 'CheckBill_75|REDEVCLIENTObj:BUYINVOICE.INPRICE' where FID in ( '75','76');
 --new table
 --  create table dbo.a_buyinvoice_upload (
--   invoiceno char,
--   fnum char,
--   price int,
--   primary key (invoiceno));
--   alter table dbo.a_buyinvoice_upload alter column invoiceno varchar(20) not null;
--     alter table dbo.a_buyinvoice_upload alter column fnum varchar(50) not null;
--     alter table dbo.a_buyinvoice_upload alter column price varchar(50) not null;
--   alter table dbo.a_buyinvoice_upload DROP constraint PK_a_buyinv;
--   alter table dbo.a_buyinvoice_upload add constraint PK_a_buyinv primary key (invoiceno,fnum);
  
--
select invoiceno,fnum,price from a_buyinvoice_upload;
delete from a_buyinvoice_upload;
update a_buyinvoice_upload set price = 10;
--ctlindex
select a.fid ,a.fname,a.ftype,a.fheadtable,a.fentrytable,a.fcheckpro,b.fctlindex as headctlindex,b.fcaption,b.fctltype,b.ffieldname,
c.fctlindex as entryctlindex,c.fctltype,c.ffieldname,c.fheadcaption,c.frelationid,c.FAction,c.ffilter
from ICTransactionType a join ICTemplate b on a.Ftemplateid = b.FID join ICTemplateEntry c on b.FID = c.FID
where a.fname like '购货发票%' and b.FCaption like '%发票号码%';
--headtable control index
select b.fcaption,b.ffieldname,b.fctlindex ,a.fname from ICTransactionType a join ICTemplate b on a.Ftemplateid = b.FID 
where a.fname like '购货发票%' and  ( b.FCaption  like '%发票号码%' or b.FCaption  like '%汇%' or b.ffieldname like '%tran%')
order by b.ffieldname;

--entrytable control index
select a.fname ,b.ffieldname,b.fctlindex from ICTransactionType a join ICTemplateentry b on a.Ftemplateid = b.FID 
where a.fname like '购货发票%' and b.FFieldName = 'fitemid'
--ctl order
select c.fheadcaption,c.ffieldname,c.fctlorder,a.fname
 from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID
where a.fname like '购货发票%' and  (c.Ffieldname like '%price%' or c.ffieldname like '%qty%'
or c.ffieldname like '%amount%' or c.ffieldname like 'fitemid') order by c.ffieldname,a.fname
;
--entry rows
select MAX( b.FEntryID) from icpurchase a join icpurchaseentry b on a.finterid = b.finterid and a.FBillNo = '062132226';
--all fieldname referate price 
SELECT 'b'+'.'+c.ffieldname  from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID 
where a.fname like '购货发票(专用)' and c.fheadcaption like '%价%';
select 
b.FAllAmount,
b.FAuxOrderPrice,
b.Fauxprice,
b.FAuxPriceDiscount,
b.FAuxTaxPrice,
b.FOrderPrice,*
from icpurchase a join icpurchaseentry b on a.finterid = b.finterid and a.FBillNo = 'ZPOFP005787';
*/
--ACTION
select a.fid ,a.ftemplateid,a.fname,a.ftype,a.fheadtable,a.fentrytable,a.fcheckpro,c.ffieldname,c.fheadcaption,
c.frelationid,c.FAction,c.fctlindex as entryctlindex,c.fctltype,c.ffilter
 from ICTransactionType a join ICTemplateEntry c on a.Ftemplateid  = c.FID
where a.fname like '购货发票(专用)' and (c.frelationid like '%price%' or c.Frelationid like 'fauxprice%')
order by c.FCtlIndex;

-- select * from t_funccontrol where FFuncID = 19752;
 delete from t_funccontrol where FFuncID = 19752
