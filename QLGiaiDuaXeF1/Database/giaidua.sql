/* Chạy đầu tiên trong nhóm dữ liệu mẫu Module 2. */
USE GiaiDuaDB;
GO

/* Hệ thống chỉ có một giải đua F1 duy nhất. */
IF NOT EXISTS (
    SELECT 1
    FROM tblGiaiDua
    WHERE tenGiaiDua = N'Giải đua xe Công thức 1'
)
BEGIN
    INSERT INTO tblGiaiDua(tenGiaiDua, moTa)
    VALUES (
        N'Giải đua xe Công thức 1',
        N'Giải đua xe Công thức 1, tổ chức theo các mùa giải hằng năm.'
    );
END
GO

SELECT id, tenGiaiDua, moTa
FROM tblGiaiDua
WHERE tenGiaiDua = N'Giải đua xe Công thức 1';
GO
