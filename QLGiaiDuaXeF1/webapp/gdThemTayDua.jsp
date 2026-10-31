<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String error = (String) request.getAttribute("error");
    String hoTen = request.getParameter("hoTen");
    String ngaySinh = request.getParameter("ngaySinh");
    String quocTich = request.getParameter("quocTich");
    String soHieuTayDua = request.getParameter("soHieuTayDua");
    request.setAttribute("pageTitle", "Thêm mới tay đua");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng">
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a>
    <span class="mx-2 text-slate-300">/</span><span>Quản lý tay đua</span>
    <span class="mx-2 text-slate-300">/</span><span class="text-slate-700">Thêm mới</span>
</nav>

<section class="mb-8 flex flex-col justify-between gap-4 border-b border-slate-200 pb-6 sm:flex-row sm:items-end">
    <div>
        <p class="page-kicker mb-2">Chức năng 1</p>
        <h1 class="text-3xl font-extrabold tracking-tight text-slate-900">Thêm mới tay đua</h1>
        <p class="mt-2 max-w-2xl text-slate-500">Tạo hồ sơ tay đua để ban tổ chức quản lý thông tin và sử dụng trong các bước tiếp theo của giải đấu.</p>
    </div>
    <a href="<%= ctx %>/gdTimTayDua.jsp" class="action-control inline-flex items-center justify-center px-4 py-2.5 text-sm shadow-sm">← Danh sách tay đua</a>
</section>

<% if (error != null && !error.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(error) %></div>
<% } %>

<div class="grid gap-6 xl:grid-cols-[minmax(0,2fr)_minmax(300px,1fr)]">
    <section class="rounded-xl border border-slate-200 bg-white shadow-sm">
        <div class="border-b border-slate-200 px-6 py-5">
            <h2 class="text-lg font-bold text-slate-900">Thông tin tay đua</h2>
            <p class="mt-1 text-sm text-slate-500">Các trường có dấu <span class="text-red-600">*</span> là bắt buộc.</p>
        </div>
        <form action="<%= ctx %>/doThemTayDua.jsp" method="post" class="p-6">
            <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                <div>
                    <label for="hoTen" class="mb-1.5 block text-sm font-semibold text-slate-700">Họ tên <span class="text-red-600">*</span></label>
                    <input id="hoTen" name="hoTen" type="text" required value="<%= HtmlUtil.escape(hoTen) %>" placeholder="Ví dụ: Lê Minh Anh" class="w-full rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
                </div>
                <div>
                    <label for="ngaySinh" class="mb-1.5 block text-sm font-semibold text-slate-700">Ngày sinh <span class="text-red-600">*</span></label>
                    <input id="ngaySinh" name="ngaySinh" type="date" required value="<%= HtmlUtil.escape(ngaySinh) %>" class="w-full rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
                </div>
                <div>
                    <label for="quocTich" class="mb-1.5 block text-sm font-semibold text-slate-700">Quốc tịch <span class="text-red-600">*</span></label>
                    <input id="quocTich" name="quocTich" type="text" required value="<%= HtmlUtil.escape(quocTich) %>" placeholder="Ví dụ: Việt Nam" class="w-full rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
                </div>
                <div>
                    <label for="soHieuTayDua" class="mb-1.5 block text-sm font-semibold text-slate-700">Số hiệu tay đua <span class="text-red-600">*</span></label>
                    <input id="soHieuTayDua" name="soHieuTayDua" type="number" min="0" required value="<%= HtmlUtil.escape(soHieuTayDua) %>" class="w-full rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm font-semibold outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
                </div>
            </div>
            <div class="mt-7 flex flex-col-reverse gap-3 border-t border-slate-200 pt-5 sm:flex-row sm:items-center sm:justify-between">
                <a href="<%= ctx %>/gdTimTayDua.jsp" class="action-control inline-flex items-center justify-center px-4 py-2.5 text-sm">Hủy và quay lại</a>
                <button type="submit" class="action-control px-7 py-2.5 text-sm shadow-sm">Lưu tay đua</button>
            </div>
        </form>
    </section>

    <aside class="h-fit rounded-xl bg-slate-900 p-6 text-slate-100 shadow-sm">
        <p class="text-xs font-bold tracking-wider text-red-400">HƯỚNG DẪN NHẬP</p>
        <h2 class="mt-2 text-xl font-bold">Kiểm tra trước khi lưu</h2>
        <ul class="mt-5 space-y-4 text-sm leading-6 text-slate-300">
            <li class="flex gap-3"><span class="mt-1 font-bold text-red-400">01</span><span>Nhập họ tên đúng với hồ sơ của tay đua.</span></li>
            <li class="flex gap-3"><span class="mt-1 font-bold text-red-400">02</span><span>Chọn ngày sinh và ghi đầy đủ quốc tịch.</span></li>
            <li class="flex gap-3"><span class="mt-1 font-bold text-red-400">03</span><span>Số hiệu tay đua phải là duy nhất trong hệ thống.</span></li>
        </ul>
        <div class="mt-6 border-t border-slate-700 pt-5 text-xs leading-5 text-slate-400">Sau khi lưu thành công, hệ thống sẽ đưa bạn về danh sách tay đua.</div>
    </aside>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
