<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, f1.dao.DoiDuaDAO, f1.model.ChangDua, f1.model.DoiDua, f1.util.DateUtil, f1.util.HtmlUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String loi = null;
    ChangDua changDua = null;
    ArrayList<ChangDua> dsChangDua = (ArrayList<ChangDua>) session.getAttribute("dsChangDua");
    String changDuaIdText = request.getParameter("changDuaId");

    try {
        int changDuaId = Integer.parseInt(changDuaIdText);
        if (dsChangDua != null) {
            for (ChangDua item : dsChangDua) {
                if (item.getId() == changDuaId) {
                    changDua = item;
                    break;
                }
            }
        }
    } catch (Exception e) {
        loi = "Chặng đua được chọn không hợp lệ.";
    }

    if (changDua == null) {
        session.setAttribute("module2Error", loi == null ? "Hãy tìm và chọn chặng đua trước." : loi);
        response.sendRedirect(request.getContextPath() + "/gdTimMuaGiai.jsp");
        return;
    }

    session.setAttribute("changDuaDangChon", changDua);
    String tuKhoa = request.getParameter("tuKhoa");
    if (tuKhoa == null) {
        tuKhoa = "";
    }
    ArrayList<DoiDua> danhSach = new ArrayList<DoiDua>();
    String thongBao = (String) session.getAttribute("module2Message");
    session.removeAttribute("module2Message");
    String loiSession = (String) session.getAttribute("module2Error");
    session.removeAttribute("module2Error");
    if (loiSession != null) {
        loi = loiSession;
    }

    if (tuKhoa.trim().isEmpty()) {
        session.removeAttribute("dsDoiDua");
    } else {
        try {
            danhSach = new DoiDuaDAO().timDoiDua(tuKhoa, changDua);
            session.setAttribute("dsDoiDua", danhSach);
        } catch (Exception e) {
            e.printStackTrace();
            loi = "Không tải được danh sách đội đua. Vui lòng kiểm tra kết nối cơ sở dữ liệu.";
        }
    }

    request.setAttribute("pageTitle", "Tìm đội đua");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<nav class="mb-5 text-sm font-medium text-slate-500" aria-label="Điều hướng">
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdChinhBTC.jsp">Trang chủ</a>
    <span class="mx-2 text-slate-300">/</span>
    <a class="text-red-600 hover:text-red-700" href="<%= ctx %>/gdTimMuaGiai.jsp">Mùa giải</a>
    <span class="mx-2 text-slate-300">/</span>
    <span class="text-slate-700">Đội đua</span>
</nav>

<section class="mb-8 border-b border-slate-200 pb-6">
    <p class="page-kicker">Chức năng 2 · <%= HtmlUtil.escape(changDua.getTenChangDua()) %></p>
    <h1 class="mt-1 text-3xl font-extrabold tracking-tight text-slate-900">Chọn đội đua</h1>
    <p class="mt-2 text-slate-500">Chặng <span class="font-semibold"><%= HtmlUtil.escape(changDua.getTenChangDua()) %></span> diễn ra ngày <%= DateUtil.format(changDua.getThoiGianToChuc()) %>.</p>
</section>

<% if (thongBao != null && !thongBao.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-emerald-300 bg-emerald-50 px-4 py-3 text-sm text-emerald-800"><%= HtmlUtil.escape(thongBao) %></div>
<% } %>
<% if (loi != null && !loi.isEmpty()) { %>
    <div class="mb-6 rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800"><%= HtmlUtil.escape(loi) %></div>
<% } %>

<section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="border-b border-slate-200 px-5 py-5 sm:px-6">
        <h2 class="text-lg font-bold text-slate-900">Danh sách đội đua</h2>
        <p class="mt-1 text-sm text-slate-500">Chọn đội để đăng kí mới hoặc chỉnh sửa hai tay đua của đội tại chặng này.</p>
    </div>
    <div class="p-5 sm:p-6">
        <form action="<%= ctx %>/gdTimDoiDua.jsp" method="get" class="mb-6 flex flex-col gap-2 sm:flex-row">
            <input type="hidden" name="changDuaId" value="<%= changDua.getId() %>">
            <input type="text" name="tuKhoa" value="<%= HtmlUtil.escape(tuKhoa) %>" placeholder="Nhập tên đội hoặc hãng"
                   class="min-w-0 flex-1 rounded-lg border border-slate-300 px-3.5 py-2.5 text-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100">
            <button type="submit" class="action-control px-5 py-2.5 text-sm shadow-sm">Tìm kiếm</button>
        </form>

        <div class="overflow-x-auto rounded-lg border border-slate-200">
            <table class="w-full table-f1 border-collapse">
                <thead>
                    <tr>
                        <th class="w-16">TT</th>
                        <th>Mã đội đua</th>
                        <th>Tên đội đua</th>
                        <th>Hãng</th>
                        <th>Trạng thái</th>
                        <th class="w-32 text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (tuKhoa.trim().isEmpty()) { %>
                        <tr><td colspan="6" class="px-4 py-12 text-center text-slate-500">Nhập tên đội hoặc hãng để tìm kiếm.</td></tr>
                    <% } else if (danhSach.isEmpty()) { %>
                        <tr><td colspan="6" class="px-4 py-12 text-center text-slate-500">Không tìm thấy đội đua phù hợp.</td></tr>
                    <% } else { int stt = 1; for (DoiDua doiDua : danhSach) { boolean daDangKi = "Đã đăng kí".equals(doiDua.getTrangThaiDangKi()); %>
                        <tr>
                            <td><%= stt++ %></td>
                            <td class="font-mono font-semibold">D<%= doiDua.getId() %></td>
                            <td class="font-semibold text-slate-900"><%= HtmlUtil.escape(doiDua.getTenDoiDua()) %></td>
                            <td><%= HtmlUtil.escape(doiDua.getHang()) %></td>
                            <td>
                                <% if (daDangKi) { %>
                                    <span class="rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-bold text-emerald-700">Đã đăng kí</span>
                                <% } else { %>
                                    <span class="rounded-full bg-amber-100 px-2.5 py-1 text-xs font-bold text-amber-700">Chưa đăng kí</span>
                                <% } %>
                            </td>
                            <td class="text-center">
                                <a href="<%= ctx %>/gdDKTayDua.jsp?doiDuaId=<%= doiDua.getId() %>" class="action-control inline-flex px-3 py-1.5 text-xs"><%= daDangKi ? "Chỉnh sửa" : "Đăng kí" %></a>
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
