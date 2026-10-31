<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, f1.dao.MuaGiaiDAO, f1.model.MuaGiai, f1.util.DateUtil, f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String tuKhoa = request.getParameter("tuKhoa");
    if (tuKhoa == null) {
        tuKhoa = "";
    }

    String loi = (String) session.getAttribute("module2Error");
    session.removeAttribute("module2Error");
    String thongBao = (String) session.getAttribute("module2Message");
    session.removeAttribute("module2Message");
    ArrayList<MuaGiai> danhSach = new ArrayList<MuaGiai>();

    if (tuKhoa.trim().isEmpty()) {
        session.removeAttribute("dsMuaGiai");
    } else {
        try {
            danhSach = new MuaGiaiDAO().timMuaGiai(tuKhoa);
            session.setAttribute("dsMuaGiai", danhSach);
        } catch (Exception e) {
            e.printStackTrace();
            loi = "Không tải được danh sách mùa giải. Vui lòng kiểm tra kết nối cơ sở dữ liệu.";
        }
    }

    request.setAttribute("pageTitle", "Tìm mùa giải");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng">
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a>
    <span class="mx-2 text-slate-300">/</span>
    <span class="text-slate-700">Đăng kí tay đua vào chặng đua</span>
</nav>

<section class="mb-8 border-b border-slate-200 pb-6">
    <p class="page-kicker">Chức năng 2</p>
    <h1 class="mt-1 text-3xl font-extrabold tracking-tight text-slate-900">Chọn mùa giải</h1>
    <p class="mt-2 text-slate-500">Tìm theo tên mùa giải hoặc năm tổ chức, sau đó chọn mùa giải cần điều hành.</p>
</section>

<% if (thongBao != null && !thongBao.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-emerald-300 bg-emerald-50 px-4 py-3 text-sm text-emerald-800"><%= HtmlUtil.escape(thongBao) %></div>
<% } %>
<% if (loi != null && !loi.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(loi) %></div>
<% } %>

<section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="border-b border-slate-200 px-5 py-5 sm:px-6">
        <h2 class="text-lg font-bold text-slate-900">Danh sách mùa giải</h2>
        <p class="mt-1 text-sm text-slate-500">Nhấn đúp vào một mùa giải để tiếp tục tìm chặng đua.</p>
    </div>
    <div class="p-5 sm:p-6">
        <form action="<%= ctx %>/gdTimMuaGiai.jsp" method="get" class="mb-6 flex flex-col gap-2 sm:flex-row">
            <input type="text" name="tuKhoa" value="<%= HtmlUtil.escape(tuKhoa) %>" placeholder="Ví dụ: 2026 hoặc Giải vô địch F1"
                   class="min-w-0 flex-1 rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
            <button type="submit" class="action-control px-5 py-2.5 text-sm shadow-sm">Tìm kiếm</button>
        </form>

        <div class="overflow-x-auto rounded-lg border border-slate-200">
            <table class="w-full table-f1 border-collapse">
                <thead>
                    <tr>
                        <th class="w-16">TT</th>
                        <th>Tên mùa giải</th>
                        <th>Năm tổ chức</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (tuKhoa.trim().isEmpty()) { %>
                        <tr><td colspan="5" class="px-4 py-12 text-center text-slate-500">Nhập tên mùa giải hoặc năm tổ chức để tìm kiếm.</td></tr>
                    <% } else if (danhSach.isEmpty()) { %>
                        <tr><td colspan="5" class="px-4 py-12 text-center text-slate-500">Không tìm thấy mùa giải phù hợp.</td></tr>
                    <% } else { int stt = 1; for (MuaGiai muaGiai : danhSach) { %>
                        <tr class="cursor-pointer" title="Nhấn đúp để chọn mùa giải"
                            ondblclick="window.location.href='<%= ctx %>/gdTimChangDua.jsp?muaGiaiId=<%= muaGiai.getId() %>'">
                            <td><%= stt++ %></td>
                            <td class="font-semibold text-slate-900"><%= HtmlUtil.escape(muaGiai.getTenMuaGiai()) %></td>
                            <td><%= muaGiai.getNamToChuc() %></td>
                            <td><%= DateUtil.format(muaGiai.getNgayBatDau()) %></td>
                            <td><%= DateUtil.format(muaGiai.getNgayKetThuc()) %></td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
        <div class="mt-5 border-t border-slate-200 pt-5">
            <a href="<%= ctx %>/gdChinhBTC.jsp" class="text-sm font-semibold text-slate-600 hover:text-slate-900">← Quay lại trang chủ</a>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
