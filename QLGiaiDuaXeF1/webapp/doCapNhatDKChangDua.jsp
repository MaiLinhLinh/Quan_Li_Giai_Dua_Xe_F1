<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.HashSet, java.util.Set, f1.dao.ChangDuaDAO, f1.model.ChangDua, f1.model.DoiDua, f1.model.TayDuaDangKi, f1.model.TayDuaDoiDua" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    ChangDua changDua = (ChangDua) session.getAttribute("changDuaDangChon");
    ArrayList<DoiDua> dsDoiDua = (ArrayList<DoiDua>) session.getAttribute("dsDoiDua");
    String doiDuaIdText = request.getParameter("doiDuaId");
    String[] tayDuaDoiDuaIds = request.getParameterValues("tayDuaDoiDuaIds");
    DoiDua doiDua = null;
    String loi = null;

    try {
        int doiDuaId = Integer.parseInt(doiDuaIdText);
        if (dsDoiDua != null) {
            for (DoiDua item : dsDoiDua) {
                if (item.getId() == doiDuaId) {
                    doiDua = item;
                    break;
                }
            }
        }
    } catch (Exception e) {
        loi = "Đội đua được chọn không hợp lệ.";
    }

    if (changDua == null || doiDua == null) {
        session.setAttribute("module2Error", loi == null ? "Phiên làm việc đã hết. Hãy chọn lại đội đua." : loi);
        response.sendRedirect(request.getContextPath() + "/gdTimMuaGiai.jsp");
        return;
    }

    if (tayDuaDoiDuaIds == null || tayDuaDoiDuaIds.length != 2) {
        session.setAttribute("module2Error", "Mỗi đội phải chọn đúng 2 tay đua cho một chặng đua.");
        response.sendRedirect(request.getContextPath() + "/gdDKTayDua.jsp?doiDuaId=" + doiDua.getId());
        return;
    }

    ArrayList<TayDuaDangKi> danhSachDangKi = new ArrayList<TayDuaDangKi>();
    Set<Integer> daChon = new HashSet<Integer>();

    for (String idText : tayDuaDoiDuaIds) {
        try {
            int tayDuaDoiDuaId = Integer.parseInt(idText);
            TayDuaDoiDua tayDuaDoiDua = null;

            // Chỉ chấp nhận tay đua thuộc đúng đội đang hiển thị, không tin trực tiếp dữ liệu gửi từ trình duyệt.
            for (TayDuaDoiDua item : doiDua.getTayDuaDoiDua()) {
                if (item.getId() == tayDuaDoiDuaId) {
                    tayDuaDoiDua = item;
                    break;
                }
            }

            if (tayDuaDoiDua == null || !daChon.add(tayDuaDoiDuaId)) {
                loi = "Danh sách tay đua được chọn không hợp lệ.";
                break;
            }

            TayDuaDangKi dangKi = new TayDuaDangKi();
            dangKi.setChangDua(changDua);
            dangKi.setTayDuaDoiDua(tayDuaDoiDua);
            danhSachDangKi.add(dangKi);
        } catch (NumberFormatException e) {
            loi = "Danh sách tay đua được chọn không hợp lệ.";
            break;
        }
    }

    if (loi != null || danhSachDangKi.size() != 2) {
        session.setAttribute("module2Error", loi == null ? "Mỗi đội phải chọn đúng 2 tay đua." : loi);
        response.sendRedirect(request.getContextPath() + "/gdDKTayDua.jsp?doiDuaId=" + doiDua.getId());
        return;
    }

    // List này chỉ chứa hai đăng kí cần lưu của đội đang chọn; DAO chỉ xóa đăng kí cũ của đội đó.
    changDua.setTayDuaDangKi(danhSachDangKi);

    try {
        boolean thanhCong = new ChangDuaDAO().capNhatChangDua(changDua);
        if (thanhCong) {
            session.setAttribute("module2Message", "Đã lưu đăng kí 2 tay đua cho đội " + doiDua.getTenDoiDua() + ".");
            response.sendRedirect(request.getContextPath() + "/gdTimDoiDua.jsp?changDuaId=" + changDua.getId());
        } else {
            session.setAttribute("module2Error", "Không thể lưu đăng kí. Kiểm tra lại hai tay đua đã chọn.");
            response.sendRedirect(request.getContextPath() + "/gdDKTayDua.jsp?doiDuaId=" + doiDua.getId());
        }
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("module2Error", "Không thể lưu đăng kí. Vui lòng kiểm tra kết nối cơ sở dữ liệu.");
        response.sendRedirect(request.getContextPath() + "/gdDKTayDua.jsp?doiDuaId=" + doiDua.getId());
    }
%>
