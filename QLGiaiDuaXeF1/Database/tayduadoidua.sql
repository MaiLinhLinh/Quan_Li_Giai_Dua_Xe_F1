/*
   Chạy sau taydua.sql và doidua.sql.
   Mỗi đội có bốn tay đua, đều còn hợp đồng ở thời điểm các chặng năm 2026.
*/
USE GiaiDuaDB;
GO

DECLARE @PhanCong TABLE (
    tenDoiDua NVARCHAR(255) NOT NULL,
    soHieuTayDua NVARCHAR(255) NOT NULL
);

INSERT INTO @PhanCong(tenDoiDua, soHieuTayDua)
VALUES
    (N'Cyber Racing', N'44'),
    (N'Cyber Racing', N'63'),
    (N'Cyber Racing', N'2'),
    (N'Cyber Racing', N'3'),

    (N'Cyber GP', N'4'),
    (N'Cyber GP', N'81'),
    (N'Cyber GP', N'5'),
    (N'Cyber GP', N'6'),

    (N'Red Comet Racing', N'1'),
    (N'Red Comet Racing', N'16'),
    (N'Red Comet Racing', N'7'),
    (N'Red Comet Racing', N'8');

INSERT INTO tblTayDuaDoiDua(ngayBatDau, ngayKetThuc, doiDuaId, tayDuaId)
SELECT '2026-01-01', NULL, dd.thanhVienHeThongid, td.thanhVienHeThongid
FROM @PhanCong pc
INNER JOIN tblDoiDua dd ON dd.tenDoiDua = pc.tenDoiDua
INNER JOIN tblTayDua td ON td.soHieuTayDua = pc.soHieuTayDua
WHERE NOT EXISTS (
    SELECT 1
    FROM tblTayDuaDoiDua tddd
    WHERE tddd.doiDuaId = dd.thanhVienHeThongid
      AND tddd.tayDuaId = td.thanhVienHeThongid
      AND tddd.ngayKetThuc IS NULL
);
GO

SELECT dd.tenDoiDua, td.hoTen, td.soHieuTayDua, tddd.ngayBatDau, tddd.ngayKetThuc
FROM tblTayDuaDoiDua tddd
INNER JOIN tblDoiDua dd ON tddd.doiDuaId = dd.thanhVienHeThongid
INNER JOIN tblTayDua td ON tddd.tayDuaId = td.thanhVienHeThongid
WHERE dd.tenDoiDua IN (N'Cyber Racing', N'Cyber GP', N'Red Comet Racing')
ORDER BY dd.tenDoiDua, TRY_CONVERT(INT, td.soHieuTayDua);
GO
