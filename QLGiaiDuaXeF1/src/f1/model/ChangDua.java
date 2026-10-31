package f1.model;

import java.time.LocalDate;
import java.util.ArrayList;

public class ChangDua {
    private int id;
    private String tenChangDua;
    private int soVongDua;
    private String diaDiem;
    private LocalDate thoiGianToChuc;
    private LocalDate ngayBatDauDangKi;
    private LocalDate ngayHetHanDangKi;
    private double tienThuongCoSo;
    private String trangThaiDangKi;
    private MuaGiai muaGiai;
    private ArrayList<TayDuaDangKi> tayDuaDangKi = new ArrayList<>();

    public ChangDua() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenChangDua() {
        return tenChangDua;
    }

    public void setTenChangDua(String tenChangDua) {
        this.tenChangDua = tenChangDua;
    }

    public int getSoVongDua() {
        return soVongDua;
    }

    public void setSoVongDua(int soVongDua) {
        this.soVongDua = soVongDua;
    }

    public String getDiaDiem() {
        return diaDiem;
    }

    public void setDiaDiem(String diaDiem) {
        this.diaDiem = diaDiem;
    }

    public LocalDate getThoiGianToChuc() {
        return thoiGianToChuc;
    }

    public void setThoiGianToChuc(LocalDate thoiGianToChuc) {
        this.thoiGianToChuc = thoiGianToChuc;
    }

    public LocalDate getNgayBatDauDangKi() {
        return ngayBatDauDangKi;
    }

    public void setNgayBatDauDangKi(LocalDate ngayBatDauDangKi) {
        this.ngayBatDauDangKi = ngayBatDauDangKi;
    }

    public LocalDate getNgayHetHanDangKi() {
        return ngayHetHanDangKi;
    }

    public void setNgayHetHanDangKi(LocalDate ngayHetHanDangKi) {
        this.ngayHetHanDangKi = ngayHetHanDangKi;
    }

    public double getTienThuongCoSo() {
        return tienThuongCoSo;
    }

    public void setTienThuongCoSo(double tienThuongCoSo) {
        this.tienThuongCoSo = tienThuongCoSo;
    }

    public String getTrangThaiDangKi() {
        return trangThaiDangKi;
    }

    public void setTrangThaiDangKi(String trangThaiDangKi) {
        this.trangThaiDangKi = trangThaiDangKi;
    }

    public MuaGiai getMuaGiai() {
        return muaGiai;
    }

    public void setMuaGiai(MuaGiai muaGiai) {
        this.muaGiai = muaGiai;
    }

    public ArrayList<TayDuaDangKi> getTayDuaDangKi() {
        return tayDuaDangKi;
    }

    public void setTayDuaDangKi(ArrayList<TayDuaDangKi> tayDuaDangKi) {
        this.tayDuaDangKi = tayDuaDangKi;
    }
}
