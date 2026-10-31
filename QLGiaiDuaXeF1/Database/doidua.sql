/* Chạy sau taydua.sql. Mỗi đội đua cũng là một thành viên hệ thống. */
USE GiaiDuaDB;
GO

DECLARE @DuLieuDoi TABLE (
    tenDangNhap NVARCHAR(255) NOT NULL,
    matKhau NVARCHAR(255) NOT NULL,
    tenDoiDua NVARCHAR(255) NOT NULL,
    hang NVARCHAR(255) NOT NULL,
    moTa NVARCHAR(255) NOT NULL
);

INSERT INTO @DuLieuDoi(tenDangNhap, matKhau, tenDoiDua, hang, moTa)
VALUES
    (N'doidua_cyber_racing', N'123456', N'Cyber Racing', N'Cyber Motors', N'Đội đua chính của hãng Cyber Motors.'),
    (N'doidua_cyber_gp', N'123456', N'Cyber GP', N'Cybex Automotive', N'Đội đua của hãng Cybex Automotive.'),
    (N'doidua_red_comet', N'123456', N'Red Comet Racing', N'Red Comet', N'Đội đua của hãng Red Comet.');

BEGIN TRANSACTION;

INSERT INTO tblThanhVienHeThong(tenDangNhap, matKhau)
SELECT d.tenDangNhap, d.matKhau
FROM @DuLieuDoi d
WHERE NOT EXISTS (
    SELECT 1
    FROM tblThanhVienHeThong tv
    WHERE tv.tenDangNhap = d.tenDangNhap
);

INSERT INTO tblDoiDua(thanhVienHeThongid, tenDoiDua, hang, moTa)
SELECT tv.id, d.tenDoiDua, d.hang, d.moTa
FROM @DuLieuDoi d
INNER JOIN tblThanhVienHeThong tv ON tv.tenDangNhap = d.tenDangNhap
WHERE NOT EXISTS (
    SELECT 1
    FROM tblDoiDua dd
    WHERE dd.thanhVienHeThongid = tv.id
);

COMMIT TRANSACTION;
GO

SELECT dd.thanhVienHeThongid AS maDoiDua, dd.tenDoiDua, dd.hang, dd.moTa
FROM tblDoiDua dd
ORDER BY dd.tenDoiDua;
GO
