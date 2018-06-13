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

select  1 as no, '威海邦德散热系统股份有限公司' as item1,'' as item2,'' as item3,''as item4,''as item5,''as item6
union 
select  2 as no,'' as item1,'产 品 报' as item2,'价 单' as item3,''as item4,''as item5,''as item6
union
select  3 as no, '物料名称:' as item1,b.fname as item2,'公司产品型号:' as item3,b.fmodel as item4,'OEM编号:'as item5,''as item6 from t_BDSailPriceReport a join t_icitem b 
on a.fproditemid = b.fitemid
union 
select  4  as no,'项目' as item1,'费用（国内）' as item2,'单位比例' as item3,'项目' as item4,'费用（国外）'as item5,'成本费用标准'as item6
union 
select  5 as no,'名称及产品编号' as item1,'' as item2,'' as item3,'名称及产品编号'as item4,''as item5,''as item6
union 
select  6 as no,'材料成本 (每Kg)' as item1,'' as item2,'' as item3,'材料类型'as item4,''as item5,''as item6
union 
select  7 as no,'材料类型' as item1,'' as item2,'' as item3,'重量（Kg）'as item4,''as item5,''as item6
union 
select  8 as no,'重量（Kg）' as item1,'' as item2,'' as item3,'材料成本 (每公斤)'as item4,''as item5,''as item6
union 
select  9 as no,'材料成本 (每件)' as item1,'' as item2,'' as item3,'材料成本 (每件'as item4,''as item5,''as item6
union 
select  10 as no, '1.直接材料成本' as item1,'' as item2,'' as item3,'1.直接材料成本' as item4,''as item5,''as item6 
union
select  11 as no, '2.直接生产成本' as item1,'' as item2,'' as item3,'2.生产成本' as item4,''as item5,''as item6 
union 
select  12 as no, '     直接工资' as item1,'' as item2,'' as item3,'     直接工资' as item4,''as item5,''as item6 
union 
select  13 as no, '     制造费用' as item1,'' as item2,'' as item3,'     制造费用' as item4,''as item5,''as item6 
union 
select  14 as no, '厂房摊销' as item1,'0.1367' as item2,'' as item3,'厂房摊销' as item4,''as item5,'近12个月厂房折旧占直接人工的比例：13.67%'as item6 
union
select  15 as no, ' 1+2合  计' as item1,'' as item2,'' as item3,' 1+2合  计' as item4,''as item5,''as item6 
union 
select  16 as no, '3.期间成本' as item1,'' as item2,'' as item3,'3.期间成本' as item4,''as item5,''as item6 
union 
select  17 as no, '    成品不良成本' as item1,'' as item2,'' as item3,'    成品不良成本' as item4,''as item5,''as item6 
union 
select  18 as no, '    财务费用' as item1,'' as item2,'' as item3,'    财务费用' as item4,''as item5,'近12个月财务费用占营业成本的比例：2.03%'as item6 
union 
select  19 as no, '    销售费用（不含运费）' as item1,'' as item2,'' as item3,'    销售费用（不含运费）' as item4,''as item5,'近12个月销售费用占营业成本的比例：1.40%元'as item6 
union 
select  20 as no, '    管理费用' as item1,'' as item2,'' as item3,'    管理费用' as item4,''as item5,'近12个月管理费用占营业成本的比例：14.52%元'as item6 
union 
select  21 as no, '    运输费用' as item1,'' as item2,'国内报价为出厂价' as item3,'    运输费用' as item4,''as item5,'单只产品运达交货地点运费'as item6 
union 
select  22 as no, '4.产品利润' as item1,'0.3,4' as item2,'' as item3,'产品利润' as item4,''as item5,'按公司产成品的成本25%计提利润'as item6 
union 
select  23 as no, '5.不含税销售价(=1+2+3)' as item1,'' as item2,'' as item3,'5.销售价(=1+2+3+4)' as item4,''as item5,''as item6 
union 
select  24 as no, '   国内增值税（17%）' as item1,'' as item2,'' as item3,'' as item4,''as item5,''as item6 
union 
select  25 as no, '6.含税销售价：' as item1,'' as item2,'' as item3,'6.单价总计(不含税)' as item4,''as item5,''as item6 
union 
select  26 as no, '7.不含税销售价：' as item1,'' as item2,'' as item3,'美元价：' as item4,''as item5,'使用的汇率需根据市场实际行情作变动'as item6 
union 
select  27 as no, '有账期国内售价(含税）：' as item1,'60' as item2,'' as item3,'有账期国外售价（美元结算）FOB:' as item4,''as item5,'现贷款年利率：5%'as item6 
union 
select  28 as no, '有账期国内售价(不含税）：' as item1,'' as item2,'' as item3,'有账期国外售价（人民币结算）FOB：' as item4,''as item5,''as item6 
union 
select  29 as no, '国内报价（含税）:' as item1,'' as item2,'' as item3,'国外报价（美元结算）FOB:' as item4,''as item5,''as item6 
union 
select  30 as no, '国内报价（不含税）' as item1,'' as item2,'' as item3,'国外报价（人民币结算）FOB：' as item4,''as item5,''as item6 
union 
select  31 as no, '该产品本公司能够实现' as item1,'' as item2,'' as item3,'财务部制定' as item4,'销售审核'as item5,'总经理批准'as item6 
union 
select  32 as no, '本报价单有效期     月' as item1,'' as item2,'' as item3,'' as item4,''as item5,''as item6 