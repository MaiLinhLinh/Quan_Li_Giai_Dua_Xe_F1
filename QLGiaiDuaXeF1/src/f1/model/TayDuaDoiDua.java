package f1.model;

import java.time.LocalDate;
import java.util.ArrayList;

public class TayDuaDoiDua {
    private int id;
    private LocalDate ngayBatDau;
    private LocalDate ngayKetThuc;
    private TayDua tayDua;
    private DoiDua doiDua;
    private ArrayList<TayDuaDangKi> tayDuaDangKi = new ArrayList<>();

    public TayDuaDoiDua() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public TayDua getTayDua() {
        return tayDua;
    }

    public void setTayDua(TayDua tayDua) {
        this.tayDua = tayDua;
    }

    public DoiDua getDoiDua() {
        return doiDua;
    }

    public void setDoiDua(DoiDua doiDua) {
        this.doiDua = doiDua;
    }

    public ArrayList<TayDuaDangKi> getTayDuaDangKi() {
        return tayDuaDangKi;
    }

    public void setTayDuaDangKi(ArrayList<TayDuaDangKi> tayDuaDangKi) {
        this.tayDuaDangKi = tayDuaDangKi;
    }
}
