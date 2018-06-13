CREATE PROCEDURE GetICMaxNum
    @TableName VARCHAR (50),  
    @FInterID  int output,    
    @Increment INT = 1 ,   
    @UserID    int =0 ---�����û�ID    
as    
    set nocount on  
    declare @FNumber int  
    declare @Sql     nvarchar(4000)  
    declare @i int  
--���ò���
    declare @iStep int
    if @TableName='T_Item'
        select @iStep=1
    else
        select @iStep=2
    select @FinterID=-1 
    --����û�ID����0�������ϵĴ洢����ȡ����ţ������Ż���������ϵͳ��    
    IF  @UserID=0  
    BEGIN  
	 exec GetICMaxNumOld @TableName, @FInterID output,@Increment  
	 return @FInterID  
    END     
    set @FNumber=0  
    set @i=1  
    set @Sql='' 
 
   UPDATE ICMaxNum SET FMaxNum = FMaxNum WHERE FTableName = @TableName 
    select top 1 @FNumber=Isnull(FNumber,0) From  IC_MaxNum where FUserID=@UserID and FFlag=0 and FTableName=@TableName order by FNumber  
  
    --���Ϊ0��ʾ��ǰ����δ�����¼����Ҫ���·���  
    if @FNumber=0  
    begin  
   
 select @FInterID=isnull(FMaxNum,0)
 from ICMaxNum    
 where FTableName= @TableName    
 if @FInterID >0    
 begin    
  begin transaction    
  --��������  
   set @Sql=@Sql+'Update ICMaxNum set FMaxNum=FMaxNum+'+str(@iStep)+' where FTableName='''+ @TableName+''' '    
  set @Sql=@Sql+' Delete from  IC_MaxNum  where FTableName='''+ @TableName +''' and  FUserID='+str(ltrim(@UserID))+' and FFlag=1'  
                while @i<=@iStep  
                begin  
                   set @Sql=@Sql+' insert into IC_MAxNum(FTableName,FUserID,FNumber) values('''+@TableName+''','  
   +str(ltrim(@UserID))+','+str(@FInterID+@i)+')  '  
                   set @i=@i+1  
                end  
                set @Sql=@Sql+' Update IC_MAxNum set FFlag=1 where FUserID='+str(ltrim(@UserID))+' and FTableName='''+@TableName+''' and FNumber='+str(@FInterID + 1)                   
   exec(@Sql)  
  if @@error=0    
   begin    
       commit    
       select @FInterID=@FInterID + 1    
   end    
  else    
   begin    
      
       rollback    
       select @FInterID=-1    
                
   end    
 end    
 else    
 begin    
  begin transaction    
  if @FinterID=-1 
        set @Sql='Insert Into ICMaxNum(FTableName,FMaxNum) values('''+@tableName+''','+str(1000+@iStep)+') '  
  else
        set  @Sql='update ICMaxNum set FMaxNum='+str(1000+@iStep)+' where FTableName='''+@tableName+''''
  while @i<=@iStep  
	begin  
	   set @Sql=@Sql+' insert into IC_MAxNum(FTableName,FUserID,FNumber) values('''+@TableName+''','  
			+str(ltrim(@UserID))+','+str(1000+@i)+')  '  
	   set @i=@i+1  
	end  
  set @Sql=@Sql+' Update IC_MAxNum set FFlag=1 where FUserID='+str(ltrim(@UserID))+' and FTableName='''+@TableName+''' and FNumber=1001'   
  exec (@Sql)  
  
  if @@error=0    
  begin    
      commit    
      select @FInterID=1001    
  end    
  else    
  begin    
      rollback    
      select @FinterID=-1    
  end       
 end    
    end  
    else   --����ֱ�ӻ�ȡ����ĺ���  
    begin  
        begin tran  
            Update IC_MAxNum set FFlag=1 where FUserID=@UserID and FTableName=@TableName and FNumber=@FNumber   
            set @FInterID=@FNumber  
        commit   
    end  
  
    return @FInterID
