select fheadselfj0184,fbillno,* from icmo where fheadselfj0184 = '1707-1789'
update icmo set  fbillno=replace(fbillno,'1789','1847') where fheadselfj0184 = '1707-1847'
update icmo set  fbillno=replace(fbillno,'1785','1848') where fheadselfj0184 = '1707-1848'