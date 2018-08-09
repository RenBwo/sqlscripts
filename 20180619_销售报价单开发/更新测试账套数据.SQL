--F_171	RMB产品控制利润率 
-- F_175	USD产品控制利润率%
-- F_172	本型号历史销售数量
update ais20161026113020.dbo.t_icitemcustom set  f_171=b.f_171
,f_172=b.f_172,f_175=b.f_175
from ais20161026113020.dbo.t_icitemcustom a 
join ais20091217151735.dbo.t_icitemcustom b on a.fitemid = b.fitemid
--F_115	返点%,F_116	标准利润率%,F_121	质量赔偿金折扣率%（批量事故除外）
--F_122	应收款账期,F_123	木托盘缠绕膜成本（元）f_125 出货条件
--	update t_organization set f_122 = (case
 		when b.ffststdate=0 and b.foptmode=0 then isnull(b.fday,0)
  		else isnull(b.fday,0)+15 end)
	from t_organization a join t_paycolconditionentry b on a.fpaycondition = b.fid
--	 and b.foptmode  =0	 
	update ais20161026113020.dbo.t_organization set f_115 = b.f_115
	 ,f_116= b.f_116
	 ,f_121= b.f_121
	 ,f_122= b.f_122
	 ,f_123= b.f_123
	 ,f_125= b.f_124
	 from ais20161026113020.dbo.t_organization a
	 join ais20091217151735.dbo.t_organization b on a.fitemid = b.fitemid
	 
	 select * from icclasstype where fname_chs like '%销售报价%'
	 select * from icclasstableinfo_bak where  fclasstypeid = 1007006 and fpage = 1 order by fid 
	 delete from icclasstableinfo where fclasstypeid = 1007006 and fpage=1 and fid >25261
insert into icclasstableinfo(fclasstypeid,fpage,fcaption_chs,fcaption_cht,fcaption_en
,fkey,ffieldname,ftablename,flistindex,flistclassname,fvisible,fenable,fneedsave,fmustinput
,fctltype,flookuptype,flookupclassid,flookuplist,fsrcfieldname,fsrctablename,fdspfieldname
,ffndfieldname,fvaluelocation,ffilter,ffiltergroup,fvaluetype,fdspcoltype,feditlen,fvalueprecision
,fsaverule,fdefvalue,faction,fuserdefine,fleft,ftop,fheight,fwidth,fcondition,ftabindex,flock
,fsum,fprec,fscale,flayer,floadaction,funcontrol,fsourcetype,fconditionext,fframeborder
,fframebordercolor,flabelwidth,flabelcolor,ftextcolor,fisF7,Fstyle)
select fclasstypeid,fpage,fcaption_chs,fcaption_cht,fcaption_en
,fkey,ffieldname,ftablename,flistindex,flistclassname,fvisible,fenable,fneedsave,fmustinput
,fctltype,flookuptype,flookupclassid,flookuplist,fsrcfieldname,fsrctablename,fdspfieldname
,ffndfieldname,fvaluelocation,ffilter,ffiltergroup,fvaluetype,fdspcoltype,feditlen,fvalueprecision
,fsaverule,fdefvalue,faction,fuserdefine,fleft,ftop,fheight,fwidth,fcondition,ftabindex,flock
,fsum,fprec,fscale,flayer,floadaction,funcontrol,fsourcetype,fconditionext,fframeborder
,fframebordercolor,flabelwidth,flabelcolor,ftextcolor,fisF7,Fstyle
from icclasstableinfo_bak where  fclasstypeid = 1007006 and fpage = 1 and fid >25261.

select top 1 * from porfq

select top 20 f_125,* from t_Organization t3 
left join t_submessage t4 on t3.f_125 = t4.fid
select * from t_submessage where finterid = 41555



