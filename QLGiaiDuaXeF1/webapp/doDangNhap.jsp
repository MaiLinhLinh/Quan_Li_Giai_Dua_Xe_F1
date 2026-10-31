<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="f1.dao.ThanhVienHeThongDAO, f1.dao.BanToChucDAO" %>
<%@ page import="f1.model.ThanhVienHeThong, f1.model.BanToChuc" %>
<%
    request.setCharacterEncoding("UTF-8");

    String tenDangNhap = request.getParameter("tenDangNhap");
    String matKhau = request.getParameter("matKhau");
    String ctx = request.getContextPath();

    if (tenDangNhap == null || tenDangNhap.trim().isEmpty()
            || matKhau == null || matKhau.isEmpty()) {
        session.setAttribute("loginError", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
        response.sendRedirect(ctx + "/gdDangNhap.jsp");
        return;
    }

    try {
        ThanhVienHeThongDAO thanhVienDAO = new ThanhVienHeThongDAO();
        ThanhVienHeThong thanhVien = new ThanhVienHeThong();
        thanhVien.setTenDangNhap(tenDangNhap.trim());
        thanhVien.setMatKhau(matKhau);

        if (thanhVienDAO.ktraDangNhap(thanhVien)) {
            BanToChucDAO banToChucDAO = new BanToChucDAO();
            BanToChuc banToChuc = banToChucDAO.layThongTinBTC(thanhVien);

            if (banToChuc != null) {
                session.setAttribute("thanhVien", thanhVien);
                session.setAttribute("banToChuc", banToChuc);
                response.sendRedirect(ctx + "/gdChinhBTC.jsp");
                return;
            }
        }

        session.setAttribute("loginError", "Tên đăng nhập hoặc mật khẩu không đúng.");
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("loginError", "Không thể kết nối cơ sở dữ liệu. Vui lòng kiểm tra lại cấu hình.");
    }

    response.sendRedirect(ctx + "/gdDangNhap.jsp");
%>
