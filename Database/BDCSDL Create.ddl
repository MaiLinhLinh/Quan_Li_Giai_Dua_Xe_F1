CREATE TABLE tblBanToChuc (
  thanhVienHeThongid int NOT NULL, 
  hoTen              nvarchar(255) NOT NULL, 
  diaChi             nvarchar(255) NOT NULL, 
  ngaySinh           date NOT NULL, 
  email              nvarchar(255) NOT NULL, 
  soDienThoai        nvarchar(255) NOT NULL, 
  viTriCongViec      nvarchar(255) NOT NULL, 
  PRIMARY KEY (thanhVienHeThongid));
CREATE TABLE tblChangDua (
  id               int IDENTITY NOT NULL, 
  tenChangDua      nvarchar(255) NOT NULL, 
  soVongDua        int NOT NULL, 
  diaDiem          nvarchar(255) NOT NULL, 
  thoiGianToChuc   date NOT NULL, 
  ngayBatDauDangKi date NOT NULL, 
  ngayHetHanDangKi date NOT NULL, 
  tienThuongCoSo   float(10) NOT NULL, 
  muaGiaiId        int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE tblDoiDua (
  thanhVienHeThongid int NOT NULL, 
  tenDoiDua          nvarchar(255) NOT NULL, 
  hang               nvarchar(255) NOT NULL, 
  moTa               nvarchar(255) NOT NULL, 
  PRIMARY KEY (thanhVienHeThongid));
CREATE TABLE tblGiaiDua (
  id         int IDENTITY NOT NULL, 
  tenGiaiDua nvarchar(255) NOT NULL, 
  moTa       nvarchar(255) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE tblMuaGiai (
  id          int IDENTITY NOT NULL, 
  tenMuaGiai  nvarchar(255) NOT NULL, 
  namToChuc   int NOT NULL, 
  ngayBatDau  date NOT NULL, 
  ngayKetThuc date NOT NULL, 
  giaiDuaId   int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE tblTayDua (
  thanhVienHeThongid int NOT NULL, 
  hoTen              nvarchar(255) NOT NULL, 
  ngaySinh           date NOT NULL, 
  quocTich           nvarchar(255) NOT NULL, 
  soHieuTayDua       nvarchar(255) NOT NULL UNIQUE, 
  PRIMARY KEY (thanhVienHeThongid));
CREATE TABLE tblTayDuaDangKi (
  id                int IDENTITY NOT NULL, 
  thuHangVeDich     int NULL, 
  diemChang         int NULL, 
  thoiGianHoanThanh int NULL, 
  soVongHoanThanh   int NULL, 
  trangThai         nvarchar(255) NULL, 
  changDuaId        int NOT NULL, 
  tayDuaDoiDuaId    int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE tblTayDuaDoiDua (
  id          int IDENTITY NOT NULL, 
  ngayBatDau  date NOT NULL, 
  ngayKetThuc date NULL, 
  doiDuaId    int NOT NULL, 
  tayDuaId    int NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE tblThanhVienHeThong (
  id          int IDENTITY NOT NULL, 
  tenDangNhap nvarchar(255) NOT NULL, 
  matKhau     nvarchar(255) NOT NULL, 
  PRIMARY KEY (id));
ALTER TABLE tblMuaGiai ADD CONSTRAINT FK_MuaGiai_GiaiDua FOREIGN KEY (giaiDuaId) REFERENCES tblGiaiDua (id);
ALTER TABLE tblChangDua ADD CONSTRAINT FK_ChangDua_MuaGiai FOREIGN KEY (muaGiaiId) REFERENCES tblMuaGiai (id);
ALTER TABLE tblTayDuaDoiDua ADD CONSTRAINT FK_TayDuaDoiDua_DoiDua FOREIGN KEY (doiDuaId) REFERENCES tblDoiDua (thanhVienHeThongid);
ALTER TABLE tblTayDuaDoiDua ADD CONSTRAINT FK_TayDuaDoiDua_TayDua FOREIGN KEY (tayDuaId) REFERENCES tblTayDua (thanhVienHeThongid);
ALTER TABLE tblTayDuaDangKi ADD CONSTRAINT FK_TayDuaDangKi_TayDuaDoiDua FOREIGN KEY (tayDuaDoiDuaId) REFERENCES tblTayDuaDoiDua (id);
ALTER TABLE tblTayDuaDangKi ADD CONSTRAINT FK_TayDuaDangKi_ChangDua FOREIGN KEY (changDuaId) REFERENCES tblChangDua (id);
ALTER TABLE tblDoiDua ADD CONSTRAINT FK_DoiDua_ThanhVienHeThong FOREIGN KEY (thanhVienHeThongid) REFERENCES tblThanhVienHeThong (id);
ALTER TABLE tblTayDua ADD CONSTRAINT FK_TayDua_ThanhVienHeThong FOREIGN KEY (thanhVienHeThongid) REFERENCES tblThanhVienHeThong (id);
ALTER TABLE tblBanToChuc ADD CONSTRAINT FK_BanToChuc_ThanhVienHeThong FOREIGN KEY (thanhVienHeThongid) REFERENCES tblThanhVienHeThong (id);

