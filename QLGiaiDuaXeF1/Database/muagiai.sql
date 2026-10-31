/* Chạy sau giaidua.sql. */
USE GiaiDuaDB;
GO

DECLARE @giaiDuaId INT;

SELECT @giaiDuaId = id
FROM tblGiaiDua
WHERE tenGiaiDua = N'Giải đua xe Công thức 1';

IF @giaiDuaId IS NULL
BEGIN
    THROW 50001, N'Chưa có giải đua F1. Hãy chạy giaidua.sql trước.', 1;
END

/* Một mùa giải ứng với một năm tổ chức của giải đua F1 duy nhất. */
IF NOT EXISTS (
    SELECT 1
    FROM tblMuaGiai
    WHERE tenMuaGiai = N'Mùa giải F1 2026'
      AND giaiDuaId = @giaiDuaId
)
BEGIN
    INSERT INTO tblMuaGiai(tenMuaGiai, namToChuc, ngayBatDau, ngayKetThuc, giaiDuaId)
    VALUES (N'Mùa giải F1 2026', 2026, '2026-01-01', '2026-12-31', @giaiDuaId);
END
GO

SELECT mg.id, mg.tenMuaGiai, mg.namToChuc, mg.ngayBatDau, mg.ngayKetThuc
FROM tblMuaGiai mg
INNER JOIN tblGiaiDua gd ON mg.giaiDuaId = gd.id
WHERE mg.tenMuaGiai = N'Mùa giải F1 2026'
  AND gd.tenGiaiDua = N'Giải đua xe Công thức 1';
GO
