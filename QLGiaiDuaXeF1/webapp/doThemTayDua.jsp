<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, f1.model.TayDua, f1.dao.TayDuaDAO, f1.util.DateUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");

    String hoTen = request.getParameter("hoTen");
    String ngaySinhStr = request.getParameter("ngaySinh");
    String quocTich = request.getParameter("quocTich");
    String soHieuTayDua = request.getParameter("soHieuTayDua");
    String ctx = request.getContextPath();

    String thongBaoLoi = null;

    if (hoTen == null || hoTen.trim().isEmpty()
            || ngaySinhStr == null || ngaySinhStr.trim().isEmpty()
            || quocTich == null || quocTich.trim().isEmpty()
            || soHieuTayDua == null || soHieuTayDua.trim().isEmpty()) {
        thongBaoLoi = "Vui lòng nhập đầy đủ họ tên, ngày sinh, quốc tịch và số hiệu tay đua.";
    } else {
        try {
            LocalDate ngaySinh = DateUtil.parse(ngaySinhStr);
            String soHieu = soHieuTayDua.trim();

            TayDua td = new TayDua();
            td.setHoTen(hoTen.trim());
            td.setNgaySinh(ngaySinh);
            td.setQuocTich(quocTich.trim());
            td.setSoHieuTayDua(soHieu);

            TayDuaDAO dao = new TayDuaDAO();
            if (!dao.ktraTayDua(td)) {
                thongBaoLoi = "Số hiệu tay đua đã tồn tại, vui lòng nhập lại.";
            } else {
                if (dao.themTayDua(td)) {
                    response.sendRedirect(ctx + "/gdTimTayDua.jsp?msg=added");
                    return;
                }
                thongBaoLoi = "Thêm tay đua không thành công. Vui lòng thử lại.";
            }
        } catch (IllegalArgumentException e) {
            thongBaoLoi = "Ngày sinh không hợp lệ.";
        } catch (Exception e) {
            e.printStackTrace();
            thongBaoLoi = "Lỗi hệ thống: " + e.getMessage();
        }
    }

    request.setAttribute("error", thongBaoLoi);
    request.getRequestDispatcher("/gdThemTayDua.jsp").forward(request, response);
%>
