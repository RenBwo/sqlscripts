----�������� ����·��ѡ������ˣ���Ҫ�޸����������еĹ���·��
SELECT B.FNumber ,B.FName ,A.FBillNo ,A.FRoutingID,* FROM ICMO A
INNER JOIN t_ICItem B ON A.FItemID =B.FItemID 
WHERE  FHeadSelfJ0184='1410-446'
AND B.FNumber LIKE '13.%'

SELECT * FROM T_Routing WHERE FInterID =1146

select * from t_Routing a
inner join t_ICItem b on a.FItemID =b.FItemID 
where b.FNumber ='13.01.00.0620-Y'

begin tran
update ICMO 
set FRoutingID =3762
where FInterID in(332893,
326029,
332894)

rollback
commit;
-----------�޸����


---�������޸Ĺ�������(ERP��ȷ��ʵ����ΰ��չ��˻㱨�������´ΰ�ERP��������)
SELECT FEntrySelfz0374,FEntrySelfz0376,FOperID,FOperSN,* FROM SHWorkBillEntry WHERE FWorkBillNO='WB023115'

SELECT * FROM  t_SubMessage WHERE FParentID =61

BEGIN TRAN
UPDATE SHWorkBillEntry 
--set FEntrySelfz0374='1410-454'
SET FEntrySelfz0376=1.0,FEntrySelfz0375=1.0
WHERE FWorkBillNO='WB023115'

ROLLBACK
COMMIT;


--�޸Ĺ���ƻ������Զ��ɹ�  �Զ���ת �� '�� 1059'  ��Ϊ '�� 1058'
BEGIN TRAN
UPDATE SHWorkBillEntry
SET FAutoOF=1058,FAutoTD=1058
FROM SHWorkBillEntry 
where FWorkBillNO ='WB021739'

ROLLBACK
COMMIT;

--- �޸Ĺ���ƻ����й�������
BEGIN TRAN
--����ƻ���
UPDATE SHWorkBillEntry
SET FOperID=40358
FROM SHWorkBillEntry 
where FWorkBillNO ='WB014185'

---����㱨
UPDATE SHProcRpt
SET FOperID =40358
WHERE FinterID =7354 AND FEntryID=1

UPDATE SHProcRptMain
SET FOperID=40358
WHERE FInterID =7354

--�ɹ���
UPDATE ICTaskDispBill 
SET FOperID=40358
WHERE FInterID =13791
--��ʱ�Ƽ�����
UPDATE ICJobPayEntry 
SET FOperID =40358
WHERE FInterID =2053 AND FEntrySelfR0134='1410-446'

ROLLBACK
COMMIT;

---���ӹ����������Ͳ����������޷�����
begin tran
update SHWorkBillEntry 
set FWorkerID=378---����
where FWorkBillNO ='WB055683'   ---����ƻ�����

rollback
commit;

---  ����ƻ����н�����㱨ɾ�����ƽ�������Ϊ��Ĵ�����ʽ���� 
---������ת����1��������  ��Ҫɾ��
select * from ICOperShift where FBillNo ='ZY080488'

BEGIN TRAN
UPDATE  ICOperShift 
SET FStatus=0
where FBillNo ='ZY080488'

ROLLBACK
COMMIT;


---���Ĺ���ƻ����й���ϵ���͹�������(�е�����ģ�

SELECT a.FWBInterID ,a.FinterID ,A.FEntrySelfz0374,C.FHeadSelfJ0184,C.FBomInterID
    ,  e.FEntrySelfZ0236 as ����·�߹���ϵ��
    ,  e.FEntrySelfZ0237 as ����·�߹�������
    ,  e.FPieceRate		 as ����·�ߵ�λ�Ƽ�����
	,  a.FEntrySelfz0375 as ����ƻ�������ϵ��
	,  a.FEntrySelfz0376 as ����ƻ�����������
	,  a.FPieceRate   as  ����ƻ�����λ�Ƽ�����
	,  a.FWorkBillNO,E.FOperID ,F.FName 
	, A.FOperSN,a.FitemID , e2.FBillNo,e.FOperSN,a.FOperSN, e.FOperID, a.FOperID	
FROM SHWorkBillEntry A
INNER JOIN SHWorkBill B ON A.FinterID =B.FInterID 
INNER JOIN ICMO C ON C.FInterID =B.FICMOInterID 
INNER JOIN ICBOM D ON D.FInterID =C.FBomInterID and D.FUseStatus=1072 and D.FStatus =1 
INNER JOIN T_RoutingOper e on e.FInterID =d.FRoutingID AND E.FOperID =A.FOperID
INNER JOIN T_routing e2 on e.FInterID =e2.FInterID 
left outer JOIN t_SubMessage F ON F.FInterID =A.FOperID and f.FParentID =61
INNER JOIN t_ICItem G ON G.FItemID = B.FitemID 
WHERE --(A.FEntrySelfz0375=0 OR A.FEntrySelfz0376=0)
  --and 
  a.FEntrySelfz0374='1410-446'  AND
  --a.FEntrySelfz0374='1410-170' and 
 (isnull(a.FEntrySelfz0375,0)<>isnull(e.FEntrySelfZ0236,0) or isnull(a.FEntrySelfz0376,0)<>isnull(e.FEntrySelfZ0237,0)
  or ISNULL(e.FPieceRate,0)<>ISNULL(a.FPieceRate,0) )
order by a.FinterID , A.FOperSN



begin tran
update SHWorkBillEntry 
set FEntrySelfz0375=a.FEntrySelfZ0236,FEntrySelfz0376=a.FEntrySelfZ0237
   --, FPieceRate =a.FPieceRate
from (SELECT a.FWBInterID ,e.FEntrySelfZ0236,e.FEntrySelfZ0237, --e.FPieceRate ,
      A.FOperSN
FROM SHWorkBillEntry A
INNER JOIN SHWorkBill B ON A.FinterID =B.FInterID 
INNER JOIN ICMO C ON C.FInterID =B.FICMOInterID 
INNER JOIN ICBOM D ON D.FInterID =C.FBomInterID 
INNER JOIN T_RoutingOper e on e.FInterID =d.FRoutingID AND E.FOperID =A.FOperID
left outer JOIN t_SubMessage F ON F.FInterID =A.FOperID and f.FParentID =61
WHERE --(A.FEntrySelfz0375=0 OR A.FEntrySelfz0376=0)
  --and a.FEntrySelfz0374='1410-259' and  
  a.FEntrySelfz0374='1410-446' and 
  (isnull(a.FEntrySelfz0375,0)<>isnull(e.FEntrySelfZ0236,0) or isnull(a.FEntrySelfz0376,0)<>isnull(e.FEntrySelfZ0237,0))
--order by a.FinterID , A.FOperSN
) a
inner join SHWorkBillEntry b on a.FWBInterID =b.FWBInterID

rollback
commit;



---���Ĺ���㱨�еĹ���ϵ���͹�������(�е������)
select a.FEntryIndex,b.FBillNo ,a.FEntrySelfY5235,a.FEntrySelfY5236 as ����㱨����ϵ��
     , a.FEntrySelfY5238 AS ����㱨��������
     , c.FEntrySelfz0374, c.FEntrySelfz0375 as ����ƻ�������ϵ�� 
     , c.FEntrySelfz0376 AS ����ƻ�����������
     , f.FName 
 from SHProcRpt a
inner join SHProcRptMain b on a.FinterID =b.FInterID 
inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  
inner JOIN t_SubMessage F ON F.FInterID =c.FOperID and f.FParentID =61
where --(a.FEntrySelfY5236=0 or a.FEntrySelfY5238=0)
  --and 
  a.FEntrySelfY5235='1410-446' and 
  (isnull(a.FEntrySelfY5236,0)<>isnull(c.FEntrySelfz0375,0) or isnull(a.FEntrySelfY5238,0)<>isnull(c.FEntrySelfz0376,0))



begin tran
update SHProcRpt 
set FEntrySelfY5236=a.FEntrySelfz0375,FEntrySelfY5238=a.FEntrySelfz0376
from (select a.FEntryIndex,c.FEntrySelfz0375,c.FEntrySelfz0376
 from SHProcRpt a
inner join SHProcRptMain b on a.FinterID =b.FInterID 
inner join SHWorkBillEntry c on c.FWBInterID =b.FWBInterID  
where --(a.FEntrySelfY5236=0 or a.FEntrySelfY5238=0)
    --and 
    a.FEntrySelfY5235='1410-446' and 
    (isnull(a.FEntrySelfY5236,0)<>isnull(c.FEntrySelfz0375,0) or isnull(a.FEntrySelfY5238,0)<>isnull(c.FEntrySelfz0376,0))
) a
inner join SHProcRpt  b on a.FEntryIndex =b.FEntryIndex

rollback
commit;


---���Ĺ���㱨  ���޵Ĺ������� ����1
select B.* from SHProcRptMain A
INNER JOIN SHProcRpt B ON A.FInterID =B.FinterID 
where A.FBillNo ='GXHB000392'

BEGIN TRAN
UPDATE SHProcRpt 
SET FEntrySelfY5238=1
WHERE FinterID =1300

ROLLBACK
COMMIT;



---�Ƽ���������  �޸�
select c.FBillNo ,a.FEntrySelfR0134,a.FEntrySelfR0133 as �Ƽ������й���ϵ��, a.FEntrySelfR0135 AS �Ƽ������еĹ�������
     , b.FEntrySelfY5235, b.FEntrySelfY5236 as ����㱨�й���ϵ��, B.FEntrySelfY5238 AS ����㱨�й�������
     , d.FBillNo , a.FWorkAuxQty , A.FAuxPieceRate 
     , a.FJobPay,  A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty as a1
	 , a.FAmount,  A.FAuxPieceRate * b.FEntrySelfY5236 * b.FEntrySelfY5238 * A.FWorkAuxQty +A.FHourPay as a2
	, e.FName --,f.FName 
	, a.FDate , a.FWBNO 
   from ICJobPayEntry a
   inner join ICJobPay c on a.FInterID =c.FInterID 
inner join SHProcRpt b on a.FProcRptInterID=b.FinterID AND B.FEntryID=A.FProcRptEntryID
inner join SHProcRptMain d on b.FinterID =d.FInterID 
inner join t_SubMessage e ON e.FInterID =A.FOperID and e.FParentID =61
--left outer join t_Emp  f on f.FItemID = a.FWorkerID
where (isnull(a.FEntrySelfR0133,0)<>isnull(b.FEntrySelfY5236,0) or isnull(a.FEntrySelfR0135,0)<>isnull(b.FEntrySelfY5238,0))
  and a.FEntrySelfR0134='1410-446' 
order by a.fdate,a.FEntrySelfR0134,a.FOperSN


begin tran
update ICJobPayEntry
set FEntrySelfR0133=FEntrySelfY5236,FEntrySelfR0135=FEntrySelfY5238
  , FJobPay=FAuxPieceRate * a.FEntrySelfY5236 * a.FEntrySelfY5238 * FWorkAuxQty
  , FAmount=FAuxPieceRate * a.FEntrySelfY5236 * a.FEntrySelfY5238 * FWorkAuxQty +FHourPay
from (
	select a.FInterID,a.FEntryID, b.FEntrySelfY5235, b.FEntrySelfY5236 , B.FEntrySelfY5238 
	  from ICJobPayEntry a
      inner join ICJobPay c on a.FInterID =c.FInterID 
	  inner join SHProcRpt b on a.FProcRptInterID=b.FinterID  AND B.FEntryID=A.FProcRptEntryID
	  where (isnull(a.FEntrySelfR0133,0)<>isnull(b.FEntrySelfY5236,0) or isnull(a.FEntrySelfR0135,0)<>isnull(b.FEntrySelfY5238,0))
	   and a.FEntrySelfR0134='1410-446' --AND C.FBillNo ='WAGE000566'
	) a
inner join ICJobPayEntry b on a.FInterID =b.FInterID and a.FEntryID=b.FEntryID 

rollback
commit;
