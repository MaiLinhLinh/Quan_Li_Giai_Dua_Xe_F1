package f1.dao;

import f1.model.TayDua;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class TayDuaDAO extends DAO {

    public static final String MAT_KHAU_MAC_DINH = "123456";

    public ArrayList<TayDua> timTayDua(String tuKhoa) throws SQLException {
        ArrayList<TayDua> danhSach = new ArrayList<>();
        String keyword = "%" + (tuKhoa == null ? "" : tuKhoa.trim()) + "%";

        String sql = """
                SELECT thanhVienHeThongid, hoTen, ngaySinh, quocTich, soHieuTayDua
                FROM tblTayDua
                WHERE hoTen LIKE ? OR soHieuTayDua LIKE ?
                ORDER BY hoTen
                """;

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, keyword);
            ps.setString(2, keyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Mỗi dòng kết quả tương ứng một đối tượng TayDua trong danh sách trả về.
                    TayDua tayDua = new TayDua();
                    tayDua.setId(rs.getInt("thanhVienHeThongid"));
                    tayDua.setHoTen(rs.getString("hoTen"));
                    tayDua.setNgaySinh(rs.getDate("ngaySinh").toLocalDate());
                    tayDua.setQuocTich(rs.getString("quocTich"));
                    tayDua.setSoHieuTayDua(rs.getString("soHieuTayDua"));
                    danhSach.add(tayDua);
                }
            }
        }

        return danhSach;
    }

    public boolean ktraTayDua(TayDua td) throws SQLException {
        // Số hiệu tay đua là duy nhất theo ràng buộc của bảng tblTayDua.
        String sql = """
                SELECT 1
                FROM tblTayDua
                WHERE soHieuTayDua = ?
                """;

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, td.getSoHieuTayDua());

            try (ResultSet rs = ps.executeQuery()) {
                return !rs.next();
            }
        }
    }

    public boolean themTayDua(TayDua td) throws SQLException {
        // tblTayDua cần một bản ghi cha ở tblThanhVienHeThong để lấy id làm khóa ngoại.
        String tenDangNhap = "taydua_" + td.getSoHieuTayDua();
        String sqlThanhVien = "INSERT INTO tblThanhVienHeThong(tenDangNhap, matKhau) VALUES(?, ?)";

        String sqlTayDua = """
                INSERT INTO tblTayDua (thanhVienHeThongid, hoTen, ngaySinh, quocTich, soHieuTayDua)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection cn = getConnection()) {
            cn.setAutoCommit(false);

            try {
                int thanhVienId;

                // Tạo thành viên hệ thống và lấy id vừa sinh ra.
                try (PreparedStatement ps = cn.prepareStatement(sqlThanhVien, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, tenDangNhap);
                    ps.setString(2, MAT_KHAU_MAC_DINH);
                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new SQLException("Không lấy được id của thành viên hệ thống vừa tạo.");
                        }
                        thanhVienId = rs.getInt(1);
                    }
                }

                try (PreparedStatement ps = cn.prepareStatement(sqlTayDua)) {
                    ps.setInt(1, thanhVienId);
                    ps.setString(2, td.getHoTen());
                    ps.setDate(3, java.sql.Date.valueOf(td.getNgaySinh()));
                    ps.setString(4, td.getQuocTich());
                    ps.setString(5, td.getSoHieuTayDua());
                    ps.executeUpdate();
                }

                cn.commit();
                return true;

            } catch (SQLException | RuntimeException e) {
                // Nếu một trong hai lần INSERT lỗi thì không lưu dở dang tài khoản cha.
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
