
/*
调机增量
*/select FHeadSelfJ0184,FItemID,min(FInterID)  as fminid
into #t1 from ICMO 
where FCancellation=0  and  fcheckdate >= '2017-06-01'
group by FHeadSelfJ0184,FItemID




update t1 set t1.FHeadSelfJ0196=t2.F_160 from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
join #t1  c on t1.finterid = c.fminid
--where t1.FInterID =@FINTERID3 

update t1 set t1.FHeadSelfJ0196=0
			from ICMO t1
inner join t_ICItem t2 on t1.FItemID=t2.FItemID
join #t1  c on t1.fitemid = c.fitemid and t1.FHeadSelfJ0184= c.FHeadSelfJ0184 
and t1.FInterID <>c.fminid and t1.FCancellation=0
