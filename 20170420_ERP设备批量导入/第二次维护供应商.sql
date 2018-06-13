select FDeviceNumber,FDeviceName,FSupplier 
update icdeviceaccount  set fsupplier = case fdevicenumber when 'BD-QM-SJT-03' then '55919' 
when 'BD-CY-CYJ-02' then '55919' when 'BD-CY-CYJ-03' then '55919' when 'BD-CY-CYJ-04' then '55919' 
when 'BD-CY-CYJ-05' then '55919' when 'BD-CY-CYJ-06' then '55919' when 'BD-CX-DJJ-01' then '55919' 
when 'BD-BG-SXKLJ-01' then '55919' when 'BD-BG-SXLZJ-01' then '55919' when 'BD-QM-SJT-06' then '55919' 
when 'BD-QM-SJT-07' then '55919' when 'BD-QM-SJT-08' then '55919' when 'BD-QM-SJT-09' then '55919' 
when 'BD-QM-SJT-10' then '55919' when 'BD-QM-SJT-11' then '55919' when 'BD-QM-SJT-12' then '55919' 
when 'BD-QM-SJT-13' then '55919' when 'BD-CY-CYJ-01' then '55919' when 'BD-ZC-ZKJ-02' then '55919' 
when 'BD-ZP-MYJ-01' then '55919' when 'BD-ZP-MYJ-02' then '55919' when 'BD-ZP-MYJ-03' then '55919' 
when 'BD-ZP-ZJGZ-27' then '55919' when 'BD-ZP-ZPT-34' then '55919' when 'BD-ZP-ZPT-35' then '55919'
 when 'BD-TS-FDJ-01' then '55919' when 'BD-TS-FDJ-01' then '55919' when 'BD-CS-HJHS-01' then '56105' 
 when 'BD-XX-ZXC-05' then '56262' when 'BD-CL-JLGKZJ-01' then '56424' when 'BD-CL-XYJ-02' then '64973' 
 when 'BD-CL-DTJ-04' then '64973' when 'BD-CL-SDWGJ-13' then '70179' when 'BD-CL-SDWGJ-14' then '70179' 
 when 'BD-FZ-QXHJ-01' then '71801' when 'BD-HJ-DZHJ-01' then '73548' when 'BD-HJ-KZQ-01' then '77848' when 'BD-ZX-YXJ-02' then '196562' when 'BD-ZX-SLQJ-01' then '196562' when 'BD-CY-FBJ-01' then '202636' when 'BD-ZH-DXJ-03' then '208768' when 'BD-ZX-FQYXJ-01' then '208768' when 'BD-BG-PXJ-01' then '221859' when 'BD-BG-PXJ-02' then '221859' when 'BD-BG-MCJCJ-01' then '221859' when 'BD-BG-MCJCJ-01' then '221859' else 0 end
where fdevicenumber in('BD-CY-CYJ-02','BD-CY-CYJ-02','BD-CY-CYJ-03','BD-CY-CYJ-04','BD-CY-CYJ-05','BD-CY-CYJ-06','BD-CX-DJJ-01','BD-BG-SXKLJ-01','BD-BG-SXLZJ-01','BD-QM-SJT-06','BD-QM-SJT-07','BD-QM-SJT-08','BD-QM-SJT-09','BD-QM-SJT-10','BD-QM-SJT-11','BD-QM-SJT-12','BD-QM-SJT-13','BD-CY-CYJ-01','BD-ZC-ZKJ-02','BD-ZP-MYJ-01','BD-ZP-MYJ-02','BD-ZP-MYJ-03','BD-ZP-ZJGZ-27','BD-ZP-ZPT-34','BD-ZP-ZPT-35','BD-TS-FDJ-01','BD-TS-FDJ-01','BD-CS-HJHS-01','BD-XX-ZXC-05','BD-CL-JLGKZJ-01','BD-CL-XYJ-02','BD-CL-DTJ-04','BD-CL-SDWGJ-13','BD-CL-SDWGJ-14','BD-FZ-QXHJ-01','BD-HJ-DZHJ-01','BD-HJ-KZQ-01','BD-ZX-YXJ-02','BD-ZX-SLQJ-01','BD-CY-FBJ-01','BD-ZH-DXJ-03','BD-ZX-FQYXJ-01','BD-BG-PXJ-01','BD-BG-PXJ-02','BD-BG-MCJCJ-01','BD-BG-MCJCJ-01')
