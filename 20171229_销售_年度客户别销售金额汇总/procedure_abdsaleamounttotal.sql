/* 
  * 
 * AUTHOR:		任波
 * DATA:		2017/12/28
 * DESCRIPTIONS:从销售出库取数,变更为从销售发票取数
 * 
 * AUTHOR:		任波
 * DATE:		2016/12/12
 * DESCRIPTIONS:销售金额年度按月别汇总
 */
Alter PROCEDURE dbo.aBdSaleAmountTotal(	@year varchar(4),@customer varchar(1) ,@product varchar(1))
AS
BEGIN
	SET NOCOUNT ON
--  declare @year varchar(4)
    if @year='' or (select isnull(@year,'aa')) = 'aa'
    BEGIN
    select @year = year(GETDATE())
    END

 select y.fnumber,y.fname,m.fname as region,SUM(m1) as m1 ,sum(m2) as m2 ,sum(m3) as m3 ,sum(m4) as m4 ,sum(m5) as m5,sum(m6) as m6 ,
 sum(m7) as m7 ,sum(m8) as m8 , sum(m9) as m9 ,sum(m10) as m10 ,sum(m11) as m11 ,sum(m12)  as m12
 ,sum(m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12) as allyear
 from ( 
 		select a.fcustid,SUM(isnull(b.fstdamount,0)) as m1 ,
 		0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 1 and YEAR(a.fcheckdate)=@year
		group by a.fcustid
		union all 
		select a.fcustid,0 as m1,SUM(isnull(b.fstdamount,0)) as m2 ,
 		0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 2 and YEAR(a.fcheckdate)=@year
		group by a.fcustid
		union all
		select a.fcustid,0 as m1,0 as m2,SUM(isnull(b.fstdamount,0)) as m3 ,
 		0 as m4,0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 3 and YEAR(a.fcheckdate)=@year
		group by a.fcustid union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,SUM(isnull(b.fstdamount,0)) as m4  ,
		0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 4 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,0 as m4,
		SUM(isnull(b.fstdamount,0)) as m5 ,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 5 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,0 as m4,0 as m5,
		SUM(isnull(b.fstdamount,0)) as m6  ,0 as m7,
		 0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 6 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,
		sUM(isnull(b.fstdamount,0)) as m7  ,
		 0 as m8,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 7 and YEAR(a.fcheckdate)=@year
		group by a.fcustid
 		union all 
		select a.fcustid, 0 as m1, 0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
 		SUM(isnull(b.fstdamount,0)) as m8  ,0 as m9,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 8 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7, 0 as m8,
		SUM(isnull(b.fstdamount,0)) as m9  ,0 as m10,0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 9 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid,0 as m1, 0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
		0 as m8,0 as m9,SUM(isnull(b.fstdamount,0)) as m10 ,
 		0 as m11,0 as m12
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 10 and YEAR(a.fcheckdate)=@year
		group by a.fcustid
 		union all 
		select a.fcustid,0 as m1,
 		0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,SUM(isnull(b.fstdamount,0)) as m11 ,0 as m12 
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 11 and YEAR(a.fcheckdate)=@year
		group by a.fcustid 
		union all 
		select a.fcustid, 0 as m1,
 		0 as m2,0 as m3,0 as m4,0 as m5,0 as m6,0 as m7,
 		0 as m8,0 as m9,0 as m10,0 as m11,SUM(isnull(b.fstdamount,0)) as m12 
		from icsale a join Icsaleentry b on a.FInterID = b.FInterID and (a.ftrantype = 86 or a.ftrantype = 80 )
		and MONTH(a.fcheckdate) = 12 and YEAR(a.fcheckdate)=@year
		group by a.fcustid
     ) x
join  t_Organization y on x.Fcustid = y.fitemid
left join t_submessage m on y.fregionid = m.finterid
group by y.fnumber,y.fname,m.fname 
order by allyear desc

END
