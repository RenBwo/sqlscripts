/*truncate table t_BDSailPriceReport
select * from t_BDSailPriceReport
select count(*) from sysobjects where type = 'u' and name like 't_BDSailPriceReport';
select max(fbillno) from t_BDSailPriceReport
insert into t_BDSailPriceReport(fproditemid) values( 292209 );

select finterid,fproditemid,* from t_CostMaterialBD 
select finterid,fproditemid,*  from t_BDSailPriceReport
select finterid,fproditemid,* from  t_BDLabourAndMake;

drop table  t_CostMaterialBD , t_BDSailPriceReport,t_BDLabourAndMake;
select Fnumber,assyname,fQty,fopername,fpiecerate,frate, fmakeqty,insull(amtpay,0),insull(amtassure,0),insull(costworker,0),insull(fmatpower,0),insull(fdepr,0),insull(famtadi,0),insull(famtmodel,0)  from t_BDLabourAndMake  where fproditemid = 292209 and finterid = 201700001 order by fnumber,fopersn;
*/--select  '' as item1,'' as item2,'' as item3,''as item4,''as item5,''as item6

select  1 as no, '�������ɢ��ϵͳ�ɷ����޹�˾' as item1,'' as item2,'' as item3,''as item4,''as item5,''as item6
union 
select  2 as no,'' as item1,'�� Ʒ ��' as item2,'�� ��' as item3,''as item4,''as item5,''as item6
union
select  3 as no, '��������:' as item1,b.fname as item2,'��˾��Ʒ�ͺ�:' as item3,b.fmodel as item4,'OEM���:'as item5,''as item6 from t_BDSailPriceReport a join t_icitem b 
on a.fproditemid = b.fitemid
union 
select  4  as no,'��Ŀ' as item1,'���ã����ڣ�' as item2,'��λ����' as item3,'��Ŀ' as item4,'���ã����⣩'as item5,'�ɱ����ñ�׼'as item6
union 
select  5 as no,'���Ƽ���Ʒ���' as item1,'' as item2,'' as item3,'���Ƽ���Ʒ���'as item4,''as item5,''as item6
union 
select  6 as no,'���ϳɱ� (ÿKg)' as item1,'' as item2,'' as item3,'��������'as item4,''as item5,''as item6
union 
select  7 as no,'��������' as item1,'' as item2,'' as item3,'������Kg��'as item4,''as item5,''as item6
union 
select  8 as no,'������Kg��' as item1,'' as item2,'' as item3,'���ϳɱ� (ÿ����)'as item4,''as item5,''as item6
union 
select  9 as no,'���ϳɱ� (ÿ��)' as item1,'' as item2,'' as item3,'���ϳɱ� (ÿ��'as item4,''as item5,''as item6
union 
select  10 as no, '1.ֱ�Ӳ��ϳɱ�' as item1,'' as item2,'' as item3,'1.ֱ�Ӳ��ϳɱ�' as item4,''as item5,''as item6 
union
select  11 as no, '2.ֱ�������ɱ�' as item1,'' as item2,'' as item3,'2.�����ɱ�' as item4,''as item5,''as item6 
union 
select  12 as no, '     ֱ�ӹ���' as item1,'' as item2,'' as item3,'     ֱ�ӹ���' as item4,''as item5,''as item6 
union 
select  13 as no, '     �������' as item1,'' as item2,'' as item3,'     �������' as item4,''as item5,''as item6 
union 
select  14 as no, '����̯��' as item1,'0.1367' as item2,'' as item3,'����̯��' as item4,''as item5,'��12���³����۾�ռֱ���˹��ı�����13.67%'as item6 
union
select  15 as no, ' 1+2��  ��' as item1,'' as item2,'' as item3,' 1+2��  ��' as item4,''as item5,''as item6 
union 
select  16 as no, '3.�ڼ�ɱ�' as item1,'' as item2,'' as item3,'3.�ڼ�ɱ�' as item4,''as item5,''as item6 
union 
select  17 as no, '    ��Ʒ�����ɱ�' as item1,'' as item2,'' as item3,'    ��Ʒ�����ɱ�' as item4,''as item5,''as item6 
union 
select  18 as no, '    �������' as item1,'' as item2,'' as item3,'    �������' as item4,''as item5,'��12���²������ռӪҵ�ɱ��ı�����2.03%'as item6 
union 
select  19 as no, '    ���۷��ã������˷ѣ�' as item1,'' as item2,'' as item3,'    ���۷��ã������˷ѣ�' as item4,''as item5,'��12�������۷���ռӪҵ�ɱ��ı�����1.40%Ԫ'as item6 
union 
select  20 as no, '    �������' as item1,'' as item2,'' as item3,'    �������' as item4,''as item5,'��12���¹������ռӪҵ�ɱ��ı�����14.52%Ԫ'as item6 
union 
select  21 as no, '    �������' as item1,'' as item2,'���ڱ���Ϊ������' as item3,'    �������' as item4,''as item5,'��ֻ��Ʒ�˴ｻ���ص��˷�'as item6 
union 
select  22 as no, '4.��Ʒ����' as item1,'0.3,4' as item2,'' as item3,'��Ʒ����' as item4,''as item5,'����˾����Ʒ�ĳɱ�25%��������'as item6 
union 
select  23 as no, '5.����˰���ۼ�(=1+2+3)' as item1,'' as item2,'' as item3,'5.���ۼ�(=1+2+3+4)' as item4,''as item5,''as item6 
union 
select  24 as no, '   ������ֵ˰��17%��' as item1,'' as item2,'' as item3,'' as item4,''as item5,''as item6 
union 
select  25 as no, '6.��˰���ۼۣ�' as item1,'' as item2,'' as item3,'6.�����ܼ�(����˰)' as item4,''as item5,''as item6 
union 
select  26 as no, '7.����˰���ۼۣ�' as item1,'' as item2,'' as item3,'��Ԫ�ۣ�' as item4,''as item5,'ʹ�õĻ���������г�ʵ���������䶯'as item6 
union 
select  27 as no, '�����ڹ����ۼ�(��˰����' as item1,'60' as item2,'' as item3,'�����ڹ����ۼۣ���Ԫ���㣩FOB:' as item4,''as item5,'�ִ��������ʣ�5%'as item6 
union 
select  28 as no, '�����ڹ����ۼ�(����˰����' as item1,'' as item2,'' as item3,'�����ڹ����ۼۣ�����ҽ��㣩FOB��' as item4,''as item5,''as item6 
union 
select  29 as no, '���ڱ��ۣ���˰��:' as item1,'' as item2,'' as item3,'���ⱨ�ۣ���Ԫ���㣩FOB:' as item4,''as item5,''as item6 
union 
select  30 as no, '���ڱ��ۣ�����˰��' as item1,'' as item2,'' as item3,'���ⱨ�ۣ�����ҽ��㣩FOB��' as item4,''as item5,''as item6 
union 
select  31 as no, '�ò�Ʒ����˾�ܹ�ʵ��' as item1,'' as item2,'' as item3,'�����ƶ�' as item4,'�������'as item5,'�ܾ�����׼'as item6 
union 
select  32 as no, '�����۵���Ч��     ��' as item1,'' as item2,'' as item3,'' as item4,''as item5,''as item6 