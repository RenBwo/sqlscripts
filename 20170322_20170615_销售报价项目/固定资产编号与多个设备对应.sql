select t102.fnum,t102.fassetnumber,t101.fassetid,t102.fassetname from  			
		  	  t_FAAlter 	t101 
		 join	  t_facard 		t102 on t102.falterid = t101.falterid 
		 where t102.fnum > 1  and t102.fgroupid = 1004