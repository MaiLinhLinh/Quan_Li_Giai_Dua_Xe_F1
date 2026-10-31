package f1.dao;

import f1.model.ChangDua;
import f1.model.MuaGiai;
import f1.model.TayDuaDangKi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ChangDuaDAO extends DAO {

    public ArrayList<ChangDua> timChangDua(String tuKhoa, MuaGiai muaGiai) throws SQLException {
        ArrayList<ChangDua> danhSach = new ArrayList<>();
        if (muaGiai == null) {
            return danhSach;
        }

        // Chỉ tìm chặng thuộc mùa giải người dùng đang chọn.
        String keyword = "%" + (tuKhoa == null ? "" : tuKhoa.trim()) + "%";
        String sql = "SELECT id, tenChangDua, soVongDua, diaDiem, thoiGianToChuc, ngayBatDauDangKi, "
                + "ngayHetHanDangKi, tienThuongCoSo FROM tblChangDua "
                + "WHERE muaGiaiId = ? AND (tenChangDua LIKE ? OR diaDiem LIKE ?) "
                + "ORDER BY thoiGianToChuc";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, muaGiai.getId());
            ps.setString(2, keyword);
            ps.setString(3, keyword);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChangDua changDua = new ChangDua();
                    changDua.setId(rs.getInt("id"));
                    changDua.setTenChangDua(rs.getString("tenChangDua"));
                    changDua.setSoVongDua(rs.getInt("soVongDua"));
                    changDua.setDiaDiem(rs.getString("diaDiem"));
                    changDua.setThoiGianToChuc(rs.getDate("thoiGianToChuc").toLocalDate());
                    changDua.setNgayBatDauDangKi(rs.getDate("ngayBatDauDangKi").toLocalDate());
                    changDua.setNgayHetHanDangKi(rs.getDate("ngayHetHanDangKi").toLocalDate());
                    changDua.setTienThuongCoSo(rs.getDouble("tienThuongCoSo"));
                    changDua.setMuaGiai(muaGiai);

                    LocalDate homNay = LocalDate.now();
                    if (homNay.isBefore(changDua.getNgayBatDauDangKi())) {
                        changDua.setTrangThaiDangKi("Chưa mở");
                    } else if (homNay.isAfter(changDua.getNgayHetHanDangKi())) {
                        changDua.setTrangThaiDangKi("Kết thúc");
                    } else {
                        changDua.setTrangThaiDangKi("Đang mở");
                    }

                    danhSach.add(changDua);
                }
            }
        }
        return danhSach;
    }

    public boolean capNhatChangDua(ChangDua changDua) throws SQLException {
        // Mỗi đội đăng ký đúng hai tay đua cho một chặng.
        if (changDua == null || changDua.getTayDuaDangKi() == null || changDua.getTayDuaDangKi().size() != 2) {
            return false;
        }

        TayDuaDangKi dangKiDauTien = changDua.getTayDuaDangKi().get(0);
        if (dangKiDauTien == null || dangKiDauTien.getTayDuaDoiDua() == null
                || dangKiDauTien.getTayDuaDoiDua().getDoiDua() == null) {
            return false;
        }

        int doiDuaId = dangKiDauTien.getTayDuaDoiDua().getDoiDua().getId();
        // Chỉ xóa đăng ký cũ của đội đang cập nhật, không ảnh hưởng các đội khác trong chặng.
        String sqlXoa = "DELETE dk FROM tblTayDuaDangKi dk "
                + "INNER JOIN tblTayDuaDoiDua tddd ON dk.tayDuaDoiDuaId = tddd.id "
                + "WHERE dk.changDuaId = ? AND tddd.doiDuaId = ?";
        String sqlThem = "INSERT INTO tblTayDuaDangKi(changDuaId, tayDuaDoiDuaId) VALUES(?, ?)";

        try (Connection cn = getConnection()) {
            cn.setAutoCommit(false);
            try {
                try (PreparedStatement ps = cn.prepareStatement(sqlXoa)) {
                    ps.setInt(1, changDua.getId());
                    ps.setInt(2, doiDuaId);
                    ps.executeUpdate();
                }

                try (PreparedStatement ps = cn.prepareStatement(sqlThem)) {
                    // Hai tay đua được chọn phải cùng thuộc một đội.
                    for (TayDuaDangKi dangKi : changDua.getTayDuaDangKi()) {
                        if (dangKi == null || dangKi.getTayDuaDoiDua() == null
                                || dangKi.getTayDuaDoiDua().getDoiDua() == null
                                || dangKi.getTayDuaDoiDua().getDoiDua().getId() != doiDuaId) {
                            cn.rollback();
                            return false;
                        }
                        ps.setInt(1, changDua.getId());
                        ps.setInt(2, dangKi.getTayDuaDoiDua().getId());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                cn.commit();
                return true;
            } catch (SQLException | RuntimeException e) {
                // DELETE và INSERT là một transaction để tránh mất đăng ký cũ nếu thêm mới lỗi.
                try {
                    cn.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }
                throw e;
            }
        }
    }
}
