package f1.model;

import java.time.LocalDate;
import java.util.ArrayList;

public class MuaGiai {
    private int id;
    private String tenMuaGiai;
    private int namToChuc;
    private LocalDate ngayBatDau;
    private LocalDate ngayKetThuc;
    private GiaiDua giaiDua;
    private ArrayList<ChangDua> changDua = new ArrayList<>();

    public MuaGiai() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenMuaGiai() {
        return tenMuaGiai;
    }

    public void setTenMuaGiai(String tenMuaGiai) {
        this.tenMuaGiai = tenMuaGiai;
    }

    public int getNamToChuc() {
        return namToChuc;
    }

    public void setNamToChuc(int namToChuc) {
        this.namToChuc = namToChuc;
    }

    public LocalDate getNgayBatDau() {
        return ngayBatDau;
    }

    public void setNgayBatDau(LocalDate ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public LocalDate getNgayKetThuc() {
        return ngayKetThuc;
    }

    public void setNgayKetThuc(LocalDate ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public GiaiDua getGiaiDua() {
        return giaiDua;
    }

    public void setGiaiDua(GiaiDua giaiDua) {
        this.giaiDua = giaiDua;
    }

    public ArrayList<ChangDua> getChangDua() {
        return changDua;
    }

    public void setChangDua(ArrayList<ChangDua> changDua) {
        this.changDua = changDua;
    }
}
