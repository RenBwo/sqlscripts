CREATE trigger [dbo].[lwm_GZLH] on [dbo].[ICMO] 
after insert
as 
if (select FParentInterID from inserted ) is not null

return 
if (select foRDErinterid from inserted) is null
return
declare @aa int --订单
declare @bb int --行号
declare @cc int --统计
declare @ll nvarchar(30)--令号  ---修改者YangYuan 2015-06-03 
declare @xx	nvarchar(30)--编号  ---修改者YangYuan 2015-06-03
--select @aa = 1136 ,@bb=1
select @aa=isnull(FOrderInterid ,0),@bb=isnull(FSourceEntryid,0) from inserted
if @aa = 0 
begin 
return
end 
select @ll=b.FEntrySelfS0160 from SeOrder a inner join SeOrderEntry b on a.finterid=b.Finterid and a.finterid =@aa and b.Fentryid=@bb
select @cc=count(*)-1 from icmo where FOrderInterid=@aa and FSourceEntryid = @bb

 
select @xx=case when @cc=0 then @ll else @ll+'_'+cast (@cc as varchar(3)) end 
update a set a.fbillno =@xx from icmo a where FOrderInterid=@aa and FSourceEntryid = @bb and finterid=(select finterid from inserted)




--select * from  ICMrpResult   where FBIllNo = 'PL2298562'