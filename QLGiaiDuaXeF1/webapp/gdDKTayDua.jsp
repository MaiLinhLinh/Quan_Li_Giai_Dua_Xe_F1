<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, f1.model.ChangDua, f1.model.DoiDua, f1.model.TayDuaDoiDua, f1.util.DateUtil, f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String loi = (String) session.getAttribute("module2Error");
    session.removeAttribute("module2Error");
    ChangDua changDua = (ChangDua) session.getAttribute("changDuaDangChon");
    ArrayList<DoiDua> dsDoiDua = (ArrayList<DoiDua>) session.getAttribute("dsDoiDua");
    DoiDua doiDua = null;

    try {
        int doiDuaId = Integer.parseInt(request.getParameter("doiDuaId"));
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
        session.setAttribute("module2Error", loi == null ? "Hãy tìm và chọn đội đua trước." : loi);
        response.sendRedirect(request.getContextPath() + "/gdTimMuaGiai.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Đăng kí tay đua");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng">
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a>
    <span class="mx-2 text-slate-300">/</span>
    <span class="text-slate-700">Đăng kí tay đua</span>
</nav>

<section class="mb-8 border-b border-slate-200 pb-6">
    <p class="page-kicker">Chức năng 2 · <%= HtmlUtil.escape(doiDua.getTenDoiDua()) %></p>
    <h1 class="mt-1 text-3xl font-extrabold tracking-tight text-slate-900">Đăng kí tay đua vào chặng</h1>
    <p class="mt-2 text-slate-500">Chọn đúng 2 tay đua của đội <span class="font-semibold"><%= HtmlUtil.escape(doiDua.getTenDoiDua()) %></span> cho chặng <span class="font-semibold"><%= HtmlUtil.escape(changDua.getTenChangDua()) %></span>.</p>
</section>

<% if (loi != null && !loi.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(loi) %></div>
<% } %>

<section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="border-b border-slate-200 px-5 py-5 sm:px-6">
        <h2 class="text-lg font-bold text-slate-900">Tay đua thuộc đội</h2>
        <p class="mt-1 text-sm text-slate-500">Các tay đua đã đăng kí trước được đánh dấu sẵn. Ngày đua: <span class="font-semibold"><%= DateUtil.format(changDua.getThoiGianToChuc()) %></span>.</p>
    </div>
    <form action="<%= ctx %>/doCapNhatDKChangDua.jsp" method="post" class="p-5 sm:p-6">
        <input type="hidden" name="doiDuaId" value="<%= doiDua.getId() %>">
        <div class="overflow-x-auto rounded-lg border border-slate-200">
            <table class="w-full table-f1 border-collapse">
                <thead>
                    <tr>
                        <th class="w-16 text-center">Chọn</th>
                        <th class="w-16">TT</th>
                        <th>Họ tên</th>
                        <th>Ngày sinh</th>
                        <th>Quốc tịch</th>
                        <th>Số hiệu</th>
                        <th>Thời hạn hợp đồng</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (doiDua.getTayDuaDoiDua().isEmpty()) { %>
                        <tr><td colspan="7" class="px-4 py-12 text-center text-slate-500">Đội chưa có tay đua hợp lệ tại thời điểm chặng diễn ra.</td></tr>
                    <% } else { int stt = 1; for (TayDuaDoiDua tayDuaDoiDua : doiDua.getTayDuaDoiDua()) { boolean daDangKi = !tayDuaDoiDua.getTayDuaDangKi().isEmpty(); %>
                        <tr>
                            <td class="text-center">
                                <input type="checkbox" name="tayDuaDoiDuaIds" value="<%= tayDuaDoiDua.getId() %>" <%= daDangKi ? "checked" : "" %>
                            </td>
                            <td><%= stt++ %></td>
                            <td class="font-semibold text-slate-900"><%= HtmlUtil.escape(tayDuaDoiDua.getTayDua().getHoTen()) %></td>
                            <td><%= DateUtil.format(tayDuaDoiDua.getTayDua().getNgaySinh()) %></td>
                            <td><%= HtmlUtil.escape(tayDuaDoiDua.getTayDua().getQuocTich()) %></td>
                            <td class="font-bold text-red-600"><%= HtmlUtil.escape(tayDuaDoiDua.getTayDua().getSoHieuTayDua()) %></td>
                            <td><%= DateUtil.format(tayDuaDoiDua.getNgayBatDau()) %> - <%= tayDuaDoiDua.getNgayKetThuc() == null ? "Hiện tại" : DateUtil.format(tayDuaDoiDua.getNgayKetThuc()) %></td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
        <p class="mt-4 text-sm text-slate-500">Hệ thống sẽ thay thế đăng kí cũ của riêng đội này tại chặng đang chọn.</p>
        <div class="mt-5 flex flex-col-reverse gap-3 border-t border-slate-200 pt-5 sm:flex-row sm:items-center sm:justify-between">
            <a href="<%= ctx %>/gdTimMuaGiai.jsp" class="action-control inline-flex justify-center px-4 py-2.5 text-sm">Quay lại</a>
            <button type="submit" class="action-control px-6 py-2.5 text-sm shadow-sm">Lưu đăng kí</button>
        </div>
    </form>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
