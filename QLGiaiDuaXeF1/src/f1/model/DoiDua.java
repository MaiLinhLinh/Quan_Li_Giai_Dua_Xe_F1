package f1.model;

import java.util.ArrayList;

public class DoiDua extends ThanhVienHeThong {
    private String tenDoiDua;
    private String hang;
    private String moTa;
    private String trangThaiDangKi;
    private ArrayList<TayDuaDoiDua> tayDuaDoiDua = new ArrayList<>();

    public DoiDua() {
    }

    public String getTenDoiDua() {
        return tenDoiDua;
    }

    public void setTenDoiDua(String tenDoiDua) {
        this.tenDoiDua = tenDoiDua;
    }

    public String getHang() {
        return hang;
    }

    public void setHang(String hang) {
        this.hang = hang;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getTrangThaiDangKi() {
        return trangThaiDangKi;
    }

    public void setTrangThaiDangKi(String trangThaiDangKi) {
        this.trangThaiDangKi = trangThaiDangKi;
    }

    public ArrayList<TayDuaDoiDua> getTayDuaDoiDua() {
        return tayDuaDoiDua;
    }

    public void setTayDuaDoiDua(ArrayList<TayDuaDoiDua> tayDuaDoiDua) {
        this.tayDuaDoiDua = tayDuaDoiDua;
    }
}
