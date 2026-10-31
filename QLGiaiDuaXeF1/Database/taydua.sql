/*
   Dữ liệu mẫu cho Module M1 - quản lý tay đua.
   Chạy file này trong SSMS khi đang kết nối SQL Server.
   Có thể chạy lại: các số hiệu đã tồn tại sẽ không được thêm trùng.
*/
USE GiaiDuaDB;
GO

DECLARE @DuLieuMau TABLE (
    tenDangNhap NVARCHAR(50) NOT NULL,
    matKhau NVARCHAR(255) NOT NULL,
    hoTen NVARCHAR(255) NOT NULL,
    ngaySinh DATE NOT NULL,
    quocTich NVARCHAR(255) NOT NULL,
    soHieuTayDua NVARCHAR(255) NOT NULL
);

INSERT INTO @DuLieuMau (tenDangNhap, matKhau, hoTen, ngaySinh, quocTich, soHieuTayDua)
VALUES
    (N'taydua_44', N'123456', N'Lewis Hamilton',       '1985-01-07', N'United Kingdom', N'44'),
    (N'taydua_1',  N'123456', N'Max Verstappen',       '1997-09-30', N'Netherlands',    N'1'),
    (N'taydua_16', N'123456', N'Charles Leclerc',      '1997-10-16', N'Monaco',         N'16'),
    (N'taydua_4',  N'123456', N'Lando Norris',         '1999-11-13', N'United Kingdom', N'4'),
    (N'taydua_55', N'123456', N'Carlos Sainz',         '1994-09-01', N'Spain',          N'55'),
    (N'taydua_14', N'123456', N'Fernando Alonso',      '1981-07-29', N'Spain',          N'14'),
    (N'taydua_63', N'123456', N'George Russell',       '1998-02-15', N'United Kingdom', N'63'),
    (N'taydua_81', N'123456', N'Oscar Piastri',        '2001-04-06', N'Australia',      N'81'),
    (N'taydua_22', N'123456', N'Yuki Tsunoda',         '2000-05-11', N'Japan',          N'22'),
    (N'taydua_11', N'123456', N'Sergio Perez',         '1990-01-26', N'Mexico',         N'11'),
    (N'taydua_2',   N'123456', N'Nguyễn Minh Anh',     '1998-03-12', N'Việt Nam',       N'2'),
    (N'taydua_3',   N'123456', N'Trần Quốc Bảo',       '1997-07-21', N'Việt Nam',       N'3'),
    (N'taydua_5',   N'123456', N'Lê Hoàng Nam',        '1999-11-05', N'Việt Nam',       N'5'),
    (N'taydua_6',   N'123456', N'Phạm Gia Huy',        '2000-01-18', N'Việt Nam',       N'6'),
    (N'taydua_7',   N'123456', N'Vũ Khánh Linh',       '2001-06-09', N'Việt Nam',       N'7'),
    (N'taydua_8',   N'123456', N'Đặng Nhật Minh',      '1996-12-27', N'Việt Nam',       N'8'),
    (N'taydua_9',   N'123456', N'Bùi Thanh Tùng',      '1998-09-14', N'Việt Nam',       N'9'),
    (N'taydua_10',  N'123456', N'Hoàng Đức Long',      '2002-02-25', N'Việt Nam',       N'10'),
    (N'taydua_12',  N'123456', N'Ngô Thảo Vy',         '2000-08-30', N'Việt Nam',       N'12'),
    (N'taydua_13',  N'123456', N'Đỗ Quang Hưng',       '1997-04-16', N'Việt Nam',       N'13');

BEGIN TRANSACTION;

/* Tạo tài khoản hệ thống trước, vì tblTayDua dùng id này làm khóa chính/khóa ngoại. */
INSERT INTO tblThanhVienHeThong (tenDangNhap, matKhau)
SELECT d.tenDangNhap, d.matKhau
FROM @DuLieuMau d
WHERE NOT EXISTS (
    SELECT 1
    FROM tblThanhVienHeThong tv
    WHERE tv.tenDangNhap = d.tenDangNhap
);

/* Chỉ thêm tay đua khi số hiệu chưa có trong hệ thống. */
INSERT INTO tblTayDua (thanhVienHeThongid, hoTen, ngaySinh, quocTich, soHieuTayDua)
SELECT tv.id, d.hoTen, d.ngaySinh, d.quocTich, d.soHieuTayDua
FROM @DuLieuMau d
INNER JOIN tblThanhVienHeThong tv ON tv.tenDangNhap = d.tenDangNhap
WHERE NOT EXISTS (
    SELECT 1
    FROM tblTayDua td
    WHERE td.soHieuTayDua = d.soHieuTayDua
);

COMMIT TRANSACTION;
GO

/* Kiểm tra 20 tay đua mẫu vừa có trong cơ sở dữ liệu. */
SELECT hoTen, ngaySinh, quocTich, soHieuTayDua
FROM tblTayDua
WHERE soHieuTayDua IN (N'44', N'1', N'16', N'4', N'55', N'14', N'63', N'81', N'22', N'11',
                        N'2', N'3', N'5', N'6', N'7', N'8', N'9', N'10', N'12', N'13')
ORDER BY TRY_CONVERT(INT, soHieuTayDua);
GO
