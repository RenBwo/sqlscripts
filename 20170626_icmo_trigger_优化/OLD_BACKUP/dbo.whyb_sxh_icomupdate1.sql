CREATE trigger [dbo].[whyb_sxh_icomupdate1] on [dbo].[ICMO]
for insert
as 
begin

DECLARE 
@FINTERID	INT,
@FHeadSelfJ0192 VARCHAR(50),
@FHeadSelfJ0193 VARCHAR(50),
@FHeadSelfJ0194 VARCHAR(50);
select @finterid=finterid from inserted
select @FHeadSelfJ0192=t4.FMapNumber,@FHeadSelfJ0193=t4.FMapName,@FHeadSelfJ0194=t5.FNote
from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
inner join T_Organization t3 on t1.FHeadSelfJ0188=t3.FNumber
inner join  ICItemMapping t4 on t4.FCompanyID=t3.FItemID and t4.FItemID=t2.FItemID
inner join ICPrcPlyEntry t5 on t5.FRelatedID=t3.FItemID and t5.FItemID=t2.FItemID
where t2.FNumber like '01.%' and t4.FID=4 and t4.FPropertyID =1  and t5.FInterID=4 and t1.finterid = @finterid

update ICMO set FHeadSelfJ0192=@FHeadSelfJ0192
,FHeadSelfJ0193=@FHeadSelfJ0193,FHeadSelfJ0194=@FHeadSelfJ0194
where FInterID=@FINTERID 




end