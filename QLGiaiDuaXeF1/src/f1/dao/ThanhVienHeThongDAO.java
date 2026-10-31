package f1.dao;

import f1.model.ThanhVienHeThong;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ThanhVienHeThongDAO extends DAO {

    /**
     * Kiểm tra đăng nhập theo hợp đồng DAO trong tài liệu yêu cầu.
     * Khi hợp lệ, id của bản ghi được gán lại vào đối tượng đầu vào để DAO
     * BanToChuc có thể dùng đối tượng này truy vấn thông tin Ban tổ chức.
     */
    public boolean ktraDangNhap(ThanhVienHeThong thanhVien) throws SQLException {
        if (thanhVien == null || thanhVien.getTenDangNhap() == null || thanhVien.getMatKhau() == null) {
            return false;
        }
        String sql = "SELECT id, tenDangNhap, matKhau FROM tblThanhVienHeThong "
                + "WHERE tenDangNhap = ? AND matKhau = ?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, thanhVien.getTenDangNhap());
            ps.setString(2, thanhVien.getMatKhau());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Gán lại id từ CSDL để dùng tiếp khi lấy thông tin Ban tổ chức.
                    thanhVien.setId(rs.getInt("id"));
                    thanhVien.setTenDangNhap(rs.getString("tenDangNhap"));
                    thanhVien.setMatKhau(rs.getString("matKhau"));
                    return true;
                }
            }
        }
        return false;
    }

}
