/*
select * from icclasstype where fname_chs like '%假%' /*ftemplateid 200000008*/
SELECT * FROM ICClassMCTemplate where fclasstypeid = 200000008--审批流模板表
SELECT * FROM ICClassMCTableInfo where ftemplateid = 16--审批流模板明细表
SELECT * FROM ICClassMCTemplateMap where ftemplateid = 16--单据-审核流模板映射表 
SELECT * FROM ICClassMCStatus200000008 --单据审核步骤表
SELECT * FROM ICClassMCRecord200000008 --单据审核记录表
*/
select a.*  from t_bos200000008   a 
join icclassmctemplatemap b on a.fid = b.fbillid 
join icclassmcrecord200000008 c on b.ftemplateid = c.ftemplateid and c.fbillid = a.fid and c.fcheckfrom = 0 and c.fcheckerid <> 16576
where a.fcombobox like '年休'  and a.ftime > '2017-11-01' 
and c.fcheckdate > '2017-10-01'  
