/*
 * DESCRIPTIONS:	针对预付款客户，财务人员在审核销售出库单时需要知道相关客户的付款情况。
 * DESCRIPTIONS:	收款单 t_rp_newreceivebill\ 销售出库 分录 icstockbillentry \销售合同 t_rpcontract 上都有客户订单编号。
 * DESCRIPTIONS：	根据收款条件，只能根据收款名称来判断是否是预付款客户，不规范。
 * DESCRIPTIONS：	所以根据客户，查找收款条件 t_paycolcondition，已付款情况 t_rp_newreceivebill.fstatus>1
 * DESCRIPTIONS:	
 */

CREATE PROCEDURE PREPAY_QUERY(@CUSTOMER_NUM_START VARCHAR(30),@CUSTOMER_NUM_END VARCHAR(300))
AS 
BEGIN
	select top 100 c.fnumber,a.fitemid,a.fnumber,a.fname,b.fname as fpaycondition	,c.fcurrencyid ,c.fcustpono,d.fcustpono
	,case c.fcurrencyid when 1 then c.famount when 1000 then c.famountfor end as famount
	,case c.fcurrencyid when 1 then c.freceiveamount when 1000 then c.freceiveamountfor end as freceiveamount	
	,case c.fcurrencyid when 1 then c.fdiscountamount when 1000 then c.fdiscountamountfor end as fdiscountamount
	,d.fcontractno
	,case d.fcurrencyid when 1 then d.ftotalamount when 1000 then d.ftotalamountfor else 0 end as fcontracttotalamount
	,case d.fcurrencyid when 1 then d.freceiveamount when 1000 then d.freceiveamountfor else 0 end as fcontractreceiveamount
	from 	t_organization 		a 
	join	t_paycolcondition 	b on a.fpaycondition = b.fid --and a.fnumber between @CUSTOMER_NUM_START and @CUSTOMER_NUM_END 
	join 	t_rp_newreceivebill c on c.fstatus > 1 and c.fcustomer = a.fitemid
	join 	t_rpcontract		d on d.fcustomer = c.fcustomer and d.fcontractid = c.fcontractid -- and d.fcustpono=c.fcustpono

	where 	a.fnumber like 'k.5.135' and c.fdate > '2017-07-01' and b.fname like '%预%'
	and d.fdate > '2017-09-01'
	
	
	
	
END 

select top 10 * from icclasstype where fname_chs like '%价格方案%' --vwicprcply
select top 10 * from icclasstype where fname_chs like '%合同%' --t_paycolcondition  
select top 10 * from icclasstype where fname_chs like '%收款%' --t_rp_newreceivebill 
select b.* from t_tabledescription a join t_fielddescription b on a.ftableid = b.ftableid 
where a.ftablename = 't_rp_newreceivebill'

select top 10 a.fitemid,a.fname,a.fnumber,fpaycondition,b.fname, a.* 
from t_organization a join t_paycolcondition b on a.fpaycondition = b.fid
where b.fname like '%预%'
 
select top 20 fbilltype,fitemclassid,fpayment,fcheckstatus,fstatus,* from t_rp_newreceivebill 
where fnumber like 'xskd002254' or fnumber like 'xskd002690'
or fdate > '2017-10-09' and fbilltype = 1000
select top 20 * from t_rpcontract where fcontractno like 'xsht002341'--5706
update t_rp_newreceivebill set fcontractid = 5706,fcontractno = 'XSHT002341' where fnumber like 'xskd002254' or fnumber like 'xskd002690'
select * from t_rp_newreceivebillentry


