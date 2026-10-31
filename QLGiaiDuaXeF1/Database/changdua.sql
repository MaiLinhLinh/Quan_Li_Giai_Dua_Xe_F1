/* Chạy sau muagiai.sql. */
USE GiaiDuaDB;
GO

DECLARE @muaGiaiId INT;

SELECT @muaGiaiId = id
FROM tblMuaGiai
WHERE tenMuaGiai = N'Mùa giải F1 2026';

IF @muaGiaiId IS NULL
BEGIN
    THROW 50002, N'Chưa có mùa giải F1 2026. Hãy chạy muagiai.sql trước.', 1;
END

/* Nam Thành đang mở đăng kí tại thời điểm dữ liệu mẫu được tạo. */
IF NOT EXISTS (
    SELECT 1
    FROM tblChangDua
    WHERE tenChangDua = N'Nam Thành'
      AND muaGiaiId = @muaGiaiId
)
BEGIN
    INSERT INTO tblChangDua(
        tenChangDua,
        soVongDua,
        diaDiem,
        thoiGianToChuc,
        ngayBatDauDangKi,
        ngayHetHanDangKi,
        tienThuongCoSo,
        muaGiaiId
    )
    VALUES (
        N'Nam Thành',
        56,
        N'Nam Định, Việt Nam',
        '2026-11-22',
        '2026-10-01',
        '2026-11-10',
        1000000,
        @muaGiaiId
    );
END

/*
   Nam Thái có tên gần với Nam Thành.
   Khi nhập từ khóa "Nam" trên giao diện, hệ thống sẽ trả về cả hai chặng.
*/
IF NOT EXISTS (
    SELECT 1
    FROM tblChangDua
    WHERE tenChangDua = N'Nam Thái'
      AND muaGiaiId = @muaGiaiId
)
BEGIN
    INSERT INTO tblChangDua(
        tenChangDua,
        soVongDua,
        diaDiem,
        thoiGianToChuc,
        ngayBatDauDangKi,
        ngayHetHanDangKi,
        tienThuongCoSo,
        muaGiaiId
    )
    VALUES (
        N'Nam Thái',
        58,
        N'Buriram, Thái Lan',
        '2026-11-29',
        '2026-10-05',
        '2026-11-17',
        1050000,
        @muaGiaiId
    );
END

IF NOT EXISTS (
    SELECT 1
    FROM tblChangDua
    WHERE tenChangDua = N'Monaco'
      AND muaGiaiId = @muaGiaiId
)
BEGIN
    INSERT INTO tblChangDua(
        tenChangDua,
        soVongDua,
        diaDiem,
        thoiGianToChuc,
        ngayBatDauDangKi,
        ngayHetHanDangKi,
        tienThuongCoSo,
        muaGiaiId
    )
    VALUES (
        N'Monaco',
        78,
        N'Monte Carlo, Monaco',
        '2026-06-07',
        '2026-04-01',
        '2026-05-20',
        1200000,
        @muaGiaiId
    );
END

IF NOT EXISTS (
    SELECT 1
    FROM tblChangDua
    WHERE tenChangDua = N'Silverstone'
      AND muaGiaiId = @muaGiaiId
)
BEGIN
    INSERT INTO tblChangDua(
        tenChangDua,
        soVongDua,
        diaDiem,
        thoiGianToChuc,
        ngayBatDauDangKi,
        ngayHetHanDangKi,
        tienThuongCoSo,
        muaGiaiId
    )
    VALUES (
        N'Silverstone',
        52,
        N'Northamptonshire, Vương quốc Anh',
        '2026-07-12',
        '2026-05-01',
        '2026-06-25',
        1100000,
        @muaGiaiId
    );
END

/* Chặng tương lai để giao diện thể hiện trạng thái Chưa mở. */
IF NOT EXISTS (
    SELECT 1
    FROM tblChangDua
    WHERE tenChangDua = N'Suzuka'
      AND muaGiaiId = @muaGiaiId
)
BEGIN
    INSERT INTO tblChangDua(
        tenChangDua,
        soVongDua,
        diaDiem,
        thoiGianToChuc,
        ngayBatDauDangKi,
        ngayHetHanDangKi,
        tienThuongCoSo,
        muaGiaiId
    )
    VALUES (
        N'Suzuka',
        53,
        N'Suzuka, Nhật Bản',
        '2026-12-13',
        '2026-11-15',
        '2026-12-01',
        1000000,
        @muaGiaiId
    );
END
GO

SELECT cd.id, cd.tenChangDua, cd.soVongDua, cd.diaDiem, cd.thoiGianToChuc,
       cd.ngayBatDauDangKi, cd.ngayHetHanDangKi
FROM tblChangDua cd
INNER JOIN tblMuaGiai mg ON cd.muaGiaiId = mg.id
WHERE mg.tenMuaGiai = N'Mùa giải F1 2026'
ORDER BY cd.thoiGianToChuc;
GO
