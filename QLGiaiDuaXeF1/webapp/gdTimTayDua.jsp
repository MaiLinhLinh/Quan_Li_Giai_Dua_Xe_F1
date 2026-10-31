<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, f1.model.TayDua, f1.dao.TayDuaDAO, f1.util.DateUtil, f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String tuKhoa = request.getParameter("tuKhoa");
    if (tuKhoa == null) tuKhoa = "";
    ArrayList<TayDua> danhSach = null;
    String loi = request.getParameter("error");
    try { danhSach = tuKhoa.trim().isEmpty() ? new ArrayList<TayDua>() : new TayDuaDAO().timTayDua(tuKhoa); }
    catch (Exception e) { e.printStackTrace(); if (loi == null || loi.isEmpty()) loi = "Không tải được danh sách tay đua. Vui lòng kiểm tra kết nối cơ sở dữ liệu."; }
    String msg = request.getParameter("msg");
    request.setAttribute("pageTitle", "Quản lý thông tin tay đua");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng"><a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a><span class="mx-2 text-slate-300">/</span><span class="text-slate-700">Quản lý tay đua</span></nav>
<section class="mb-8 flex flex-wrap items-end justify-between gap-4 border-b border-slate-200 pb-6">
    <div><p class="page-kicker">Chức năng 1</p><h1 class="mt-1 text-3xl font-extrabold tracking-tight text-slate-900">Quản lý thông tin tay đua</h1><p class="mt-2 text-slate-500">Tìm kiếm theo họ tên hoặc số hiệu; thêm mới tay đua theo yêu cầu của Ban tổ chức.</p></div>
    <a href="<%= ctx %>/gdThemTayDua.jsp" class="action-control inline-flex items-center px-4 py-2.5 text-sm shadow-sm">+ Thêm tay đua mới</a>
</section>
<% if ("added".equals(msg)) { %><div class="mb-6 rounded-lg border border-emerald-300 bg-emerald-50 px-4 py-3 text-sm text-emerald-800">Thêm tay đua mới thành công.</div><% } %>
<% if (loi != null && !loi.isEmpty()) { %><div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(loi) %></div><% } %>

<section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="flex flex-col gap-3 border-b border-slate-200 px-5 py-5 sm:flex-row sm:items-center sm:justify-between sm:px-6"><div><h2 class="text-lg font-bold text-slate-900">Danh sách tay đua</h2><p class="mt-1 text-sm text-slate-500">Nhập từ khóa để bắt đầu tìm kiếm.</p></div><span class="text-xs font-semibold text-slate-400">M1 · Quản lý tay đua</span></div>
    <div class="p-5 sm:p-6">
        <form action="<%= ctx %>/gdTimTayDua.jsp" method="get" class="mb-6 flex flex-col gap-2 sm:flex-row"><input type="text" name="tuKhoa" value="<%= HtmlUtil.escape(tuKhoa) %>" placeholder="Nhập tên hoặc số hiệu tay đua" class="min-w-0 flex-1 rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"><button type="submit" class="action-control px-5 py-2.5 text-sm shadow-sm">Tìm kiếm</button></form>
        <div class="overflow-x-auto rounded-lg border border-slate-200"><table class="w-full table-f1 border-collapse"><thead><tr><th class="w-16">STT</th><th>Họ tên</th><th>Ngày sinh</th><th>Quốc tịch</th><th>Số hiệu tay đua</th><th class="w-24 text-center">Sửa</th><th class="w-24 text-center">Xoá</th></tr></thead><tbody>
            <% if (danhSach == null || danhSach.isEmpty()) { %><tr><td colspan="7" class="px-4 py-12 text-center text-slate-500">Chưa có kết quả. Hãy nhập họ tên hoặc số hiệu để tìm kiếm.</td></tr><% } else { int stt = 1; for (TayDua t : danhSach) { %>
            <tr><td><%= stt++ %></td><td class="font-semibold text-slate-900"><%= HtmlUtil.escape(t.getHoTen()) %></td><td><%= DateUtil.format(t.getNgaySinh()) %></td><td><%= HtmlUtil.escape(t.getQuocTich()) %></td><td class="font-bold text-red-600"><%= HtmlUtil.escape(t.getSoHieuTayDua()) %></td><td class="text-center"><button type="button" disabled title="Chức năng chưa triển khai trong module M1" class="cursor-not-allowed rounded bg-blue-600 px-3 py-1 text-xs font-semibold text-white opacity-50">Sửa</button></td><td class="text-center"><button type="button" disabled title="Chức năng chưa triển khai trong module M1" class="cursor-not-allowed rounded bg-rose-600 px-3 py-1 text-xs font-semibold text-white opacity-50">Xoá</button></td></tr>
            <% } } %>
        </tbody></table></div>
        <div class="mt-5 flex flex-wrap items-center justify-between gap-3 border-t border-slate-200 pt-5"><a href="<%= ctx %>/gdChinhBTC.jsp" class="text-sm font-semibold text-slate-600 hover:text-slate-900">← Quay lại trang chủ</a><span class="text-xs text-slate-400">Sửa và xoá sẽ được bổ sung sau.</span></div>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
