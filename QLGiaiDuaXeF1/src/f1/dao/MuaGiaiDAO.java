package f1.dao;

import f1.model.GiaiDua;
import f1.model.MuaGiai;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MuaGiaiDAO extends DAO {

    public ArrayList<MuaGiai> timMuaGiai(String tuKhoa) throws SQLException {
        ArrayList<MuaGiai> danhSach = new ArrayList<>();
        String keyword = "%" + (tuKhoa == null ? "" : tuKhoa.trim()) + "%";
        String sql = "SELECT mg.id AS muaGiaiId, mg.tenMuaGiai, mg.namToChuc, mg.ngayBatDau, mg.ngayKetThuc, "
                + "gd.id AS giaiDuaId, gd.tenGiaiDua, gd.moTa "
                + "FROM tblMuaGiai mg INNER JOIN tblGiaiDua gd ON mg.giaiDuaId = gd.id "
                + "WHERE mg.tenMuaGiai LIKE ? OR CAST(mg.namToChuc AS NVARCHAR(4)) LIKE ? "
                + "ORDER BY mg.namToChuc DESC, mg.tenMuaGiai";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Một mùa giải luôn thuộc một giải đua, nên đọc cả hai đối tượng từ JOIN.
                    GiaiDua giaiDua = new GiaiDua();
                    giaiDua.setId(rs.getInt("giaiDuaId"));
                    giaiDua.setTenGiaiDua(rs.getString("tenGiaiDua"));
                    giaiDua.setMoTa(rs.getString("moTa"));

                    MuaGiai muaGiai = new MuaGiai();
                    muaGiai.setId(rs.getInt("muaGiaiId"));
                    muaGiai.setTenMuaGiai(rs.getString("tenMuaGiai"));
                    muaGiai.setNamToChuc(rs.getInt("namToChuc"));
                    muaGiai.setNgayBatDau(rs.getDate("ngayBatDau").toLocalDate());
                    muaGiai.setNgayKetThuc(rs.getDate("ngayKetThuc").toLocalDate());
                    muaGiai.setGiaiDua(giaiDua);
                    danhSach.add(muaGiai);
                }
            }
        }
        return danhSach;
    }
}
