/*
 * 上海有色金属网铝锭期货价格 资料
 */
select fsqltablename,* from t_itemclass where fname like '上海有色金属网%'
select  fsqlcolumnname,fname,* from t_itempropdesc where fitemclassid = 3032

/*
 * 运费标准
 */
select fsqltablename,* from t_itemclass where fname like '运费标准%'
select fsqlcolumnname,fname,* from t_itempropdesc where fitemclassid = 3029

select * from t_item where  fitemclassid = 3029
--f_109 出货 条件 fitemid 物料内码
--f_106 税率 f_103 运费标准（含税） f_110 运费标准（不含税）
-- f_110=f_103/(1+f_106)
select f_109,* from t_item_3029 
/*
 * update t_item_3029 set f_110=round(f_103/(1+f_106) ,2)
 */
select f_125 from t_organization

select * from icclasstableinfo where fclasstypeid = 1007006 
order by fpage,ffieldname--fbase2 出货条件 fitemnumber 物料代码（内码）
--update icclasstableinfo set ffieldname='FAiFurPricShanghai' where fid = 26371 and fclasstypeid = 1007006 
--EXEC sp_rename 'porfq.AiFurPriceShanghai','FAiFurPriceShanghai','column'
select top 1 * from porfq





