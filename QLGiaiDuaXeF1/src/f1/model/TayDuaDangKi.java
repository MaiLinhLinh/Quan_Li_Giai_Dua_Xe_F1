package f1.model;

public class TayDuaDangKi {
    private int id;
    private Integer thuHangVeDich;
    private Integer diemChang;
    private Integer thoiGianHoanThanh;
    private Integer soVongHoanThanh;
    private String trangThai;
    private ChangDua changDua;
    private TayDuaDoiDua tayDuaDoiDua;

    public TayDuaDangKi() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getThuHangVeDich() {
        return thuHangVeDich;
    }

    public void setThuHangVeDich(Integer thuHangVeDich) {
        this.thuHangVeDich = thuHangVeDich;
    }

    public Integer getDiemChang() {
        return diemChang;
    }

    public void setDiemChang(Integer diemChang) {
        this.diemChang = diemChang;
    }

    public Integer getThoiGianHoanThanh() {
        return thoiGianHoanThanh;
    }

    public void setThoiGianHoanThanh(Integer thoiGianHoanThanh) {
        this.thoiGianHoanThanh = thoiGianHoanThanh;
    }

    public Integer getSoVongHoanThanh() {
        return soVongHoanThanh;
    }

    public void setSoVongHoanThanh(Integer soVongHoanThanh) {
        this.soVongHoanThanh = soVongHoanThanh;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public ChangDua getChangDua() {
        return changDua;
    }

    public void setChangDua(ChangDua changDua) {
        this.changDua = changDua;
    }

    public TayDuaDoiDua getTayDuaDoiDua() {
        return tayDuaDoiDua;
    }

    public void setTayDuaDoiDua(TayDuaDoiDua tayDuaDoiDua) {
        this.tayDuaDoiDua = tayDuaDoiDua;
    }
}
