--1 20161129�˻������۳��ⵥ���� ���۲����ֶ����ɵ��˻���
--����֪ͨ��

select b.fsourcebillno,a.fbillno
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013287';
select  u.fitemid,u.fauxprice,u.fprice,u.famount,u.fqty,* from 
 dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
  on v1.FInterID = u.FInterID   where   v1.fbillno = 'SEIN000813';
  --�޸ķ���֪ͨ�� ����
 update U set u.FPrice=case u.Fitemid when 53259 then 180 when 175890 then 165
 when 195296 then 175 when  228073 then 170 when 247298 then 175 when 51814 then 205 when 177844 then 240  end
 from  dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
 on v1.FInterID = u.FInterID /*and v1.FTranType = 82 */  where   v1.fbillno = 'SEIN000813' ;
  --�޸ĸ������ۡ����
 update U set u.FauxPrice=u.FPrice,u.FAmount = u.FPrice * u.FQty from  dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
 on v1.FInterID = u.FInterID /*and v1.FTranType = 82 */  where   v1.fbillno = 'SEIN000813';

 --2 20161125 ���۳��ⵥ
 --'xout013287'
select a.fbillno,b.fauxqty,b.FAuxPrice,b.famount,b.FEntrySelfB0161,b.FEntrySelfB0160 
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013287';

update b set b.fauxprice = case b.Fitemid when 53259 then 180 when 175890 then 165
 when 195296 then 175 when  228073 then 170 when 247298 then 175 when 51814 then 205 when 177844 then 240  end
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013287' 

--20161206 modify sale_price ,sale_amount
update b set FConsignPrice = FAuxPrice,FConsignAmount = FAuxQty * fauxprice ,
b.FEntrySelfB0161 = FAuxQty * fauxprice,b.FEntrySelfB0160 = FAuxPrice , b.FAmount = FAuxQty * fauxprice
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID  and a.FBillNo = 'xout013287';

select * from vwICBill_8 where FbillNo = 'xout013287';

--3 20161129  ���۷�Ʊ
 select a.fbillno,b.fitemid,b.fentryid,b.fqty,
--δ˰�۸�
b.fprice,b.fauxprice,
--δ˰���
 b.famount,B.FSTDAMOUNT,
--��˰�۸�
b.ftaxprice,b.fauxtaxprice,
--��˰���
B.FAMOUNTINCLUDETAX,B.FSTDAMOUNTINCLUDETAX,B.FPRICEDISCOUNT,B.FAUXPRICEDISCOUNT,B.FREMAINAMOUNTFOR,B.FREMAINAMOUNT,
--˰�� 
b.ftaxrate ,
--˰��
 b.ftaxamount,B.FSTDTAXAMOUNT
   from icsale a join icsaleentry b on a.finterid = b.finterid where a.FBillNo = 'ZSEFP001122';
 --���޸ĵ��� ftaxprice
 update b set b.ftaxprice = case fitemid when 53259 then 180 
 when 175890 then 165
 when 195296 then 175
  when 228073 then 170
  when 247298 then 175
  when 51814 then 205
  when 177844 then 240 end
 from icsale a join icsaleentry b on a.finterid = b.finterid 
 where a.FBillNo = 'ZSEFP001122' ;    
      
   update B     set 
 --δ˰�۸�
b.fprice = b.FTaxPrice/1.17,b.fauxprice  = b.FTaxPrice/1.17,
--δ˰���
 b.famount  = b.FTaxPrice/1.17*b.FQty ,B.FSTDAMOUNT = b.FTaxPrice/1.17*b.FQty,
--��˰�۸�
b.fauxtaxprice =  b.ftaxprice,
--��˰���
B.FAMOUNTINCLUDETAX = b.FTaxPrice * b.FQty,
B.FSTDAMOUNTINCLUDETAX  = b.FTaxPrice * b.FQty,
B.FPRICEDISCOUNT  = b.FTaxPrice ,
B.FAUXPRICEDISCOUNT  = b.FTaxPrice ,
B.FREMAINAMOUNTFOR  = b.FTaxPrice * b.FQty,
B.FREMAINAMOUNT  = b.FTaxPrice * b.FQty,
--˰�� b.ftaxrate ˰��
 b.ftaxamount = b.FTaxPrice / 1.17 * 0.17 * b.FQty,B.FSTDTAXAMOUNT = b.FTaxPrice / 1.17 * b.FQty  * 0.17
 from icsale a join icsaleentry b on a.finterid = b.finterid where a.FBillNo = 'ZSEFP001122';

 -------------another------
 --1 20161129�˻������۳��ⵥ���� ���۲����ֶ����ɵ��˻���
--����֪ͨ��

select b.fsourcebillno,a.fbillno
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo ='xout013291';
select  * from 
 dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
  on v1.FInterID = u.FInterID   where   v1.fbillno = 'SEOUT009021';
  --�޸ķ���֪ͨ�� ����
 update U set u.FPrice=case u.Fitemid when 53259 then 180 when 175890 then 165
 when 241032 then 175 when  243812 then 170 when 247298 then 175 when 51814 then 205 when 177844 then 240  end
 from  dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
 on v1.FInterID = u.FInterID /*and v1.FTranType = 82 */  where   v1.fbillno = 'SEOUT009021' ;
  --�޸ĸ������ۡ����
 update U set u.FauxPrice=u.FPrice,u.FAmount = u.FPrice * u.FQty from  dbo.SEOutStock AS v1 WITH (NOLOCK) LEFT OUTER JOIN dbo.SEOutStockEntry AS u
 on v1.FInterID = u.FInterID /*and v1.FTranType = 82 */  where   v1.fbillno = 'SEOUT009021';

 --2 20161125 ���۳��ⵥ
 --'xout013287'
select a.fbillno,b.fauxqty,b.FAuxPrice,b.famount,b.FEntrySelfB0161,b.FEntrySelfB0160 
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013287';

--xout013291 ��Ҫ���޸���������
select a.fbillno,b.fauxqty,b.FAuxPrice,b.famount,b.FEntrySelfB0161,b.FEntrySelfB0160 ,b.fconsignprice,b.FConsignAmount ,
b.fitemid
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291';
--�ȱ������
update  b set b.fauxprice = 180 ,b.FEntrySelfB0161 =1800,b.FEntrySelfB0160 = 180 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '53259';
update  b set b.fauxprice = 165 ,b.FEntrySelfB0161 =165*15,b.FEntrySelfB0160 = 165 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '175890';
update  b set b.fauxprice = 175 ,b.FEntrySelfB0161 =  175*5,b.FEntrySelfB0160 = 175 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '195296';
update  b set b.fauxprice = 170 ,b.FEntrySelfB0161 = 170*5,b.FEntrySelfB0160 =  170 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '228073';
update  b set b.fauxprice = 175 ,b.FEntrySelfB0161 =1750,b.FEntrySelfB0160 = 1750 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '247298';
update  b set b.fauxprice = 205 ,b.FEntrySelfB0161 =205*3,b.FEntrySelfB0160 = 205 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '51814';
update  b set b.fauxprice = 240 ,b.FEntrySelfB0161 = 240*10,b.FEntrySelfB0160 = 240 , b.FAmount = FAuxQty * fauxprice
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.FItemID = '177844';

select Famount,Fauxprice,fauxqty from vwICBill_8 where FbillNo = 'xout013291';
select c.fname,c.fitemid,c.FModel, a.fbillno,b.fauxqty,b.FAuxPrice,b.famount,b.FEntrySelfB0161,b.FEntrySelfB0160 
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
join t_ICItem c on b.FItemID = c.fitemid;
--����fitemid
select fitemid from t_ICItem where FModel ='NBD-PFA-1001334-YG'
--�޸�����
update  b set B.FITEMID = 195296 
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and b.fauxprice = 175 AND b.FEntrySelfB0161 =  175*5 AND b.FEntrySelfB0160 = 175*5;
update  b set B.FITEMID = 228073 
from ICstockbill a join icstockbillentry b on a.FInterID = b.FInterID and a.FbillNo = 'xout013291'
and  b.fauxprice = 170 AND b.FEntrySelfB0161 = 170*5 AND b.FEntrySelfB0160 =  170*5 ;
--20161206 modify sale_price ,sale_amount
update b set FConsignPrice = FAuxPrice,FConsignAmount = FAuxQty * fauxprice ,
b.FEntrySelfB0161 = FAuxQty * fauxprice,b.FEntrySelfB0160 = FAuxPrice , b.FAmount = FAuxQty * fauxprice
from ICStockBill a join ICStockBillEntry b on a.FInterID = b.FInterID  and a.FBillNo = 'xout013291';

select * from vwICBill_8 where FbillNo = 'xout013291';
--3 20161129  ���۷�Ʊ
 select a.fbillno,b.fitemid,b.fentryid,b.fqty,
--δ˰�۸�
b.fprice,b.fauxprice,
--δ˰���
 b.famount,B.FSTDAMOUNT,
--��˰�۸�
b.ftaxprice,b.fauxtaxprice,
--��˰���
B.FAMOUNTINCLUDETAX,B.FSTDAMOUNTINCLUDETAX,B.FPRICEDISCOUNT,B.FAUXPRICEDISCOUNT,B.FREMAINAMOUNTFOR,B.FREMAINAMOUNT,
--˰�� 
b.ftaxrate ,
--˰��
 b.ftaxamount,B.FSTDTAXAMOUNT
   from icsale a join icsaleentry b on a.finterid = b.finterid where a.FBillNo = 'ZSEFP001122';
 --���޸ĵ��� ftaxprice
 update b set b.ftaxprice = case fitemid when 53259 then 180 
 when 175890 then 165
 when 195296 then 175
  when 228073 then 170
  when 247298 then 175
  when 51814 then 205
  when 177844 then 240 end
 from icsale a join icsaleentry b on a.finterid = b.finterid 
 where a.FBillNo = 'ZSEFP001122' ;
   
   
   
   
   update B     set 
 --δ˰�۸�
b.fprice = b.FTaxPrice/1.17,b.fauxprice  = b.FTaxPrice/1.17,
--δ˰���
 b.famount  = b.FTaxPrice/1.17*b.FQty ,B.FSTDAMOUNT = b.FTaxPrice/1.17*b.FQty,
--��˰�۸�
b.fauxtaxprice =  b.ftaxprice,
--��˰���
B.FAMOUNTINCLUDETAX = b.FTaxPrice * b.FQty,
B.FSTDAMOUNTINCLUDETAX  = b.FTaxPrice * b.FQty,
B.FPRICEDISCOUNT  = b.FTaxPrice ,
B.FAUXPRICEDISCOUNT  = b.FTaxPrice ,
B.FREMAINAMOUNTFOR  = b.FTaxPrice * b.FQty,
B.FREMAINAMOUNT  = b.FTaxPrice * b.FQty,
--˰�� b.ftaxrate ˰��
 b.ftaxamount = b.FTaxPrice / 1.17 * 0.17 * b.FQty,B.FSTDTAXAMOUNT = b.FTaxPrice / 1.17 * b.FQty  * 0.17
 from icsale a join icsaleentry b on a.finterid = b.finterid where a.FBillNo = 'ZSEFP001122';