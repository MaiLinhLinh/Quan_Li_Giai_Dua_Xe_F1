package f1.model;

public class ThanhVienHeThong {
    private int id;
    private String tenDangNhap;
    private String matKhau;

    public ThanhVienHeThong() {
    }

    public ThanhVienHeThong(int id, String tenDangNhap, String matKhau) {
        this.id = id;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }
}
