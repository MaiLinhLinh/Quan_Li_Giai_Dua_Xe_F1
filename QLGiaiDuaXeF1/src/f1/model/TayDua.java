package f1.model;

import java.time.LocalDate;

public class TayDua extends ThanhVienHeThong {
    private String hoTen;
    private LocalDate ngaySinh;
    private String quocTich;
    private String soHieuTayDua;

    public TayDua() {
    }

    public TayDua(int id, String hoTen, LocalDate ngaySinh, String quocTich, String soHieuTayDua) {
        setId(id);
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.quocTich = quocTich;
        this.soHieuTayDua = soHieuTayDua;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public LocalDate getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(LocalDate ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getQuocTich() {
        return quocTich;
    }

    public void setQuocTich(String quocTich) {
        this.quocTich = quocTich;
    }

    public String getSoHieuTayDua() {
        return soHieuTayDua;
    }

    public void setSoHieuTayDua(String soHieuTayDua) {
        this.soHieuTayDua = soHieuTayDua;
    }
}
