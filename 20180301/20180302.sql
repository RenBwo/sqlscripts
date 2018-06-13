后台变更步骤：
 1.备份
 2.储液器壳体修毛刺 工资系数  1变更为1.3478
 3.储液器壳体钻孔 工资系数 0.5231变更为 0.6769
 4.售后压板修毛刺  变更为0.8913
 完成。

select finterid,fentryid,foperid,fentryselfz0236 into renbo_back_20180302 from t_routingoper 

1> update t_routingoper set fentryselfz0236 = 1.3478 from t_routing a join t_routingoper b on a.finterid = b.finterid where 
2> a.fitemid in (select a.fitemid from t_routing a join t_routingoper b on a.finterid = b.finterid and b.fentryselfz0236=0.5231 and b.foperid =
3> 40195) and b.foperid = 40193 and a.finterid in (select a.finterid from t_routing a join t_routingoper b on a.finterid = b.finterid and b.fentryselfz0236
4> =0.5231 and b.foperid = 40195)
5> go

(585 rows affected)
1> update t_routingoper set fentryselfz0236 = 0.6769 from t_routing a join t_routingoper b on a.finterid = b.finterid and b.foperid = 40195 and b.fentryselfz0236
2> =0.5231
3> go

(585 rows affected)
1> update t_routingoper set fentryselfz0236 = 0.8913 where foperid = 40193 and fentryselfz0236 = 1 
2> go

(1778 rows affected)


