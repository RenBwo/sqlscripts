/* 
 * AUTHOR:		任波
 * DATA:		2017/12/29
 * DESCRIPTIONS:产品类型进行月别汇总功能
 */
create PROCEDURE dbo.aBdSaleAmtTolByProd(	@year varchar(4))
AS
BEGIN
	SET NOCOUNT ON
	-- declare @year varchar(4)
    if @year='' or (select isnull(@year,'aa')) = 'aa'
    BEGIN
    select @year = year(GETDATE())
    END

 select  (case 	when y.fname like '%冷凝器%'  then '冷凝器'  
 				when y.fname like '%油冷器%'  then '油冷器'  
 				when y.fname like '%集流管%'  then '集流管'  
 				else '其它' 									end) as producttype
 ,sum(q1) as q1,SUM(m1) as m1 ,sum(q2) as q2,sum(m2) as m2 ,sum(q3) as q3,sum(m3) as m3 
 ,sum(q4) as q4,sum(m4) as m4 ,sum(q5) as q5,sum(m5) as m5 ,sum(q6) as q6,sum(m6) as m6
 ,sum(q7) as q7,sum(m7) as m7 ,sum(q8) as q8,sum(m8) as m8 ,sum(q9) as q9,sum(m9) as m9 
 ,sum(q10) as q10,sum(m10) as m10 ,sum(q11) as q11,sum(m11) as m11 ,sum(q12) as q12,sum(m12)  as m12
 ,sum(q1+q2+q3+q4+q5+q6+q7+q8+q9+q10+q11+q12) as qtyallyear
 ,sum(m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12) as amtallyear
 from ( 
 		select b.Fitemid,sum(b.fqty) as q1,SUM(isnull(b.fstdamount,0)) as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 1 and YEAR(a.fcheckdate)=@year
		group by b.fitemid
		union all 
		select b.fitemid, 0   as q1,0 as m1 
 		,sum(b.fqty) as q2,SUM(isnull(b.fstdamount,0)) as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 2 and YEAR(a.fcheckdate)=@year
		group by b.fitemid
		union all
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,sum(b.fqty) as q3,SUM(isnull(b.fstdamount,0)) as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 3 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,sum(b.fqty)as q4,SUM(isnull(b.fstdamount,0)) as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 4 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,sum(b.fqty) as q5,SUM(isnull(b.fstdamount,0)) as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 5 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,sum(b.fqty)as q6,SUM(isnull(b.fstdamount,0)) as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 6 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,sum(b.fqty) as q7,SUM(isnull(b.fstdamount,0)) as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 7 and YEAR(a.fcheckdate)=@year
		group by b.fitemid
 		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,sum(b.fqty) as q8
 		,SUM(isnull(b.fstdamount,0)) as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 8 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,sum(b.fqty) as q9,SUM(isnull(b.fstdamount,0)) as m9,0 as q10,0 as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 9 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,sum(b.fqty) as q10,SUM(isnull(b.fstdamount,0)) as m10,0 as q11,0 as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 10 and YEAR(a.fcheckdate)=@year
		group by b.fitemid
 		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,sum(b.fqty) as q11,SUM(isnull(b.fstdamount,0)) as m11,0 as q12,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 11 and YEAR(a.fcheckdate)=@year
		group by b.fitemid 
		union all 
		select b.fitemid,0 as q1,0 as m1 
 		,0 as q2,0 as m2,0 as q3,0 as m3,0 as q4,0 as m4,0 as q5,0 as m5,0 as q6,0 as m6,0 as q7,0 as m7,0 as q8
 		,0 as m8,0 as q9,0 as m9,0 as q10,0 as m10,0 as q11,0 as m11,sum(b.fqty) as q12,SUM(isnull(b.fstdamount,0)) as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 12 and YEAR(a.fcheckdate)=@year
		group by b.fitemid
     ) x
join  t_icitem y on x.Fitemid = y.fitemid 
group by (case 	when y.fname like '%冷凝器%'  then '冷凝器'  
 				when y.fname like '%油冷器%'  then '油冷器'  
 				when y.fname like '%集流管%'  then '集流管'  
 				else '其它' 									end)

END

