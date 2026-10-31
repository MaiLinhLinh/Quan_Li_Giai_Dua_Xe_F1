/*
   Chạy cuối cùng, sau changdua.sql, doidua.sql và tayduadoidua.sql.

   Có hai đội đã đăng kí tại Nam Thành:
   - Cyber Racing: tay đua số 44 và 63.
   - Red Comet Racing: tay đua số 1 và 16.

   Cyber GP chưa có bản ghi nào tại tblTayDuaDangKi,
   nên khi tìm "Cyber" trên web sẽ thấy một đội Đã đăng kí và một đội Chưa đăng kí.
*/
USE GiaiDuaDB;
GO

DECLARE @changDuaId INT;

SELECT @changDuaId = cd.id
FROM tblChangDua cd
INNER JOIN tblMuaGiai mg ON cd.muaGiaiId = mg.id
WHERE cd.tenChangDua = N'Nam Thành'
  AND mg.tenMuaGiai = N'Mùa giải F1 2026';

IF @changDuaId IS NULL
BEGIN
    THROW 50003, N'Chưa có Nam Thành. Hãy chạy changdua.sql trước.', 1;
END

DECLARE @DuLieuDangKi TABLE (
    tenDoiDua NVARCHAR(255) NOT NULL,
    soHieuTayDua NVARCHAR(255) NOT NULL
);

INSERT INTO @DuLieuDangKi(tenDoiDua, soHieuTayDua)
VALUES
    (N'Cyber Racing', N'44'),
    (N'Cyber Racing', N'63'),
    (N'Red Comet Racing', N'1'),
    (N'Red Comet Racing', N'16');

BEGIN TRANSACTION;

/* Các cột kết quả để NULL: đây mới chỉ là đăng kí, chặng đua chưa diễn ra. */
INSERT INTO tblTayDuaDangKi(changDuaId, tayDuaDoiDuaId)
SELECT @changDuaId, tddd.id
FROM @DuLieuDangKi ddk
INNER JOIN tblDoiDua dd ON dd.tenDoiDua = ddk.tenDoiDua
INNER JOIN tblTayDua td ON td.soHieuTayDua = ddk.soHieuTayDua
INNER JOIN tblTayDuaDoiDua tddd
    ON tddd.doiDuaId = dd.thanhVienHeThongid
   AND tddd.tayDuaId = td.thanhVienHeThongid
   AND tddd.ngayKetThuc IS NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM tblTayDuaDangKi dk
    WHERE dk.changDuaId = @changDuaId
      AND dk.tayDuaDoiDuaId = tddd.id
);

COMMIT TRANSACTION;
GO

SELECT cd.tenChangDua, dd.tenDoiDua, td.hoTen, td.soHieuTayDua,
       dk.thuHangVeDich, dk.diemChang, dk.thoiGianHoanThanh,
       dk.soVongHoanThanh, dk.trangThai
FROM tblTayDuaDangKi dk
INNER JOIN tblChangDua cd ON dk.changDuaId = cd.id
INNER JOIN tblTayDuaDoiDua tddd ON dk.tayDuaDoiDuaId = tddd.id
INNER JOIN tblDoiDua dd ON tddd.doiDuaId = dd.thanhVienHeThongid
INNER JOIN tblTayDua td ON tddd.tayDuaId = td.thanhVienHeThongid
WHERE cd.tenChangDua = N'Nam Thành'
ORDER BY dd.tenDoiDua, TRY_CONVERT(INT, td.soHieuTayDua);
GO
