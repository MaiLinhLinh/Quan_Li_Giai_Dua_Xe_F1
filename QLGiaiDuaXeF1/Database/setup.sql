USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.sql_logins WHERE name = N'f1_user')
BEGIN
    CREATE LOGIN f1_user WITH PASSWORD = N'F1@123456';
END
GO

USE GiaiDuaDB;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'f1_user')
BEGIN
    CREATE USER f1_user FOR LOGIN f1_user;
END
GO

IF IS_ROLEMEMBER('db_datareader', 'f1_user') = 0
BEGIN
    ALTER ROLE db_datareader ADD MEMBER f1_user;
END
GO

IF IS_ROLEMEMBER('db_datawriter', 'f1_user') = 0
BEGIN
    ALTER ROLE db_datawriter ADD MEMBER f1_user;
END
GO

IF NOT EXISTS (SELECT 1 FROM tblThanhVienHeThong WHERE tenDangNhap = N'a')
BEGIN
    INSERT INTO tblThanhVienHeThong(tenDangNhap, matKhau)
    VALUES (N'a', N'a@123');

    DECLARE @thanhVienId INT = SCOPE_IDENTITY();

    INSERT INTO tblBanToChuc(thanhVienHeThongid, hoTen, diaChi, ngaySinh, email, soDienThoai, viTriCongViec)
    VALUES (@thanhVienId, N'Nguyễn Văn A', N'Hà Nội', '1990-01-01', N'a@example.com', N'0123456789', N'Ban tổ chức');
END
GO
