package f1.model;

import java.util.ArrayList;

public class GiaiDua {
    private int id;
    private String tenGiaiDua;
    private String moTa;
    private ArrayList<MuaGiai> muaGiai = new ArrayList<>();

    public GiaiDua() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenGiaiDua() {
        return tenGiaiDua;
    }

    public void setTenGiaiDua(String tenGiaiDua) {
        this.tenGiaiDua = tenGiaiDua;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public ArrayList<MuaGiai> getMuaGiai() {
        return muaGiai;
    }

    public void setMuaGiai(ArrayList<MuaGiai> muaGiai) {
        this.muaGiai = muaGiai;
    }
}
