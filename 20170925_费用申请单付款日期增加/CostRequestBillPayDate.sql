/* 
 * 费用（借款）申请 的付款日期带到付款申请单
 * 费用（借款）申请 的付款日期 FYGL_EXPENSEAPPLY.fdate1
 * 付款申请单		 的付款日期  t_rp_payapplybill.fdate1
 */

alter trigger trig_paypapplybill_paydate on dbo.t_rp_payapplybillentry for insert as
begin
	if (select findex from inserted) =1
	begin
update t_rp_payapplybill set fdate1 = c.fdate1
from inserted a 
join  t_rp_payapplybill b on a.fbillid = b.fbillid and a.findex = 1 
join fygl_expenseapply c on c.fbillno = a.fbillno_src
end
end
/*
select  top 100 *  
from t_rp_payapplybillentry a 
join  t_rp_payapplybill b on a.fbillid = b.fbillid and a.findex = 1 
join fygl_expenseapply c on c.fbillno = a.fbillno_src*/