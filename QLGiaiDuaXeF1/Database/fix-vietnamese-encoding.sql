/*
 Chạy một lần trong SSMS trên cơ sở dữ liệu GiaiDuaDB để sửa bản ghi mẫu
 đã được tạo trước đây bằng bảng mã sai. File chỉ dùng ký tự ASCII để
 không phụ thuộc bảng mã của SSMS hoặc sqlcmd.
*/
USE GiaiDuaDB;
GO

UPDATE tblBanToChuc
SET hoTen = NCHAR(78) + NCHAR(103) + NCHAR(117) + NCHAR(121) + NCHAR(7877) + NCHAR(110) + NCHAR(32) + NCHAR(86) + NCHAR(259) + NCHAR(110) + NCHAR(32) + NCHAR(65),
    diaChi = NCHAR(72) + NCHAR(224) + NCHAR(32) + NCHAR(78) + NCHAR(7897) + NCHAR(105),
    viTriCongViec = NCHAR(66) + NCHAR(97) + NCHAR(110) + NCHAR(32) + NCHAR(116) + NCHAR(7893) + NCHAR(32) + NCHAR(99) + NCHAR(104) + NCHAR(7913) + NCHAR(99)
WHERE thanhVienHeThongid = (SELECT id FROM tblThanhVienHeThong WHERE tenDangNhap = N'a');
GO
