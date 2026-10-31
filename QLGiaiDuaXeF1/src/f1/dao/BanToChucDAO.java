package f1.dao;

import f1.model.BanToChuc;
import f1.model.ThanhVienHeThong;
import f1.util.TextEncodingUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BanToChucDAO extends DAO {

    public BanToChuc layThongTinBTC(ThanhVienHeThong thanhVien) throws SQLException {
        if (thanhVien == null) {
            return null;
        }

        String sql = "SELECT thanhVienHeThongid, hoTen, diaChi, ngaySinh, email, soDienThoai, viTriCongViec "
                + "FROM tblBanToChuc WHERE thanhVienHeThongid = ?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, thanhVien.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // tblBanToChuc dùng id của thành viên hệ thống làm khóa chính.
                    BanToChuc btc = new BanToChuc();
                    btc.setId(rs.getInt("thanhVienHeThongid"));
                    btc.setHoTen(TextEncodingUtil.repairMojibake(rs.getString("hoTen")));
                    btc.setDiaChi(TextEncodingUtil.repairMojibake(rs.getString("diaChi")));
                    btc.setNgaySinh(rs.getDate("ngaySinh").toLocalDate());
                    btc.setEmail(rs.getString("email"));
                    btc.setSoDienThoai(rs.getString("soDienThoai"));
                    btc.setViTriCongViec(TextEncodingUtil.repairMojibake(rs.getString("viTriCongViec")));
                    return btc;
                }
            }
        }
        return null;
    }
}
