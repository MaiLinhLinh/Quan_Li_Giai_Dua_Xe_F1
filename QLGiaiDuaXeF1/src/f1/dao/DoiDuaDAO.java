package f1.dao;

import f1.model.ChangDua;
import f1.model.DoiDua;
import f1.model.TayDua;
import f1.model.TayDuaDangKi;
import f1.model.TayDuaDoiDua;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DoiDuaDAO extends DAO {

    public ArrayList<DoiDua> timDoiDua(String tuKhoa, ChangDua changDua) throws SQLException {
        ArrayList<DoiDua> danhSach = new ArrayList<>();
        if (changDua == null) {
            return danhSach;
        }

        String keyword = "%" + (tuKhoa == null ? "" : tuKhoa.trim()) + "%";
        // JOIN trả về đội, tay đua thuộc đội và đăng ký của tay đua đó tại chặng đang chọn.
        String sql = "SELECT dd.thanhVienHeThongid AS doiDuaId, dd.tenDoiDua, dd.hang, dd.moTa, "
                + "tddd.id AS tayDuaDoiDuaId, tddd.ngayBatDau, tddd.ngayKetThuc, "
                + "td.thanhVienHeThongid AS tayDuaId, td.hoTen, td.ngaySinh, td.quocTich, td.soHieuTayDua, "
                + "dk.id AS dangKiId, dk.thuHangVeDich, dk.diemChang, dk.thoiGianHoanThanh, "
                + "dk.soVongHoanThanh, dk.trangThai "
                + "FROM tblDoiDua dd "
                + "LEFT JOIN tblTayDuaDoiDua tddd ON tddd.doiDuaId = dd.thanhVienHeThongid "
                + "AND tddd.ngayBatDau <= ? AND (tddd.ngayKetThuc IS NULL OR tddd.ngayKetThuc >= ?) "
                + "LEFT JOIN tblTayDua td ON td.thanhVienHeThongid = tddd.tayDuaId "
                + "LEFT JOIN tblTayDuaDangKi dk ON dk.tayDuaDoiDuaId = tddd.id AND dk.changDuaId = ? "
                + "WHERE dd.tenDoiDua LIKE ? OR dd.hang LIKE ? "
                + "ORDER BY dd.tenDoiDua, CASE WHEN dk.id IS NULL THEN 1 ELSE 0 END, td.hoTen";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(changDua.getThoiGianToChuc()));
            ps.setDate(2, java.sql.Date.valueOf(changDua.getThoiGianToChuc()));
            ps.setInt(3, changDua.getId());
            ps.setString(4, keyword);
            ps.setString(5, keyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DoiDua doiDua = null;
                    int doiDuaId = rs.getInt("doiDuaId");
                    // Một đội có nhiều tay đua nên nhiều dòng SQL có cùng doiDuaId.
                    // Tìm đối tượng đội đã tạo để không thêm trùng vào danhSach.
                    for (DoiDua item : danhSach) {
                        if (item.getId() == doiDuaId) {
                            doiDua = item;
                            break;
                        }
                    }
                    if (doiDua == null) {
                        doiDua = new DoiDua();
                        doiDua.setId(doiDuaId);
                        doiDua.setTenDoiDua(rs.getString("tenDoiDua"));
                        doiDua.setHang(rs.getString("hang"));
                        doiDua.setMoTa(rs.getString("moTa"));
                        danhSach.add(doiDua);
                    }

                    Object tayDuaDoiDuaId = rs.getObject("tayDuaDoiDuaId");
                    if (tayDuaDoiDuaId == null) {
                        // LEFT JOIN vẫn giữ đội chưa có tay đua hợp lệ tại thời điểm chặng diễn ra.
                        continue;
                    }

                    TayDuaDoiDua tayDuaDoiDua = null;
                    for (TayDuaDoiDua item : doiDua.getTayDuaDoiDua()) {
                        if (item.getId() == ((Number) tayDuaDoiDuaId).intValue()) {
                            tayDuaDoiDua = item;
                            break;
                        }
                    }
                    if (tayDuaDoiDua == null) {
                        // Tạo quan hệ tay đua - đội đua và gắn tay đua vào đúng đội.
                        TayDua tayDua = new TayDua();
                        tayDua.setId(rs.getInt("tayDuaId"));
                        tayDua.setHoTen(rs.getString("hoTen"));
                        tayDua.setNgaySinh(rs.getDate("ngaySinh").toLocalDate());
                        tayDua.setQuocTich(rs.getString("quocTich"));
                        tayDua.setSoHieuTayDua(rs.getString("soHieuTayDua"));

                        tayDuaDoiDua = new TayDuaDoiDua();
                        tayDuaDoiDua.setId(((Number) tayDuaDoiDuaId).intValue());
                        tayDuaDoiDua.setNgayBatDau(rs.getDate("ngayBatDau").toLocalDate());
                        java.sql.Date ngayKetThuc = rs.getDate("ngayKetThuc");
                        if (ngayKetThuc != null) {
                            tayDuaDoiDua.setNgayKetThuc(ngayKetThuc.toLocalDate());
                        }
                        tayDuaDoiDua.setDoiDua(doiDua);
                        tayDuaDoiDua.setTayDua(tayDua);
                        doiDua.getTayDuaDoiDua().add(tayDuaDoiDua);
                    }

                    Object dangKiId = rs.getObject("dangKiId");
                    if (dangKiId != null) {
                        // Chỉ thêm đăng ký của đúng chặng đang được truyền vào hàm.
                        TayDuaDangKi dangKi = new TayDuaDangKi();
                        dangKi.setId(((Number) dangKiId).intValue());
                        dangKi.setThuHangVeDich((Integer) rs.getObject("thuHangVeDich"));
                        dangKi.setDiemChang((Integer) rs.getObject("diemChang"));
                        dangKi.setThoiGianHoanThanh((Integer) rs.getObject("thoiGianHoanThanh"));
                        dangKi.setSoVongHoanThanh((Integer) rs.getObject("soVongHoanThanh"));
                        dangKi.setTrangThai(rs.getString("trangThai"));
                        dangKi.setChangDua(changDua);
                        dangKi.setTayDuaDoiDua(tayDuaDoiDua);
                        tayDuaDoiDua.getTayDuaDangKi().add(dangKi);
                    }
                }
            }
        }

        for (DoiDua doiDua : danhSach) {
            int soTayDuaDaDangKi = 0;

            for (TayDuaDoiDua tayDuaDoiDua : doiDua.getTayDuaDoiDua()) {
                if (!tayDuaDoiDua.getTayDuaDangKi().isEmpty()) {
                    soTayDuaDaDangKi++;
                }
            }

            // Một đội chỉ được xem là đã đăng ký khi có đủ hai tay đua tại chặng này.
            if (soTayDuaDaDangKi == 2) {
                doiDua.setTrangThaiDangKi("Đã đăng kí");
            } else {
                doiDua.setTrangThaiDangKi("Chưa đăng kí");
            }
        }

        return danhSach;
    }
}
