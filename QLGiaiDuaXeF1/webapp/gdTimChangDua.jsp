<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, f1.dao.ChangDuaDAO, f1.model.ChangDua, f1.model.MuaGiai, f1.util.DateUtil, f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String loi = null;
    MuaGiai muaGiai = null;
    ArrayList<MuaGiai> dsMuaGiai = (ArrayList<MuaGiai>) session.getAttribute("dsMuaGiai");
    String muaGiaiIdText = request.getParameter("muaGiaiId");

    try {
        int muaGiaiId = Integer.parseInt(muaGiaiIdText);
        if (dsMuaGiai != null) {
            for (MuaGiai item : dsMuaGiai) {
                if (item.getId() == muaGiaiId) {
                    muaGiai = item;
                    break;
                }
            }
        }
    } catch (Exception e) {
        loi = "Mùa giải được chọn không hợp lệ.";
    }

    if (muaGiai == null) {
        session.setAttribute("module2Error", loi == null ? "Hãy tìm và chọn mùa giải trước." : loi);
        response.sendRedirect(request.getContextPath() + "/gdTimMuaGiai.jsp");
        return;
    }

    session.setAttribute("muaGiaiDangChon", muaGiai);
    String tuKhoa = request.getParameter("tuKhoa");
    if (tuKhoa == null) {
        tuKhoa = "";
    }
    ArrayList<ChangDua> danhSach = new ArrayList<ChangDua>();

    if (tuKhoa.trim().isEmpty()) {
        session.removeAttribute("dsChangDua");
    } else {
        try {
            danhSach = new ChangDuaDAO().timChangDua(tuKhoa, muaGiai);
            session.setAttribute("dsChangDua", danhSach);
        } catch (Exception e) {
            e.printStackTrace();
            loi = "Không tải được danh sách chặng đua. Vui lòng kiểm tra kết nối cơ sở dữ liệu.";
        }
    }

    request.setAttribute("pageTitle", "Tìm chặng đua");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng">
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a>
    <span class="mx-2 text-slate-300">/</span>
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdTimMuaGiai.jsp">Mùa giải</a>
    <span class="mx-2 text-slate-300">/</span>
    <span class="text-slate-700">Chặng đua</span>
</nav>

<section class="mb-8 border-b border-slate-200 pb-6">
    <p class="page-kicker">Chức năng 2 · <%= HtmlUtil.escape(muaGiai.getTenMuaGiai()) %></p>
    <h1 class="mt-1 text-3xl font-extrabold tracking-tight text-slate-900">Chọn chặng đua</h1>
    <p class="mt-2 text-slate-500">Tìm theo tên chặng hoặc địa điểm tổ chức; nhấn đúp vào chặng để tìm đội đua.</p>
</section>

<% if (loi != null && !loi.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(loi) %></div>
<% } %>

<section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="border-b border-slate-200 px-5 py-5 sm:px-6">
        <h2 class="text-lg font-bold text-slate-900">Danh sách chặng đua</h2>
        <p class="mt-1 text-sm text-slate-500">Mùa giải đang chọn: <span class="font-semibold"><%= HtmlUtil.escape(muaGiai.getTenMuaGiai()) %></span>.</p>
    </div>
    <div class="p-5 sm:p-6">
        <form action="<%= ctx %>/gdTimChangDua.jsp" method="get" class="mb-6 flex flex-col gap-2 sm:flex-row">
            <input type="hidden" name="muaGiaiId" value="<%= muaGiai.getId() %>">
            <input type="text" name="tuKhoa" value="<%= HtmlUtil.escape(tuKhoa) %>" placeholder="Nhập tên chặng hoặc địa điểm"
                   class="min-w-0 flex-1 rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
            <button type="submit" class="action-control px-5 py-2.5 text-sm shadow-sm">Tìm kiếm</button>
        </form>

        <div class="overflow-x-auto rounded-lg border border-slate-200">
            <table class="w-full table-f1 border-collapse">
                <thead>
                    <tr>
                        <th class="w-16">TT</th>
                        <th>Tên chặng</th>
                        <th>Số vòng đua</th>
                        <th>Địa điểm</th>
                        <th>Thời gian</th>
                        <th>Ngày mở đăng kí</th>
                        <th>Hạn chót đăng kí</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (tuKhoa.trim().isEmpty()) { %>
                        <tr><td colspan="8" class="px-4 py-12 text-center text-slate-500">Nhập tên chặng hoặc địa điểm để tìm kiếm.</td></tr>
                    <% } else if (danhSach.isEmpty()) { %>
                        <tr><td colspan="8" class="px-4 py-12 text-center text-slate-500">Không tìm thấy chặng đua phù hợp.</td></tr>
                    <% } else { int stt = 1; for (ChangDua changDua : danhSach) { %>
                        <tr class="cursor-pointer" title="Nhấn đúp để chọn chặng đua"
                            ondblclick="window.location.href='<%= ctx %>/gdTimDoiDua.jsp?changDuaId=<%= changDua.getId() %>'">
                            <td><%= stt++ %></td>
                            <td class="font-semibold text-slate-900"><%= HtmlUtil.escape(changDua.getTenChangDua()) %></td>
                            <td><%= changDua.getSoVongDua() %></td>
                            <td><%= HtmlUtil.escape(changDua.getDiaDiem()) %></td>
                            <td><%= DateUtil.format(changDua.getThoiGianToChuc()) %></td>
                            <td><%= DateUtil.format(changDua.getNgayBatDauDangKi()) %></td>
                            <td><%= DateUtil.format(changDua.getNgayHetHanDangKi()) %></td>
                            <td>
                                <% if ("Đang mở".equals(changDua.getTrangThaiDangKi())) { %>
                                    <span class="rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-bold text-emerald-700">Đang mở</span>
                                <% } else if ("Chưa mở".equals(changDua.getTrangThaiDangKi())) { %>
                                    <span class="rounded-full bg-amber-100 px-2.5 py-1 text-xs font-bold text-amber-700">Chưa mở</span>
                                <% } else { %>
                                    <span class="rounded-full bg-slate-200 px-2.5 py-1 text-xs font-bold text-slate-600">Kết thúc</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
        <div class="mt-5 border-t border-slate-200 pt-5">
            <a href="<%= ctx %>/gdTimMuaGiai.jsp" class="text-sm font-semibold text-slate-600 hover:text-slate-900">← Chọn mùa giải khác</a>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
