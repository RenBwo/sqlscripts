SELECT * FROM ICStockBill WHERE FBILLNO = 'SOUT261042';
SELECT * FROM ICStockBill WHERE FBILLNO = 'SOUT263606';
update ICStockBill set FVchInterID = 0  WHERE FBILLNO = 'SOUT261042';
select * from t_VoucherBlankOut;