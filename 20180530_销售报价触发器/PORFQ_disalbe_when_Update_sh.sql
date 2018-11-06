/* DATA:		2018/10/31
 * AUTHOR:		RENBO
 * DESCRIPTION:	升级期间禁止使用
 * drop trigger PORFQ_DISABLE_WHEN_UPDATE
 */
ALTER TRIGGER [dbo].[PORFQ_DISABLE_WHEN_UPDATE] 	ON [dbo].[PORFQ]
INSTEAD OF INSERT, UPDATE
AS 
BEGIN
	IF ((select count(*) from inserted ) > 0
	and (select case when getdate()>'2018-11-01 15:00:00' 
	then 1 else 0 end)=1 
	and (select case when getdate()<'2018-11-01 20:00:00' 
	then 1 else 0 end)=1)
	begin
	raiserror(N'2018-11-01 15:00:00 ~~ 20:00:00,销售报价单进行升级,暂时无法使用',18,1) 
	return
	end
END
